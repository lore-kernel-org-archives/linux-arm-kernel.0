From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 26 Jan 2018 12:44:16 -0800
Subject: [PATCH v3 1/6] arm: Add BTB invalidation on switch_mm for
 Cortex-A9, A12 and A17
In-Reply-To: <20180125152139.32431-2-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-2-marc.zyngier@arm.com>
Message-ID: <1e81134a-c88f-1764-a193-24e55eb43819@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2018 07:21 AM, Marc Zyngier wrote:
> In order to avoid aliasing attacks against the branch predictor,
> some implementations require to invalidate the BTB when switching
> from one user context to another.
> 
> For this, we reuse the existing implementation for Cortex-A8, and
> apply it to A9, A12 and A17.

Should this read: and apply it to A8, A9, A12 and A17

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mm/proc-v7-2level.S |  4 ++--
>  arch/arm/mm/proc-v7-3level.S |  6 ++++++
>  arch/arm/mm/proc-v7.S        | 30 +++++++++++++++---------------
>  3 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
> index c6141a5435c3..0422e58b74e8 100644
> --- a/arch/arm/mm/proc-v7-2level.S
> +++ b/arch/arm/mm/proc-v7-2level.S
> @@ -41,7 +41,7 @@
>   *	even on Cortex-A8 revisions not affected by 430973.
>   *	If IBE is not set, the flush BTAC/BTB won't do anything.
>   */
> -ENTRY(cpu_ca8_switch_mm)
> +ENTRY(cpu_v7_btbinv_switch_mm)
>  #ifdef CONFIG_MMU
>  	mov	r2, #0
>  	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
> @@ -66,7 +66,7 @@ ENTRY(cpu_v7_switch_mm)
>  #endif
>  	bx	lr
>  ENDPROC(cpu_v7_switch_mm)
> -ENDPROC(cpu_ca8_switch_mm)
> +ENDPROC(cpu_v7_btbinv_switch_mm)
>  
>  /*
>   *	cpu_v7_set_pte_ext(ptep, pte)
> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
> index 7d16bbc4102b..934272e1fa08 100644
> --- a/arch/arm/mm/proc-v7-3level.S
> +++ b/arch/arm/mm/proc-v7-3level.S
> @@ -54,6 +54,11 @@
>   * Set the translation table base pointer to be pgd_phys (physical address of
>   * the new TTB).
>   */
> +ENTRY(cpu_v7_btbinv_switch_mm)
> +#ifdef CONFIG_MMU
> +	mov	r2, #0
> +	mcr	p15, 0, r2, c7, c5, 6			@ flush BTAC/BTB
> +#endif
>  ENTRY(cpu_v7_switch_mm)
>  #ifdef CONFIG_MMU
>  	mmid	r2, r2
> @@ -64,6 +69,7 @@ ENTRY(cpu_v7_switch_mm)
>  #endif
>  	ret	lr
>  ENDPROC(cpu_v7_switch_mm)
> +ENDPROC(cpu_v7_btbinv_switch_mm)
>  
>  #ifdef __ARMEB__
>  #define rl r3
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 01d64c0b2563..0a14967fd400 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -159,18 +159,18 @@ ENDPROC(cpu_v7_do_resume)
>  #endif
>  
>  /*
> - * Cortex-A8
> + * Cortex-A8/A12/A17 that require a BTB invalidation on switch_mm

Should this read Cortex-A8/A9/A12/A17?
-- 
Florian
