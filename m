From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Jun 2013 23:29:37 +0200 (CEST)
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1306252316470.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Uwe Kleine-K?nig wrote:

> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.

I don't think that anyone is searching for interrupt controllers as
they are simply an essential part of the M3/4 SoCs.
 
>     
>     This depends on the stuff currently in tip/irq/for-arm
> 
>  arch/arm/kernel/entry-v7m.S |   2 +-

This is not depending on my tree. I can take the patch if

 - you drop the arm related change and do that cleanup later

or

 - the relevant maintainers provide their ACK.

> +	for (i = 0; i < numbanks; ++i) {
> +		struct irq_chip_generic *gc =
> +			irq_get_domain_generic_chip(nvic_irq_domain, 32 * i);
> +		gc->reg_base = nvic_base + 4 * i;
> +		gc->chip_types[0].regs.enable = NVIC_ISER;
> +		gc->chip_types[0].regs.disable = NVIC_ICER;
> +		gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
> +		gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
> +		gc->chip_types[0].chip.irq_eoi = nvic_eoi;
> +	}
> +
> +	/* Disable all interrupts */
> +	for (i = 0; i < irqs; i += 32)
> +		writel_relaxed(~0, nvic_base + NVIC_ICER + i * 4 / 32);

So this is another, slightly different loop than the previous one

> +	for (i = 0; i < numbanks; ++i) {

This time based on irqs and increasing the irq number per loop by a
full bank. Why not doing this in the above loop which does exaclty the
same and you don't have to do the odd register base math. A simple

	writel_relaxed(~0, gc->reg_base + NVIC_ICER);

in the banks loop is sufficient, right?

Thanks,

	tglx
