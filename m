From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 5 Feb 2018 11:00:34 +0100
Subject: [PATCH v4 4/6] arm: Add icache invalidation on switch_mm for
 Cortex-A15
In-Reply-To: <20180201110738.5421-5-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
 <20180201110738.5421-5-marc.zyngier@arm.com>
Message-ID: <20180205100034.GS21802@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 11:07:36AM +0000, Marc Zyngier wrote:
> In order to avoid aliasing attacks against the branch predictor,
> Cortex-A15 require to invalidate the BTB when switching
> from one user context to another. The only way to do so on this
> CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
> mode.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mm/proc-v7-2level.S | 10 ++++++++++
>  arch/arm/mm/proc-v7-3level.S | 10 ++++++++++
>  arch/arm/mm/proc-v7.S        | 23 ++++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> index 0422e58b74e8..6d81ed7b2cb0 100644
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -40,7 +40,16 @@
>   *	Note that we always need to flush BTAC/BTB if IBE is set
>   *	even on Cortex-A8 revisions not affected by 430973.
>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
> + *
> + *	Cortex-A15 requires ACTLR[0] to be set from secure in order
> + *	for the icache invalidation to also invalidate the BTB.
>   */
> +ENTRY(cpu_v7_icinv_switch_mm)
> +#ifdef CONFIG_MMU
> +	mcr	p15, 0, r0, c7, c5, 0		@ ICIALLU
> +	/* Fall through to switch_mm... */
> +#endif

aren't we falling through to cpu_v7_btbinv_switch_mm including the 
btb invalidation used for ca8 et al. here?  Maybe we just don't care?
> +
>  ENTRY(cpu_v7_btbinv_switch_mm)
>  #ifdef CONFIG_MMU
>  	mov	r2, #0
> @@ -67,6 +76,7 @@ ENTRY(cpu_v7_switch_mm)
>  	bx	lr
>  ENDPROC(cpu_v7_switch_mm)
>  ENDPROC(cpu_v7_btbinv_switch_mm)
> +ENDPROC(cpu_v7_icinv_switch_mm)
>  
>  /*
>   *	cpu_v7_set_pte_ext(ptep, pte)
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index c616afd1b8f4..797053980755 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -54,6 +54,15 @@
>   * Set the translation table base pointer to be pgd_phys (physical address of
>   * the new TTB).
>   */
> +ENTRY(cpu_v7_icinv_switch_mm)
> +#ifdef CONFIG_MMU
> +	/*
> +	 * Cortex-A15 requires ACTLR[0] to be set from secure in order
> +	 * for the icache invalidation to also invalidate the BTB.
> +	 */
> +	mcr	p15, 0, r0, c7, c5, 0		@ ICIALLU
> +	/* Fall through to switch_mm... */
> +#endif

same question...

>  ENTRY(cpu_v7_btbinv_switch_mm)
>  #ifdef CONFIG_MMU
>  	mcr	p15, 0, r0, c7, c5, 6			@ flush BTAC/BTB
> @@ -69,6 +78,7 @@ ENTRY(cpu_v7_switch_mm)
>  	ret	lr
>  ENDPROC(cpu_v7_switch_mm)
>  ENDPROC(cpu_v7_btbinv_switch_mm)
> +ENDPROC(cpu_v7_icinv_switch_mm)
>  
>  #ifdef __ARMEB__
>  #define rl r3
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 389a7c442058..ba13e4e45c3b 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -232,6 +232,26 @@ ENDPROC(cpu_ca9mp_do_resume)
>  	globl_equ	cpu_ca17_do_resume,	cpu_v7_do_resume
>  #endif
>  
> +/*
> + * Cortex-A15
> + */
> +	globl_equ	cpu_ca15_proc_init,	cpu_v7_proc_init
> +	globl_equ	cpu_ca15_proc_fin,	cpu_v7_proc_fin
> +	globl_equ	cpu_ca15_reset,		cpu_v7_reset
> +	globl_equ	cpu_ca15_do_idle,	cpu_v7_do_idle
> +	globl_equ	cpu_ca15_dcache_clean_area, cpu_v7_dcache_clean_area
> +	globl_equ	cpu_ca15_set_pte_ext,	cpu_v7_set_pte_ext
> +	globl_equ	cpu_ca15_suspend_size,	cpu_v7_suspend_size
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	globl_equ	cpu_ca15_switch_mm,	cpu_v7_icinv_switch_mm
> +#else
> +	globl_equ	cpu_ca15_switch_mm,	cpu_v7_switch_mm
> +#endif
> +#ifdef CONFIG_ARM_CPU_SUSPEND
> +	globl_equ	cpu_ca15_do_suspend,	cpu_v7_do_suspend
> +	globl_equ	cpu_ca15_do_resume,	cpu_v7_do_resume
> +#endif
> +
>  #ifdef CONFIG_CPU_PJ4B
>  	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
>  	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
> @@ -573,6 +593,7 @@ __v7_setup_stack:
>  
>  	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
>  	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
> +	define_processor_functions ca15, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
>  	define_processor_functions ca17, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
>  #ifndef CONFIG_ARM_LPAE
>  	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
> @@ -694,7 +715,7 @@ __v7_ca12mp_proc_info:
>  __v7_ca15mp_proc_info:
>  	.long	0x410fc0f0
>  	.long	0xff0ffff0
> -	__v7_proc __v7_ca15mp_proc_info, __v7_ca15mp_setup
> +	__v7_proc __v7_ca15mp_proc_info, __v7_ca15mp_setup, proc_fns = ca15_processor_functions
>  	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
>  
>  	/*
> -- 
> 2.14.2
> 

Thanks,
-Christoffer
