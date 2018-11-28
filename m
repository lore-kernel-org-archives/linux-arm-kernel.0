From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 16:52:37 +0100
Subject: [linux-sunxi] [PATCH v2 1/2] media: uapi: Add H264 low-level
 decoder API compound controls.
In-Reply-To: <2123591.3TCVFQjlgd@jernej-laptop>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
 <2123591.3TCVFQjlgd@jernej-laptop>
Message-ID: <20181128155237.5sb7sgik67pcndsw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Tue, Nov 27, 2018 at 06:23:10PM +0100, Jernej ?krabec wrote:
> > @@ -1156,4 +1164,162 @@ struct v4l2_ctrl_mpeg2_quantization {
> >  	__u8	chroma_non_intra_quantiser_matrix[64];
> >  };
> > 
> > +/* Compounds controls */
> > +
> > +#define V4L2_H264_SPS_CONSTRAINT_SET0_FLAG			0x01
> > +#define V4L2_H264_SPS_CONSTRAINT_SET1_FLAG			0x02
> > +#define V4L2_H264_SPS_CONSTRAINT_SET2_FLAG			0x04
> > +#define V4L2_H264_SPS_CONSTRAINT_SET3_FLAG			0x08
> > +#define V4L2_H264_SPS_CONSTRAINT_SET4_FLAG			0x10
> > +#define V4L2_H264_SPS_CONSTRAINT_SET5_FLAG			0x20
> 
> How are these constraint flags meant to be used?

They are supposed to be used as bit fields in the constraint_set_flags
variable part of the v4l2_ctrl_h264_sps structure.

> > +
> > +#define V4L2_H264_SPS_FLAG_SEPARATE_COLOUR_PLANE		0x01
> > +#define V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS	0x02
> > +#define V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO		0x04
> > +#define V4L2_H264_SPS_FLAG_GAPS_IN_FRAME_NUM_VALUE_ALLOWED	0x08
> > +#define V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY			0x10
> > +#define V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD		0x20
> > +#define V4L2_H264_SPS_FLAG_DIRECT_8X8_INFERENCE			0x40
> > +
> > +struct v4l2_ctrl_h264_sps {
> > +	__u8 profile_idc;
> > +	__u8 constraint_set_flags;
> > +	__u8 level_idc;
> > +	__u8 seq_parameter_set_id;
> > +	__u8 chroma_format_idc;
> > +	__u8 bit_depth_luma_minus8;
> > +	__u8 bit_depth_chroma_minus8;
> > +	__u8 log2_max_frame_num_minus4;
> > +	__u8 pic_order_cnt_type;
> > +	__u8 log2_max_pic_order_cnt_lsb_minus4;
> > +	__u8 max_num_ref_frames;
> > +	__u8 num_ref_frames_in_pic_order_cnt_cycle;
> > +	__s32 offset_for_ref_frame[255];
> > +	__s32 offset_for_non_ref_pic;
> > +	__s32 offset_for_top_to_bottom_field;
> > +	__u16 pic_width_in_mbs_minus1;
> > +	__u16 pic_height_in_map_units_minus1;
> > +	__u8 flags;
> > +};
> > +
> > +#define V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE				0x0001
> > +#define V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT	0x0002
> > +#define V4L2_H264_PPS_FLAG_WEIGHTED_PRED				0x0004
> > +#define V4L2_H264_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT		0x0008
> > +#define V4L2_H264_PPS_FLAG_CONSTRAINED_INTRA_PRED			0x0010
> > +#define V4L2_H264_PPS_FLAG_REDUNDANT_PIC_CNT_PRESENT			0x0020
> > +#define V4L2_H264_PPS_FLAG_TRANSFORM_8X8_MODE				0x0040
> > +#define V4L2_H264_PPS_FLAG_PIC_SCALING_MATRIX_PRESENT			0x0080
> > +
> > +struct v4l2_ctrl_h264_pps {
> > +	__u8 pic_parameter_set_id;
> > +	__u8 seq_parameter_set_id;
> > +	__u8 num_slice_groups_minus1;
> > +	__u8 num_ref_idx_l0_default_active_minus1;
> > +	__u8 num_ref_idx_l1_default_active_minus1;
> > +	__u8 weighted_bipred_idc;
> > +	__s8 pic_init_qp_minus26;
> > +	__s8 pic_init_qs_minus26;
> > +	__s8 chroma_qp_index_offset;
> > +	__s8 second_chroma_qp_index_offset;
> > +	__u8 flags;
> > +};
> > +
> > +struct v4l2_ctrl_h264_scaling_matrix {
> > +	__u8 scaling_list_4x4[6][16];
> > +	__u8 scaling_list_8x8[6][64];
> > +};
> > +
> > +struct v4l2_h264_weight_factors {
> > +	__s8 luma_weight[32];
> > +	__s8 luma_offset[32];
> > +	__s8 chroma_weight[32][2];
> > +	__s8 chroma_offset[32][2];
> > +};
> 
> Regarding weight type __s8 - isn't too small just a bit?
> 
> ITU-T Rec. H264 (05/2003) says that this field has value between -128 to 127 if 
> weight flag is set. That fits perfectly. However, when weight flag is 0, default 
> value is 2^luma_log2_weight_denom (for example). luma_log2_weight_denom can 
> have values between 0 and 7, which means that weight will have values from 1 
> to 128. That is just slightly over the max value for __s8.

luma_log2_weight_denom is in the v4l2_h264_pred_weight_table
structure, so you wouldn't use the weights if the weight flag isn't
set.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/3bc03699/attachment-0001.sig>
