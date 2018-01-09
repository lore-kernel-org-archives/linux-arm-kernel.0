From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Jan 2018 14:22:13 +0000
Subject: [PATCH v2 1/6] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <06eb2573-ad3f-c980-ca15-8becfa600f62@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-2-marc.zyngier@arm.com>
 <5b7b171c-ea22-7c65-de8d-cb953a6f1ec3@arm.com>
 <06eb2573-ad3f-c980-ca15-8becfa600f62@arm.com>
Message-ID: <50bb5eb2-9a3f-6d69-28bf-c32d576a2c7d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/18 14:21, Marc Zyngier wrote:
> On 09/01/18 14:14, Andre Przywara wrote:
>> Hi,
>>
>> On 08/01/18 18:55, Marc Zyngier wrote:
>>> In order to avoid aliasing attacks against the branch predictor,
>>> some implementations require to invalidate the BTB when switching
>>> from one user context to another.
>>>
>>> For this, we reuse the existing implementation for Cortex-A8, and
>>> apply it to A9, A12 and A17.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm/mm/proc-v7-2level.S |  4 ++--
>>>  arch/arm/mm/proc-v7-3level.S |  6 ++++++
>>>  arch/arm/mm/proc-v7.S        | 30 +++++++++++++++---------------
>>>  3 files changed, 23 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
>>> index c6141a5435c3..0422e58b74e8 100644
>>> --- a/arch/arm/mm/proc-v7-2level.S
>>> +++ b/arch/arm/mm/proc-v7-2level.S
>>> @@ -41,7 +41,7 @@
>>>   *	even on Cortex-A8 revisions not affected by 430973.
>>>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
>>>   */
>>> -ENTRY(cpu_ca8_switch_mm)
>>> +ENTRY(cpu_v7_btbinv_switch_mm)
>>>  #ifdef CONFIG_MMU
>>>  	mov	r2, #0
>>>  	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
>>> @@ -66,7 +66,7 @@ ENTRY(cpu_v7_switch_mm)
>>>  #endif
>>>  	bx	lr
>>>  ENDPROC(cpu_v7_switch_mm)
>>> -ENDPROC(cpu_ca8_switch_mm)
>>> +ENDPROC(cpu_v7_btbinv_switch_mm)
>>>  
>>>  /*
>>>   *	cpu_v7_set_pte_ext(ptep, pte)
>>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>>> index 7d16bbc4102b..f6adfe88ead2 100644
>>> --- a/arch/arm/mm/proc-v7-3level.S
>>> +++ b/arch/arm/mm/proc-v7-3level.S
>>> @@ -54,6 +54,11 @@
>>>   * Set the translation table base pointer to be pgd_phys (physical address of
>>>   * the new TTB).
>>>   */
>>> +ENTRY(cpu_v7_btbinv_switch_mm)
>>> +#ifdef CONFIG_MMU
>>> +	mov	r3, #0
>>
>> As Robin pointed out correctly, BPIALL ignores Rt, so you can get rid of
>> that line entirely (which is not matching the actual Rt below, btw).
>> Might be worth to add a comment about this.
> I know. I just kept it out of consistency with the existing Cortex-A8
> workaround, which may or may not behave the same way (I don't have one
> around to test...).

[pressed send too quickly]

And yes, the r2/r3 business is yet another blunder. Duh.

	M.
-- 
Jazz is not dead. It just smells funny...
