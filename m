From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 2 Feb 2018 15:09:19 +0100
Subject: [Patch v8 11/12] [media] s5p-mfc: Add support for HEVC encoder
In-Reply-To: <1517574348-22111-12-git-send-email-smitha.t@samsung.com>
References: <1517574348-22111-1-git-send-email-smitha.t@samsung.com>
 <CGME20180202125018epcas1p31771ade936e0290e579b8e0805f3f0a1@epcas1p3.samsung.com>
 <1517574348-22111-12-git-send-email-smitha.t@samsung.com>
Message-ID: <37e3531b-b677-9d3c-e954-25d8f989e774@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/18 13:25, Smitha T Murthy wrote:
> Add HEVC encoder support and necessary registers, V4L2 CIDs,
> and hevc encoder parameters
> 
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Not quite, one last comment:

> ---
>  drivers/media/platform/s5p-mfc/regs-mfc-v10.h   |  28 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc.c        |   1 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c |   3 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  54 ++-
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    | 536 ++++++++++++++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr.h    |   8 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c | 182 ++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h |   8 +
>  8 files changed, 818 insertions(+), 2 deletions(-)
> 

<snip>

>  static inline int vui_sar_idc(enum v4l2_mpeg_video_h264_vui_sar_idc sar)
>  {
>  	static unsigned int t[V4L2_MPEG_VIDEO_H264_VUI_SAR_IDC_EXTENDED + 1] = {
> @@ -1635,6 +2024,153 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
>  		p->codec.vp8.profile = ctrl->val;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:
> +		p->codec.hevc.rc_frame_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_QP:
> +		p->codec.hevc.rc_p_frame_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP:
> +		p->codec.hevc.rc_b_frame_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_FRAME_RATE_RESOLUTION:
> +		p->codec.hevc.rc_framerate = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP:
> +		p->codec.hevc.rc_min_qp = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP:
> +		p->codec.hevc.rc_max_qp = ctrl->val;
> +		break;

When you change this, you should call __v4l2_ctrl_modify_range to modify the
range of the controls that depend on this.

You can make a patch '13/12' for this or post a v9 for this patch. I would like to
see this implemented. It's one of those things that never gets implemented if you
don't address this now.

It shouldn't be difficult to do.

Regards,

	Hans
