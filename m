From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Apr 2011 10:04:17 -0700
Subject: [RFC PATCH 02/12] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <1303326501-15664-3-git-send-email-marc.zyngier@arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DB5A991.90002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/2011 12:08 PM, Marc Zyngier wrote:
> diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
> index ec0bbf7..c599795 100644
> --- a/arch/arm/include/asm/entry-macro-multi.S
> +++ b/arch/arm/include/asm/entry-macro-multi.S
> @@ -24,7 +24,7 @@
>  	adrne	lr, BSYM(1b)
>  	bne	do_IPI
>  
> -#ifdef CONFIG_LOCAL_TIMERS
> +#if defined(CONFIG_LOCAL_TIMERS) && !defined(CONFIG_ARM_GIC_VPPI)
>  	test_for_ltirq r0, r6, r5, lr
>  	movne	r0, sp
>  	adrne	lr, BSYM(1b)
> diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
> index c115b82..14a3363 100644
> --- a/arch/arm/include/asm/hardware/entry-macro-gic.S
> +++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
> @@ -17,23 +17,26 @@
>  	.endm
>  #endif
>  
> +#ifdef CONFIG_ARM_GIC_VPPI
> +#define DO_IRQ_BASE	16
> +#else
> +#define DO_IRQ_BASE	30
> +#endif
> +
>  /*
>   * The interrupt numbering scheme is defined in the
>   * interrupt controller spec.  To wit:
>   *
>   * Interrupts 0-15 are IPI
> - * 16-28 are reserved
> - * 29-31 are local.  We allow 30 to be used for the watchdog.
> + * 16-31 are local.  We allow 30 to be used for the watchdog.
>   * 32-1020 are global
>   * 1021-1022 are reserved
>   * 1023 is "spurious" (no interrupt)
>   *
> - * For now, we ignore all local interrupts so only return an interrupt if it's
> - * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
> - *
>   * A simple read from the controller will tell us the number of the highest
>   * priority enabled interrupt.  We then just need to check whether it is in the
> - * valid range for an IRQ (30-1020 inclusive).
> + * valid range for an IRQ (30-1020 inclusive). If CONFIG_ARM_GIC_VPPI is
> + * enabled, local interrupts are handled the same way as global ones.
>   */
>  
>  	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> @@ -43,7 +46,7 @@
>  
>  	ldr	\tmp, =1021
>  	bic     \irqnr, \irqstat, #0x1c00
> -	cmp     \irqnr, #29
> +	cmp     \irqnr, #(DO_IRQ_BASE - 1)
>  	cmpcc	\irqnr, \irqnr
>  	cmpne	\irqnr, \tmp
>  	cmpcs	\irqnr, \irqnr
> @@ -63,6 +66,7 @@
>  	cmpcs	\irqnr, \irqnr
>  	.endm
>  
> +#ifndef CONFIG_ARM_GIC_VPPI
>  /* As above, this assumes that irqstat and base are preserved.. */
>  
>  	.macro test_for_ltirq, irqnr, irqstat, base, tmp
> @@ -73,3 +77,4 @@
>  	streq	\irqstat, [\base, #GIC_CPU_EOI]
>  	cmp	\tmp, #0
>  	.endm
> +#endif

I would expect these bits to be part of the first patch in this series
because they're necessary to actually use the CONFIG_ARM_GIC_VPPI
option. Can you move them to the first patch?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
