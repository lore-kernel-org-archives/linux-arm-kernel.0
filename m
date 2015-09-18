From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 18 Sep 2015 08:59:44 +0200
Subject: [PATCH 16/16] phy: phy-core: fix initcall level
In-Reply-To: <55FBAC2D.1020301@ti.com>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
 <1440592108-3740-17-git-send-email-holler@ahsoftware.de>
 <55FBAC2D.1020301@ti.com>
Message-ID: <55FBB660.4020302@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.09.2015 um 08:16 schrieb Kishon Vijay Abraham I:
> Hi,
>
> On Wednesday 26 August 2015 05:58 PM, Alexander Holler wrote:
>> The phy-core has to be initialized before other dependent usb-drivers,
>> otherwise a crash might occur.
>>
>> Currently phy_core_init() is called in the initcall-level device, which is
>> the same level where most usb-drivers will end up. By luck this seemed to
>> have been called most of the time before other usb-drivers without having
>> been explicitly enforced. But if phy_core_init() is not called before a
>> dependent driver, a null-pointer exception might occur (e.g. because the
>> phy device class isn't registered).
>
> Did you actually face a problem? IIUC the modules get loaded based on
> the drivers/Makefile order (unless the other modules are in a different
> initcall table).

I had a problem while playing with a modified init-system (based on 
dependencies). So not an actual problem.

> IMHO the fix should be in the module that caused the crash. Change it to
> use module_init?

The problem arises if the init-system ignores the link order and assumes 
all drivers in the same initcall level can be called without any special 
ordering.
The problem might also appear if a driver changes its name, directory or 
position in file system. E.g. how to you make sure that a driver in 
staging will be linked after the phy-core? Actually this happens, but I 
would assume its by luck. I assume if staging would be renamed to 
'beta-quality' a lot of stuff would actually fail because of the problem 
with the implicit link order.

Anyway, nothing which really has to be fixed. It's just a notice that 
maybe another initcall level of 'subsys' or something else before 
'device' might be a better place for phy-core. I've chosen fs_sync 
instead of subsys because otherwise I would have had to look up if 
phy-core depends on another subsystem and therefore has to be 
initialized after subsys.

Regards,

Alexander Holler

>
> Thanks
> Kishon
>
>>
>> To fix this, phy_core_init() is moved to the initcall-level fs (right
>> before the standard initcall level device).
>>
>> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
>> ---
>>   drivers/phy/phy-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index fc48fac..4945029 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -930,7 +930,7 @@ static int __init phy_core_init(void)
>>
>>   	return 0;
>>   }
>> -module_init(phy_core_init);
>> +fs_initcall_sync(phy_core_init);
>>
>>   static void __exit phy_core_exit(void)
>>   {
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
