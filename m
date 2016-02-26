From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 26 Feb 2016 11:26:23 +0100 (CET)
Subject: [PATCH 1/2] irqchip: add lpc18xx gpio pin interrupt driver
In-Reply-To: <1456437887-24432-2-git-send-email-manabian@gmail.com>
References: <1456437887-24432-1-git-send-email-manabian@gmail.com>
 <1456437887-24432-2-git-send-email-manabian@gmail.com>
Message-ID: <alpine.DEB.2.11.1602261122120.3638@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2016, Joachim Eastwood wrote:
> +static void lpc18xx_gpio_pint_handler(struct irq_desc *desc)
> +{
> +	struct lpc18xx_gpio_pint_chip *pint = irq_desc_get_handler_data(desc);
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	int irq_no, i;
> +
> +	/* Find the interrupt */
> +	for (i = 0; i < pint->nrirqs; i++) {
> +		if (pint->irqmap[i] == irq) {

Why don't you have a reverse map for this?

> +			irq_no = irq_find_mapping(pint->domain, i);
> +			generic_handle_irq(irq_no);
> +		}
> +	}
> +}
> +
> +static void lpc18xx_gpio_pint_edge_ack(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_IST);
> +	irq_gc_unlock(gc);
> +}

How is that different from irq_gc_ack_set_bit ?

> +static void lpc18xx_gpio_pint_edge_mask(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENR);
> +	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENF);
> +	irq_gc_unlock(gc);
> +}

If you use seperate irq types, then you can use the generic chip functions and
be done with it.

> +static void lpc18xx_gpio_pint_edge_unmask(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 type, mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	type = irqd_get_trigger_type(d);
> +	if (type & IRQ_TYPE_EDGE_RISING)
> +		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENR);
> +	if (type & IRQ_TYPE_EDGE_FALLING)
> +		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENF);
> +	irq_gc_unlock(gc);
> +}
> +
> +static void lpc18xx_gpio_pint_level_mask(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENR);
> +	irq_gc_unlock(gc);
> +}
> +
> +static void lpc18xx_gpio_pint_level_unmask(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENR);
> +	irq_gc_unlock(gc);
> +}

All the callbacks can go away.

> +static int lpc18xx_gpio_pint_type(struct irq_data *data, unsigned int type)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	u32 mask = data->mask;
> +
> +	irq_gc_lock(gc);
> +	if (type & IRQ_TYPE_LEVEL_MASK)
> +		gc->type_cache |= mask;
> +	else
> +		gc->type_cache &= ~mask;
> +	irq_reg_writel(gc, gc->type_cache, LPC18XX_GPIO_PINT_ISEL);
> +
> +	switch (type) {
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENF);
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENF);
> +		break;
> +
> +	/* IRQ_TYPE_EDGE_* is set in lpc18xx_gpio_pint_edge_unmask */
> +	}
> +
> +	irqd_set_trigger_type(data, type);
> +	irq_setup_alt_chip(data, type);

So you already use an alt chip, but still implement your own callbacks?

WHY?

Thanks,

	tglx
