From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 23 May 2016 17:20:06 +0200
Subject: [PATCH V5 6/6] vfio, platform: make reset driver a requirement by
 default
In-Reply-To: <1463364819-477-7-git-send-email-okaya@codeaurora.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
 <1463364819-477-7-git-send-email-okaya@codeaurora.org>
Message-ID: <57431FA6.8060405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
On 05/16/2016 04:13 AM, Sinan Kaya wrote:
> The code was allowing platform devices to be used without a supporting
> VFIO reset driver. The hardware can be left in some inconsistent state
> after a guest machine abort.
> 
> The reset driver will put the hardware back to safe state and disable
> interrupts before returning the control back to the host machine.

The commit message should describe the new module option.

You should also describe this is not just a matter of having a reset
function implemented & found somewhere but also a matter of having the
reset call to succeed. A reset failure now induce a failure on the first
open(). Shouldn't we handle this failure in a separate patch to make
this clearer?
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_amba.c             |  5 +++++
>  drivers/vfio/platform/vfio_platform.c         |  5 +++++
>  drivers/vfio/platform/vfio_platform_common.c  | 18 ++++++++++++++----
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  4 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index a66479b..7585902 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -23,6 +23,10 @@
>  #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
>  #define DRIVER_DESC     "VFIO for AMBA devices - User Level meta-driver"
>  
> +static bool reset_required = true;
> +module_param(reset_required, bool, 0644);
> +MODULE_PARM_DESC(reset_required, "override reset requirement (default: 1)");
> +
>  /* probing devices from the AMBA bus */
>  
>  static struct resource *get_amba_resource(struct vfio_platform_device *vdev,
> @@ -68,6 +72,7 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
>  	vdev->get_resource = get_amba_resource;
>  	vdev->get_irq = get_amba_irq;
>  	vdev->parent_module = THIS_MODULE;
> +	vdev->reset_required = reset_required;
>  
>  	ret = vfio_platform_probe_common(vdev, &adev->dev);
>  	if (ret) {
> diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
> index b1cc3a7..ef89146 100644
> --- a/drivers/vfio/platform/vfio_platform.c
> +++ b/drivers/vfio/platform/vfio_platform.c
> @@ -23,6 +23,10 @@
>  #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
>  #define DRIVER_DESC     "VFIO for platform devices - User Level meta-driver"
>  
> +static bool reset_required = true;
> +module_param(reset_required, bool, 0644);
> +MODULE_PARM_DESC(reset_required, "override reset requirement (default: 1)");
> +
>  /* probing devices from the linux platform bus */
>  
>  static struct resource *get_platform_resource(struct vfio_platform_device *vdev,
> @@ -66,6 +70,7 @@ static int vfio_platform_probe(struct platform_device *pdev)
>  	vdev->get_resource = get_platform_resource;
>  	vdev->get_irq = get_platform_irq;
>  	vdev->parent_module = THIS_MODULE;
> +	vdev->reset_required = reset_required;
>  
>  	ret = vfio_platform_probe_common(vdev, &pdev->dev);
>  	if (ret)
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 095d5b7..89fb18f 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -121,10 +121,10 @@ static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>  	return vdev->of_reset ? true : false;
>  }
>  
> -static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
> +static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  {
>  	if (vdev->acpihid)
> -		return;
> +		return vfio_platform_acpi_has_reset(vdev) ? 0 : -EINVAL;
-ENOENT instead?
>  
>  	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>  						    &vdev->reset_module);
> @@ -133,6 +133,8 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>  		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>  							&vdev->reset_module);
>  	}
> +
> +	return vdev->of_reset ? 0 : -EINVAL;
same
>  }
>  
>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
> @@ -263,7 +265,9 @@ static int vfio_platform_open(void *device_data)
>  		if (ret)
>  			goto err_irq;
>  
> -		vfio_platform_call_reset(vdev);
> +		ret = vfio_platform_call_reset(vdev);
> +		if (ret && vdev->reset_required)
> +			goto err_irq;

what do we do at release time in case the reset fails. You did not
change anything. Shouldn't we at least emit a warning to the user if the
reset becomes mandated (separate patch as evoked above)?

Thanks

Eric
>  	}
>  
>  	vdev->refcnt++;
> @@ -669,7 +673,13 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  		return ret;
>  	}
>  
> -	vfio_platform_get_reset(vdev);
> +	ret = vfio_platform_get_reset(vdev);
> +	if (ret && vdev->reset_required) {
> +		pr_err("vfio: no reset function found for device %s\n",
> +		       vdev->name);
> +		iommu_group_put(group);
> +		return ret;

> +	}
>  
>  	mutex_init(&vdev->igate);
>  
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index ba9e4f8..68fbc00 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -50,6 +50,7 @@ struct vfio_platform_region {
>  };
>  
>  struct vfio_platform_device {
> +	bool				reset_required;
>  	struct vfio_platform_region	*regions;
>  	u32				num_regions;
>  	struct vfio_platform_irq	*irqs;
> 
