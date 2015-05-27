From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 May 2015 08:42:32 +0100
Subject: [v4 1/4] arm64: kvm: add a cpu tear-down function
In-Reply-To: <55655470.4020807@linaro.org>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
 <1431047884-5637-2-git-send-email-takahiro.akashi@linaro.org>
 <55643C56.5040600@arm.com> <55655470.4020807@linaro.org>
Message-ID: <55657568.5010305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

On 27/05/15 06:21, AKASHI Takahiro wrote:
> Marc,
> 
> Thank you for your reviews:
> 
> On 05/26/2015 06:26 PM, Marc Zyngier wrote:
>> Hi Takahiro,
>>
>> On 08/05/15 02:18, AKASHI Takahiro wrote:
>>> Cpu must be put back into its initial state, at least, in the
>>> following cases in order to shutdown the system and/or re-initialize cpus
>>> later on:
>>> 1) kexec/kdump
>>> 2) cpu hotplug (offline)
>>> 3) removing kvm as a module
>>>
>>> To address those issues in later patches, this patch adds a tear-down
>>> function, kvm_cpu_reset(), that disables D-cache & MMU and restore a vector
>>> table to the initial stub at EL2.
>>>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>   arch/arm/kvm/arm.c                |   15 +++++++++++++++
>>>   arch/arm/kvm/mmu.c                |    5 +++++
>>>   arch/arm64/include/asm/kvm_asm.h  |    1 +
>>>   arch/arm64/include/asm/kvm_host.h |   11 +++++++++++
>>>   arch/arm64/include/asm/kvm_mmu.h  |    7 +++++++
>>>   arch/arm64/include/asm/virt.h     |   11 +++++++++++
>>>   arch/arm64/kvm/hyp-init.S         |   32 ++++++++++++++++++++++++++++++++
>>>   arch/arm64/kvm/hyp.S              |   16 +++++++++++++---
>>>   8 files changed, 95 insertions(+), 3 deletions(-)
>>>

[...]

>>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>>> index c319116..2614cfc 100644
>>> --- a/arch/arm64/kvm/hyp-init.S
>>> +++ b/arch/arm64/kvm/hyp-init.S
>>> @@ -115,6 +115,38 @@ target: /* We're now in the trampoline code, switch page tables */
>>>   	eret
>>>   ENDPROC(__kvm_hyp_init)
>>>
>>> +	/*
>>> +	 * x0: HYP boot pgd
>>> +	 * x1: HYP phys_idmap_start
>>> +	 * x2: HYP stub vectors
>>> +	 */
>>> +ENTRY(__kvm_hyp_reset)
>>> +	/* We're in trampoline code in VA, switch back to boot page tables */
>>> +	msr	ttbr0_el2, x0
>>> +	isb
>>> +
>>> +	/* Invalidate the old TLBs */
>>> +	tlbi	alle2
>>> +	dsb	sy
>>> +
>>> +	/* Branch into PA space */
>>> +	adr	x0, 1f
>>> +	bfi	x1, x0, #0, #PAGE_SHIFT
>>> +	br	x1
>>> +
>>> +	/* We're now in idmap, disable MMU */
>>> +1:	mrs	x0, sctlr_el2
>>> +	ldr	x1, =SCTLR_EL2_FLAGS
>>> +	bic	x0, x0, x1		// Clear SCTL_M and etc
>>> +	msr	sctlr_el2, x0
>>> +	isb
>>> +
>>> +	/* Install stub vectors */
>>> +	msr	vbar_el2, x2
>>
>> Instead of using a parameter, can't you just do
>>
>> 	adr	x2, __hyp_stub_vectors
>> 	msr	vbar_el2, x2
>>
>> ? I can't imagine a case where we don't want this behaviour, and this
>> would slightly simplify the calling convention.
> 
> Yeah, but it will also enforces kvm to be statically linked to the kernel.
> (not module-capable) Is that OK?

I don't think this enforces anything to be statically linked. You don't
have to refer to the symbol from C code for module linking to work. You
may have to use a combination of ADRP + ADD :lo12: to make sure you can
reach the symbol (ADR is limited to +/- 1MB).

[...]

>>> -1:	/* Default to HVC_CALL_HYP. */
>>> +	/* jump into trampoline code */
>>> +1:	cmp	x18, #HVC_RESET
>>> +	b.ne	2f
>>> +	br	x3				// no return
>>
>> Same here. If we're always jumping to the trampoline code, why do we
>> have to pass it as a parameter?
> 
> We need here a physical address of reset function. It seems easy to call
> kvm_virt_to_trampoline() in C code. But, yes, we can also do it in asm.

I think that would be a lot clearer as it will be self-contained.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
