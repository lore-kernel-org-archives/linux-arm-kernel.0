From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Jul 2016 15:36:48 -0400
Subject: [PATCH V8 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <20160623123410.647b3be0@t450s.home>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
 <1466437879-32182-5-git-send-email-okaya@codeaurora.org>
 <20160623123410.647b3be0@t450s.home>
Message-ID: <604722bb-5e82-851f-c1a1-cb34b55bf77d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 6/23/2016 2:34 PM, Alex Williamson wrote:
> On Mon, 20 Jun 2016 11:51:14 -0400
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> The code is using the compatible DT string to associate a reset driver
>> with the actual device itself. The compatible string does not exist on
>> ACPI based systems. HID is the unique identifier for a device driver
>> instead.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c  | 57 ++++++++++++++++++++++++---
>>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>>  2 files changed, 53 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index 6be92c3..fbf4565 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -13,6 +13,7 @@
>>   */
>>  
>>  #include <linux/device.h>
>> +#include <linux/acpi.h>
>>  #include <linux/iommu.h>
>>  #include <linux/module.h>
>>  #include <linux/mutex.h>
>> @@ -49,6 +50,37 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>>  	return reset_fn;
>>  }
>>  
>> +#ifdef CONFIG_ACPI
>> +static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +				    struct device *dev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>> +
>> +	if (acpi_disabled)
>> +		return -ENODEV;
>> +
>> +	if (!adev) {
>> +		pr_err("VFIO: ACPI companion device not found for %s\n",
>> +			vdev->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	vdev->acpihid = acpi_device_hid(adev);
>> +	if (!vdev->acpihid) {
>> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
>> +		       vdev->name);
>> +		return -ENODEV;
>> +	}
> 
> Do you want to try to use different errnos here so you don't rely on
> the pr_err() calls for debugging?  I could imagine -EPERM, -ENODEV,
> -EINVAL respectively, but maybe there are better options.
> 

will do.

>> +	return 0;
>> +}
>> +#else
>> +static inline int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +					   struct device *dev)
>> +{
>> +	return -ENOENT;
>> +}
>> +#endif
>> +
>>  static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>>  {
>>  	return vdev->of_reset ? true : false;
>> @@ -547,6 +579,20 @@ static const struct vfio_device_ops vfio_platform_ops = {
>>  	.mmap		= vfio_platform_mmap,
>>  };
>>  
>> +int vfio_platform_of_probe(struct vfio_platform_device *vdev,
>> +			   struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	ret = device_property_read_string(dev, "compatible",
>> +					  &vdev->compat);
>> +	if (ret)
>> +		pr_err("VFIO: cannot retrieve compat for %s\n",
>> +			vdev->name);
> 
> Previously there was only one probe method and I imagine this pr_err
> was useful.  Now we have multiple methods of probing for the device.
> Do we really want each one generating pr_err messages or just one at
> the end if none of our probes worked?

IMO, the new approach is better and is more specific. The error messages
are firmware specific. The previous message included missing compat string
for instance doesn't exist on ACPI firmware and ACPI HID also doesn't exist
on DT firmware. 

I'd rather be verbose rather than a simple probe failed message.

> 
>> +
>> +	return ret;
>> +}
>> +
>>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>  			       struct device *dev)
>>  {
>> @@ -556,11 +602,12 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>  	if (!vdev)
>>  		return -EINVAL;
>>  
>> -	ret = device_property_read_string(dev, "compatible", &vdev->compat);
>> -	if (ret) {
>> -		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
>> -		return -EINVAL;
>> -	}
>> +	ret = vfio_platform_acpi_probe(vdev, dev);
>> +	if (ret)
>> +		ret = vfio_platform_of_probe(vdev, dev);
> 
> 
> The only out way out of vfio_platform_acpi_probe() without hitting a
> pr_err is one of (!CONFIG_ACPI || acpi_disabled || success).  Doesn't
> that make for some unnecessary warning for a DT user?

Let me explain the rationale.

As you know, there can be two kernel build combinations. One build where 
ACPI is not selected in Kconfig and another one with the ACPI Kconfig.

In the first case, CONFIG_ACPI is stubbed out in this file and DT user
will not see any kind of messages from ACPI. 

In the second case, both DT and ACPI is compiled in but the system is booting with
any of these combinations. 

If the firmware is DT type, then acpi_disabled is 1. The ACPI probe routine
terminates immediately without any messages. 

If the firmware is ACPI type, then acpi_disabled is 0. All other checks are valid
checks. We cannot claim that this system is DT.

> 
> 
>> +
>> +	if (ret)
>> +		return ret;
>>  
>>  	vdev->device = dev;
>>  
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
>> index 71ed7d1..ba9e4f8 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -58,6 +58,7 @@ struct vfio_platform_device {
>>  	struct mutex			igate;
>>  	struct module			*parent_module;
>>  	const char			*compat;
>> +	const char			*acpihid;
>>  	struct module			*reset_module;
>>  	struct device			*device;
>>  
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
