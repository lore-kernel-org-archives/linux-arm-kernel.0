From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 2 Jun 2014 11:10:24 +0100
Subject: [PATCH] ARM: Exynos : Fix build error with thumb2
In-Reply-To: <1401119625-11309-1-git-send-email-santosh.shukla@linaro.org>
References: <1401119625-11309-1-git-send-email-santosh.shukla@linaro.org>
Message-ID: <20140602101023.GB3855@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 09:23:45PM +0530, Santosh Shukla wrote:
> From: santosh shukla <santosh.shukla@linaro.org>
> 
> Add non-global symbol .LLl2x0_regs_phys to avoid build break in thumb2 mode.
> 
> IIUC, arm assembler fail to load value of "global" variable
> l2xo_regs_phys for thum2 mode and wrapping it in non-global symbol like
> .Ll2x0_regs_phys solves the build break issue.
> 
> arch/arm/mach-exynos/sleep.S: Assembler messages:
> arch/arm/mach-exynos/sleep.S:57: Error: invalid immediate for address
> calculation (value = 0x00000004)
> 
> fix inspired from [1]
> 
> [1] https://lkml.org/lkml/2010/3/31/235
> 
> Signed-off-by: santosh shukla <santosh.shukla@linaro.org>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

The binutils folks insist that this is not a bug in gas.  (I disagreed, but
it's a grey area.)  This is the established pattern for working round this
issue -- looks fine to me.

Cheers
---Dave


> ---
>  arch/arm/mach-exynos/sleep.S |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
> index a2613e9..dc8c6b6 100644
> --- a/arch/arm/mach-exynos/sleep.S
> +++ b/arch/arm/mach-exynos/sleep.S
> @@ -54,7 +54,7 @@ ENTRY(exynos_cpu_resume)
>  	ldr	r1, =CPU_CORTEX_A9
>  	cmp	r0, r1
>  	bne	skip_l2_resume
> -	adr	r0, l2x0_regs_phys
> +	adr	r0, .Ll2x0_regs_phys
>  	ldr	r0, [r0]
>  	cmp	r0, #0
>  	beq	skip_l2_resume
> @@ -79,6 +79,8 @@ skip_l2_resume:
>  	b	cpu_resume
>  ENDPROC(exynos_cpu_resume)
>  #ifdef CONFIG_CACHE_L2X0
> +
> +.Ll2x0_regs_phys:
>  	.globl l2x0_regs_phys
>  l2x0_regs_phys:
>  	.long	0
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
