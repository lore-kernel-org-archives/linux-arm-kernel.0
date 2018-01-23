From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 23 Jan 2018 15:26:04 +0100
Subject: [PATCH v2 6/6] arm: KVM: Invalidate icache on guest exit for
 Cortex-A15
In-Reply-To: <20180108185533.9698-7-marc.zyngier@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-7-marc.zyngier@arm.com>
Message-ID: <20180123142604.GL21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 06:55:33PM +0000, Marc Zyngier wrote:
> In order to avoid aliasing attacks against the branch predictor
> on Cortex-A15, let's invalidate the BTB on guest exit, which can
> only be done by invalidating the icache (with ACTLR[0] being set).
> 
> We use the same hack as for A12/A17 to perform the vector decoding.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  arch/arm/include/asm/kvm_mmu.h |  4 ++++
>  arch/arm/kvm/hyp/hyp-entry.S   | 27 ++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index b47db5b9e407..72ffb4d27fde 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -226,12 +226,16 @@ static inline void *kvm_get_hyp_vector(void)
>  {
>  	extern char __kvm_hyp_vector[];
>  	extern char __kvm_hyp_vector_bp_inv[];
> +	extern char __kvm_hyp_vector_ic_inv[];
>  
>  	switch(read_cpuid_part()) {
>  	case ARM_CPU_PART_CORTEX_A12:
>  	case ARM_CPU_PART_CORTEX_A17:
>  		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
>  
> +	case ARM_CPU_PART_CORTEX_A15:
> +		return kvm_ksym_ref(__kvm_hyp_vector_ic_inv);
> +
>  	default:
>  		return kvm_ksym_ref(__kvm_hyp_vector);
>  	}
> diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
> index 2e8d2179eb70..7c0059927e2e 100644
> --- a/arch/arm/kvm/hyp/hyp-entry.S
> +++ b/arch/arm/kvm/hyp/hyp-entry.S
> @@ -70,7 +70,31 @@ __kvm_hyp_vector:
>  	W(b)	hyp_hvc
>  	W(b)	hyp_irq
>  	W(b)	hyp_fiq
> -	
> +
> +	.align 5
> +__kvm_hyp_vector_ic_inv:
> +	.global __kvm_hyp_vector_ic_inv
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
> +	W(add)	sp, sp, #1	/* FIQ		  0 */
> +
> +	sub	sp, sp, #1
> +
> +	mcr	p15, 0, r0, c7, c5, 0	/* ICIALLU */
> +	isb
> +
> +	b	decode_vectors
> +
>  	.align 5
>  __kvm_hyp_vector_bp_inv:
>  	.global __kvm_hyp_vector_bp_inv
> @@ -93,6 +117,7 @@ __kvm_hyp_vector_bp_inv:
>  	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
>  	isb
>  
> +decode_vectors:
>  	/*
>  	 * Yet another silly hack: Use VPIDR as a temp register.
>  	 * Thumb2 is really a pain, as SP cannot be used with most
> -- 
> 2.14.2
> 
