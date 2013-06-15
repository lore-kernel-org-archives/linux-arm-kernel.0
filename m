From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 15 Jun 2013 01:41:49 +0100
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130615004149.D85B13E0A2E@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013 23:50:35 +0200, Uwe Kleine-K??nig  <u.kleine-koenig@pengutronix.de> wrote:
> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
> 
> Support for this controller appeared in Catalin's Cortex tree based on
> 2.6.33 but was nearly completely rewritten.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v3, sent with
>     Message-Id: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>:
>     
>      - use generic chip
>      - rename nvic_do_IRQ to nvic_handle_irq
>     
>     This depends on the stuff currently in tip/irq/for-arm

Minor comments below, but it looks good to me. Nice and small.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +asmlinkage void __exception_irq_entry
> +nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> +{
> +	unsigned int irq = irq_linear_revmap(nvic_irq_domain, hwirq);
> +
> +	handle_IRQ(irq, regs);

Or simply:
	handle_IRQ(irq_linear_revmap(nvic_irq_domain, hwirq), regs);

:)

> +static int __init nvic_of_init(struct device_node *node,
> +			       struct device_node *parent)
> +{
> +	void __iomem *nvic_base;
> +	unsigned int irqs, i, ret;
> +	unsigned numbanks = (readl_relaxed(V7M_SCS_ICTR) &
> +			     V7M_SCS_ICTR_INTLINESNUM_MASK) + 1;
> +	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> +
> +	nvic_base = of_iomap(node, 0);
> +	if (!nvic_base) {
> +		pr_warn("unable to map nvic registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	irqs = numbanks * 32;
> +	if (irqs > NVIC_MAX_IRQ)
> +		irqs = NVIC_MAX_IRQ;

I would display some kind of message here.

> +
> +	nvic_irq_domain =
> +		irq_domain_add_linear(node, irqs, &irq_generic_chip_ops, NULL);
> +	if (!nvic_irq_domain) {
> +		pr_warn("Failed to allocate irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = irq_alloc_domain_generic_chips(nvic_irq_domain, 32, numbanks,
> +					     "nvic_irq", handle_fasteoi_irq,
> +					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
> +	if (ret) {
> +		pr_warn("Failed to allocate irq chips\n");
> +		irq_domain_remove(nvic_irq_domain);
> +		return ret;
> +	}
> +
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
> +
> +	/* Set priority on all interrupts */
> +	for (i = 0; i < irqs; i += 4)
> +		writel_relaxed(0, nvic_base + NVIC_IPR + i);
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(armv7m_nvic, "arm,armv7m-nvic", nvic_of_init);
> -- 
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
email sent from notmuch.vim plugin
