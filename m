From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 17 Jun 2016 09:13:48 +0200
Subject: [PATCH 6/6] [media] gsc-m2m: improve v4l2_capability driver and
 card fields
In-Reply-To: <1466113235-25909-7-git-send-email-javier@osg.samsung.com>
References: <1466113235-25909-1-git-send-email-javier@osg.samsung.com>
 <1466113235-25909-7-git-send-email-javier@osg.samsung.com>
Message-ID: <5763A32C.2000307@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2016 11:40 PM, Javier Martinez Canillas wrote:
> According to the V4L2 documentation the driver and card fields should be
> used to identify the driver and the device but the gsc-m2m driver fills
> those field using the platform device name, which in turn is the name of
> the device DT node.
> 
> So not only the filled information isn't correct but also the same values
> are used in the driver, card and bus_info fields.
> 
> Before this patch:
> 
> Driver Info (not using libv4l2):
>         Driver name   : 13e00000.video-
>         Card type     : 13e00000.video-scaler
>         Bus info      : platform:13e00000.video-scaler
>         Driver version: 4.7.0
> 
> After this patch:
> 
> Driver Info (not using libv4l2):
>         Driver name   : exynos-gsc
>         Card type     : exynos-gsc gscaler
>         Bus info      : platform:13e00000.video-scaler
>         Driver version: 4.7.0
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

Hans

> 
> ---
> 
>  drivers/media/platform/exynos-gsc/gsc-m2m.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> index af81383086b8..274861c27367 100644
> --- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
> +++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> @@ -279,8 +279,8 @@ static int gsc_m2m_querycap(struct file *file, void *fh,
>  	struct gsc_ctx *ctx = fh_to_ctx(fh);
>  	struct gsc_dev *gsc = ctx->gsc_dev;
>  
> -	strlcpy(cap->driver, gsc->pdev->name, sizeof(cap->driver));
> -	strlcpy(cap->card, gsc->pdev->name, sizeof(cap->card));
> +	strlcpy(cap->driver, GSC_MODULE_NAME, sizeof(cap->driver));
> +	strlcpy(cap->card, GSC_MODULE_NAME " gscaler", sizeof(cap->card));
>  	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
>  		 dev_name(&gsc->pdev->dev));
>  	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE |
> 
