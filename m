From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Jan 2017 09:39:54 +0000
Subject: [PATCH 03/22] irqchip: add a driver for Cortina Gemini
In-Reply-To: <20170122121624.10147-1-linus.walleij@linaro.org>
References: <20170122121624.10147-1-linus.walleij@linaro.org>
Message-ID: <c7e28b3c-a1fa-9069-e947-9021467f668e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 22/01/17 12:16, Linus Walleij wrote:
> As a part of transitioning the Gemini platform to device tree we
> create this clean, device-tree-only irqchip driver.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> irqchip maintainers: please just apply this when you feel pleased
> with it. These portions are functionally orthogonal to the series,
> it is just in a series for context.
> ---

[...]

> +int __init gemini_of_init_irq(struct device_node *node,
> +			      struct device_node *parent)
> +{
> +	struct gemini_irq_data *g = &girq;
> +	unsigned int i;
> +
> +	/*
> +	 * Disable the idle handler by default since it is buggy
> +	 * For more info see arch/arm/mach-gemini/idle.c
> +	 */
> +	cpu_idle_poll_ctrl(true);
> +
> +	g->base = of_iomap(node, 0);
> +	WARN(!g->base, "unable to map gemini irq registers\n");
> +
> +	/* Disable all interrupts */
> +	writel(0, IRQ_MASK(g->base));
> +	writel(0, FIQ_MASK(g->base));
> +
> +	g->domain = irq_domain_add_simple(node, GEMINI_NUM_IRQS, 0,
> +					  &gemini_irqdomain_ops, g);
> +	/* Map all IRQs */
> +	for (i = 0; i < GEMINI_NUM_IRQS; i++)
> +		irq_create_mapping(g->domain, i);

Why is this needed? I can see it being useful while converting the
platform to DT, but as you seem to kill the old code altogether, this
can probably go.

> +
> +	set_handle_irq(gemini_irqchip_handle_irq);
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(gemini, "cortina,gemini-interrupt-controller",
> +		gemini_of_init_irq);
> 

Otherwise, looks good to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
