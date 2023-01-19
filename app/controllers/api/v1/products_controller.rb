class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update show destroy]

  def index
    @products = Product.all
    render json: @products, status:200
  end

  def show
    if @product
      render json: @product, status:200
    else
      render json: {error: "Not Found"}
    end
  end

  def create
    @product = Product.new(prod_params)
    if @product.save
      render json: @product, status:200
    else
      render json: {error: "@Product not create"}
    end
  end

  def destroy
    if @product.destroy
      render json: @product, status:200
    else
      render json: {error: "@Product not available"}
    end
  end

  def update    
    if @product.update(prod_params)
      render json: @product, status:200
    else
      render json: {error: "@Product not available"}
    end
  end

  private

  def prod_params 
    params.require(:product).permit([
      :name, :brand, :price
      ])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
  end

end
