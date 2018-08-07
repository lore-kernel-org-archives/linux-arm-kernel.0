From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 07 Aug 2018 14:07:49 +0200
Subject: [linux-sunxi] [PATCH v6 4/8] media: platform: Add Cedrus VPU
 decoder driver
In-Reply-To: <1703875.6APCh3GEgq@jernej-laptop>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
 <1703875.6APCh3GEgq@jernej-laptop>
Message-ID: <3b093c7c5f8503869a94d4065e215439bc5c71ec.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 2018-07-29 at 09:58 +0200, Jernej ?krabec wrote:
> Hi!
> 
> Dne sreda, 25. julij 2018 ob 12:02:52 CEST je Paul Kocialkowski napisal(a):
> > This introduces the Cedrus VPU driver that supports the VPU found in
> > Allwinner SoCs, also known as Video Engine. It is implemented through
> > a v4l2 m2m decoder device and a media device (used for media requests).
> > So far, it only supports MPEG2 decoding.
> > 
> > Since this VPU is stateless, synchronization with media requests is
> > required in order to ensure consistency between frame headers that
> > contain metadata about the frame to process and the raw slice data that
> > is used to generate the frame.
> > 
> > This driver was made possible thanks to the long-standing effort
> > carried out by the linux-sunxi community in the interest of reverse
> > engineering, documenting and implementing support for Allwinner VPU.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> 
> <snip>

[...]

> > +static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run
> > *run) +{
> > +	const struct v4l2_ctrl_mpeg2_slice_params *slice_params;
> > +	const struct v4l2_ctrl_mpeg2_quantization *quantization;
> > +	dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
> > +	dma_addr_t fwd_luma_addr, fwd_chroma_addr;
> > +	dma_addr_t bwd_luma_addr, bwd_chroma_addr;
> > +	struct cedrus_dev *dev = ctx->dev;
> > +	u32 vld_end, vld_len;
> > +	const u8 *matrix;
> > +	unsigned int i;
> > +	u32 reg;
> > +
> > +	slice_params = run->mpeg2.slice_params;
> > +	quantization = run->mpeg2.quantization;
> > +
> > +	/* Activate MPEG engine. */
> > +	cedrus_engine_enable(dev, CEDRUS_CODEC_MPEG2);
> > +
> > +	/* Set intra quantization matrix. */
> > +
> > +	if (quantization && quantization->load_intra_quantiser_matrix)
> > +		matrix = quantization->intra_quantiser_matrix;
> > +	else
> > +		matrix = intra_quantization_matrix_default;
> > +
> > +	for (i = 0; i < 64; i++) {
> > +		reg = VE_DEC_MPEG_IQMINPUT_WEIGHT(i, matrix[i]);
> > +		reg |= VE_DEC_MPEG_IQMINPUT_FLAG_INTRA;
> > +
> > +		cedrus_write(dev, VE_DEC_MPEG_IQMINPUT, reg);
> > +	}
> > +
> > +	/* Set non-intra quantization matrix. */
> > +
> > +	if (quantization && quantization->load_non_intra_quantiser_matrix)
> > +		matrix = quantization->non_intra_quantiser_matrix;
> > +	else
> > +		matrix = non_intra_quantization_matrix_default;
> > +
> > +	for (i = 0; i < 64; i++) {
> > +		reg = VE_DEC_MPEG_IQMINPUT_WEIGHT(i, matrix[i]);
> > +		reg |= VE_DEC_MPEG_IQMINPUT_FLAG_NON_INTRA;
> > +
> > +		cedrus_write(dev, VE_DEC_MPEG_IQMINPUT, reg);
> > +	}
> > +
> > +	/* Set MPEG picture header. */
> > +
> > +	reg = VE_DEC_MPEG_MP12HDR_SLICE_TYPE(slice_params->slice_type);
> > +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(0, 0, slice_params->f_code[0][0]);
> > +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(0, 1, slice_params->f_code[0][1]);
> > +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(1, 0, slice_params->f_code[1][0]);
> > +	reg |= VE_DEC_MPEG_MP12HDR_F_CODE(1, 1, slice_params->f_code[1][1]);
> > +	reg |=
> > VE_DEC_MPEG_MP12HDR_INTRA_DC_PRECISION(slice_params->intra_dc_precision);
> > +	reg |=
> > VE_DEC_MPEG_MP12HDR_INTRA_PICTURE_STRUCTURE(slice_params->picture_structure
> > ); +	reg |=
> > VE_DEC_MPEG_MP12HDR_TOP_FIELD_FIRST(slice_params->top_field_first); +	reg
> > > =
> > 
> > VE_DEC_MPEG_MP12HDR_FRAME_PRED_FRAME_DCT(slice_params->frame_pred_frame_dct
> > ); +	reg |=
> > VE_DEC_MPEG_MP12HDR_CONCEALMENT_MOTION_VECTORS(slice_params->concealment_mo
> > tion_vectors); +	reg |=
> > VE_DEC_MPEG_MP12HDR_Q_SCALE_TYPE(slice_params->q_scale_type); +	reg |=
> > VE_DEC_MPEG_MP12HDR_INTRA_VLC_FORMAT(slice_params->intra_vlc_format); +	
> 
> reg
> > > = VE_DEC_MPEG_MP12HDR_ALTERNATE_SCAN(slice_params->alternate_scan); +	reg
> > > = VE_DEC_MPEG_MP12HDR_FULL_PEL_FORWARD_VECTOR(0);
> > 
> > +	reg |= VE_DEC_MPEG_MP12HDR_FULL_PEL_BACKWARD_VECTOR(0);
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_MP12HDR, reg);
> > +
> > +	/* Set frame dimensions. */
> > +
> > +	reg = VE_DEC_MPEG_PICCODEDSIZE_WIDTH(slice_params->width);
> > +	reg |= VE_DEC_MPEG_PICCODEDSIZE_HEIGHT(slice_params->height);
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_PICCODEDSIZE, reg);
> > +
> > +	reg = VE_DEC_MPEG_PICBOUNDSIZE_WIDTH(slice_params->width);
> > +	reg |= VE_DEC_MPEG_PICBOUNDSIZE_HEIGHT(slice_params->height);
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
> > +
> > +	/* Forward and backward prediction reference buffers. */
> > +
> > +	fwd_luma_addr = cedrus_dst_buf_addr(ctx, slice_params->forward_ref_index,
> > 0); +	fwd_chroma_addr = cedrus_dst_buf_addr(ctx,
> > slice_params->forward_ref_index, 1); +
> > +	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
> > +	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
> > +
> > +	bwd_luma_addr = cedrus_dst_buf_addr(ctx, slice_params->backward_ref_index,
> > 0); +	bwd_chroma_addr = cedrus_dst_buf_addr(ctx,
> > slice_params->backward_ref_index, 1); +
> > +	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
> > +	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR, bwd_chroma_addr);
> > +
> > +	/* Destination luma and chroma buffers. */
> > +
> > +	dst_luma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
> > +	dst_chroma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
> > +	cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_ROT_LUMA, dst_luma_addr);
> > +	cedrus_write(dev, VE_DEC_MPEG_ROT_CHROMA, dst_chroma_addr);
> 
> It seems that above ROT buffers are not required at all, if (please see next 
> comment)

Yes, you're totally right!

> > +
> > +	/* Source offset and length in bits. */
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_VLD_OFFSET, slice_params->slice_pos);
> > +
> > +	vld_len = slice_params->slice_len - slice_params->slice_pos;
> > +	cedrus_write(dev, VE_DEC_MPEG_VLD_LEN, vld_len);
> > +
> > +	/* Source beginning and end addresses. */
> > +
> > +	src_buf_addr = vb2_dma_contig_plane_dma_addr(&run->src->vb2_buf, 0);
> > +
> > +	reg = VE_DEC_MPEG_VLD_ADDR_BASE(src_buf_addr);
> > +	reg |= VE_DEC_MPEG_VLD_ADDR_VALID_PIC_DATA;
> > +	reg |= VE_DEC_MPEG_VLD_ADDR_LAST_PIC_DATA;
> > +	reg |= VE_DEC_MPEG_VLD_ADDR_FIRST_PIC_DATA;
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_VLD_ADDR, reg);
> > +
> > +	vld_end = src_buf_addr + DIV_ROUND_UP(slice_params->slice_len, 8);
> > +	cedrus_write(dev, VE_DEC_MPEG_VLD_END, vld_end);
> > +
> > +	/* Macroblock address: start at the beginning. */
> > +	reg = VE_DEC_MPEG_MBADDR_Y(0) | VE_DEC_MPEG_MBADDR_X(0);
> > +	cedrus_write(dev, VE_DEC_MPEG_MBADDR, reg);
> > +
> > +	/* Clear previous errors. */
> > +	cedrus_write(dev, VE_DEC_MPEG_ERROR, 0);
> > +
> > +	/* Clear correct macroblocks register. */
> > +	cedrus_write(dev, VE_DEC_MPEG_CRTMBADDR, 0);
> > +
> > +	/* Enable appropriate interruptions and components. */
> > +
> > +	reg = VE_DEC_MPEG_CTRL_IRQ_MASK | VE_DEC_MPEG_CTRL_MC_NO_WRITEBACK |
> > +	      VE_DEC_MPEG_CTRL_ROTATE_SCALE_OUT_EN |
> > +	      VE_DEC_MPEG_CTRL_MC_CACHE_EN;
> 
> ... if you remove VE_DEC_MPEG_CTRL_ROTATE_SCALE_OUT_EN. Everything gets still 
> correctly decoded. media-codec code for mpeg2 from AW doesn't use that at all. 
> I think that VE_DEC_MPEG_CTRL_MC_NO_WRITEBACK flag actually disables rotate/
> scale operation.

I agree with your conclusions here. The rotate and scale output (often
called 2nd output) is not used in our pipeline so there is indeed no
need to configure the dst addresses or set its enable bit.

Things indeed work just as well without it, so I'll get rid of that in
v7. Thanks!

Cheers,

Paul

> Best regards,
> Jernej
> 
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
> > +}
> > +
> > +static void cedrus_mpeg2_trigger(struct cedrus_ctx *ctx)
> > +{
> > +	struct cedrus_dev *dev = ctx->dev;
> > +	u32 reg;
> > +
> > +	/* Trigger MPEG engine. */
> > +	reg = VE_DEC_MPEG_TRIGGER_HW_MPEG_VLD | VE_DEC_MPEG_TRIGGER_MPEG2 |
> > +	      VE_DEC_MPEG_TRIGGER_MB_BOUNDARY;
> > +
> > +	cedrus_write(dev, VE_DEC_MPEG_TRIGGER, reg);
> > +}
> > +
> > +struct cedrus_dec_ops cedrus_dec_ops_mpeg2 = {
> > +	.irq_clear	= cedrus_mpeg2_irq_clear,
> > +	.irq_disable	= cedrus_mpeg2_irq_disable,
> > +	.irq_status	= cedrus_mpeg2_irq_status,
> > +	.setup		= cedrus_mpeg2_setup,
> > +	.trigger	= cedrus_mpeg2_trigger,
> > +};
> 
> 
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180807/b63e69fa/attachment-0001.sig>
