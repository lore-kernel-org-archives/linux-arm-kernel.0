From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 16:50:28 +0100
Subject: [linux-sunxi] [PATCH v2 2/2] media: cedrus: Add H264 decoding
 support
In-Reply-To: <2826880.kP3DS59ZBy@jernej-laptop>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-3-maxime.ripard@bootlin.com>
 <2826880.kP3DS59ZBy@jernej-laptop>
Message-ID: <20181127155028.5ukw3g6zjbnvarbp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thanks for your review!

On Sat, Nov 24, 2018 at 09:43:43PM +0100, Jernej ?krabec wrote:
> > +enum cedrus_h264_sram_off {
> > +	CEDRUS_SRAM_H264_PRED_WEIGHT_TABLE	= 0x000,
> > +	CEDRUS_SRAM_H264_FRAMEBUFFER_LIST	= 0x100,
> > +	CEDRUS_SRAM_H264_REF_LIST_0		= 0x190,
> > +	CEDRUS_SRAM_H264_REF_LIST_1		= 0x199,
> > +	CEDRUS_SRAM_H264_SCALING_LIST_8x8	= 0x200,
> > +	CEDRUS_SRAM_H264_SCALING_LIST_4x4	= 0x218,
> 
> I triple checked above address and it should be 0x220. For easier 
> implementation later, you might want to add second scaling list address for 
> 8x8 at 0x210. Then you can do something like:
> 
> cedrus_h264_write_sram(dev, CEDRUS_SRAM_H264_SCALING_LIST_8x8_0,
> 			       scaling->scaling_list_8x8[0],
> 			       sizeof(scaling->scaling_list_8x8[0]));
> cedrus_h264_write_sram(dev, CEDRUS_SRAM_H264_SCALING_LIST_8x8_1,
> 			       scaling->scaling_list_8x8[3],
> 			       sizeof(scaling->scaling_list_8x8[0]));
> cedrus_h264_write_sram(dev, CEDRUS_SRAM_H264_SCALING_LIST_4x4,
> 			       scaling->scaling_list_4x4,
> 			       sizeof(scaling->scaling_list_4x4));
> 
> I know that it's not implemented here, just FYI.

Ack. I guess I can just leave it out entirely for now, since it's not
implemented.

> > +static void cedrus_fill_ref_pic(struct cedrus_ctx *ctx,
> > +				struct cedrus_buffer *buf,
> > +				unsigned int top_field_order_cnt,
> > +				unsigned int bottom_field_order_cnt,
> > +				struct cedrus_h264_sram_ref_pic *pic)
> > +{
> > +	struct vb2_buffer *vbuf = &buf->m2m_buf.vb.vb2_buf;
> > +	unsigned int position = buf->codec.h264.position;
> > +
> > +	pic->top_field_order_cnt = top_field_order_cnt;
> > +	pic->bottom_field_order_cnt = bottom_field_order_cnt;
> > +	pic->frame_info = buf->codec.h264.pic_type << 8;
> > +
> > +	pic->luma_ptr = cedrus_buf_addr(vbuf, &ctx->dst_fmt, 0) - PHYS_OFFSET;
> > +	pic->chroma_ptr = cedrus_buf_addr(vbuf, &ctx->dst_fmt, 1) - PHYS_OFFSET;
> 
> I think subtracting PHYS_OFFSET breaks driver on H3 boards with 2 GiB of RAM. 
> Isn't that unnecessary anyway due to
> 
> dev->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
> 
> in cedrus_hw.c?
> 
> This comment is meant for all PHYS_OFFSET subtracting in this patch.

PHYS_OFFSET was needed on some older SoCs, and the dma_pfn_offset
trick wasn't working, I hacked it and forgot about it. I'll try to
figure it out for the next version.

> > +static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
> > +				   struct cedrus_run *run,
> > +				   const u8 *ref_list, u8 num_ref,
> > +				   enum cedrus_h264_sram_off sram)
> > +{
> > +	const struct v4l2_ctrl_h264_decode_param *decode = run->h264.decode_param;
> > +	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
> > +	struct cedrus_dev *dev = ctx->dev;
> > +	u32 sram_array[CEDRUS_MAX_REF_IDX / sizeof(u32)];
> > +	unsigned int size, i;
> > +
> > +	memset(sram_array, 0, sizeof(sram_array));
> > +
> > +	for (i = 0; i < num_ref; i += 4) {
> > +		unsigned int j;
> > +
> > +		for (j = 0; j < 4; j++) {
> 
> I don't think you have to complicate with two loops here. 
> cedrus_h264_write_sram() takes void* and it aligns to 4 anyway. So as long 
> input buffer is multiple of 4 (u8[CEDRUS_MAX_REF_IDX] qualifies for that), you 
> can use single for loop with "u8 sram_array[CEDRUS_MAX_REF_IDX]". This should 
> make code much more readable.

This wasn't really about the alignment, but in order to get the
offsets in the u32 and the array more easily.

Breaking out the loop will make that computation less easy on the eye,
so I guess it's very subjective.

> > +			const struct v4l2_h264_dpb_entry *dpb;
> > +			const struct cedrus_buffer *cedrus_buf;
> > +			const struct vb2_v4l2_buffer *ref_buf;
> > +			unsigned int position;
> > +			int buf_idx;
> > +			u8 ref_idx = i + j;
> > +			u8 dpb_idx;
> > +
> > +			if (ref_idx >= num_ref)
> > +				break;
> > +
> > +			dpb_idx = ref_list[ref_idx];
> > +			dpb = &decode->dpb[dpb_idx];
> > +
> > +			if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> > +				continue;
> > +
> > +			buf_idx = vb2_find_tag(cap_q, dpb->tag, 0);
> > +			if (buf_idx < 0)
> > +				continue;
> > +
> > +			ref_buf = to_vb2_v4l2_buffer(ctx->dst_bufs[buf_idx]);
> > +			cedrus_buf = vb2_v4l2_to_cedrus_buffer(ref_buf);
> > +			position = cedrus_buf->codec.h264.position;
> > +
> > +			sram_array[i] |= position << (j * 8 + 1);
> > +			if (ref_buf->field == V4L2_FIELD_BOTTOM)
> 
> You newer set above flag to buffer so this will be always false.

As far as I know, the field is supposed to be set by the userspace.

> > +	// sequence parameters
> > +	reg = BIT(19);
> 
> This one can be inferred from sps->chroma_format_idc.

I'll look into this

> > +	reg |= (sps->pic_width_in_mbs_minus1 & 0xff) << 8;
> > +	reg |= sps->pic_height_in_map_units_minus1 & 0xff;
> > +	if (sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY)
> > +		reg |= BIT(18);
> > +	if (sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD)
> > +		reg |= BIT(17);
> > +	if (sps->flags & V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE)
> > +		reg |= BIT(16);
> > +	cedrus_write(dev, VE_H264_FRAME_SIZE, reg);
> > +
> > +	// slice parameters
> > +	reg = 0;
> > +	/*
> > +	 * FIXME: This bit marks all the frames as references. This
> > +	 * should probably be set based on nal_ref_idc, but the libva
> > +	 * doesn't pass that information along, so this is not always
> > +	 * available. We should find something else, maybe change the
> > +	 * kernel UAPI somehow?
> > +	 */
> > +	reg |= BIT(12);
> 
> I really think you should use nal_ref_idc here as it is in specification.  You 
> can still fake the data from libva backend. I don't think that any driver 
> needs this for anything else than check if it is 0 or not.

Yeah, Tomasz suggested the same thing as a reply to the cover letter,
I'll change that in the next version.

> > +	reg |= (slice->slice_type & 0xf) << 8;
> > +	reg |= slice->cabac_init_idc & 0x3;
> > +	reg |= BIT(5);
> > +	if (slice->flags & V4L2_H264_SLICE_FLAG_FIELD_PIC)
> > +		reg |= BIT(4);
> > +	if (slice->flags & V4L2_H264_SLICE_FLAG_BOTTOM_FIELD)
> > +		reg |= BIT(3);
> > +	if (slice->flags & V4L2_H264_SLICE_FLAG_DIRECT_SPATIAL_MV_PRED)
> > +		reg |= BIT(2);
> > +	cedrus_write(dev, VE_H264_SLICE_HDR, reg);
> > +
> > +	reg = 0;
> 
> You might want to set bit 12 here, which enables active reference picture 
> override. However, I'm not completely sure about that.

Did you find some videos that were broken because of this?

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
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/4a47041c/attachment-0001.sig>
