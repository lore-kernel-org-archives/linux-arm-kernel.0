From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 14 Jul 2016 15:41:46 -0600
Subject: [PATCH V9 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <1468461995-32676-5-git-send-email-okaya@codeaurora.org>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-5-git-send-email-okaya@codeaurora.org>
Message-ID: <20160714154146.38e37d84@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2016 22:06:30 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> The code is using the compatible DT string to associate a reset driver
> with the actual device itself. The compatible string does not exist on
> ACPI based systems. HID is the unique identifier for a device driver
> instead.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 70 +++++++++++++++++++++++++--
>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>  2 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index 6be92c3..ff148764 100644
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
> @@ -49,6 +50,33 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>  	return reset_fn;
>  }
>

This function still feels a bit sloppy
  
> +static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
> +				    struct device *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);

When !CONFIG_ACPI, this returns NULL

> +
> +	if (acpi_disabled)

When !CONFIG_ACPI, this is defined as 1, so we'll always exit here.

> +		return -EPERM;
> +
> +	if (!adev) {

This is really the only (ACPI_CONFIG && !acpi_disabled) error exit,
because...

> +		pr_err("VFIO: ACPI companion device not found for %s\n",
> +			vdev->name);
> +		return -ENODEV;
> +	}
> +
> +#ifdef CONFIG_ACPI
> +	vdev->acpihid = acpi_device_hid(adev);

This can't actually return NULL.  So the test below is unreached.
Maybe we should just conclude this function here with:

#endif

return vdev->acpihid ? 0 : -ENOENT;

which is even still a bit paranoid since it can't actually happen.

> +	if (!vdev->acpihid) {
> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
> +		       vdev->name);
> +		return -EINVAL;
> +	}
> +	return 0;
> +#else
> +	return -ENOENT;
> +#endif
> +}
> +
>  static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>  {
>  	return vdev->of_reset ? true : false;
> @@ -547,6 +575,37 @@ static const struct vfio_device_ops vfio_platform_ops = {
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
> +	if (ret)
> +		pr_err("VFIO: cannot retrieve compat for %s\n",
> +			vdev->name);
> +
> +	return ret;
> +}
> +
> +/*
> + * There can be two kernel build combinations. One build where
> + * ACPI is not selected in Kconfig and another one with the ACPI Kconfig.
> + *
> + * In the first case, vfio_platform_acpi_probe will return since
> + * acpi_disabled  * is 1. DT user will not see any kind of messages from

                    ^^ Previous editing cruft?

> + * ACPI.
> + *
> + * In the second case, both DT and ACPI is compiled in but the system is
> + * booting with any of these combinations.
> + *
> + * If the firmware is DT type, then acpi_disabled is 1. The ACPI probe routine
> + * terminates immediately without any messages.
> + *
> + * If the firmware is ACPI type, then acpi_disabled is 0. All other checks are
> + * valid checks. We cannot claim that this system is DT.
> + */
>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  			       struct device *dev)
>  {
> @@ -556,11 +615,12 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
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
> +
> +	if (ret)
> +		return ret;
>  
>  	vdev->device = dev;
>  
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 71ed7d1..ba9e4f8 100644
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
