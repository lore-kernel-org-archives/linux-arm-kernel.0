From: nm@ti.com (Nishanth Menon)
Date: Wed, 10 Jan 2018 15:52:21 -0600
Subject: [PATCH v2 1/6] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <6662dd72-121c-0cfb-ea31-aeecad4c7d03@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-2-marc.zyngier@arm.com>
 <20180110175322.GZ3875@atomide.com>
 <6662dd72-121c-0cfb-ea31-aeecad4c7d03@arm.com>
Message-ID: <87c06809-e035-52d7-0822-5fffb402c1dd@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2018 11:57 AM, Marc Zyngier wrote:
> On 10/01/18 17:53, Tony Lindgren wrote:
>> * Marc Zyngier <marc.zyngier@arm.com> [180108 19:00]:
>>> In order to avoid aliasing attacks against the branch predictor,
>>> some implementations require to invalidate the BTB when switching
>>> from one user context to another.
>>>
>>> For this, we reuse the existing implementation for Cortex-A8, and
>>> apply it to A9, A12 and A17.
>>
>> I suspect we now must also make sure Cortex-A8 has the IBE bit
>> set unconditionally for this to work. Currently the assumption is
>> that IBE bit needs to be set only on the earlier CPU revisions
>> that suffer from ARM_ERRATA_430973.
>>
>>> --- a/arch/arm/mm/proc-v7-2level.S
>>> +++ b/arch/arm/mm/proc-v7-2level.S
>>> @@ -41,7 +41,7 @@
>>>    *	even on Cortex-A8 revisions not affected by 430973.
>>>    *	If IBE is not set, the flush BTAC/BTB won't do anything.
>>>    */
>>> -ENTRY(cpu_ca8_switch_mm)
>>> +ENTRY(cpu_v7_btbinv_switch_mm)
>>>   #ifdef CONFIG_MMU
>>>   	mov	r2, #0
>>>   	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
>>
>> So without IBE set, as the comments above say, the flush won't
>> do anything.
> 
> Indeed. Firmware/bootloaders must be updated to set IBE, just like on
> Cortex-A15. I'll add a note to that effect.
OK. in u-boot, I had helped on the following:
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=5902f4ce0f2bd1411e40dc0ece3598a0fc19b2ae

maybe be build off that?

-- 
Regards,
Nishanth Menon
