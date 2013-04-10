From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 10 Apr 2013 14:20:22 +0200
Subject: [PATCH] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <1376906.qvoN3qK2gl@flatron>
References: <201304100135.12471.heiko@sntech.de> <1376906.qvoN3qK2gl@flatron>
Message-ID: <201304101420.23106.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

thanks for your comments, more inline.


Am Mittwoch, 10. April 2013, 12:36:39 schrieb Tomasz Figa:
> Hi Heiko,
> 
> Basically looks good to me, but please see my inline comments about
> handling of EINT0-3.
> 
> On Wednesday 10 of April 2013 01:35:12 Heiko St?bner wrote:
> > The s3c24xx pins follow a similar pattern as the other Samsung SoCs and
> > can therefore reuse the already introduced infrastructure.

[...]

> > +struct s3c24xx_eint_data {
> > +	struct samsung_pinctrl_drv_data *drvdata;
> > +	struct irq_domain *domains[NUM_EINT];
> > +	int parents[NUM_EINT_IRQ];
> > +};
> > +
> > +struct s3c24xx_eint_domain_data {
> > +	struct samsung_pin_bank *bank;
> > +	struct s3c24xx_eint_data *eint_data;
> 
> What about:
> 
> +	bool eint0_3_parent_only;
> 
> (or whatever name would be more appropriate), which would store the
> information about the s3c24xx-specific quirk in 24xx-specific data
> structure, without the need to add another field to the generic
> samsung_pinctrl_drv_data structure?
> 
> See my further comments on how I would see using this field in interrupt
> handling code.

ok, sounds good, especially gathering the type from the wakeup-int property

> > +};

[...]

> Now I would split the following 3 functions into two sets of 3 functions,
> one set for s3c2412 and other for remaining SoCs and make separate EINT0-3
> IRQ chips for both cases.

Not doing the decision every time, might bring some very slight speed 
improvements, so is probably the right way to go.

> > +
> > +static void s3c24xx_eint0_3_ack(struct irq_data *data)
> > +{
> > +	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(data);
> > +	struct samsung_pinctrl_drv_data *d = bank->drvdata;
> > +	struct s3c24xx_eint_domain_data *ddata = bank->irq_domain-
> >
> >host_data;
> >
> > +	struct s3c24xx_eint_data *eint_data = ddata->eint_data;
> > +	int parent_irq = eint_data->parents[data->hwirq];
> > +	struct irq_chip *parent_chip = irq_get_chip(parent_irq);
> > +
> > +	if (d->ctrl->type == S3C2412) {
> > +		unsigned long bitval = 1UL << data->hwirq;
> > +		writel(bitval, d->virt_base + EINTPEND_REG);
> > +	}
> > +
> > +	if (parent_chip->irq_ack)
> > +		parent_chip->irq_ack(irq_get_irq_data(parent_irq));
> 
> Btw. Is this parent level acking really needed here?

Depends. If using chained_irq_* of course not, but if the irq-handler should 
stay in charge of when to ack it might be better this way.

Generic s3c24xx SoCs need acking in the main controller only, while s3c2412 
needs acking in both the main controller and eintpend.

> > +}

[...]

> > +static void s3c24xx_demux_eint0_3(unsigned int irq, struct irq_desc
> > *desc) +{
> > +	struct irq_data *data = irq_desc_get_irq_data(desc);
> > +	struct s3c24xx_eint_data *eint_data = irq_get_handler_data(irq);
> > +	unsigned int virq;
> > +
> 
> Instead of acking the interrupt at parent chip from ack callback of
> EINT0_3 chip, I would rather use chained_irq_enter() here...
> 
> > +	/* the first 4 eints have a simple 1 to 1 mapping */
> > +	virq = irq_linear_revmap(eint_data->domains[data->hwirq],
> > data->hwirq); +	/* Something must be really wrong if an unmapped
> 
> EINT
> 
> > +	 * was unmasked...
> > +	 */
> > +	BUG_ON(!virq);
> > +
> > +	generic_handle_irq(virq);
> 
> ...and chained_irq_exit() here.

If I understand it correctly, the way chained_irq_* works it would limit the 
eints to a level style handling. With the way it's currently the whole 
determination of when to ack,mask and unmask is completely for the real 
handler (edge or level) to decide, as the original interrupt gets completely 
forwarded into the irq-domain without further constraints.

So, after the change on regular s3c24xx SoCs when the real irq handler wants 
to ack the irq, it would be a no-op, as it would already have been acked by 
chained_irq_enter.

Masking might be even more interesting. Currently control is transfered 
completely to the pinctrl irq-domain, which then controls the masking of the 
interrupt thru the parent-calls - on regular s3c24xx the masking of these is 
also only done in the main controller.

When using chained_irq_* it also wants to mask the interrupt which might 
conflict with regular enable_irq/disable_irq calls being done for example in 
driver code.


So in short I agree with the earlier split of the irqchip, but would keep the 
irq operations themself centralized in the pinctrl driver, instead of using 
chained_irq_* functions.


Heiko
 

> > +}
> > +
> > +static inline void s3c24xx_demux_eint(unsigned int irq, struct irq_desc
> > *desc, +				      u32 offset, u32 range)
> > +{
> > +	struct irq_chip *chip = irq_get_chip(irq);
> > +	struct s3c24xx_eint_data *data = irq_get_handler_data(irq);
> > +	struct samsung_pinctrl_drv_data *d = data->drvdata;
> > +	unsigned int pend, mask;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	pend = readl(d->virt_base + EINTPEND_REG);
> > +	mask = readl(d->virt_base + EINTMASK_REG);
> > +
> > +	pend &= ~mask;
> > +	pend &= range;
> > +
> > +	while (pend) {
> > +		unsigned int virq;
> > +
> > +		irq = __ffs(pend);
> > +		pend &= ~(1 << irq);
> > +		virq = irq_linear_revmap(data->domains[irq], irq -
> 
> offset);
> 
> > +		/* Something must be really wrong if an unmapped EINT
> > +		 * was unmasked...
> > +		 */
> > +		BUG_ON(!virq);
> > +
> > +		generic_handle_irq(virq);
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void s3c24xx_demux_eint4_7(unsigned int irq, struct irq_desc
> > *desc) +{
> > +	s3c24xx_demux_eint(irq, desc, 0, 0xf0);
> > +}
> > +
> > +static void s3c24xx_demux_eint8_23(unsigned int irq, struct irq_desc
> > *desc) +{
> > +	s3c24xx_demux_eint(irq, desc, 8, 0xffff00);
> > +}
> > +
> > +static irq_flow_handler_t s3c24xx_eint_handlers[NUM_EINT_IRQ] = {
> > +	s3c24xx_demux_eint0_3,
> > +	s3c24xx_demux_eint0_3,
> > +	s3c24xx_demux_eint0_3,
> > +	s3c24xx_demux_eint0_3,
> > +	s3c24xx_demux_eint4_7,
> > +	s3c24xx_demux_eint8_23,
> > +};
> > +
> > +static int s3c24xx_gpf_irq_map(struct irq_domain *h, unsigned int virq,
> > +					irq_hw_number_t hw)
> > +{
> > +	struct s3c24xx_eint_domain_data *ddata = h->host_data;
> > +	struct samsung_pin_bank *bank = ddata->bank;
> > +
> > +	if (!(bank->eint_mask & (1 << (bank->eint_offset + hw))))
> > +		return -EINVAL;
> > +
> > +	if (hw <= 3) {
> 
> Now here I would check ddata->eint0_3_parent_only and set the chip
> conditionally, either to s3c24xx or s3c2412 variant.
> 
> > +		irq_set_chip_and_handler(virq, &s3c24xx_eint0_3_chip,
> > +					 handle_edge_irq);
> > +		irq_set_chip_data(virq, bank);
> > +	} else {
> > +		irq_set_chip_and_handler(virq, &s3c24xx_eint_chip,
> > +					 handle_edge_irq);
> > +		irq_set_chip_data(virq, bank);
> > +	}
> > +	set_irq_flags(virq, IRQF_VALID);
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops s3c24xx_gpf_irq_ops = {
> > +	.map	= s3c24xx_gpf_irq_map,
> > +	.xlate	= irq_domain_xlate_twocell,
> > +};
> > +
> > +static int s3c24xx_gpg_irq_map(struct irq_domain *h, unsigned int virq,
> > +					irq_hw_number_t hw)
> > +{
> > +	struct s3c24xx_eint_domain_data *ddata = h->host_data;
> > +	struct samsung_pin_bank *bank = ddata->bank;
> > +
> > +	if (!(bank->eint_mask & (1 << (bank->eint_offset + hw))))
> > +		return -EINVAL;
> > +
> > +	irq_set_chip_and_handler(virq, &s3c24xx_eint_chip,
> 
> handle_edge_irq);
> 
> > +	irq_set_chip_data(virq, bank);
> > +	set_irq_flags(virq, IRQF_VALID);
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops s3c24xx_gpg_irq_ops = {
> > +	.map	= s3c24xx_gpg_irq_map,
> > +	.xlate	= irq_domain_xlate_twocell,
> > +};
> > +
> > +static const struct of_device_id s3c24xx_eint_irq_ids[] = {
> > +	{ .compatible = "samsung,s3c24xx-wakeup-eint", },
> > +	{ }
> > +};
> > +
> > +static int s3c24xx_eint_init(struct samsung_pinctrl_drv_data *d)
> > +{
> > +	struct device *dev = d->dev;
> > +	struct device_node *eint_np = NULL;
> > +	struct device_node *np;
> > +	struct samsung_pin_bank *bank;
> > +	struct s3c24xx_eint_data *eint_data;
> > +	const struct irq_domain_ops *ops;
> > +	unsigned int i;
> > +
> > +	for_each_child_of_node(dev->of_node, np) {
> > +		if (of_match_node(s3c24xx_eint_irq_ids, np)) {
> > +			eint_np = np;
> > +			break;
> > +		}
> > +	}
> > +	if (!eint_np)
> > +		return -ENODEV;
> > +
> > +	eint_data = devm_kzalloc(dev, sizeof(*eint_data), GFP_KERNEL);
> > +	if (!eint_data) {
> > +		dev_err(dev, "could not allocate memory for wkup eint
> 
> data\n");
> 
> > +		return -ENOMEM;
> > +	}
> > +	eint_data->drvdata = d;
> > +
> > +	for (i = 0; i < NUM_EINT_IRQ; ++i) {
> > +		unsigned int irq;
> > +
> > +		irq = irq_of_parse_and_map(eint_np, i);
> > +		if (!irq) {
> > +			dev_err(dev, "failed to get wakeup EINT IRQ %d\n",
> 
> i);
> 
> > +			return -ENXIO;
> > +		}
> > +
> > +		eint_data->parents[i] = irq;
> > +		irq_set_chained_handler(irq, s3c24xx_eint_handlers[i]);
> > +		irq_set_handler_data(irq, eint_data);
> > +	}
> > +
> > +	bank = d->ctrl->pin_banks;
> > +	for (i = 0; i < d->ctrl->nr_banks; ++i, ++bank) {
> > +		struct s3c24xx_eint_domain_data *ddata;
> > +		unsigned int mask;
> > +		unsigned int irq;
> > +		unsigned int pin;
> > +
> > +		if (bank->eint_type != EINT_TYPE_WKUP)
> > +			continue;
> > +
> > +		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +		if (!ddata) {
> > +			dev_err(dev, "failed to allocate domain data\n");
> > +			return -ENOMEM;
> > +		}
> > +		ddata->bank = bank;
> > +		ddata->eint_data = eint_data;
> 
> Here the eint0_3_parent_only field can be set based on compatible string
> of the EINT controller.
> 
> > +
> > +		ops = (bank->eint_offset == 0) ? &s3c24xx_gpf_irq_ops
> > +					       : &s3c24xx_gpg_irq_ops;
> > +
> > +		bank->irq_domain = irq_domain_add_linear(bank->of_node,
> > +				bank->nr_pins, ops, ddata);
> > +		if (!bank->irq_domain) {
> > +			dev_err(dev, "wkup irq domain add failed\n");
> > +			return -ENXIO;
> > +		}
> > +
> > +		irq = bank->eint_offset;
> > +		mask = bank->eint_mask;
> > +		for (pin = 0; mask; ++pin, mask >>= 1) {
> > +			if (irq > NUM_EINT)
> > +				break;
> > +			if (!(mask & 1))
> > +				continue;
> > +			eint_data->domains[irq] = bank->irq_domain;
> > +			++irq;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct samsung_pin_bank s3c2413_pin_banks[] = {
> > +	PIN_BANK_A(23, 0x000, "gpa"),
> > +	PIN_BANK_2BIT(11, 0x010, "gpb"),
> > +	PIN_BANK_2BIT(16, 0x020, "gpc"),
> > +	PIN_BANK_2BIT(16, 0x030, "gpd"),
> > +	PIN_BANK_2BIT(16, 0x040, "gpe"),
> > +	PIN_BANK_2BIT_EINTW(8, 0x050, "gpf", 0, 0xff),
> > +	PIN_BANK_2BIT_EINTW(16, 0x060, "gpg", 8, 0xffff00),
> > +	PIN_BANK_2BIT(11, 0x070, "gph"),
> > +	PIN_BANK_2BIT(13, 0x080, "gpj"),
> > +};
> > +
> > +struct samsung_pin_ctrl s3c2413_pin_ctrl[] = {
> > +	{
> > +		.pin_banks	= s3c2413_pin_banks,
> > +		.nr_banks	= ARRAY_SIZE(s3c2413_pin_banks),
> > +		.eint_wkup_init = s3c24xx_eint_init,
> > +		.label		= "S3C2413-GPIO",
> > +		.type		= S3C2412,
> 
> And then finally you shouldn't need this type field anymore.
