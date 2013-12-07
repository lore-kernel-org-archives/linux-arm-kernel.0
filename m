From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Dec 2013 15:30:07 +0100
Subject: [PATCH 1/3] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
References: <1386008042-6826-1-git-send-email-shc_work@mail.ru>
Message-ID: <201312071530.07901.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 December 2013, Alexander Shiyan wrote:
> This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/Kconfig                |   2 -
>  arch/arm/mach-clps711x/common.h |   3 +
>  drivers/irqchip/Kconfig         |   8 ++
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-clps711x.c  | 246 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 258 insertions(+), 2 deletions(-)
> create mode 100644 drivers/irqchip/irq-clps711x.c

It seems you forgot to add the irqchip maintainer to Cc, I've added him in this
reply.

> +static void clps711x_intc_eoi(struct irq_data *d)
> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +
> +	writel_relaxed(0, clps711x_intc->base + clps711x_irqs[hwirq].eoi);
> +}
> +
> +static void clps711x_intc_mask(struct irq_data *d)
> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(intmr);
> +	tmp &= ~(1 << (hwirq % 16));
> +	writel_relaxed(tmp, intmr);
> +}
> +
> +static void clps711x_intc_unmask(struct irq_data *d)
> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	void __iomem *intmr = clps711x_intc->intmr[hwirq / 16];
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(intmr);
> +	tmp |= 1 << (hwirq % 16);
> +	writel_relaxed(tmp, intmr);
> +}

These look rather simple, have you checked if you can reuse the generic
irqchip code?

> +	clps711x_intc->domain =
> +		irq_domain_add_legacy(np, ARRAY_SIZE(clps711x_irqs),
> +				      0, 0, &clps711x_intc_ops, NULL);

You should probably use irq_domain_add_simple() here, and pass first_irq = -1
for the DT case, unless you still need a mix of DT with platform devices
that have hardwired IRQ resources.

> +void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
> +{
> +	BUG_ON(_clps711x_intc_init(NULL, base, size));
> +}
> +EXPORT_SYMBOL(clps711x_intc_init);

No need to export this symbol, because you don't call the function from
loadable modules.

	Arnd
