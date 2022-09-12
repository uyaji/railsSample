class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc ) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   size:         { less_than: 5.megabytes,
                                      messgae: "should be less than 5MB" },
                      content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" }
  # 表示用のリサイズ済画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
