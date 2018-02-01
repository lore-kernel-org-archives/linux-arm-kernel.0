From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Feb 2018 11:46:59 +0000
Subject: [PATCH v4 6/6] arm: KVM: Invalidate icache on guest exit for
 Cortex-A15
In-Reply-To: <20180201110738.5421-7-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
 <20180201110738.5421-7-marc.zyngier@arm.com>
Message-ID: <52547cd9-2821-3401-5a67-9aea5a93bbf9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/18 11:07, Marc Zyngier wrote:
> In order to avoid aliasing attacks against the branch predictor
> on Cortex-A15, let's invalidate the BTB on guest exit, which can
> only be done by invalidating the icache (with ACTLR[0] being set).
> 
> We use the same hack as for A12/A17 to perform the vector decoding.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/include/asm/kvm_mmu.h |  5 +++++
>   arch/arm/kvm/hyp/hyp-entry.S   | 24 ++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index dedd4b8a3fa4..4216d40ca25c 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -238,6 +238,11 @@ static inline void *kvm_get_hyp_vector(void)
>   		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
>   	}
>   
> +	case ARM_CPU_PART_CORTEX_A15:
> +	{
> +		extern char __kvm_hyp_vector_ic_inv[];
> +		return kvm_ksym_ref(__kvm_hyp_vector_ic_inv);
> +	}
>   #endif
>   	default:
>   	{
> diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
> index e789f52a5129..918a05dd2d63 100644
> --- a/arch/arm/kvm/hyp/hyp-entry.S
> +++ b/arch/arm/kvm/hyp/hyp-entry.S
> @@ -72,6 +72,28 @@ __kvm_hyp_vector:
>   	W(b)	hyp_fiq
>   
>   #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
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
> +	W(nop)			/* FIQ		  0 */
> +
> +	mcr	p15, 0, r0, c7, c5, 0	/* ICIALLU */
> +	isb
> +
> +	b	decode_vectors

Ultimately it might be worth macroising (or just duplicating) 
decode_vectors so that we might reduce the almost-guaranteed "miss in 
I$, take a full pipeline flush, miss in I$ again" penalty of this branch 
to a single I$ miss, but until some numbers appear to prove that 
worthwhile this is certainly the most expedient solution.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
>   	.align 5
>   __kvm_hyp_vector_bp_inv:
>   	.global __kvm_hyp_vector_bp_inv
> @@ -92,6 +114,8 @@ __kvm_hyp_vector_bp_inv:
>   	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
>   	isb
>   
> +decode_vectors:
> +
>   #ifdef CONFIG_THUMB2_KERNEL
>   	/*
>   	 * Yet another silly hack: Use VPIDR as a temp register.
> 
