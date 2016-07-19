From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 18 Jul 2016 18:24:48 -0600
Subject: [PATCH V10 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <b4655a0ba9152e6b2951e379e1615dad@codeaurora.org>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
 <1468883367-2854-5-git-send-email-okaya@codeaurora.org>
 <20160718180049.78db3dfb@t450s.home>
 <b4655a0ba9152e6b2951e379e1615dad@codeaurora.org>
Message-ID: <20160718182448.7b11a7af@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jul 2016 20:16:50 -0400
okaya at codeaurora.org wrote:

> On 2016-07-18 20:00, Alex Williamson wrote:
> > On Mon, 18 Jul 2016 19:09:22 -0400
> > Sinan Kaya <okaya@codeaurora.org> wrote:
> >   
> >> The code is using the compatible DT string to associate a reset driver
> >> with the actual device itself. The compatible string does not exist on
> >> ACPI based systems. HID is the unique identifier for a device driver
> >> instead.
> >> 
> >> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> >> ---
> >>  drivers/vfio/platform/vfio_platform_common.c  | 69 
> >> +++++++++++++++++++++++++--
> >>  drivers/vfio/platform/vfio_platform_private.h |  1 +
> >>  2 files changed, 65 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/drivers/vfio/platform/vfio_platform_common.c 
> >> b/drivers/vfio/platform/vfio_platform_common.c
> >> index 6be92c3..a5299f6 100644
> >> --- a/drivers/vfio/platform/vfio_platform_common.c
> >> +++ b/drivers/vfio/platform/vfio_platform_common.c
> >> @@ -13,6 +13,7 @@
> >>   */
> >> 
> >>  #include <linux/device.h>
> >> +#include <linux/acpi.h>
> >>  #include <linux/iommu.h>
> >>  #include <linux/module.h>
> >>  #include <linux/mutex.h>
> >> @@ -49,6 +50,32 @@ static vfio_platform_reset_fn_t 
> >> vfio_platform_lookup_reset(const char *compat,
> >>  	return reset_fn;
> >>  }
> >> 
> >> +static int vfio_platform_acpi_probe(struct vfio_platform_device 
> >> *vdev,
> >> +				    struct device *dev)
> >> +{
> >> +	struct acpi_device *adev;
> >> +
> >> +	if (acpi_disabled)
> >> +		return -EPERM;
> >> +
> >> +	adev = ACPI_COMPANION(dev);  
> > 
> > I didn't necessarily have a problem with this being set in the
> > declaration.  
> 
> I think this is better. If ACPI is disabled, it is dangerous to call an 
> ACPI API.

Ok, fair enough.

> >   
> >> +	if (!adev) {
> >> +		pr_err("VFIO: ACPI companion device not found for %s\n",
> >> +			vdev->name);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +#ifdef CONFIG_ACPI
> >> +	vdev->acpihid = acpi_device_hid(adev);
> >> +	if (!vdev->acpihid) {
> >> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
> >> +		       vdev->name);
> >> +		return -EINVAL;
> >> +	}
> >> +#endif
> >> +	return WARN_ON(!vdev->acpihid) ? -ENOENT : 0;  
> > 
> > ?!?!  The point was that that entire if{} branch is unnecessary.  The
> > WARN_ON handles the (impossible) case of !vdev->acpihid.  We just need:
> > 
> > #ifdef CONFIG_ACPI
> > 	vdev->acpihid = acpi_device_hid(adev);
> > #endif
> > 	return WARN_ON(!vdev->acpihid) ? -ENOENT : 0;
> >   
> 
> OK, got it now. I thought you were trying to get rid of #else
> 
> > nit, might make sense to replace EPERM with ENOENT and use EINVAL here.
> >   
> 
> Sure, will take carr of it.
> 
> Anything else I need to take care of?

Not that I see, maybe just send a new version of this patch if the
changes don't trickle through too much.  Thanks,

Alex

 
> >> +}
> >> +
> >>  static bool vfio_platform_has_reset(struct vfio_platform_device 
> >> *vdev)
> >>  {
> >>  	return vdev->of_reset ? true : false;
> >> @@ -547,6 +574,37 @@ static const struct vfio_device_ops 
> >> vfio_platform_ops = {
> >>  	.mmap		= vfio_platform_mmap,
> >>  };
> >> 
> >> +int vfio_platform_of_probe(struct vfio_platform_device *vdev,
> >> +			   struct device *dev)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = device_property_read_string(dev, "compatible",
> >> +					  &vdev->compat);
> >> +	if (ret)
> >> +		pr_err("VFIO: cannot retrieve compat for %s\n",
> >> +			vdev->name);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +/*
> >> + * There can be two kernel build combinations. One build where
> >> + * ACPI is not selected in Kconfig and another one with the ACPI 
> >> Kconfig.
> >> + *
> >> + * In the first case, vfio_platform_acpi_probe will return since
> >> + * acpi_disabled is 1. DT user will not see any kind of messages from
> >> + * ACPI.
> >> + *
> >> + * In the second case, both DT and ACPI is compiled in but the system 
> >> is
> >> + * booting with any of these combinations.
> >> + *
> >> + * If the firmware is DT type, then acpi_disabled is 1. The ACPI 
> >> probe routine
> >> + * terminates immediately without any messages.
> >> + *
> >> + * If the firmware is ACPI type, then acpi_disabled is 0. All other 
> >> checks are
> >> + * valid checks. We cannot claim that this system is DT.
> >> + */
> >>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
> >>  			       struct device *dev)
> >>  {
> >> @@ -556,11 +614,12 @@ int vfio_platform_probe_common(struct 
> >> vfio_platform_device *vdev,
> >>  	if (!vdev)
> >>  		return -EINVAL;
> >> 
> >> -	ret = device_property_read_string(dev, "compatible", &vdev->compat);
> >> -	if (ret) {
> >> -		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
> >> -		return -EINVAL;
> >> -	}
> >> +	ret = vfio_platform_acpi_probe(vdev, dev);
> >> +	if (ret)
> >> +		ret = vfio_platform_of_probe(vdev, dev);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> 
> >>  	vdev->device = dev;
> >> 
> >> diff --git a/drivers/vfio/platform/vfio_platform_private.h 
> >> b/drivers/vfio/platform/vfio_platform_private.h
> >> index 71ed7d1..ba9e4f8 100644
> >> --- a/drivers/vfio/platform/vfio_platform_private.h
> >> +++ b/drivers/vfio/platform/vfio_platform_private.h
> >> @@ -58,6 +58,7 @@ struct vfio_platform_device {
> >>  	struct mutex			igate;
> >>  	struct module			*parent_module;
> >>  	const char			*compat;
> >> +	const char			*acpihid;
> >>  	struct module			*reset_module;
> >>  	struct device			*device;
> >>   
