From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:54:53 +0000
Subject: [RFC PATCH 01/11] ARM: NOMMU: define stubs for fixup
In-Reply-To: <20161122094851.GT1041@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-2-git-send-email-vladimir.murzin@arm.com>
 <20161122094851.GT1041@n2100.armlinux.org.uk>
Message-ID: <583415ED.200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 09:48, Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2016 at 09:25:58AM +0000, Vladimir Murzin wrote:
>> When build for NOMMU following errors show ups:
>>
>> arch/arm/kernel/patch.c: In function 'patch_map':
>> arch/arm/kernel/patch.c:39:2: error: implicit declaration of function 'set_fixmap' [-Werror=implicit-function-declaration]
>>   set_fixmap(fixmap, page_to_phys(page));
>>   ^
>> arch/arm/kernel/patch.c:41:2: error: implicit declaration of function '__fix_to_virt' [-Werror=implicit-function-declaration]
>>   return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
>>   ^
>> arch/arm/kernel/patch.c: In function 'patch_unmap':
>> arch/arm/kernel/patch.c:47:2: error: implicit declaration of function 'clear_fixmap' [-Werror=implicit-function-declaration]
>>   clear_fixmap(fixmap);
>>   ^
>> cc1: some warnings being treated as errors
>>
>> Fixup does not make much sense in NOMMU configurations, so provide
>> stub definitions.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
> 
> I think there should be a Fixes: line for the commit which introduced
> this?

It was discovered only after PATCH 11/11 was applied. Without that patch this
error is unreachable, so no regression.

If you do think it is a good to have Fixes: I can add 

Fixes: ab0615e2d6fb (" arm: use fixmap for text patching when text is RO")

Cheers
Vladimir

> 
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/include/asm/fixmap.h |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
>> index 5c17d2d..0bfc2e3 100644
>> --- a/arch/arm/include/asm/fixmap.h
>> +++ b/arch/arm/include/asm/fixmap.h
>> @@ -59,6 +59,12 @@ enum fixed_addresses {
>>  
>>  #else
>>  
>> +#define set_fixmap(idx, phys)
>> +#define clear_fixmap(idx)
>> +
>> +#define __fix_to_virt(x)	(x)
>> +#define __virt_to_fix(x)	(x)
>> +
>>  static inline void early_fixmap_init(void) { }
>>  
>>  #endif
>> -- 
>> 1.7.9.5
>>
> 
