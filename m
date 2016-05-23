From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 23 May 2016 15:16:39 +0200
Subject: [PATCH V5 3/6] vfio: platform: determine reset capability
In-Reply-To: <1463364819-477-4-git-send-email-okaya@codeaurora.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
 <1463364819-477-4-git-send-email-okaya@codeaurora.org>
Message-ID: <574302B7.7010605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2016 04:13 AM, Sinan Kaya wrote:
> Creating a new function to determine if this driver supports reset
> function or not. This is an attempt to abstract device tree calls
> from the rest of the code.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index cb91dd3..25378bd 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -49,6 +49,11 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>  	return reset_fn;
>  }
>  
> +static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
> +{
> +	return vdev->of_reset ? true : false;
> +}
> +
>  static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  {
>  	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
> @@ -215,7 +220,7 @@ static long vfio_platform_ioctl(void *device_data,
>  		if (info.argsz < minsz)
>  			return -EINVAL;
>  
> -		if (vdev->of_reset)
> +		if (vfio_platform_has_reset(vdev))
>  			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
>  		info.flags = vdev->flags;
>  		info.num_regions = vdev->num_regions;
> 
Reviewed-by: Eric Auger <eric.auger@linaro.org>

Eric
