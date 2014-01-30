From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Thu, 30 Jan 2014 08:39:24 +0100
Subject: [PATCH v2 2/2] drivers/media: s5p-mfc: Add Horizontal and Vertical
 MV Search Range
In-Reply-To: <1391060563-27015-3-git-send-email-amit.grover@samsung.com>
References: <52E0ED10.2020901@samsung.com>
 <1391060563-27015-1-git-send-email-amit.grover@samsung.com>
 <1391060563-27015-3-git-send-email-amit.grover@samsung.com>
Message-ID: <52EA01AC.3000706@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2014 06:42 AM, Amit Grover wrote:
> This patch adds Controls to set Horizontal and Vertical search range
> for Motion Estimation block for Samsung MFC video Encoders.
> 
> Signed-off-by: Swami Nathan <swaminath.p@samsung.com>
> Signed-off-by: Amit Grover <amit.grover@samsung.com>
> ---
>  drivers/media/platform/s5p-mfc/regs-mfc-v6.h    |    1 +
>  drivers/media/platform/s5p-mfc/s5p_mfc_common.h |    2 ++
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c    |   24 +++++++++++++++++++++++
>  drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c |    8 ++------
>  4 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v6.h b/drivers/media/platform/s5p-mfc/regs-mfc-v6.h
> index 2398cdf..8d0b686 100644
> --- a/drivers/media/platform/s5p-mfc/regs-mfc-v6.h
> +++ b/drivers/media/platform/s5p-mfc/regs-mfc-v6.h
> @@ -229,6 +229,7 @@
>  #define S5P_FIMV_E_PADDING_CTRL_V6		0xf7a4
>  #define S5P_FIMV_E_MV_HOR_RANGE_V6		0xf7ac
>  #define S5P_FIMV_E_MV_VER_RANGE_V6		0xf7b0
> +#define S5P_FIMV_E_MV_RANGE_V6_MASK		0x3fff
>  
>  #define S5P_FIMV_E_VBV_BUFFER_SIZE_V6		0xf84c
>  #define S5P_FIMV_E_VBV_INIT_DELAY_V6		0xf850
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
> index 6920b54..b90ee34 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_common.h
> @@ -430,6 +430,8 @@ struct s5p_mfc_vp8_enc_params {
>  struct s5p_mfc_enc_params {
>  	u16 width;
>  	u16 height;
> +	u32 mv_h_range;
> +	u32 mv_v_range;
>  
>  	u16 gop_size;
>  	enum v4l2_mpeg_video_multi_slice_mode slice_mode;
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> index 4ff3b6c..704f30c1 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> @@ -208,6 +208,24 @@ static struct mfc_control controls[] = {
>  		.default_value = 0,
>  	},
>  	{
> +		.id = V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE,
> +		.type = V4L2_CTRL_TYPE_INTEGER,
> +		.name = "Horizontal MV Search Range",

Don't set the name here if the control is also defined in v4l2-ctrls.
That way the string from v4l2-ctrls is the leading definition.

Regards,

	Hans

> +		.minimum = 16,
> +		.maximum = 128,
> +		.step = 16,
> +		.default_value = 32,
> +	},
> +	{
> +		.id = V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE,
> +		.type = V4L2_CTRL_TYPE_INTEGER,
> +		.name = "Vertical MV Search Range",
> +		.minimum = 16,
> +		.maximum = 128,
> +		.step = 16,
> +		.default_value = 32,
> +	},
> +	{
>  		.id = V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE,
>  		.type = V4L2_CTRL_TYPE_INTEGER,
>  		.minimum = 0,
> @@ -1377,6 +1395,12 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
>  		p->vbv_size = ctrl->val;
>  		break;
> +	case V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE:
> +		p->mv_h_range = ctrl->val;
> +		break;
> +	case V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE:
> +		p->mv_v_range = ctrl->val;
> +		break;
>  	case V4L2_CID_MPEG_VIDEO_H264_CPB_SIZE:
>  		p->codec.h264.cpb_size = ctrl->val;
>  		break;
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> index 461358c..3c10188 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -727,14 +727,10 @@ static int s5p_mfc_set_enc_params(struct s5p_mfc_ctx *ctx)
>  	WRITEL(reg, S5P_FIMV_E_RC_CONFIG_V6);
>  
>  	/* setting for MV range [16, 256] */
> -	reg = 0;
> -	reg &= ~(0x3FFF);
> -	reg = 256;
> +	reg = (p->mv_h_range & S5P_FIMV_E_MV_RANGE_V6_MASK);
>  	WRITEL(reg, S5P_FIMV_E_MV_HOR_RANGE_V6);
>  
> -	reg = 0;
> -	reg &= ~(0x3FFF);
> -	reg = 256;
> +	reg = (p->mv_v_range & S5P_FIMV_E_MV_RANGE_V6_MASK);
>  	WRITEL(reg, S5P_FIMV_E_MV_VER_RANGE_V6);
>  
>  	WRITEL(0x0, S5P_FIMV_E_FRAME_INSERTION_V6);
> 
