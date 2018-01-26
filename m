From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Jan 2018 10:23:11 +0100
Subject: [PATCH v3 3/6] arm: KVM: Invalidate BTB on guest exit for
 Cortex-A12/A17
In-Reply-To: <20180125152139.32431-4-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-4-marc.zyngier@arm.com>
Message-ID: <20180126092311.GV21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 03:21:36PM +0000, Marc Zyngier wrote:
> In order to avoid aliasing attacks against the branch predictor,
> let's invalidate the BTB on guest exit. This is made complicated
> by the fact that we cannot take a branch before invalidating the
> BTB.
> 
> We only apply this to A12 and A17, which are the only two ARM
> cores on which this useful.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_asm.h |  2 --
>  arch/arm/include/asm/kvm_mmu.h | 13 ++++++++-
>  arch/arm/kvm/hyp/hyp-entry.S   | 62 ++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
> index 36dd2962a42d..df24ed48977d 100644
> --- a/arch/arm/include/asm/kvm_asm.h
> +++ b/arch/arm/include/asm/kvm_asm.h
> @@ -61,8 +61,6 @@ struct kvm_vcpu;
>  extern char __kvm_hyp_init[];
>  extern char __kvm_hyp_init_end[];
>  
> -extern char __kvm_hyp_vector[];
> -
>  extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>  extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index eb46fc81a440..b47db5b9e407 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -37,6 +37,7 @@
>  
>  #include <linux/highmem.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
>  #include <asm/pgalloc.h>
>  #include <asm/stage2_pgtable.h>
>  
> @@ -223,7 +224,17 @@ static inline unsigned int kvm_get_vmid_bits(void)
>  
>  static inline void *kvm_get_hyp_vector(void)
>  {
> -	return kvm_ksym_ref(__kvm_hyp_vector);
> +	extern char __kvm_hyp_vector[];
> +	extern char __kvm_hyp_vector_bp_inv[];
> +
> +	switch(read_cpuid_part()) {
> +	case ARM_CPU_PART_CORTEX_A12:
> +	case ARM_CPU_PART_CORTEX_A17:
> +		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
> +
> +	default:
> +		return kvm_ksym_ref(__kvm_hyp_vector);
> +	}
>  }
>  
>  static inline int kvm_map_vectors(void)
> diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
> index 95a2faefc070..aab6b0c06a19 100644
> --- a/arch/arm/kvm/hyp/hyp-entry.S
> +++ b/arch/arm/kvm/hyp/hyp-entry.S
> @@ -70,6 +70,57 @@ __kvm_hyp_vector:
>  	W(b)	hyp_hvc
>  	W(b)	hyp_irq
>  	W(b)	hyp_fiq
> +	

nit: trailing white space

> +	.align 5
> +__kvm_hyp_vector_bp_inv:
> +	.global __kvm_hyp_vector_bp_inv
> +
> +	/*
> +	 * We encode the exception entry in the bottom 3 bits of
> +	 * SP, and we have to guarantee to be 8 bytes aligned.
> +	 */
> +	W(add)	sp, sp, #1	/* Reset 	  7 */
> +	W(add)	sp, sp, #1	/* Undef	  6 */
> +	W(add)	sp, sp, #1	/* Syscall	  5 */
> +	W(add)	sp, sp, #1	/* Prefetch abort 4 */
> +	W(add)	sp, sp, #1	/* Data abort	  3 */
> +	W(add)	sp, sp, #1	/* HVC		  2 */
> +	W(add)	sp, sp, #1	/* IRQ		  1 */
> +	W(nop)			/* FIQ		  0 */
> +
> +	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
> +	isb
> +
> +	/*
> +	 * Yet another silly hack: Use VPIDR as a temp register.
> +	 * Thumb2 is really a pain, as SP cannot be used with most
> +	 * of the bitwise instructions. The vect_br macro ensures
> +	 * things gets cleaned-up.
> +	 */
> +	mcr	p15, 4, r0, c0, c0, 0	/* VPIDR */
> +	mov	r0, sp
> +	and	r0, r0, #7
> +	sub	sp, sp, r0
> +	push	{r1, r2}
> +	mov	r1, r0
> +	mrc	p15, 4, r0, c0, c0, 0	/* VPIDR */
> +	mrc	p15, 0, r2, c0, c0, 0	/* MIDR  */
> +	mcr	p15, 4, r2, c0, c0, 0	/* VPIDR */
> +
> +.macro vect_br val, targ
> +	cmp	r1, #\val
> +	popeq	{r1, r2}
> +	beq	\targ
> +.endm
> +
> +	vect_br	0, hyp_fiq
> +	vect_br	1, hyp_irq
> +	vect_br	2, hyp_hvc
> +	vect_br	3, hyp_dabt
> +	vect_br	4, hyp_pabt
> +	vect_br	5, hyp_svc
> +	vect_br	6, hyp_undef
> +	vect_br	7, hyp_reset
>  
>  .macro invalid_vector label, cause
>  	.align
> @@ -149,7 +200,14 @@ hyp_hvc:
>  	bx	ip
>  
>  1:
> -	push	{lr}
> +	/*
> +	 * Pushing r2 here is just a way of keeping the stack aligned to
> +	 * 8 bytes on any path that can trigger a HYP exception. Here,
> +	 * we may well be about to jump into the guest, and the guest
> +	 * exit would otherwise be badly decoded by our fancy
> +	 * "decode-exception-without-a-branch" code...
> +	 */
> +	push	{r2, lr}
>  
>  	mov	lr, r0
>  	mov	r0, r1
> @@ -159,7 +217,7 @@ hyp_hvc:
>  THUMB(	orr	lr, #1)
>  	blx	lr			@ Call the HYP function
>  
> -	pop	{lr}
> +	pop	{r2, lr}
>  	eret
>  
>  guest_trap:
> -- 
> 2.14.2
> 
