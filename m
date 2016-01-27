From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 Jan 2016 16:37:36 +0900
Subject: [PATCH 10/19] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <56A7B018.7050900@arm.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <ab2ffead6b80df7e0676bc7383c1183c1e50453f.1452884156.git.geoff@infradead.org>
 <56A7B018.7050900@arm.com>
Message-ID: <56A873C0.6090406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2016 02:42 AM, James Morse wrote:
> Hi!
>
> On 15/01/16 19:18, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> The current kvm implementation on arm64 does cpu-specific initialization
>> at system boot, and has no way to gracefully shutdown a core in terms of
>> kvm. This prevents, especially, kexec from rebooting the system on a boot
>> core in EL2.
>>
>> This patch adds a cpu tear-down function and also puts an existing cpu-init
>> code into a separate function, kvm_arch_hardware_disable() and
>> kvm_arch_hardware_enable() respectively.
>> We don't need arm64-specific cpu hotplug hook any more.
>>
>> Since this patch modifies common part of code between arm and arm64, one
>> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
>> compiling errors.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index e06fd29..e91f80e 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>
>>   #ifdef CONFIG_CPU_PM
>>   static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
>>   				    unsigned long cmd,
>>   				    void *v)
>>   {
>> -	if (cmd == CPU_PM_EXIT &&
>> -	    __hyp_get_vectors() == hyp_default_vectors) {
>> -		cpu_init_hyp_mode(NULL);
>> +	switch (cmd) {
>> +	case CPU_PM_ENTER:
>> +		if (__this_cpu_read(kvm_arm_hardware_enabled))
>> +			cpu_reset_hyp_mode();
>> +
>>   		return NOTIFY_OK;
>> -	}
>> +	case CPU_PM_EXIT:
>> +		if (__this_cpu_read(kvm_arm_hardware_enabled))
>> +			cpu_init_hyp_mode();
>
> I read this as:
> 		if (enabled)
> 			enable();
>
> What am I missing? Is there a missing '!'?
>
> [/me thinks some more]
>
> I suspect this is trying to be clever: leaving the flag set over a
> deep-sleep, to indicate that the hardware should be re-enabled when we
> resume... if so, a comment to that effect would be good.

Yep, I meant so. Will add some comment.

>
>>
>> -	return NOTIFY_DONE;
>> +		return NOTIFY_OK;
>> +
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>>   }
>>
>>   static struct notifier_block hyp_init_cpu_pm_nb = {
>
>> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
>> index 3070096..bca79f9 100644
>> --- a/arch/arm64/include/asm/virt.h
>> +++ b/arch/arm64/include/asm/virt.h
>> @@ -58,9 +58,18 @@
>>
>>   #define HVC_CALL_FUNC 3
>>
>> +/*
>> + * HVC_RESET_CPU - Reset cpu in EL2 to initial state.
>> + *
>> + * @x0: entry address in trampoline code in va
>> + * @x1: identical mapping page table in pa
>> + */
>> +
>>   #define BOOT_CPU_MODE_EL1	(0xe11)
>>   #define BOOT_CPU_MODE_EL2	(0xe12)
>>
>> +#define HVC_RESET_CPU 4
>> +
>
> Patch 5 added a fancy new way to call arbitrary functions at el2, why
> not use that? (it would save beating up el1_sync again).

Let me think. I need to detangle some header files.

> I agree the trampoline stuff is complicated - I will try and cook-up a
> version of this patch for hibernate that does this. (... and comment
> what I think is happening above while I'm at it)
>
>
>>   #ifndef __ASSEMBLY__
>>
>>   /*
>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>> index 1d7e502..d909ce2 100644
>> --- a/arch/arm64/kvm/hyp-init.S
>> +++ b/arch/arm64/kvm/hyp-init.S
>> @@ -140,6 +140,39 @@ merged:
>>   	eret
>>   ENDPROC(__kvm_hyp_init)
>>
>> +	/*
>> +	 * x0: HYP boot pgd
>> +	 * x1: HYP phys_idmap_start
>> +	 */
>> +ENTRY(__kvm_hyp_reset)
>> +	/* We're in trampoline code in VA, switch back to boot page tables */
>> +	msr	ttbr0_el2, x0
>> +	isb
>> +
>> +	/* Invalidate the old TLBs */
>> +	tlbi	alle2
>> +	dsb	sy
>> +
>> +	/* Branch into PA space */
>> +	adr	x0, 1f
>> +	bfi	x1, x0, #0, #PAGE_SHIFT
>> +	br	x1
>> +
>> +	/* We're now in idmap, disable MMU */
>> +1:	mrs	x0, sctlr_el2
>> +	ldr	x1, =SCTLR_ELx_FLAGS
>> +	bic	x0, x0, x1		// Clear SCTL_M and etc
>> +	msr	sctlr_el2, x0
>> +	isb
>> +
>> +	/* Install stub vectors */
>> +	adrp	x0, __hyp_stub_vectors
>> +	add	x0, x0, #:lo12:__hyp_stub_vectors
>
> adr_l ?

OK.

Thanks,
-Takahiro AKASHI

>> +	msr	vbar_el2, x0
>> +
>> +	eret
>> +ENDPROC(__kvm_hyp_reset)
>> +
>>   	.ltorg
>>
>>   	.popsection
>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> index 15b1ef9..ed82dc2 100644
>> --- a/arch/arm64/kvm/hyp.S
>> +++ b/arch/arm64/kvm/hyp.S
>> @@ -986,10 +991,27 @@ el1_sync:					// Guest trapped into EL2
>>   	cmp	x18, #HVC_GET_VECTORS
>>   	b.ne	1f
>>   	mrs	x0, vbar_el2
>> -	b	2f
>> -
>> -1:	/* Default to HVC_CALL_HYP. */
>> +	b	do_eret
>>
>> +	/* jump into trampoline code */
>> +1:	cmp	x18, #HVC_RESET_CPU
>> +	b.ne	2f
>> +	/*
>> +	 * Entry point is:
>> +	 *	TRAMPOLINE_VA
>> +	 *	+ (__kvm_hyp_reset - (__hyp_idmap_text_start & PAGE_MASK))
>> +	 */
>> +	adrp	x2, __kvm_hyp_reset
>> +	add	x2, x2, #:lo12:__kvm_hyp_reset
>> +	adrp	x3, __hyp_idmap_text_start
>> +	add	x3, x3, #:lo12:__hyp_idmap_text_start
>
> adr_l ?
>
>> +	and	x3, x3, PAGE_MASK
>> +	sub	x2, x2, x3
>> +	ldr	x3, =TRAMPOLINE_VA
>> +	add	x2, x2, x3
>> +	br	x2				// no return
>> +
>> +2:	/* Default to HVC_CALL_HYP. */
>>   	push	lr, xzr
>>
>>   	/*
>
>
> Thanks,
>
> James
>
