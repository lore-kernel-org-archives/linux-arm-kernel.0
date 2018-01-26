From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 26 Jan 2018 08:20:41 -0800
Subject: [PATCH v3 4/6] arm: Add icache invalidation on switch_mm for
 Cortex-A15
In-Reply-To: <38746bda-6773-41e7-3b2f-7f9476ef9fb2@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-5-marc.zyngier@arm.com> <20180126091425.GU21802@cbox>
 <38746bda-6773-41e7-3b2f-7f9476ef9fb2@arm.com>
Message-ID: <d3252795-ae63-693a-4e63-4a1df074d342@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/26/2018 01:30 AM, Marc Zyngier wrote:
> On 26/01/18 09:14, Christoffer Dall wrote:
>> On Thu, Jan 25, 2018 at 03:21:37PM +0000, Marc Zyngier wrote:
>>> In order to avoid aliasing attacks against the branch predictor,
>>> Cortex-A15 require to invalidate the BTB when switching
>>> from one user context to another. The only way to do so on this
>>> CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
>>> mode.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm/mm/proc-v7-2level.S | 10 ++++++++++
>>>  arch/arm/mm/proc-v7-3level.S | 16 ++++++++++++++++
>>>  arch/arm/mm/proc-v7.S        | 18 +++++++++++++++++-
>>>  3 files changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
>>> index 0422e58b74e8..7dc9e1c69039 100644
>>> --- a/arch/arm/mm/proc-v7-2level.S
>>> +++ b/arch/arm/mm/proc-v7-2level.S
>>> @@ -40,7 +40,17 @@
>>>   *	Note that we always need to flush BTAC/BTB if IBE is set
>>>   *	even on Cortex-A8 revisions not affected by 430973.
>>>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
>>> + *
>>> + *	Cortex-A15 requires ACTLR[0] to be set from secure in order
>>> + *	for the icache invalidation to also invalidate the BTB.
>>>   */
>>
>> Seems like we can read (but not write) this bit from non-secure.  Should
>> we test if it's set somewhere during boot and warn the user if not?
> 
> That would have to be something that happens much later in the boot
> process, as the proc structure is picked up very early, before we run
> any C code.
> 
> I could add some detection code later, but we'll be stuck with a icache
> invalidation for nothing. Not a pretty situation.

Would it make sense to put some code in the decompressor (maybe some
people don't use the decompressor...) similar to how we check for an
ARMv7 CPU w/o LPAE attempting to boot a LPAE enabled kernel for instance.

This is not technically a hard failure if ACTLR[0] is not set,
everything will still work fine, it just is not ideal from a security
perspective.

Should we have a Kconfig option, similar to what Nishanth proposed for
u-boot, with which we could guard an optional check against ACTLR[0]
being set?

> 
>>
>>> +ENTRY(cpu_ca15_switch_mm)
>>> +#ifdef CONFIG_MMU
>>> +	mcr	p15, 0, r0, c7, c5, 0			@ ICIALLU
>>> +	isb
>>> +	b	cpu_v7_switch_mm
>>> +#endif
>>> +ENDPROC(cpu_ca15_switch_mm)
>>>  ENTRY(cpu_v7_btbinv_switch_mm)
>>>  #ifdef CONFIG_MMU
>>>  	mov	r2, #0
>>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>>> index 934272e1fa08..cae6bb4da956 100644
>>> --- a/arch/arm/mm/proc-v7-3level.S
>>> +++ b/arch/arm/mm/proc-v7-3level.S
>>> @@ -71,6 +71,22 @@ ENTRY(cpu_v7_switch_mm)
>>>  ENDPROC(cpu_v7_switch_mm)
>>>  ENDPROC(cpu_v7_btbinv_switch_mm)
>>>  
>>> +/*
>>> + *	Cortex-A15 requires ACTLR[0] to be set from secure in order
>>> + *	for the icache invalidation to also invalidate the BTB.
>>> + */
>>> +ENTRY(cpu_ca15_switch_mm)
>>> +#ifdef CONFIG_MMU
>>> +	mcr	p15, 0, r0, c7, c5, 0			@ ICIALLU
>>> +	mmid	r2, r2
>>> +	asid	r2, r2
>>> +	orr	rpgdh, rpgdh, r2, lsl #(48 - 32)	@ upper 32-bits of pgd
>>> +	mcrr	p15, 0, rpgdl, rpgdh, c2		@ set TTB 0
>>> +	isb
>>> +#endif
>>> +	ret	lr
>>> +ENDPROC(cpu_ca15_switch_mm)
>>> +
>>
>> There's some potential for code shaing with cpu_v7_switch_mm here,
>> either via a macro or by simply calling cpu_v7_switch_mm from
>> cpu_ca15_switch_mm, but I'm not sure if we care?
> 
> We could, but most things seems to been duplicated between the two
> page-table implementations. I can look in to it if this is going anywhere.
> 
>>
>>>  #ifdef __ARMEB__
>>>  #define rl r3
>>>  #define rh r2
>>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>>> index 0a14967fd400..9310fd9aa1cf 100644
>>> --- a/arch/arm/mm/proc-v7.S
>>> +++ b/arch/arm/mm/proc-v7.S
>>> @@ -173,6 +173,21 @@ ENDPROC(cpu_v7_do_resume)
>>>  	globl_equ	cpu_v7_btbinv_do_resume,	cpu_v7_do_resume
>>>  #endif
>>>  
>>> +/*
>>> + * Cortex-A15 that require an icache invalidation on switch_mm
>>
>> uber nit: The wording is weird here, how about "Cortex-A15 requires
>> an..." ?
> 
> Sure.
> 
> Thanks,
> 
> 	M.
> 

-- 
Florian
