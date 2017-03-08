From: gerg@uclinux.org (Greg Ungerer)
Date: Wed, 8 Mar 2017 22:39:21 +1000
Subject: [PATCH v2 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <29b174a1-bd4f-b030-23b7-ff6a7b4c9e83@arm.com>
References: <314159a7-b664-1256-647d-c05880ad7710@uclinux.org>
 <29b174a1-bd4f-b030-23b7-ff6a7b4c9e83@arm.com>
Message-ID: <2caee280-c35d-7d20-d374-f78fb93d4735@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 08/03/17 19:56, Vladimir Murzin wrote:
> On 08/03/17 03:21, Greg Ungerer wrote:
>> On 21/01/17 19:20, afzal mohammed write:
>>> No-MMU dynamic exception base address configuration on CP15
>>> processors. In the case of low vectors, decision based on whether
>>> security extensions are enabled & whether remap vectors to RAM
>>> CONFIG option is selected.
>>>
>>> For no-MMU without CP15, current default value of 0x0 is retained.
>>>
>>> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
>>
>> This patch (which is in mainline now as commit f8300a0b5d) breaks
>> my patch series to support running the Versatile QEMU target with
>> a nommu configured linux kernel. This series can be found here:
>>
>>  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/490653.html
>>
>> The problem is that QEMU is failing out with:
>>
>>  qemu: fatal: Trying to execute code outside RAM or ROM at 0x41069264
>>
>> when this your patch is applied.
>>
>>
>>> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
>>> index 2740967727e2..20ac52579952 100644
>>> --- a/arch/arm/mm/nommu.c
>>> +++ b/arch/arm/mm/nommu.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/kernel.h>
>>>
>>>  #include <asm/cacheflush.h>
>>> +#include <asm/cp15.h>
>>>  #include <asm/sections.h>
>>>  #include <asm/page.h>
>>>  #include <asm/setup.h>
>>> @@ -22,6 +23,8 @@
>>>
>>>  #include "mm.h"
>>>
>>> +unsigned long vectors_base;
>>> +
>>>  #ifdef CONFIG_ARM_MPU
>>>  struct mpu_rgn_info mpu_rgn_info;
>>>
>>> @@ -278,15 +281,60 @@ static void sanity_check_meminfo_mpu(void) {}
>>>  static void __init mpu_setup(void) {}
>>>  #endif /* CONFIG_ARM_MPU */
>>>
>>> +#ifdef CONFIG_CPU_CP15
>>> +#ifdef CONFIG_CPU_HIGH_VECTOR
>>> +static unsigned long __init setup_vectors_base(void)
>>> +{
>>> +	unsigned long reg = get_cr();
>>> +
>>> +	set_cr(reg | CR_V);
>>> +	return 0xffff0000;
>>> +}
>>> +#else /* CONFIG_CPU_HIGH_VECTOR */
>>> +/* Write exception base address to VBAR */
>>> +static inline void set_vbar(unsigned long val)
>>> +{
>>> +	asm("mcr p15, 0, %0, c12, c0, 0" : : "r" (val) : "cc");
>>> +}
>>> +
>>> +/*
>>> + * Security extensions, bits[7:4], permitted values,
>>> + * 0b0000 - not implemented, 0b0001/0b0010 - implemented
>>> + */
>>> +static inline bool security_extensions_enabled(void)
>>> +{
>>> +	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
>>
>> The problem is here. This ends up generating the asm code:
>>
>>   2ebacc:       ee103f31        mrc     15, 0, r3, cr0, cr1, {1}
>>
>> QEMU loses it on running this (confirmed by single stepping here).
>>
>> Is this valid for an ARM926EJ?
>> Or is it QEMU that is at fault here...
>>
>> I can see that this would be valid for an ARM11 for example
>> (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0360f/CHDGIJFB.html)
>>
>> But I could not see that it is valid on an ARM926
>> (http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0198e/I1003211.html)
>>
>> Maybe I am looking in the wrong place though.
>>
>> Thoughts?
>
> I'm wondering if something like bellow would help?
>
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 3b5c7aa..25542ec 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -303,7 +303,11 @@ static inline void set_vbar(unsigned long val)
>   */
>  static inline bool security_extensions_enabled(void)
>  {
> +#if __LINUX_ARM_ARCH__ < 6
> +	return 0;
> +#else
>  	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
> +#endif
>  }
>
>  static unsigned long __init setup_vectors_base(void)

Yes, that fixes the problem. Boots up fine with that applied.

Regards
Greg
