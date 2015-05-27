From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 May 2015 14:21:52 +0900
Subject: [v4 1/4] arm64: kvm: add a cpu tear-down function
In-Reply-To: <55643C56.5040600@arm.com>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
 <1431047884-5637-2-git-send-email-takahiro.akashi@linaro.org>
 <55643C56.5040600@arm.com>
Message-ID: <55655470.4020807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

Thank you for your reviews:

On 05/26/2015 06:26 PM, Marc Zyngier wrote:
> Hi Takahiro,
>
> On 08/05/15 02:18, AKASHI Takahiro wrote:
>> Cpu must be put back into its initial state, at least, in the
>> following cases in order to shutdown the system and/or re-initialize cpus
>> later on:
>> 1) kexec/kdump
>> 2) cpu hotplug (offline)
>> 3) removing kvm as a module
>>
>> To address those issues in later patches, this patch adds a tear-down
>> function, kvm_cpu_reset(), that disables D-cache & MMU and restore a vector
>> table to the initial stub at EL2.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm/kvm/arm.c                |   15 +++++++++++++++
>>   arch/arm/kvm/mmu.c                |    5 +++++
>>   arch/arm64/include/asm/kvm_asm.h  |    1 +
>>   arch/arm64/include/asm/kvm_host.h |   11 +++++++++++
>>   arch/arm64/include/asm/kvm_mmu.h  |    7 +++++++
>>   arch/arm64/include/asm/virt.h     |   11 +++++++++++
>>   arch/arm64/kvm/hyp-init.S         |   32 ++++++++++++++++++++++++++++++++
>>   arch/arm64/kvm/hyp.S              |   16 +++++++++++++---
>>   8 files changed, 95 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 07e7eb1..251ab9e 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -897,6 +897,21 @@ static void cpu_init_hyp_mode(void *dummy)
>>   	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
>>   }
>>
>> +static void kvm_cpu_reset(void *dummy)
>
> It looks like you can entirely loose the "dummy" parameter. The only
> reason some function have this is when they are used from an IPI call.

OK. I will remove all of them.

>> +{
>> +	phys_addr_t boot_pgd_ptr;
>> +	phys_addr_t phys_idmap_start;
>> +
>> +	if (__hyp_get_vectors() == hyp_default_vectors)
>> +		return;
>> +
>> +	boot_pgd_ptr = kvm_mmu_get_boot_httbr();
>> +	phys_idmap_start = kvm_get_idmap_start();
>> +	__cpu_reset_hyp_mode(boot_pgd_ptr, phys_idmap_start,
>> +			     hyp_default_vectors,
>> +			     kvm_virt_to_trampoline(__kvm_hyp_reset));
>> +}
>> +
>>   static int hyp_init_cpu_notify(struct notifier_block *self,
>>   			       unsigned long action, void *cpu)
>>   {
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 3e6859b..3631a37 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -1490,6 +1490,11 @@ phys_addr_t kvm_get_idmap_vector(void)
>>   	return hyp_idmap_vector;
>>   }
>>
>> +phys_addr_t kvm_get_idmap_start(void)
>> +{
>> +	return hyp_idmap_start;
>> +}
>> +
>>   int kvm_mmu_init(void)
>>   {
>>   	int err;
>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>> index 4f7310f..f1c16e2 100644
>> --- a/arch/arm64/include/asm/kvm_asm.h
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>> @@ -118,6 +118,7 @@ struct kvm_vcpu;
>>
>>   extern char __kvm_hyp_init[];
>>   extern char __kvm_hyp_init_end[];
>> +extern char __kvm_hyp_reset[];
>>
>>   extern char __kvm_hyp_vector[];
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 8ac3c70..6a8da9c 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -199,6 +199,8 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
>>   struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
>>
>>   u64 kvm_call_hyp(void *hypfn, ...);
>> +void kvm_call_reset(phys_addr_t boot_pgd_ptr, phys_addr_t phys_idmap_start,
>> +		    unsigned long stub_vector_ptr, unsigned long reset_func);
>>   void force_vm_exit(const cpumask_t *mask);
>>   void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>>
>> @@ -223,6 +225,15 @@ static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>>   		     hyp_stack_ptr, vector_ptr);
>>   }
>>
>> +static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
>> +					phys_addr_t phys_idmap_start,
>> +					unsigned long stub_vector_ptr,
>> +					unsigned long reset_func)
>> +{
>> +	kvm_call_reset(boot_pgd_ptr, phys_idmap_start, stub_vector_ptr,
>> +		       reset_func);
>> +}
>> +
>>   struct vgic_sr_vectors {
>>   	void	*save_vgic;
>>   	void	*restore_vgic;
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 6458b53..facfd6d 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -96,6 +96,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
>>   phys_addr_t kvm_mmu_get_httbr(void);
>>   phys_addr_t kvm_mmu_get_boot_httbr(void);
>>   phys_addr_t kvm_get_idmap_vector(void);
>> +phys_addr_t kvm_get_idmap_start(void);
>>   int kvm_mmu_init(void);
>>   void kvm_clear_hyp_idmap(void);
>>
>> @@ -305,5 +306,11 @@ static inline void __kvm_flush_dcache_pud(pud_t pud)
>>   void kvm_set_way_flush(struct kvm_vcpu *vcpu);
>>   void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled);
>>
>> +extern char __hyp_idmap_text_start[];
>
> If you're defining it here, then it worth considering removing the
> similar declaration from mmu.c.

Yes. I will remove them from mmu.c.

>> +#define kvm_virt_to_trampoline(x)	\
>> +		(TRAMPOLINE_VA		\
>> +		+ ((unsigned long)(x)	\
>> +		  - ((unsigned long)__hyp_idmap_text_start & PAGE_MASK)))
>> +
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* __ARM64_KVM_MMU_H__ */
>> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
>> index 3070096..7fcd087 100644
>> --- a/arch/arm64/include/asm/virt.h
>> +++ b/arch/arm64/include/asm/virt.h
>> @@ -61,6 +61,17 @@
>>   #define BOOT_CPU_MODE_EL1	(0xe11)
>>   #define BOOT_CPU_MODE_EL2	(0xe12)
>>
>> +/*
>> + * HVC_RESET - Reset cpu in EL2 to initial state.
>> + *
>> + * @x0: entry address in trampoline code in va
>> + * @x1: identical mapping page table in pa
>> + * @x2: start address of identical mapping in pa
>> + * @x3: initial stub vector in pa
>> + */
>> +
>> +#define HVC_RESET 5
>> +
>>   #ifndef __ASSEMBLY__
>>
>>   /*
>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>> index c319116..2614cfc 100644
>> --- a/arch/arm64/kvm/hyp-init.S
>> +++ b/arch/arm64/kvm/hyp-init.S
>> @@ -115,6 +115,38 @@ target: /* We're now in the trampoline code, switch page tables */
>>   	eret
>>   ENDPROC(__kvm_hyp_init)
>>
>> +	/*
>> +	 * x0: HYP boot pgd
>> +	 * x1: HYP phys_idmap_start
>> +	 * x2: HYP stub vectors
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
>> +	ldr	x1, =SCTLR_EL2_FLAGS
>> +	bic	x0, x0, x1		// Clear SCTL_M and etc
>> +	msr	sctlr_el2, x0
>> +	isb
>> +
>> +	/* Install stub vectors */
>> +	msr	vbar_el2, x2
>
> Instead of using a parameter, can't you just do
>
> 	adr	x2, __hyp_stub_vectors
> 	msr	vbar_el2, x2
>
> ? I can't imagine a case where we don't want this behaviour, and this
> would slightly simplify the calling convention.

Yeah, but it will also enforces kvm to be statically linked to the kernel.
(not module-capable) Is that OK?

>> +
>> +	eret
>> +ENDPROC(__kvm_hyp_reset)
>> +
>>   	.ltorg
>>
>>   	.popsection
>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> index fd085ec..7c3bdee 100644
>> --- a/arch/arm64/kvm/hyp.S
>> +++ b/arch/arm64/kvm/hyp.S
>> @@ -1136,6 +1136,11 @@ ENTRY(kvm_call_hyp)
>>   	ret
>>   ENDPROC(kvm_call_hyp)
>>
>> +ENTRY(kvm_call_reset)
>> +	hvc	#HVC_RESET
>> +	ret
>> +ENDPROC(kvm_call_reset)
>> +
>>   .macro invalid_vector	label, target
>>   	.align	2
>>   \label:
>> @@ -1179,10 +1184,14 @@ el1_sync:					// Guest trapped into EL2
>>   	cmp	x18, #HVC_GET_VECTORS
>>   	b.ne	1f
>>   	mrs	x0, vbar_el2
>> -	b	2f
>> +	b	3f
>
> How about renaming this to something like "do_eret" once and for all so
> that we stop this dance each time someone adds a new entry point?

Good point. I will take it.

>> -1:	/* Default to HVC_CALL_HYP. */
>> +	/* jump into trampoline code */
>> +1:	cmp	x18, #HVC_RESET
>> +	b.ne	2f
>> +	br	x3				// no return
>
> Same here. If we're always jumping to the trampoline code, why do we
> have to pass it as a parameter?

We need here a physical address of reset function. It seems easy to call
kvm_virt_to_trampoline() in C code. But, yes, we can also do it in asm.

Thanks,
-Takahiro AKASHI

>>
>> +2:	/* Default to HVC_CALL_HYP. */
>>   	push	lr, xzr
>>
>>   	/*
>> @@ -1196,7 +1205,8 @@ el1_sync:					// Guest trapped into EL2
>>   	blr	lr
>>
>>   	pop	lr, xzr
>> -2:	eret
>> +
>> +3:	eret
>>
>>   el1_trap:
>>   	/*
>>
>
> Thanks,
>
> 	M.
>
