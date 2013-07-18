From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 18 Jul 2013 16:04:08 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
 <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130718150408.GB2655@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 11:28:33PM -0400, Nicolas Pitre wrote:
> Unlike real A15/A7's, the RTSM simulation doesn't appear to hit the
> cache when the CTRL.C bit is cleared.  Let's ensure there is no memory
> access within the disable and flush cache sequence, including to the
> stack.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-vexpress/dcscb.c | 58 +++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> index 16d57a8a9d..9f01c04d58 100644
> --- a/arch/arm/mach-vexpress/dcscb.c
> +++ b/arch/arm/mach-vexpress/dcscb.c
> @@ -136,14 +136,29 @@ static void dcscb_power_down(void)
>  		/*
>  		 * Flush all cache levels for this cluster.
>  		 *
> -		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> -		 * a preliminary flush here for those CPUs.  At least, that's
> -		 * the theory -- without the extra flush, Linux explodes on
> -		 * RTSM (to be investigated).
> +		 * To do so we do:
> +		 * - Clear the CTLR.C bit to prevent further cache allocations

SCTLR

> +		 * - Flush the whole cache
> +		 * - Disable local coherency by clearing the ACTLR "SMP" bit
> +		 *
> +		 * Let's do it in the safest possible way i.e. with
> +		 * no memory access within the following sequence
> +		 * including the stack.
>  		 */
> -		flush_cache_all();
> -		set_cr(get_cr() & ~CR_C);
> -		flush_cache_all();
> +		asm volatile(
> +		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> +		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> +		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> +		"isb	\n\t"
> +		"bl	v7_flush_dcache_all \n\t"
> +		"clrex	\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> +		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> +		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> +		"isb	\n\t"
> +		"dsb	"
> +		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> +		      "r9","r10","r11","lr","memory");

Along with the TC2 support, we now have 4 copies of this code sequence.

This is basically the A15/A7 native "exit coherency and flash and
disable some levels of dcache" operation, whose only parameter is which
cache levels to flush.

That's a big mouthful -- we can probably come up with a better name --
but we've pretty much concluded that there is no way to break this
operation apart into bitesize pieces.  Nonetheless, any native
powerdown sequence for these processors will need to do this, or
something closely related.

Is it worth consolidating, or is that premature?

> +		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> +		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> +		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> +		"isb	\n\t"
> +		"bl	v7_flush_dcache_all \n\t"
> +		"clrex	\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> +		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> +		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> +		"isb	\n\t"
> +		"dsb	"
> +		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> +		      "r9","r10","r11","lr","memory");


>  
>  		/*
>  		 * This is a harmless no-op.  On platforms with a real
> @@ -152,9 +167,6 @@ static void dcscb_power_down(void)
>  		 */
>  		outer_flush_all();

Do you have any opinion on whether we should leave that for educational
purposes?

None of the relevant platforms has a non-architected outer cache, so
there could be an argument for removing it.  But that might mislead
people who use this code as a reference.

Cheers
---Dave

>  
> -		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> -		set_auxcr(get_auxcr() & ~(1 << 6));
> -
>  		/*
>  		 * Disable cluster-level coherency by masking
>  		 * incoming snoops and DVM messages:
> @@ -167,18 +179,22 @@ static void dcscb_power_down(void)
>  
>  		/*
>  		 * Flush the local CPU cache.
> -		 *
> -		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> -		 * a preliminary flush here for those CPUs.  At least, that's
> -		 * the theory -- without the extra flush, Linux explodes on
> -		 * RTSM (to be investigated).
> +		 * Let's do it in the safest possible way as above.
>  		 */
> -		flush_cache_louis();
> -		set_cr(get_cr() & ~CR_C);
> -		flush_cache_louis();
> -
> -		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
> -		set_auxcr(get_auxcr() & ~(1 << 6));
> +		asm volatile(
> +		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> +		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> +		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> +		"isb	\n\t"
> +		"bl	v7_flush_dcache_louis \n\t"
> +		"clrex	\n\t"
> +		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> +		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> +		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> +		"isb	\n\t"
> +		"dsb	"
> +		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> +		      "r9","r10","r11","lr","memory");
>  	}
>  
>  	__mcpm_cpu_down(cpu, cluster);
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
