From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 30 Jul 2018 14:54:05 +0200
Subject: [PATCH 9/9] media: cedrus: Add H264 decoding support
In-Reply-To: <20180613140714.1686-10-maxime.ripard@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-10-maxime.ripard@bootlin.com>
Message-ID: <c2c5b43c4ea426a765297fb390752da87df9c55a.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> Introduce some basic H264 decoding support in cedrus. So far, only the
> baseline profile videos have been tested, and some more advanced features
> used in higher profiles are not even implemented.

While working on H265 support, I noticed a few things that should apply
to H264 as well.

[...]

> +struct sunxi_cedrus_h264_sram_ref_pic {
> +	__le32	top_field_order_cnt;
> +	__le32	bottom_field_order_cnt;
> +	__le32	frame_info;
> +	__le32	luma_ptr;
> +	__le32	chroma_ptr;
> +	__le32	extra_data_ptr;
> +	__le32	extra_data_end;

These two previous fields represent the top and bottom (field) motion
vector column buffer addresses, so the second field is not the end of
the first one. These fields should be frame-specific and they are called
topmv_coladdr, botmv_coladdr by Allwinner.

> +	__le32	reserved;
> +} __packed;
> +

[...]

> +static void sunxi_cedrus_fill_ref_pic(struct sunxi_cedrus_h264_sram_ref_pic *pic,
> +				      struct vb2_buffer *buf,
> +				      dma_addr_t extra_buf,
> +				      size_t extra_buf_len,
> +				      unsigned int top_field_order_cnt,
> +				      unsigned int bottom_field_order_cnt,
> +				      enum sunxi_cedrus_h264_pic_type pic_type)
> +{
> +	pic->top_field_order_cnt = top_field_order_cnt;
> +	pic->bottom_field_order_cnt = bottom_field_order_cnt;
> +	pic->frame_info = pic_type << 8;
> +	pic->luma_ptr = vb2_dma_contig_plane_dma_addr(buf, 0) - PHYS_OFFSET;
> +	pic->chroma_ptr = vb2_dma_contig_plane_dma_addr(buf, 1) - PHYS_OFFSET;
> +	pic->extra_data_ptr = extra_buf - PHYS_OFFSET;
> +	pic->extra_data_end = (extra_buf - PHYS_OFFSET) + extra_buf_len;
> +}
> +
> +static void sunxi_cedrus_write_frame_list(struct sunxi_cedrus_ctx *ctx,
> +					  struct sunxi_cedrus_run *run)
> +{
> +	struct sunxi_cedrus_h264_sram_ref_pic pic_list[SUNXI_CEDRUS_H264_FRAME_NUM];
> +	const struct v4l2_ctrl_h264_decode_param *dec_param = run->h264.decode_param;
> +	const struct v4l2_ctrl_h264_slice_param *slice = run->h264.slice_param;
> +	const struct v4l2_ctrl_h264_sps *sps = run->h264.sps;
> +	struct sunxi_cedrus_buffer *output_buf;
> +	struct sunxi_cedrus_dev *dev = ctx->dev;
> +	unsigned long used_dpbs = 0;
> +	unsigned int position;
> +	unsigned int output = 0;
> +	unsigned int i;
> +
> +	memset(pic_list, 0, sizeof(pic_list));
> +
> +	for (i = 0; i < ARRAY_SIZE(dec_param->dpb); i++) {
> +		const struct v4l2_h264_dpb_entry *dpb = &dec_param->dpb[i];
> +		const struct sunxi_cedrus_buffer *cedrus_buf;
> +		struct vb2_buffer *ref_buf;
> +
> +		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> +			continue;
> +
> +		ref_buf = ctx->dst_bufs[dpb->buf_index];
> +		cedrus_buf = vb2_to_cedrus_buffer(ref_buf);
> +		position = cedrus_buf->codec.h264.position;
> +		used_dpbs |= BIT(position);
> +		
> +		sunxi_cedrus_fill_ref_pic(&pic_list[position], ref_buf,
> +					  ctx->codec.h264.mv_col_buf_dma,
> +					  ctx->codec.h264.mv_col_buf_size,

Following up on my previous comment, this should be specific to each
frame, with 2 buffer chunks per frame (top and bottom fields) as done in
Allwinner's H264MallocBuffer function. 

[...]

> +static void sunxi_cedrus_set_params(struct sunxi_cedrus_ctx *ctx,
> +				    struct sunxi_cedrus_run *run)
> +{
> +	const struct v4l2_ctrl_h264_slice_param *slice = run->h264.slice_param;
> +	const struct v4l2_ctrl_h264_pps *pps = run->h264.pps;
> +	const struct v4l2_ctrl_h264_sps *sps = run->h264.sps;
> +	struct sunxi_cedrus_dev *dev = ctx->dev;
> +	dma_addr_t src_buf_addr;
> +	u32 offset = slice->header_bit_size;
> +	u32 len = (slice->size * 8) - offset;
> +	u32 reg;
> +
> +	sunxi_cedrus_write(dev, ctx->codec.h264.pic_info_buf_dma - PHYS_OFFSET, 0x250);
> +	sunxi_cedrus_write(dev, (ctx->codec.h264.pic_info_buf_dma - PHYS_OFFSET) + 0x48000, 0x254);
> +
> +	sunxi_cedrus_write(dev, len, VE_H264_VLD_LEN);
> +	sunxi_cedrus_write(dev, offset, VE_H264_VLD_OFFSET);
> +
> +	src_buf_addr = vb2_dma_contig_plane_dma_addr(&run->src->vb2_buf, 0);
> +	src_buf_addr -= PHYS_OFFSET;
> +	sunxi_cedrus_write(dev, VE_H264_VLD_ADDR_VAL(src_buf_addr) |
> +			   VE_H264_VLD_ADDR_FIRST | VE_H264_VLD_ADDR_VALID | VE_H264_VLD_ADDR_LAST,
> +			   VE_H264_VLD_ADDR);
> +	sunxi_cedrus_write(dev, src_buf_addr + VBV_SIZE - 1, VE_H264_VLD_END);
> +
> +	sunxi_cedrus_write(dev, VE_H264_TRIGGER_TYPE_INIT_SWDEC,
> +			   VE_H264_TRIGGER_TYPE);

It seems that this trigger type is only useful when trying
to subsequently access the bitstream data from the VPU (for easier
parsing, as done in libvdpau-sunxi), but it should not be required when
all the parsing was done already and no such access is necessary.

I haven't tested without it so far, but I have a hunch we can spare this
call.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/d5a59cac/attachment.sig>
