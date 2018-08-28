From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 28 Aug 2018 17:06:57 +0200
Subject: [PATCH 2/2] media: cedrus: Add HEVC/H.265 decoding support
In-Reply-To: <20180828080240.10982-3-paul.kocialkowski@bootlin.com>
References: <20180828080240.10982-1-paul.kocialkowski@bootlin.com>
 <20180828080240.10982-3-paul.kocialkowski@bootlin.com>
Message-ID: <20180828150657.dxwevt3oaac3lgx5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 28, 2018 at 10:02:40AM +0200, Paul Kocialkowski wrote:
> @@ -165,7 +182,8 @@ static inline void cedrus_write(struct cedrus_dev *dev, u32 reg, u32 val)
>  
>  static inline u32 cedrus_read(struct cedrus_dev *dev, u32 reg)
>  {
> -	return readl(dev->base + reg);
> +	u32 val = readl(dev->base + reg);
> +	return val;

I'm not sure that's needed :)

> +static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
> +					     const struct v4l2_hevc_dpb_entry *dpb,
> +					     u8 num_active_dpb_entries)
> +{
> +	struct cedrus_dev *dev = ctx->dev;
> +	dma_addr_t dst_luma_addr, dst_chroma_addr;
> +	dma_addr_t mv_col_buf_addr[2];
> +	u32 pic_order_cnt[2];
> +	unsigned int i;
> +
> +	for (i = 0; i < num_active_dpb_entries; i++) {
> +		dst_luma_addr = cedrus_dst_buf_addr(ctx, dpb[i].buffer_index,
> +						    0); // FIXME - PHYS_OFFSET ?
> +		dst_chroma_addr = cedrus_dst_buf_addr(ctx, dpb[i].buffer_index,
> +						      1); // FIXME - PHYS_OFFSET ?
> +		mv_col_buf_addr[0] = cedrus_h265_frame_info_mv_col_buf_addr(ctx,
> +			dpb[i].buffer_index, 0);
> +		pic_order_cnt[0] = dpb[i].pic_order_cnt[0];
> +
> +		if (dpb[i].field_pic) {
> +			mv_col_buf_addr[1] =
> +				cedrus_h265_frame_info_mv_col_buf_addr(ctx,
> +				dpb[i].buffer_index, 1);
> +			pic_order_cnt[1] = dpb[i].pic_order_cnt[1];
> +		}
> +
> +		cedrus_h265_frame_info_write_single(dev, i, dpb[i].field_pic,
> +						    pic_order_cnt,
> +						    mv_col_buf_addr,
> +						    dst_luma_addr,
> +						    dst_chroma_addr);
> +	}
> +}

You have this a number of times, but you can reduce the range of most
of the variables (basically all of them but dev and i) to the loop
itself. Declaring them for the whole function like you did suggests
that you're going to use the value from one iteration to the other,
which isn't the case here.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/72a367ab/attachment.sig>
