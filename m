From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 15 Jul 2016 21:27:24 -0400
Subject: [PATCH V9 4/9] vfio: platform: add support for ACPI probe
In-Reply-To: <20160714154146.38e37d84@t450s.home>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-5-git-send-email-okaya@codeaurora.org>
 <20160714154146.38e37d84@t450s.home>
Message-ID: <bd8dacde-da6c-2353-7488-58b2f050699c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/14/2016 5:41 PM, Alex Williamson wrote:
> On Wed, 13 Jul 2016 22:06:30 -0400
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
>>  drivers/vfio/platform/vfio_platform_common.c  | 70 +++++++++++++++++++++++++--
>>  drivers/vfio/platform/vfio_platform_private.h |  1 +
>>  2 files changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index 6be92c3..ff148764 100644
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
>> @@ -49,6 +50,33 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>>  	return reset_fn;
>>  }
>>
> 
> This function still feels a bit sloppy
>   
>> +static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>> +				    struct device *dev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> 
> When !CONFIG_ACPI, this returns NULL
> 
>> +
>> +	if (acpi_disabled)
> 
> When !CONFIG_ACPI, this is defined as 1, so we'll always exit here.
> 
>> +		return -EPERM;
>> +

I'll move this here and leave the variable definition above only.

	adev = ACPI_COMPANION(dev);

>> +	if (!adev) {
> 
> This is really the only (ACPI_CONFIG && !acpi_disabled) error exit,
> because...
> 
>> +		pr_err("VFIO: ACPI companion device not found for %s\n",
>> +			vdev->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +#ifdef CONFIG_ACPI
>> +	vdev->acpihid = acpi_device_hid(adev);
> 

Based on the current implementation of acpi_device_hid, the function wlll 
return a name of "device" when the pnp device id list is empty. 

Do you want to rely on the current implementation behavior rather than be
safe?

> This can't actually return NULL.  So the test below is unreached.
> Maybe we should just conclude this function here with:
> 
> #endif
> 
> return vdev->acpihid ? 0 : -ENOENT;
> 
> which is even still a bit paranoid since it can't actually happen.
> 
>> +	if (!vdev->acpihid) {
>> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
>> +		       vdev->name);
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +#else
>> +	return -ENOENT;
>> +#endif
>> +}
>> +


>> +
>> +/*
>> + * There can be two kernel build combinations. One build where
>> + * ACPI is not selected in Kconfig and another one with the ACPI Kconfig.
>> + *
>> + * In the first case, vfio_platform_acpi_probe will return since
>> + * acpi_disabled  * is 1. DT user will not see any kind of messages from
> 
>                     ^^ Previous editing cruft?

Yep, good catch. Got warned by checkpatch for 80 characters. 



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
