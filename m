From: alex.williamson@redhat.com (Alex Williamson)
Date: Wed, 13 May 2015 12:32:39 -0600
Subject: [PATCH 3/5] VFIO: platform: add reset callback
In-Reply-To: <1431008843-28411-4-git-send-email-eric.auger@linaro.org>
References: <1431008843-28411-1-git-send-email-eric.auger@linaro.org>
 <1431008843-28411-4-git-send-email-eric.auger@linaro.org>
Message-ID: <1431541959.3625.54.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-07 at 16:27 +0200, Eric Auger wrote:
> A new reset callback is introduced. If this callback is populated,
> the reset is invoked on device release or upon userspace ioctl. The
> modality is exposed on VFIO_DEVICE_GET_INFO.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> v2 -> v3:
> - change patch title and commit message. Use IS_ERR_OR_NULL to
>   anticipate for getter returned value.
> 
> v1 -> v2:
> - On VFIO_DEVICE_RESET returns -EINVAL in case the callback is not
>   populated (instead of -ENOTTY)
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 12 ++++++++++--
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index edbf24c..0d10018 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -103,6 +103,8 @@ static void vfio_platform_release(void *device_data)
>  	mutex_lock(&driver_lock);
>  
>  	if (!(--vdev->refcnt)) {
> +		if (!IS_ERR_OR_NULL(vdev->reset))
> +			vdev->reset(vdev);


It seems sloppy to have a function pointer that could be ERR_PTR.

Should we also be trying to reset on device open?

>  		vfio_platform_regions_cleanup(vdev);
>  		vfio_platform_irq_cleanup(vdev);
>  	}
> @@ -162,6 +164,8 @@ static long vfio_platform_ioctl(void *device_data,
>  		if (info.argsz < minsz)
>  			return -EINVAL;
>  
> +		if (!IS_ERR_OR_NULL(vdev->reset))
> +			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
>  		info.flags = vdev->flags;
>  		info.num_regions = vdev->num_regions;
>  		info.num_irqs = vdev->num_irqs;
> @@ -255,8 +259,12 @@ static long vfio_platform_ioctl(void *device_data,
>  
>  		return ret;
>  
> -	} else if (cmd == VFIO_DEVICE_RESET)
> -		return -EINVAL;
> +	} else if (cmd == VFIO_DEVICE_RESET) {
> +		if (!IS_ERR_OR_NULL(vdev->reset))
> +			return vdev->reset(vdev);
> +		else
> +			return -EINVAL;
> +	}
>  
>  	return -ENOTTY;
>  }
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 68909a4..84ccf6d 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -68,6 +68,7 @@ struct vfio_platform_device {
>  		(*get_resource)(struct vfio_platform_device *vdev, int i);
>  	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
>  	struct device *(*get_device)(struct vfio_platform_device *vdev);
> +	int	(*reset)(struct vfio_platform_device *vdev);
>  };
>  
>  typedef int (*vfio_platform_reset_fn_t)(struct vfio_platform_device *vdev);
