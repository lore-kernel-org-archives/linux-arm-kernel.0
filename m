From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Wed, 08 Aug 2018 14:05:31 +0200
Subject: [PATCH v6 1/8] media: v4l: Add definitions for MPEG2 slice
 format and metadata
In-Reply-To: <57d8c895-ad9f-5105-e923-9666fdf909d9@xs4all.nl>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-2-paul.kocialkowski@bootlin.com>
 <57d8c895-ad9f-5105-e923-9666fdf909d9@xs4all.nl>
Message-ID: <d10ae3939e0559cbb0ce9584513d1499962d46c9.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 2018-08-04 at 15:30 +0200, Hans Verkuil wrote:
> On 07/25/2018 12:02 PM, Paul Kocialkowski wrote:

[...]

> > diff --git a/Documentation/media/uapi/v4l/pixfmt-compressed.rst b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
> > index abec03937bb3..4e73f62b5163 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-compressed.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-compressed.rst
> > @@ -60,6 +60,11 @@ Compressed Formats
> >        - ``V4L2_PIX_FMT_MPEG2``
> >        - 'MPG2'
> >        - MPEG2 video elementary stream.
> > +    * .. _V4L2-PIX-FMT-MPEG2-SLICE:
> > +
> > +      - ``V4L2_PIX_FMT_MPEG2_SLICE``
> > +      - 'MG2S'
> > +      - MPEG2 parsed slice data, as extracted from the MPEG2 bitstream.
> 
> This does not mention that this requires the use of the Request API and which controls
> are compulsory in the request.

Right, so I will add a more extensive description regarding the intended
use case for this format, covering what controls are required.

> >      * .. _V4L2-PIX-FMT-MPEG4:
> >  
> >        - ``V4L2_PIX_FMT_MPEG4``
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> > index 3610dce3a4f8..22483d894259 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> > @@ -844,6 +844,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> >  	case V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE:		return "Vertical MV Search Range";
> >  	case V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER:		return "Repeat Sequence Header";
> >  	case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:		return "Force Key Frame";
> > +	case V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS:		return "MPEG2 Slice Header";
> > +	case V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION:		return "MPEG2 Quantization Matrices";
> 
> Use MPEG-2 instead of MPEG2 in these two descriptions.

Will do!

Cheers,

Paul

> Regards,
> 
> 	Hans
> 
> >  
> >  	/* VPX controls */
> >  	case V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS:		return "VPX Number of Partitions";
> > @@ -1292,6 +1294,12 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
> >  	case V4L2_CID_RDS_TX_ALT_FREQS:
> >  		*type = V4L2_CTRL_TYPE_U32;
> >  		break;
> > +	case V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS:
> > +		*type = V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION:
> > +		*type = V4L2_CTRL_TYPE_MPEG2_QUANTIZATION;
> > +		break;
> >  	default:
> >  		*type = V4L2_CTRL_TYPE_INTEGER;
> >  		break;
> > @@ -1550,6 +1558,7 @@ static void std_log(const struct v4l2_ctrl *ctrl)
> >  static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
> >  			union v4l2_ctrl_ptr ptr)
> >  {
> > +	struct v4l2_ctrl_mpeg2_slice_params *p_mpeg2_slice_params;
> >  	size_t len;
> >  	u64 offset;
> >  	s64 val;
> > @@ -1612,6 +1621,45 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
> >  			return -ERANGE;
> >  		return 0;
> >  
> > +	case V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS:
> > +		p_mpeg2_slice_params = ptr.p;
> > +
> > +		switch (p_mpeg2_slice_params->intra_dc_precision) {
> > +		case 0: /* 8 bits */
> > +		case 1: /* 9 bits */
> > +		case 11: /* 11 bits */
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		switch (p_mpeg2_slice_params->picture_structure) {
> > +		case 1: /* interlaced top field */
> > +		case 2: /* interlaced bottom field */
> > +		case 3: /* progressive */
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		switch (p_mpeg2_slice_params->slice_type) {
> > +		case V4L2_MPEG2_SLICE_TYPE_I:
> > +		case V4L2_MPEG2_SLICE_TYPE_P:
> > +		case V4L2_MPEG2_SLICE_TYPE_B:
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (p_mpeg2_slice_params->backward_ref_index > VIDEO_MAX_FRAME ||
> > +		    p_mpeg2_slice_params->forward_ref_index > VIDEO_MAX_FRAME)
> > +			return -EINVAL;
> > +
> > +		return 0;
> > +
> > +	case V4L2_CTRL_TYPE_MPEG2_QUANTIZATION:
> > +		return 0;
> > +
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -2186,6 +2234,12 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
> >  	case V4L2_CTRL_TYPE_U32:
> >  		elem_size = sizeof(u32);
> >  		break;
> > +	case V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS:
> > +		elem_size = sizeof(struct v4l2_ctrl_mpeg2_slice_params);
> > +		break;
> > +	case V4L2_CTRL_TYPE_MPEG2_QUANTIZATION:
> > +		elem_size = sizeof(struct v4l2_ctrl_mpeg2_quantization);
> > +		break;
> >  	default:
> >  		if (type < V4L2_CTRL_COMPOUND_TYPES)
> >  			elem_size = sizeof(s32);
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index 44fc0102221f..68e914b83a03 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1304,6 +1304,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >  		case V4L2_PIX_FMT_H263:		descr = "H.263"; break;
> >  		case V4L2_PIX_FMT_MPEG1:	descr = "MPEG-1 ES"; break;
> >  		case V4L2_PIX_FMT_MPEG2:	descr = "MPEG-2 ES"; break;
> > +		case V4L2_PIX_FMT_MPEG2_SLICE:	descr = "MPEG-2 parsed slice data"; break;
> >  		case V4L2_PIX_FMT_MPEG4:	descr = "MPEG-4 part 2 ES"; break;
> >  		case V4L2_PIX_FMT_XVID:		descr = "Xvid"; break;
> >  		case V4L2_PIX_FMT_VC1_ANNEX_G:	descr = "VC-1 (SMPTE 412M Annex G)"; break;
> > diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> > index 34ee3167d7dd..83eff6f91ed2 100644
> > --- a/include/media/v4l2-ctrls.h
> > +++ b/include/media/v4l2-ctrls.h
> > @@ -35,13 +35,15 @@ struct poll_table_struct;
> >  
> >  /**
> >   * union v4l2_ctrl_ptr - A pointer to a control value.
> > - * @p_s32:	Pointer to a 32-bit signed value.
> > - * @p_s64:	Pointer to a 64-bit signed value.
> > - * @p_u8:	Pointer to a 8-bit unsigned value.
> > - * @p_u16:	Pointer to a 16-bit unsigned value.
> > - * @p_u32:	Pointer to a 32-bit unsigned value.
> > - * @p_char:	Pointer to a string.
> > - * @p:		Pointer to a compound value.
> > + * @p_s32:			Pointer to a 32-bit signed value.
> > + * @p_s64:			Pointer to a 64-bit signed value.
> > + * @p_u8:			Pointer to a 8-bit unsigned value.
> > + * @p_u16:			Pointer to a 16-bit unsigned value.
> > + * @p_u32:			Pointer to a 32-bit unsigned value.
> > + * @p_char:			Pointer to a string.
> > + * @p_mpeg2_slice_params:	Pointer to a MPEG2 slice parameters structure.
> > + * @p_mpeg2_quantization:	Pointer to a MPEG2 quantization data structure.
> > + * @p:				Pointer to a compound value.
> >   */
> >  union v4l2_ctrl_ptr {
> >  	s32 *p_s32;
> > @@ -50,6 +52,8 @@ union v4l2_ctrl_ptr {
> >  	u16 *p_u16;
> >  	u32 *p_u32;
> >  	char *p_char;
> > +	struct v4l2_ctrl_mpeg2_slice_params *p_mpeg2_slice_params;
> > +	struct v4l2_ctrl_mpeg2_quantization *p_mpeg2_quantization;
> >  	void *p;
> >  };
> >  
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> > index e4ee10ee917d..ce6de781037a 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -557,6 +557,9 @@ enum v4l2_mpeg_video_mpeg4_profile {
> >  };
> >  #define V4L2_CID_MPEG_VIDEO_MPEG4_QPEL		(V4L2_CID_MPEG_BASE+407)
> >  
> > +#define V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS	(V4L2_CID_MPEG_BASE+450)
> > +#define V4L2_CID_MPEG_VIDEO_MPEG2_QUANTIZATION	(V4L2_CID_MPEG_BASE+451)
> > +
> >  /*  Control IDs for VP8 streams
> >   *  Although VP8 is not part of MPEG we add these controls to the MPEG class
> >   *  as that class is already handling other video compression standards
> > @@ -1092,4 +1095,44 @@ enum v4l2_detect_md_mode {
> >  #define V4L2_CID_DETECT_MD_THRESHOLD_GRID	(V4L2_CID_DETECT_CLASS_BASE + 3)
> >  #define V4L2_CID_DETECT_MD_REGION_GRID		(V4L2_CID_DETECT_CLASS_BASE + 4)
> >  
> > +#define V4L2_MPEG2_SLICE_TYPE_I			1
> > +#define V4L2_MPEG2_SLICE_TYPE_P			2
> > +#define V4L2_MPEG2_SLICE_TYPE_B			3
> > +#define V4L2_MPEG2_SLICE_TYPE_D			4
> > +
> > +struct v4l2_ctrl_mpeg2_slice_params {
> > +	__u32	slice_len;
> > +	__u32	slice_pos;
> > +
> > +	__u16	width;
> > +	__u16	height;
> > +
> > +	__u8	slice_type;
> > +	__u8	f_code[2][2];
> > +
> > +	__u8	intra_dc_precision;
> > +	__u8	picture_structure;
> > +	__u8	top_field_first;
> > +	__u8	frame_pred_frame_dct;
> > +	__u8	concealment_motion_vectors;
> > +	__u8	q_scale_type;
> > +	__u8	intra_vlc_format;
> > +	__u8	alternate_scan;
> > +
> > +	__u8	backward_ref_index;
> > +	__u8	forward_ref_index;
> > +};
> > +
> > +struct v4l2_ctrl_mpeg2_quantization {
> > +	__u8	load_intra_quantiser_matrix : 1;
> > +	__u8	load_non_intra_quantiser_matrix : 1;
> > +	__u8	load_chroma_intra_quantiser_matrix : 1;
> > +	__u8	load_chroma_non_intra_quantiser_matrix : 1;
> > +
> > +	__u8	intra_quantiser_matrix[64];
> > +	__u8	non_intra_quantiser_matrix[64];
> > +	__u8	chroma_intra_quantiser_matrix[64];
> > +	__u8	chroma_non_intra_quantiser_matrix[64];
> > +};
> > +
> >  #endif
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 1f6c4b52baae..d171361ed9b3 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -629,6 +629,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_H263     v4l2_fourcc('H', '2', '6', '3') /* H263          */
> >  #define V4L2_PIX_FMT_MPEG1    v4l2_fourcc('M', 'P', 'G', '1') /* MPEG-1 ES     */
> >  #define V4L2_PIX_FMT_MPEG2    v4l2_fourcc('M', 'P', 'G', '2') /* MPEG-2 ES     */
> > +#define V4L2_PIX_FMT_MPEG2_SLICE v4l2_fourcc('M', 'G', '2', 'S') /* MPEG-2 parsed slice data */
> >  #define V4L2_PIX_FMT_MPEG4    v4l2_fourcc('M', 'P', 'G', '4') /* MPEG-4 part 2 ES */
> >  #define V4L2_PIX_FMT_XVID     v4l2_fourcc('X', 'V', 'I', 'D') /* Xvid           */
> >  #define V4L2_PIX_FMT_VC1_ANNEX_G v4l2_fourcc('V', 'C', '1', 'G') /* SMPTE 421M Annex G compliant stream */
> > @@ -1587,6 +1588,8 @@ struct v4l2_ext_control {
> >  		__u8 __user *p_u8;
> >  		__u16 __user *p_u16;
> >  		__u32 __user *p_u32;
> > +		struct v4l2_ctrl_mpeg2_slice_params __user *p_mpeg2_slice_params;
> > +		struct v4l2_ctrl_mpeg2_quantization __user *p_mpeg2_quantization;
> >  		void __user *ptr;
> >  	};
> >  } __attribute__ ((packed));
> > @@ -1632,6 +1635,8 @@ enum v4l2_ctrl_type {
> >  	V4L2_CTRL_TYPE_U8	     = 0x0100,
> >  	V4L2_CTRL_TYPE_U16	     = 0x0101,
> >  	V4L2_CTRL_TYPE_U32	     = 0x0102,
> > +	V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS = 0x0103,
> > +	V4L2_CTRL_TYPE_MPEG2_QUANTIZATION = 0x0104,
> >  };
> >  
> >  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
> > 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/9171616a/attachment.sig>
