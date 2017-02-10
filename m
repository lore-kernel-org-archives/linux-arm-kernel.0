From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 10 Feb 2017 08:01:43 +0100
Subject: [PATCH v2 2/4] [media] exynos-gsc: Respect userspace colorspace
 setting
In-Reply-To: <20170209200420.3046-3-thibault.saunier@osg.samsung.com>
References: <20170209200420.3046-1-thibault.saunier@osg.samsung.com>
 <CGME20170209200635epcas2p1686b5b5522efe835f7a0b4505e16cf12@epcas2p1.samsung.com>
 <20170209200420.3046-3-thibault.saunier@osg.samsung.com>
Message-ID: <6c959d34-146b-53f2-f932-7ab4ff9e931c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.02.2017 21:04, Thibault Saunier wrote:
> If the colorspace is specified by userspace we should respect
> it and not reset it ourself if we can support it.
>
> Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
> ---
>  drivers/media/platform/exynos-gsc/gsc-core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
> index 2beb43401987..63bb4577827d 100644
> --- a/drivers/media/platform/exynos-gsc/gsc-core.c
> +++ b/drivers/media/platform/exynos-gsc/gsc-core.c
> @@ -445,10 +445,14 @@ int gsc_try_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
>  
>  	pix_mp->num_planes = fmt->num_planes;
>  
> -	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
> -		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
> -	else /* SD */
> -		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
> +	if (pix_mp->colorspace != V4L2_COLORSPACE_REC709 &&
> +		pix_mp->colorspace != V4L2_COLORSPACE_SMPTE170M &&
> +		pix_mp->colorspace != V4L2_COLORSPACE_DEFAULT) {
> +		if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
> +		  pix_mp->colorspace = V4L2_COLORSPACE_REC709;
> +		else /* SD */
> +		  pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
> +	  }
>  
>  	for (i = 0; i < pix_mp->num_planes; ++i) {
>  		struct v4l2_plane_pix_format *plane_fmt = &pix_mp->plane_fmt[i];
> @@ -492,12 +496,17 @@ int gsc_g_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
>  	pix_mp->height		= frame->f_height;
>  	pix_mp->field		= V4L2_FIELD_NONE;
>  	pix_mp->pixelformat	= frame->fmt->pixelformat;
> -	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
> -		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
> -	else /* SD */
> -		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
>  	pix_mp->num_planes	= frame->fmt->num_planes;
>  
> +	if (pix_mp->colorspace != V4L2_COLORSPACE_REC709 &&
> +		pix_mp->colorspace != V4L2_COLORSPACE_SMPTE170M &&
> +		pix_mp->colorspace != V4L2_COLORSPACE_DEFAULT) {
> +		if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
> +		  pix_mp->colorspace = V4L2_COLORSPACE_REC709;
> +		else /* SD */
> +		  pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
> +	  }
> +

This is g_fmt, so you set colorspace regardless of its current value, am
I right?

Regards
Andrzej

>  	for (i = 0; i < pix_mp->num_planes; ++i) {
>  		pix_mp->plane_fmt[i].bytesperline = (frame->f_width *
>  			frame->fmt->depth[i]) / 8;
