From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 23 May 2016 22:18:37 -0400
Subject: [PATCH V5 4/6] vfio: platform: add support for ACPI probe
In-Reply-To: <5743031B.5000208@linaro.org>
References: <1463364819-477-1-git-send-email-okaya@codeaurora.org>
 <1463364819-477-5-git-send-email-okaya@codeaurora.org>
 <5743031B.5000208@linaro.org>
Message-ID: <5743B9FD.5030501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/23/2016 9:18 AM, Eric Auger wrote:
> On 05/16/2016 04:13 AM, Sinan Kaya wrote:
>> The code is using the compatible DT string to associate a reset driver
>> with the actual device itself. The compatible string does not exist on
>> ACPI based systems. HID is the unique identifier for a device driver
>> instead.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c  | 58 ++++++++++++++++++++++++---
>>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>>  2 files changed, 54 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index 25378bd..d859d3b 100644
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
>> +int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +			     struct device *dev)
> should be static

makes sense

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
>> +	return 0;
>> +}
>> +#else
>> +int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +			     struct device *dev)
> static inline?

yup

>> +{
>> +	return -EINVAL;
> nit: -ENOENT ?

OK

>> +}
>> +#endif
>> +
>>  static bool vfio_platform_has_reset(struct vfio_platform_device *vdev)
>>  {
>>  	return vdev->of_reset ? true : false;
>> @@ -548,6 +580,21 @@ static const struct vfio_device_ops vfio_platform_ops = {
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
>> +	if (ret) {
>> +		pr_err("VFIO: cannot retrieve compat for %s\n",
>> +			vdev->name);
>> +		return ret;
>> +	}
>> +	return 0;
> nit: can be simplified by returning ret in any case.

will do

> 
> Best Regards
> 
> Eric
> 
>> +}
>> +
>>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>  			       struct device *dev)
>>  {
>> @@ -557,11 +604,12 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
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
>>
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
