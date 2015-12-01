From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 01 Dec 2015 19:16:33 +0000
Subject: [PATCH v3 4/6] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <1448987062-31225-5-git-send-email-carlo@caione.org>
References: <1448987062-31225-1-git-send-email-carlo@caione.org>
 <1448987062-31225-5-git-send-email-carlo@caione.org>
Message-ID: <565DF211.8000005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 16:24, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
> interrupt modules that can be programmed to use any of the GPIOs in the
> chip as an interrupt source.
> 
> For each GPIO IRQ we have:
> 
> GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC
> 
> The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
> any other interrupt in the chip. The difference for the GPIO interrupts
> is that they can be filtered and conditioned.
> 
> This patch adds support for the external GPIOs interrupts and enables
> them for Meson8 and Meson8b SoCs.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/pinctrl/Kconfig                    |   1 +
>  drivers/pinctrl/meson/Makefile             |   2 +-
>  drivers/pinctrl/meson/irqchip-gpio-meson.c | 321 +++++++++++++++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson.c      |  30 +++
>  drivers/pinctrl/meson/pinctrl-meson.h      |  15 ++
>  5 files changed, 368 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pinctrl/meson/irqchip-gpio-meson.c
> 

[...]

> +static int meson_irq_domain_alloc(struct irq_domain *domain, unsigned int irq,
> +				  unsigned int nr_irqs, void *arg)
> +{
> +	struct meson_pinctrl *pc = domain->host_data;
> +	struct irq_fwspec *irq_data = arg;
> +	struct irq_fwspec gic_data;
> +	irq_hw_number_t hwirq;
> +	int index, ret, i;
> +
> +	if (irq_data->param_count != 2)
> +		return -EINVAL;
> +
> +	hwirq = irq_data->param[0];
> +	dev_dbg(pc->dev, "%s irq %d, nr %d, hwirq %lu\n",
> +			__func__, irq, nr_irqs, hwirq);
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		index = meson_map_gic_irq(domain, hwirq + i);
> +		if (index < 0)
> +			return index;
> +
> +		irq_domain_set_hwirq_and_chip(domain, irq + i,
> +					      hwirq + i,
> +					      &meson_irq_chip,
> +					      pc);
> +
> +		gic_data.param_count = 3;
> +		gic_data.fwnode = domain->parent->fwnode;
> +		gic_data.param[0] = 0; /* SPI */
> +		gic_data.param[1] = pc->gic_irqs[index];
> +		gic_data.param[1] = IRQ_TYPE_EDGE_RISING;

That feels quite wrong. Hardcoding the trigger like this and hoping for
a set_type to set it right at a later time is just asking for trouble.
Why can't you use the trigger type that has been provided by the
interrupt descriptor?

> +
> +		ret = irq_domain_alloc_irqs_parent(domain, irq + i, nr_irqs,
> +						   &gic_data);
> +	}
> +
> +	return 0;
> +}
> +
> +static void meson_irq_domain_free(struct irq_domain *domain, unsigned int irq,
> +				  unsigned int nr_irqs)
> +{
> +	struct meson_pinctrl *pc = domain->host_data;
> +	struct irq_data *irq_data;
> +	int index, i;
> +
> +	spin_lock(&pc->lock);
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_data = irq_domain_get_irq_data(domain, irq + i);
> +		index = meson_get_gic_irq(pc, irq_data->hwirq);
> +		if (index < 0)
> +			continue;
> +		pc->irq_map[index] = IRQ_FREE;
> +	}
> +	spin_unlock(&pc->lock);
> +
> +	irq_domain_free_irqs_parent(domain, irq, nr_irqs);
> +}
> +
> +static int meson_irq_domain_translate(struct irq_domain *d,
> +				      struct irq_fwspec *fwspec,
> +				      unsigned long *hwirq,
> +				      unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 2)
> +			return -EINVAL;
> +
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1];
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static struct irq_domain_ops meson_irq_domain_ops = {
> +	.alloc		= meson_irq_domain_alloc,
> +	.free		= meson_irq_domain_free,
> +	.translate	= meson_irq_domain_translate,
> +};
> +
> +int meson_gpio_irq_init(struct meson_pinctrl *pc)
> +{
> +	struct device_node *node = pc->dev->of_node;
> +	struct device_node *parent_node;
> +	struct irq_domain *parent_domain;
> +	const __be32 *irqs;
> +	int i, size;
> +
> +	parent_node = of_irq_find_parent(node);
> +	if (!parent_node) {
> +		dev_err(pc->dev, "can't find parent interrupt controller\n");
> +		return -EINVAL;
> +	}
> +
> +	parent_domain = irq_find_host(parent_node);
> +	if (!parent_domain) {
> +		dev_err(pc->dev, "can't find parent IRQ domain\n");
> +		return -EINVAL;
> +	}
> +
> +	pc->reg_irq = meson_map_resource(pc, node, "irq");
> +	if (!pc->reg_irq) {
> +		dev_err(pc->dev, "can't find irq registers\n");
> +		return -EINVAL;
> +	}
> +
> +	irqs = of_get_property(node, "amlogic,irqs-gpio", &size);
> +	if (!irqs) {
> +		dev_err(pc->dev, "no parent interrupts specified\n");
> +		return -EINVAL;
> +	}
> +	pc->num_gic_irqs = size / sizeof(__be32);
> +
> +	pc->irq_map = devm_kmalloc(pc->dev, sizeof(int) * pc->num_gic_irqs,
> +				   GFP_KERNEL);
> +	if (!pc->irq_map)
> +		return -ENOMEM;
> +
> +	pc->gic_irqs = devm_kzalloc(pc->dev, sizeof(int) * pc->num_gic_irqs,
> +				    GFP_KERNEL);
> +	if (!pc->gic_irqs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < pc->num_gic_irqs; i++) {
> +		pc->irq_map[i] = IRQ_FREE;
> +		of_property_read_u32_index(node, "amlogic,irqs-gpio", i,
> +					   &pc->gic_irqs[i]);
> +	}
> +
> +	pc->irq_domain = irq_domain_add_hierarchy(parent_domain, 0,
> +						  pc->data->last_pin,
> +						  node, &meson_irq_domain_ops,
> +						  pc);
> +	if (!pc->irq_domain)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
> index 0c5655b..894b9ad 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> @@ -540,6 +540,30 @@ static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
>  	return !!(val & BIT(bit));
>  }
>  
> +static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct meson_domain *domain = to_meson_domain(chip);
> +	struct meson_pinctrl *pc = domain->pinctrl;
> +	struct meson_bank *bank;
> +	struct irq_fwspec irq_data;
> +	unsigned int hwirq, irq;
> +
> +	hwirq = domain->data->pin_base + offset;
> +
> +	if (meson_get_bank(domain, hwirq, &bank))
> +		return -ENXIO;
> +
> +	irq_data.param_count = 2;
> +	irq_data.param[0] = hwirq;
> +
> +	/* dummy. It will be changed later in meson_irq_set_type */
> +	irq_data.param[1] = IRQ_TYPE_EDGE_RISING;

Blah. Worse than I though... How do you end-up here? Why can't you
obtain the corresponding of_phandle_args instead of making things up?
This looks mad. Do you really need this?

	M.
-- 
Jazz is not dead. It just smells funny...
