From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 10 Feb 2017 07:58:41 +0100
Subject: [PATCH v2 1/4] [media] exynos-gsc: Use 576p instead 720p as a
 threshold for colorspaces
In-Reply-To: <20170209200420.3046-2-thibault.saunier@osg.samsung.com>
References: <20170209200420.3046-1-thibault.saunier@osg.samsung.com>
 <CGME20170209200635epcas1p468de5bbd46e247ff583d3d97cfe1840b@epcas1p4.samsung.com>
 <20170209200420.3046-2-thibault.saunier@osg.samsung.com>
Message-ID: <9d2b9454-7ed0-b596-05eb-e0588311fc94@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.02.2017 21:04, Thibault Saunier wrote:
> From: Javier Martinez Canillas <javier@osg.samsung.com>
>
> The media documentation says that the V4L2_COLORSPACE_SMPTE170M colorspace
> should be used for SDTV and V4L2_COLORSPACE_REC709 for HDTV. But drivers
> don't agree on the display resolution that should be used as a threshold.
>
> Some drivers set V4L2_COLORSPACE_REC709 for 720p and higher while others
> set V4L2_COLORSPACE_REC709 for anything higher than 576p. Newers drivers
> use the latter and that also matches what user-space multimedia programs
> do (i.e: GStreamer), so change the driver logic to be aligned with this.
>
> Also, check for the resolution in G_FMT instead unconditionally setting
> the V4L2_COLORSPACE_REC709 colorspace.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

--
Regards
Andrzej
> ---
>  drivers/media/platform/exynos-gsc/gsc-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/exynos-gsc/gsc-core.c b/drivers/media/platform/exynos-gsc/gsc-core.c
> index cbb03768f5d7..2beb43401987 100644
> --- a/drivers/media/platform/exynos-gsc/gsc-core.c
> +++ b/drivers/media/platform/exynos-gsc/gsc-core.c
> @@ -445,7 +445,7 @@ int gsc_try_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
>  
>  	pix_mp->num_planes = fmt->num_planes;
>  
> -	if (pix_mp->width >= 1280) /* HD */
> +	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
>  		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
>  	else /* SD */
>  		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
> @@ -492,7 +492,10 @@ int gsc_g_fmt_mplane(struct gsc_ctx *ctx, struct v4l2_format *f)
>  	pix_mp->height		= frame->f_height;
>  	pix_mp->field		= V4L2_FIELD_NONE;
>  	pix_mp->pixelformat	= frame->fmt->pixelformat;
> -	pix_mp->colorspace	= V4L2_COLORSPACE_REC709;
> +	if (pix_mp->width > 720 && pix_mp->height > 576) /* HD */
> +		pix_mp->colorspace = V4L2_COLORSPACE_REC709;
> +	else /* SD */
> +		pix_mp->colorspace = V4L2_COLORSPACE_SMPTE170M;
>  	pix_mp->num_planes	= frame->fmt->num_planes;
>  
>  	for (i = 0; i < pix_mp->num_planes; ++i) {
