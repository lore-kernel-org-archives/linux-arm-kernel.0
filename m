From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Jan 2018 14:46:09 +0000
Subject: [PATCH 1/3] arm: Add BTB invalidation on switch_mm for Cortex-A9,
 A12, A15 and A17
In-Reply-To: <432481b8-11f0-6ee2-8b5c-5ac20f5f27db@arm.com>
References: <20180106120907.26701-1-marc.zyngier@arm.com>
 <20180106120907.26701-2-marc.zyngier@arm.com>
 <432481b8-11f0-6ee2-8b5c-5ac20f5f27db@arm.com>
Message-ID: <f48d11af-32b7-1c20-abaa-1efdf24616d0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/18 14:29, Andre Przywara wrote:
> Hi,
> 
> On 06/01/18 12:09, Marc Zyngier wrote:
>> In order to avoid aliasing attacks against the branch predictor,
>> some implementations require to invalidate the BTB when switching
>> from one user context to another.
>>
>> For this, we reuse the existing implementation for Cortex-A8, and
>> apply it to A9, A12, A15, and A17.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mm/proc-v7-2level.S |  4 ++--
>>  arch/arm/mm/proc-v7-3level.S |  6 ++++++
>>  arch/arm/mm/proc-v7.S        | 32 ++++++++++++++++----------------
>>  3 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
>> index c6141a5435c3..0422e58b74e8 100644
>> --- a/arch/arm/mm/proc-v7-2level.S
>> +++ b/arch/arm/mm/proc-v7-2level.S
>> @@ -41,7 +41,7 @@
>>   *	even on Cortex-A8 revisions not affected by 430973.
>>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
>>   */
>> -ENTRY(cpu_ca8_switch_mm)
>> +ENTRY(cpu_v7_btbinv_switch_mm)
>>  #ifdef CONFIG_MMU
>>  	mov	r2, #0
>>  	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
>> @@ -66,7 +66,7 @@ ENTRY(cpu_v7_switch_mm)
>>  #endif
>>  	bx	lr
>>  ENDPROC(cpu_v7_switch_mm)
>> -ENDPROC(cpu_ca8_switch_mm)
>> +ENDPROC(cpu_v7_btbinv_switch_mm)
>>  
>>  /*
>>   *	cpu_v7_set_pte_ext(ptep, pte)
>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>> index 7d16bbc4102b..934272e1fa08 100644
>> --- a/arch/arm/mm/proc-v7-3level.S
>> +++ b/arch/arm/mm/proc-v7-3level.S
>> @@ -54,6 +54,11 @@
>>   * Set the translation table base pointer to be pgd_phys (physical address of
>>   * the new TTB).
>>   */
>> +ENTRY(cpu_v7_btbinv_switch_mm)
>> +#ifdef CONFIG_MMU
>> +	mov	r2, #0
>> +	mcr	p15, 0, r2, c7, c5, 6			@ flush BTAC/BTB
> 
> r2 is already used below: this is the second argument to the function.
> The first argument is a phys_addr_t, so it takes both r0 and r1 already.
> That's why we need to use r3 above.
> This fixes a crash on the Midway for me.

I suppose you have DRAM above 4GB. Lucky you! I'll fix that in v2.

Thanks for the heads up.

	M.
-- 
Jazz is not dead. It just smells funny...
