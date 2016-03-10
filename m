From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 10 Mar 2016 12:13:28 -0500
Subject: [PATCH 1/2] vfio, platform: add support for ACPI while detecting
 the reset driver
In-Reply-To: <56E14858.9050401@linaro.org>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
 <56E14858.9050401@linaro.org>
Message-ID: <56E1AB38.8020702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/10/2016 5:11 AM, Eric Auger wrote:
> Hi Sinan,
> On 03/08/2016 04:33 PM, Sinan Kaya wrote:
>> The  code is using the compatible DT string to associate a reset driver with
>> the actual device itself. The compatible string does not exist on ACPI
>> based systems. HID is the unique identifier for a device driver instead.
>> The change allows a driver to register with DT compatible string or ACPI
>> HID and then match the object with one of these conditions.
>>
>> Rules for loading the reset driver are as follow:
>> - ACPI HID needs match for ACPI systems
>> - DT compat needs to match for OF systems
>>
>> Tested-by: Eric Auger <eric.auger@linaro.org> (device tree only)
>> Tested-by: Shanker Donthineni <shankerd@codeaurora.org> (ACPI only)
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  .../vfio/platform/reset/vfio_platform_amdxgbe.c    |   4 +-
>>  .../platform/reset/vfio_platform_calxedaxgmac.c    |   4 +-
>>  drivers/vfio/platform/vfio_platform_common.c       | 112 +++++++++++++++++----
>>  drivers/vfio/platform/vfio_platform_private.h      |  43 ++++----
>>  4 files changed, 125 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
>> index d4030d0..170dcf5 100644
>> --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
>> +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
>> @@ -119,7 +119,9 @@ int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>>  	return 0;
>>  }
>>  
>> -module_vfio_reset_handler("amd,xgbe-seattle-v1a", vfio_platform_amdxgbe_reset);
>> +module_vfio_reset_handler("amd,xgbe-seattle-v1a", NULL,
>> +			  vfio_platform_amdxgbe_reset);
>> +VFIO_PLATFORM_MODULE_ALIAS("amd,xgbe-seattle-v1a");
> Looks the other overridden MODULE_ALIAS have a naming like
> MODULE_ALIAS_something? what about MODULE_ALIAS_VFIO_PLATFORM_RESET?
> not very compact but maybe closer to what it stands for.

alright, I'll follow that.

>>  
>>  MODULE_VERSION("0.1");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
>> index e3d3d94..635c6e0 100644
>> --- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
>> +++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
>> @@ -77,7 +77,9 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
>>  	return 0;
>>  }
>>  
>> -module_vfio_reset_handler("calxeda,hb-xgmac", vfio_platform_calxedaxgmac_reset);
>> +module_vfio_reset_handler("calxeda,hb-xgmac", NULL,
>> +			  vfio_platform_calxedaxgmac_reset);
>> +VFIO_PLATFORM_MODULE_ALIAS("calxeda,hb-xgmac");
>>  
>>  MODULE_VERSION(DRIVER_VERSION);
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index 418cdd9..c758e72 100644
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
>> @@ -31,14 +32,22 @@ static LIST_HEAD(reset_list);
>>  static DEFINE_MUTEX(driver_lock);
>>  
>>  static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>> -					struct module **module)
>> +				  const char *acpihid, struct module **module)
>>  {
>>  	struct vfio_platform_reset_node *iter;
>>  	vfio_platform_reset_fn_t reset_fn = NULL;
>>  
>>  	mutex_lock(&driver_lock);
>>  	list_for_each_entry(iter, &reset_list, link) {
>> -		if (!strcmp(iter->compat, compat) &&
>> +		if (acpihid && iter->acpihid &&
>> +		    !strcmp(iter->acpihid, acpihid) &&
>> +			try_module_get(iter->owner)) {
>> +			*module = iter->owner;
>> +			reset_fn = iter->reset;
>> +			break;
>> +		}
>> +		if (compat && iter->compat &&
>> +		    !strcmp(iter->compat, compat) &&
>>  			try_module_get(iter->owner)) {
>>  			*module = iter->owner;
>>  			reset_fn = iter->reset;
>> @@ -49,15 +58,30 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
>>  	return reset_fn;
>>  }
>>  
>> -static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>> +static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
> What is the point returning a value here? See my comment at the end.

I was trying to do some error handling here. If a driver does not have a
reset implementation, we are letting it go right now. 

I think we need to make reset driver a requirement. Mark Rutland reminded me 
that I need a reset driver. 

I did not think about it during implementation and I have not seen any 
warnings like you said.

>>  {
>> -	vdev->reset = vfio_platform_lookup_reset(vdev->compat,
>> -						&vdev->reset_module);
>> -	if (!vdev->reset) {
>> -		request_module("vfio-reset:%s", vdev->compat);
>> -		vdev->reset = vfio_platform_lookup_reset(vdev->compat,
>> -							 &vdev->reset_module);
>> -	}


>>  
>> -	vfio_platform_get_reset(vdev);
>> +	ret = vfio_platform_get_reset(vdev);
>> +	if (ret) {
>> +		iommu_group_put(group);
>> +		return ret;
>> +	}
> This change is not related to your commit message. Also here you change
> the use model of VFIO platform and forbid any usage if no reset module
> is available, right? I don't think this is something we discussed and I
> think it removes some flexibility. Currently a warning is emitted in
> case we don't have a reset function.

Well, I haven't seen that warning during testing. I was trying to be more 
proactive.

I'm fine removing these checks but not having a reset driver needs a really
big warning here.

> 
> Best Regards
> 
> Eric
>>  



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
