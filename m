From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 18 Jan 2013 20:03:12 +0530
Subject: [PATCH 1/1] ARM: Add API to detect SCU base address from CP15
In-Reply-To: <20130118162958.8e7491cb4c0487c86ccd0071@nvidia.com>
References: <1358506755-13705-1-git-send-email-hdoyu@nvidia.com>
 <50F9460A.6010600@ti.com>
 <20130118162958.8e7491cb4c0487c86ccd0071@nvidia.com>
Message-ID: <50F95D28.8030601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 January 2013 07:59 PM, Hiroshi Doyu wrote:
> On Fri, 18 Jan 2013 13:54:34 +0100
> Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>
>> On Friday 18 January 2013 04:29 PM, Hiroshi Doyu wrote:
>>> Add API to detect SCU base address from CP15.
>>>
>>> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
>>> ---
>>> NOTE:
>>> This wasn't delivered to linux-arm-kernel at lists.infradead.org, resending....
>>>
>>> For usage: http://patchwork.ozlabs.org/patch/212013/
>>> ---
>>>    arch/arm/include/asm/smp_scu.h |   17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
>>> index 4eb6d00..f619eef 100644
>>> --- a/arch/arm/include/asm/smp_scu.h
>>> +++ b/arch/arm/include/asm/smp_scu.h
>>> @@ -6,6 +6,23 @@
>>>    #define SCU_PM_POWEROFF	3
>>>
>>>    #ifndef __ASSEMBLER__
>>> +
>>> +#include <asm/cputype.h>
>>> +
>>> +static inline phys_addr_t scu_get_base(void)
>>> +{
>>> +	phys_addr_t pa;
>>> +	unsigned long part_number = read_cpuid_part_number();
>>> +
>>> +	switch (part_number) {
>>> +	case ARM_CPU_PART_CORTEX_A9:
>>> +		/* Get SCU physical base */
>>> +		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
>>> +		return pa;
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>> You may not need the switch case considering peripheral SCU is
>> specific to A9 SOCs. Would just if like below is better ?
>>
>> phys_addr_t pa = 0;
>>
>> if (ARM_CPU_PART_CORTEX_A9 == read_cpuid_part_number())
>> 	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
>> return pa;
>
> I just considered the case if there will be another A?, which is SCU
> detectable, added later. If no possibility, yours would be enough.
>
We can convert if into switch case if we need that in
future :-) For now if() should be just fine. Feel
free add my ack on updated patch.

Regards,
Santosh
