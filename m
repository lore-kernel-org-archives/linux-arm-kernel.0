From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 15 Oct 2015 10:08:02 +0200
Subject: [PATCH] VFIO: platform: AMD xgbe reset module
In-Reply-To: <22278785.Xzxnmu2YlU@wuerfel>
References: <1444836792-2405-1-git-send-email-eric.auger@linaro.org>
 <22278785.Xzxnmu2YlU@wuerfel>
Message-ID: <561F5EE2.7010405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
On 10/14/2015 05:38 PM, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 15:33:12 Eric Auger wrote:
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -31,6 +31,11 @@ static const struct vfio_platform_reset_combo reset_lookup_table[] = {
>>                 .reset_function_name = "vfio_platform_calxedaxgmac_reset",
>>                 .module_name = "vfio-platform-calxedaxgmac",
>>         },
>> +       {
>> +               .compat = "amd,xgbe-seattle-v1a",
>> +               .reset_function_name = "vfio_platform_amdxgbe_reset",
>> +               .module_name = "vfio-platform-amdxgbe",
>> +       },
>>  };
>>  
>>  static void vfio_platform_get_reset(struct vfio_platform_device *vdev,
>>
> 
> This is causing build errors for me when CONFIG_MODULES is disabled.
Sorry about that and thanks for reporting the issue
> 
> Could this please be restructured so vfio_platform_get_reset does
> not attempt to call __symbol_get() but instead has the drivers
> register themselves properly to a subsystem?
OK

Could you elaborate about "has the drivers register themselves properly
to a subsystem".

My first proposal when coping with this problematic of being able to add
reset plugins to the vfio-platform driver was to create new drivers per
device requiring reset. but this was considered painful for end-users,
who needed to be aware of the right driver to bind - and I think that
makes sense - (https://lkml.org/lkml/2015/4/17/568) .

A naive question I dare to ask, wouldn't it be acceptable to make
vfio_platform depend on CONFIG_MODULES? Don't we disable modules for
security purpose? In that context would we use VFIO?

Best Regards

Eric
> 
> I don't see any way this could be fixed otherwise. The problem
> of course showed up with calxedaxgmac already, but I'd prefer not
> to see anything added there until the common code has been improved.
> 
> 	Arnd
> 
