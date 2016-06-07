From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 7 Jun 2016 22:28:25 +0200
Subject: [PATCH V6 8/8] vfio: platform: check reset call return code
 during release
In-Reply-To: <1464472878-27176-9-git-send-email-okaya@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-9-git-send-email-okaya@codeaurora.org>
Message-ID: <2ecf0796-f711-8554-9567-061f3ac5e6eb@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
Le 29/05/2016 ? 00:01, Sinan Kaya a ?crit :
> Release call is ignoring the return code from reset call and can
> potentially continue even though reset call failed.
> 
> If reset_required module parameter is set, this patch is going
> to validate the return code and will cause stack dump with
> WARN_ON and warn the user of failure.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 962cfb1..bb05ca0 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -243,7 +243,15 @@ static void vfio_platform_release(void *device_data)
>  	mutex_lock(&driver_lock);
>  
>  	if (!(--vdev->refcnt)) {
> -		vfio_platform_call_reset(vdev, NULL);
> +		const char *extra_dbg = NULL;
> +		int ret;
> +
> +		ret = vfio_platform_call_reset(vdev, &extra_dbg);
> +		if (ret && vdev->reset_required) {
> +			dev_warn(vdev->device, "reset driver is required and reset call failed in release (%d) %s\n",
> +				 ret, extra_dbg ? extra_dbg : "");
> +			WARN_ON(1);
> +		}
>  		vfio_platform_regions_cleanup(vdev);
>  		vfio_platform_irq_cleanup(vdev);
>  	}
> 
Looks OK to me
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
