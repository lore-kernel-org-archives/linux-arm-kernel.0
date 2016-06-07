From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 7 Jun 2016 22:21:13 +0200
Subject: [PATCH V6 7/8] vfio: platform: check reset call return code
 during open
In-Reply-To: <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
Message-ID: <5ae51f93-d141-00bf-f58f-40fbf7b1307d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
Le 29/05/2016 ? 00:01, Sinan Kaya a ?crit :
> Open call is ignoring the return code from reset call and can
> potentially continue even though reset call failed.
> 
> If reset_required module parameter is set, this patch is going
> to validate the return code and will abort open if reset fails.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index e87ceab..962cfb1 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -264,6 +264,8 @@ static int vfio_platform_open(void *device_data)
>  	mutex_lock(&driver_lock);
>  
>  	if (!vdev->refcnt) {
> +		const char *extra_dbg = NULL;
> +
>  		ret = vfio_platform_regions_init(vdev);
>  		if (ret)
>  			goto err_reg;
> @@ -272,7 +274,12 @@ static int vfio_platform_open(void *device_data)
>  		if (ret)
>  			goto err_irq;
>  
> -		vfio_platform_call_reset(vdev, NULL);
> +		ret = vfio_platform_call_reset(vdev, &extra_dbg);
> +		if (ret && vdev->reset_required) {
> +			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
> +				 ret, extra_dbg ? extra_dbg : "");
> +			goto err_irq;
I am afraid you need to tear down the resources allocated by vfio_platform_irq_init. 

Best Regards

Eric
> +		}
>  	}
>  
>  	vdev->refcnt++;
> 
