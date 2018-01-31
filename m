From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 31 Jan 2018 12:11:57 +0000
Subject: [PATCH v3 3/6] arm: KVM: Invalidate BTB on guest exit for
 Cortex-A12/A17
In-Reply-To: <361ff814-cf1e-ad1f-329a-0fe416c2b6f7@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-4-marc.zyngier@arm.com>
 <361ff814-cf1e-ad1f-329a-0fe416c2b6f7@arm.com>
Message-ID: <044733c7-ac45-adc1-acfb-fbae32ba09b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 26/01/18 17:12, Robin Murphy wrote:
> On 25/01/18 15:21, Marc Zyngier wrote:
>> In order to avoid aliasing attacks against the branch predictor,
>> let's invalidate the BTB on guest exit. This is made complicated
>> by the fact that we cannot take a branch before invalidating the
>> BTB.
>>
>> We only apply this to A12 and A17, which are the only two ARM
>> cores on which this useful.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   arch/arm/include/asm/kvm_asm.h |  2 --
>>   arch/arm/include/asm/kvm_mmu.h | 13 ++++++++-
>>   arch/arm/kvm/hyp/hyp-entry.S   | 62 ++++++++++++++++++++++++++++++++++++++++--
>>   3 files changed, 72 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
>> index 36dd2962a42d..df24ed48977d 100644
>> --- a/arch/arm/include/asm/kvm_asm.h
>> +++ b/arch/arm/include/asm/kvm_asm.h
>> @@ -61,8 +61,6 @@ struct kvm_vcpu;
>>   extern char __kvm_hyp_init[];
>>   extern char __kvm_hyp_init_end[];
>>   
>> -extern char __kvm_hyp_vector[];
>> -
>>   extern void __kvm_flush_vm_context(void);
>>   extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>>   extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index eb46fc81a440..b47db5b9e407 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -37,6 +37,7 @@
>>   
>>   #include <linux/highmem.h>
>>   #include <asm/cacheflush.h>
>> +#include <asm/cputype.h>
>>   #include <asm/pgalloc.h>
>>   #include <asm/stage2_pgtable.h>
>>   
>> @@ -223,7 +224,17 @@ static inline unsigned int kvm_get_vmid_bits(void)
>>   
>>   static inline void *kvm_get_hyp_vector(void)
>>   {
>> -	return kvm_ksym_ref(__kvm_hyp_vector);
>> +	extern char __kvm_hyp_vector[];
>> +	extern char __kvm_hyp_vector_bp_inv[];
>> +
>> +	switch(read_cpuid_part()) {
>> +	case ARM_CPU_PART_CORTEX_A12:
>> +	case ARM_CPU_PART_CORTEX_A17:
>> +		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
>> +
>> +	default:
>> +		return kvm_ksym_ref(__kvm_hyp_vector);
>> +	}
>>   }
>>   
>>   static inline int kvm_map_vectors(void)
>> diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
>> index 95a2faefc070..aab6b0c06a19 100644
>> --- a/arch/arm/kvm/hyp/hyp-entry.S
>> +++ b/arch/arm/kvm/hyp/hyp-entry.S
>> @@ -70,6 +70,57 @@ __kvm_hyp_vector:
>>   	W(b)	hyp_hvc
>>   	W(b)	hyp_irq
>>   	W(b)	hyp_fiq
>> +	
>> +	.align 5
>> +__kvm_hyp_vector_bp_inv:
>> +	.global __kvm_hyp_vector_bp_inv
>> +
>> +	/*
>> +	 * We encode the exception entry in the bottom 3 bits of
>> +	 * SP, and we have to guarantee to be 8 bytes aligned.
>> +	 */
>> +	W(add)	sp, sp, #1	/* Reset 	  7 */
>> +	W(add)	sp, sp, #1	/* Undef	  6 */
>> +	W(add)	sp, sp, #1	/* Syscall	  5 */
>> +	W(add)	sp, sp, #1	/* Prefetch abort 4 */
>> +	W(add)	sp, sp, #1	/* Data abort	  3 */
>> +	W(add)	sp, sp, #1	/* HVC		  2 */
>> +	W(add)	sp, sp, #1	/* IRQ		  1 */
>> +	W(nop)			/* FIQ		  0 */
>> +
>> +	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
>> +	isb
>> +
> 
> The below is quite a bit of faff; might it be worth an
> 
> #ifdef CONFIG_THUMB2_KERNEL
> 
>> +	/*
>> +	 * Yet another silly hack: Use VPIDR as a temp register.
>> +	 * Thumb2 is really a pain, as SP cannot be used with most
>> +	 * of the bitwise instructions. The vect_br macro ensures
>> +	 * things gets cleaned-up.
>> +	 */
>> +	mcr	p15, 4, r0, c0, c0, 0	/* VPIDR */
>> +	mov	r0, sp
>> +	and	r0, r0, #7
>> +	sub	sp, sp, r0
>> +	push	{r1, r2}
>> +	mov	r1, r0
>> +	mrc	p15, 4, r0, c0, c0, 0	/* VPIDR */
>> +	mrc	p15, 0, r2, c0, c0, 0	/* MIDR  */
>> +	mcr	p15, 4, r2, c0, c0, 0	/* VPIDR */
> 
> #endif
> 
>> +
>> +.macro vect_br val, targ
> 
> ARM(cmp		sp, #val)

Doesn't quite work, as we still have all the top bits that contain the 
stack address. But I like the idea of making it baster for non-T2. How
about this instead?

diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
index 2377ed86e20b..23c954a9e441 100644
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -114,6 +114,8 @@ __kvm_hyp_vector_bp_inv:
 	isb
 
 decode_vectors:
+
+#ifdef CONFIG_THUMB2_KERNEL
 	/*
 	 * Yet another silly hack: Use VPIDR as a temp register.
 	 * Thumb2 is really a pain, as SP cannot be used with most
@@ -129,10 +131,16 @@ decode_vectors:
 	mrc	p15, 4, r0, c0, c0, 0	/* VPIDR */
 	mrc	p15, 0, r2, c0, c0, 0	/* MIDR  */
 	mcr	p15, 4, r2, c0, c0, 0	/* VPIDR */
+#endif
 
 .macro vect_br val, targ
-	cmp	r1, #\val
-	popeq	{r1, r2}
+ARM(	eor	sp, sp, #\val	)
+ARM(	tst	sp, #7		)
+ARM(	eorne	sp, sp, #\val	)
+
+THUMB(	cmp	r1, #\val	)
+THUMB(	popeq	{r1, r2}	)
+
 	beq	\targ
 .endm
 


> THUMB(cmp	r1, #\val)
> THUMB(popeq	{r1, r2}
> 
>> +	beq	\targ
>> +.endm
> 
> ...to keep the "normal" path relatively streamlined?

I think the above achieves it... Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
