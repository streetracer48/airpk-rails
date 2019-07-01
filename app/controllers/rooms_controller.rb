class RoomsController < ApplicationController
  before_action :set_room, except: [:index, :new, :create]
  before_action :authenticate_user!, except: :show
  before_action :is_authorized, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]
  
  def index 
    @rooms = current_user.rooms
  end

  def new 
    @room = current_user.rooms.build
  end
  
  def create 
    @room = current_user.rooms.build(room_params)
    if @room.save 
      flash[:notice] = "Room Successfully Saved!"
      redirect_to listing_room_path(@room)
    else
      flash[:alert] = "Room cannot be saved! Please try again."
      render :new
    end
  end

  def update 
    if @room.update(room_params)
      flash[:notice] = "Room Successfully Updated!"
    else
      flash[:alert] = "Room cannot be Updated!"
    end

    redirect_back(fallback_location: request.referer)
  end

  def show

  end

  def listing 

  end

  def pricing 

  end

  def description

  end

  def photo_upload 
    @photos = @room.photos
  end

  def amenities 

  end

  def location

  end

  private 
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params 
      params.require(:room).permit(:home_type,
                                  :room_type, 
                                  :accommodate,
                                  :bed_room,
                                  :bath_room,
                                  :listing_name,
                                  :summary,
                                  :address,
                                  :has_tv,
                                  :has_kitchen,
                                  :has_aircon,
                                  :has_heating,
                                  :has_wifi,
                                  :price,
                                  :active)
    end

    def is_authorized
      unless current_user.id == @room.user_id
        flash[:alert] = "Unauthorized access!" 
        redirect_to root_url
      end
    end
end
