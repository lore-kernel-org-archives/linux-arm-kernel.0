From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 9 May 2016 17:47:06 +0200
Subject: [PATCH V4 1/2] vfio, platform: add support for ACPI during probe
 and reset
In-Reply-To: <1462136872-17590-2-git-send-email-okaya@codeaurora.org>
References: <1462136872-17590-1-git-send-email-okaya@codeaurora.org>
 <1462136872-17590-2-git-send-email-okaya@codeaurora.org>
Message-ID: <5730B0FA.1040303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,
On 05/01/2016 11:07 PM, Sinan Kaya wrote:
> The code is using the compatible DT string to associate a reset driver with
> the actual device itself. The compatible string does not exist on ACPI
> based systems. HID is the unique identifier for a device driver instead.
> 
> When ACPI is enabled, the change will query the presence of _RST method
> and will call it instead of querying an external reset driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 176 +++++++++++++++++++++-----
>  drivers/vfio/platform/vfio_platform_private.h |   7 +-
>  2 files changed, 147 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index e65b142..528ec04 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/device.h>
> +#include <linux/acpi.h>
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -41,7 +42,7 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>  		if (!strcmp(iter->compat, compat) &&
>  			try_module_get(iter->owner)) {
>  			*module = iter->owner;
> -			reset_fn = iter->reset;
> +			reset_fn = iter->of_reset;
>  			break;
>  		}
>  	}
> @@ -49,20 +50,111 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>  	return reset_fn;
>  }
>  
> -static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
> +
> +#ifdef CONFIG_ACPI
> +int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
> +			     struct device *dev)
>  {
> -	vdev->reset = vfio_platform_lookup_reset(vdev->compat,
> -						&vdev->reset_module);
> -	if (!vdev->reset) {
> -		request_module("vfio-reset:%s", vdev->compat);
> -		vdev->reset = vfio_platform_lookup_reset(vdev->compat,
> -							 &vdev->reset_module);
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	vdev->acpihid = acpi_device_hid(adev);
> +	if (!vdev->acpihid) {
> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
> +		       vdev->name);
> +		return -ENODEV;
>  	}
> +	return 0;
> +}
> +
> +static int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev)
> +{
> +	struct device *dev = vdev->device;
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +	acpi_status acpi_ret;
> +	unsigned long long val;
> +
> +	acpi_ret = acpi_evaluate_integer(handle, "_RST", NULL, &val);
> +	if (ACPI_FAILURE(acpi_ret))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
> +{
> +	struct device *dev = vdev->device;
> +	acpi_handle handle = ACPI_HANDLE(dev);
> +
> +	if (acpi_has_method(handle, "_RST"))
> +		return 0;
Can't you directly return acpi_has_method(handle, "_RST"), hence return
a boolean?
> +
> +	return -EINVAL;
> +}
> +#else
> +int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
> +			     struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +
> +static int vfio_platform_acpi_call_reset(struct vfio_platform_device *vdev)
> +{
> +	return -EINVAL;
> +}
> +
> +static int vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static int vfio_platform_has_reset(struct vfio_platform_device *vdev)
> +{
return a boolean?
> +	if (vdev->acpihid)
> +		return vfio_platform_acpi_has_reset(vdev);
> +
> +	if (vdev->of_reset)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
> +{
> +	int rc;
> +
> +	if (vdev->acpihid)
> +		return vfio_platform_acpi_has_reset(vdev);
> +
> +	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
> +						    &vdev->reset_module);
> +	if (vdev->of_reset)
> +		return 0;
> +
> +	rc = request_module("vfio-reset:%s", vdev->compat);
> +	if (rc)
> +		return rc;
> +
> +	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
> +						    &vdev->reset_module);
> +	if (vdev->of_reset)
> +		return 0;
> +
> +	return -EINVAL;
>  }
>  
>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>  {
> -	if (vdev->reset)
> +	if (vdev->acpihid)
> +		return;
> +
> +	if (vdev->of_reset)
>  		module_put(vdev->reset_module);
>  }
>  
> @@ -134,6 +226,20 @@ static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
>  	kfree(vdev->regions);
>  }
>  
> +static int vfio_platform_call_reset(struct vfio_platform_device *vdev)
> +{
> +	if (vdev->of_reset) {
> +		dev_info(vdev->device, "reset\n");
> +		vdev->of_reset(vdev);
return vdev->of_reset(vdev) to align with acpi reset behavior.
> +		return 0;
> +	} else if (vdev->acpihid) {
> +		return vfio_platform_acpi_call_reset(vdev);
I think it would make sense to have the same dev_info traces for dt and
acpi.
> +	}
> +
> +	dev_warn(vdev->device, "no reset function found!\n");
> +	return -EINVAL;
> +}
> +
>  static void vfio_platform_release(void *device_data)
>  {
>  	struct vfio_platform_device *vdev = device_data;
> @@ -141,12 +247,7 @@ static void vfio_platform_release(void *device_data)
>  	mutex_lock(&driver_lock);
>  
>  	if (!(--vdev->refcnt)) {
> -		if (vdev->reset) {
> -			dev_info(vdev->device, "reset\n");
> -			vdev->reset(vdev);
> -		} else {
> -			dev_warn(vdev->device, "no reset function found!\n");
> -		}
> +		vfio_platform_call_reset(vdev);
>  		vfio_platform_regions_cleanup(vdev);
>  		vfio_platform_irq_cleanup(vdev);
>  	}
> @@ -175,12 +276,9 @@ static int vfio_platform_open(void *device_data)
>  		if (ret)
>  			goto err_irq;
>  
> -		if (vdev->reset) {
> -			dev_info(vdev->device, "reset\n");
> -			vdev->reset(vdev);
> -		} else {
> -			dev_warn(vdev->device, "no reset function found!\n");
> -		}
> +		ret = vfio_platform_call_reset(vdev);
> +		if (ret)
> +			goto err_irq;
This change should be in next patch since if you fail finding a reset
function, you clean things up, mandating a reset function to exist.

Also in case the reset function fails you change the behavior which is
not detailed in the commit msg.
>  	}
>  
>  	vdev->refcnt++;
> @@ -213,7 +311,7 @@ static long vfio_platform_ioctl(void *device_data,
>  		if (info.argsz < minsz)
>  			return -EINVAL;
>  
> -		if (vdev->reset)
> +		if (!vfio_platform_has_reset(vdev))
>  			vdev->flags |= VFIO_DEVICE_FLAGS_RESET;
>  		info.flags = vdev->flags;
>  		info.num_regions = vdev->num_regions;
> @@ -312,10 +410,7 @@ static long vfio_platform_ioctl(void *device_data,
>  		return ret;
>  
>  	} else if (cmd == VFIO_DEVICE_RESET) {
> -		if (vdev->reset)
> -			return vdev->reset(vdev);
> -		else
> -			return -EINVAL;
> +		return vfio_platform_call_reset(vdev);
Here you also change the behavior: before, in case the dt reset failed
we returned an error. Now we return 0.

To me this patch would deserve to be split into 2 parts: ACPI probing
without reset and then ACPI reset. In case you change the behavior of
existing dt reset, please put that in a separate patch.

Best Regards

Eric
>  	}
>  
>  	return -ENOTTY;
> @@ -544,6 +639,21 @@ static const struct vfio_device_ops vfio_platform_ops = {
>  	.mmap		= vfio_platform_mmap,
>  };
>  
> +int vfio_platform_of_probe(struct vfio_platform_device *vdev,
> +			   struct device *dev)
> +{
> +	int ret;
> +
> +	ret = device_property_read_string(dev, "compatible",
> +					  &vdev->compat);
> +	if (ret) {
> +		pr_err("VFIO: cannot retrieve compat for %s\n",
> +			vdev->name);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  			       struct device *dev)
>  {
> @@ -553,14 +663,14 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  	if (!vdev)
>  		return -EINVAL;
>  
> -	ret = device_property_read_string(dev, "compatible", &vdev->compat);
> -	if (ret) {
> -		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
> -		return -EINVAL;
> -	}
> +	ret = vfio_platform_acpi_probe(vdev, dev);
> +	if (ret)
> +		ret = vfio_platform_of_probe(vdev, dev);
>  
> -	vdev->device = dev;
> +	if (ret)
> +		return ret;
>  
> +	vdev->device = dev;
>  	group = iommu_group_get(dev);
>  	if (!group) {
>  		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
> @@ -611,7 +721,7 @@ void vfio_platform_unregister_reset(const char *compat,
>  
>  	mutex_lock(&driver_lock);
>  	list_for_each_entry_safe(iter, temp, &reset_list, link) {
> -		if (!strcmp(iter->compat, compat) && (iter->reset == fn)) {
> +		if (!strcmp(iter->compat, compat) && (iter->of_reset == fn)) {
>  			list_del(&iter->link);
>  			break;
>  		}
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 42816dd..ba9e4f8 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -58,6 +58,7 @@ struct vfio_platform_device {
>  	struct mutex			igate;
>  	struct module			*parent_module;
>  	const char			*compat;
> +	const char			*acpihid;
>  	struct module			*reset_module;
>  	struct device			*device;
>  
> @@ -71,7 +72,7 @@ struct vfio_platform_device {
>  	struct resource*
>  		(*get_resource)(struct vfio_platform_device *vdev, int i);
>  	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
> -	int	(*reset)(struct vfio_platform_device *vdev);
> +	int	(*of_reset)(struct vfio_platform_device *vdev);
>  };
>  
>  typedef int (*vfio_platform_reset_fn_t)(struct vfio_platform_device *vdev);
> @@ -80,7 +81,7 @@ struct vfio_platform_reset_node {
>  	struct list_head link;
>  	char *compat;
>  	struct module *owner;
> -	vfio_platform_reset_fn_t reset;
> +	vfio_platform_reset_fn_t of_reset;
>  };
>  
>  extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
> @@ -103,7 +104,7 @@ extern void vfio_platform_unregister_reset(const char *compat,
>  static struct vfio_platform_reset_node __reset ## _node = {	\
>  	.owner = THIS_MODULE,					\
>  	.compat = __compat,					\
> -	.reset = __reset,					\
> +	.of_reset = __reset,					\
>  };								\
>  __vfio_platform_register_reset(&__reset ## _node)
>  
> 
