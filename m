From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Feb 2018 10:09:04 +0000
Subject: [PATCH v4 4/6] arm: Add icache invalidation on switch_mm for
 Cortex-A15
In-Reply-To: <20180205100034.GS21802@cbox>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
 <20180201110738.5421-5-marc.zyngier@arm.com> <20180205100034.GS21802@cbox>
Message-ID: <4d5bc4a5-484e-4176-8eff-3ac26e9e150a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/18 10:00, Christoffer Dall wrote:
> On Thu, Feb 01, 2018 at 11:07:36AM +0000, Marc Zyngier wrote:
>> In order to avoid aliasing attacks against the branch predictor,
>> Cortex-A15 require to invalidate the BTB when switching
>> from one user context to another. The only way to do so on this
>> CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
>> mode.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/mm/proc-v7-2level.S | 10 ++++++++++
>>  arch/arm/mm/proc-v7-3level.S | 10 ++++++++++
>>  arch/arm/mm/proc-v7.S        | 23 ++++++++++++++++++++++-
>>  3 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
>> index 0422e58b74e8..6d81ed7b2cb0 100644
>> --- a/arch/arm/mm/proc-v7-2level.S
>> +++ b/arch/arm/mm/proc-v7-2level.S
>> @@ -40,7 +40,16 @@
>>   *	Note that we always need to flush BTAC/BTB if IBE is set
>>   *	even on Cortex-A8 revisions not affected by 430973.
>>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
>> + *
>> + *	Cortex-A15 requires ACTLR[0] to be set from secure in order
>> + *	for the icache invalidation to also invalidate the BTB.
>>   */
>> +ENTRY(cpu_v7_icinv_switch_mm)
>> +#ifdef CONFIG_MMU
>> +	mcr	p15, 0, r0, c7, c5, 0		@ ICIALLU
>> +	/* Fall through to switch_mm... */
>> +#endif
> 
> aren't we falling through to cpu_v7_btbinv_switch_mm including the 
> btb invalidation used for ca8 et al. here?  Maybe we just don't care?

The trick is that on A15 (which is the only CPU using the ICIALLU code),
the BTB invalidation is a NOP, so executing it doesn't really hurt.

>> +
>>  ENTRY(cpu_v7_btbinv_switch_mm)
>>  #ifdef CONFIG_MMU
>>  	mov	r2, #0
>> @@ -67,6 +76,7 @@ ENTRY(cpu_v7_switch_mm)
>>  	bx	lr
>>  ENDPROC(cpu_v7_switch_mm)
>>  ENDPROC(cpu_v7_btbinv_switch_mm)
>> +ENDPROC(cpu_v7_icinv_switch_mm)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
