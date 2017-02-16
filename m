From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 16 Feb 2017 12:29:11 +0100
Subject: [PATCH v4 30/36] media: imx: update capture dev format on IDMAC
 output pad set_fmt
In-Reply-To: <1487211578-11360-31-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-31-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487244551.2377.35.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> When configuring the IDMAC output pad formats (in ipu_csi,
> ipu_ic_prpenc, and ipu_ic_prpvf subdevs), the attached capture
> device format must also be updated.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/staging/media/imx/imx-ic-prpencvf.c | 9 +++++++++
>  drivers/staging/media/imx/imx-media-csi.c   | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
> index 2be8845..6e45975 100644
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@ -739,6 +739,7 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
>  		       struct v4l2_subdev_format *sdformat)
>  {
>  	struct prp_priv *priv = sd_to_priv(sd);
> +	struct imx_media_video_dev *vdev = priv->vdev;
>  	const struct imx_media_pixfmt *cc;
>  	struct v4l2_mbus_framefmt *infmt;
>  	u32 code;
> @@ -800,6 +801,14 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
>  	} else {
>  		priv->format_mbus[sdformat->pad] = sdformat->format;
>  		priv->cc[sdformat->pad] = cc;
> +		if (sdformat->pad == PRPENCVF_SRC_PAD) {
> +			/*
> +			 * update the capture device format if this is
> +			 * the IDMAC output pad
> +			 */
> +			imx_media_mbus_fmt_to_pix_fmt(&vdev->fmt.fmt.pix,
> +						      &sdformat->format, cc);
> +		}

This is replaced again by patch 36. These should probably be squashed
together.

regards
Philipp
