From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Mar 2015 14:30:41 -0400 (EDT)
Subject: [PATCH v2 3/4] ARM: exynos: move resume code to .text section
In-Reply-To: <1427219550-21636-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1427219550-21636-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427219550-21636-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1503241427280.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Mar 2015, Ard Biesheuvel wrote:

> This code calls cpu_resume() using a straight branch (b), so
> it has no business being in the .data section, especially now
> we moved cpu_resume() back to .text as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/mach-exynos/sleep.S | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
> index 31d25834b9c4..fe5d9ed24ac2 100644
> --- a/arch/arm/mach-exynos/sleep.S
> +++ b/arch/arm/mach-exynos/sleep.S
> @@ -23,14 +23,7 @@
>  #define CPU_MASK	0xff0ffff0
>  #define CPU_CORTEX_A9	0x410fc090
>  
> -	/*
> -	 * The following code is located into the .data section. This is to
> -	 * allow l2x0_regs_phys to be accessed with a relative load while we
> -	 * can't rely on any MMU translation. We could have put l2x0_regs_phys
> -	 * in the .text section as well, but some setups might insist on it to
> -	 * be truly read-only. (Reference from: arch/arm/kernel/sleep.S)
> -	 */
> -	.data
> +	.text
>  	.align
>  
>  	/*
> @@ -69,10 +62,12 @@ ENTRY(exynos_cpu_resume_ns)
>  	cmp	r0, r1
>  	bne	skip_cp15
>  
> -	adr	r0, cp15_save_power
> +	adr	r0, _cp15_save_power
>  	ldr	r1, [r0]
> -	adr	r0, cp15_save_diag
> +	ldr	r1, [r0, r1]
> +	adr	r0, _cp15_save_diag
>  	ldr	r2, [r0]
> +	ldr	r2, [r0, r2]
>  	mov	r0, #SMC_CMD_C15RESUME
>  	dsb
>  	smc	#0
> @@ -118,6 +113,13 @@ skip_l2x0:
>  skip_cp15:
>  	b	cpu_resume
>  ENDPROC(exynos_cpu_resume_ns)
> +

A .align would be needed here in case this is compiled as Thumb2.

> +_cp15_save_power:
> +	.long	cp15_save_power - .
> +_cp15_save_diag:
> +	.long	cp15_save_diag - .
> +
> +	.data
>  	.globl cp15_save_diag
>  cp15_save_diag:
>  	.long	0	@ cp15 diagnostic
> @@ -126,6 +128,7 @@ cp15_save_power:
>  	.long	0	@ cp15 power control
>  
>  #ifdef CONFIG_CACHE_L2X0
> +	.text
>  	.align
>  1:	.long	l2x0_saved_regs - .
>  #endif /* CONFIG_CACHE_L2X0 */

This looks rather weird. I'd suggest you move this before the added 
.data instead.


Nicolas
