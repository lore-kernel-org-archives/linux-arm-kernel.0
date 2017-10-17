From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 17 Oct 2017 15:56:42 +0200 (CEST)
Subject: [PATCH v3 2/5] irqchip: Add Realtek RTD1295 mux driver
In-Reply-To: <20171017124708.6242-3-afaerber@suse.de>
References: <20171017124708.6242-1-afaerber@suse.de>
 <20171017124708.6242-3-afaerber@suse.de>
Message-ID: <alpine.DEB.2.20.1710171457570.1932@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Oct 2017, Andreas F?rber wrote:
> +
> +struct rtd119x_irq_mux_info {
> +	unsigned isr_offset;
> +	unsigned umsk_isr_offset;
> +	unsigned scpu_int_en_offset;
> +	const u32 *isr_to_scpu_int_en_mask;

Please use 'unsigned int' instead of the shorthand 'unsigned' and while at
it make the struct definition tabular. That makes it way simpler to read.

struct rtd119x_irq_mux_info {
	unsigned int	isr_offset;
	unsigned int	umsk_isr_offset;
	unsigned int	scpu_int_en_offset;
	const u32 	*isr_to_scpu_int_en_mask;

> +};
> +
> +struct rtd119x_irq_mux_data {
> +	void __iomem *reg_isr;
> +	void __iomem *reg_umsk_isr;
> +	void __iomem *reg_scpu_int_en;
> +	const struct rtd119x_irq_mux_info *info;
> +	int irq;
> +	struct irq_domain *domain;

See above.

> +	spinlock_t lock;

This wants to be a raw_spinlock_t because it's taken in interrupt disabled
context. Not an issue in mainline, but the RT patchset will barf. 

> +};
> +
> +static void rtd119x_mux_irq_handle(struct irq_desc *desc)
> +{
> +	struct rtd119x_irq_mux_data *data = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 scpu_int_en, isr, mask;
> +	int ret, i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	scpu_int_en = readl_relaxed(data->reg_scpu_int_en);
> +	isr = readl_relaxed(data->reg_isr);
> +
> +	for (i = 0; i < 32; i++) {
> +		if (!(isr & BIT(i)))
> +			continue;

Not really performance optimal especially if the interrupt is at the end of
the bits. Such a loop should be optimized for a single interrupt because
that's the majority of events.

        while (isr) {
		i = __ffs(isr);
		isr &= ~(1U << i);
Hmm?

> +		mask = data->info->isr_to_scpu_int_en_mask[i];
> +		if (!(scpu_int_en & mask))
> +			continue;

So this catches the case where you get an unmasked interrupt and there is
another pending interrupt in ISR which is masked. See further down for
more comments on this.

> +
> +		ret = generic_handle_irq(irq_find_mapping(data->domain, i));
> +		if (ret == 0)

Please use the (!ret) shorthand as we normally do in the kernel or simply
get rid of ret completely.

		if (!generic_handle_irq(irq_find_mapping(data->domain, i)))

Hmm?

> +			writel_relaxed(BIT(i), data->reg_isr);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}

> +static void rtd119x_mux_enable_irq(struct irq_data *data)
> +{
> +       struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
> +       unsigned long flags;
> +       u32 scpu_int_en, mask;
> +
> +       mask = mux_data->info->isr_to_scpu_int_en_mask[data->hwirq];
> +       if (!mask)
> +               return;
> +
> +       spin_lock_irqsave(&mux_data->lock, flags);
> +
> +       scpu_int_en = readl_relaxed(mux_data->reg_scpu_int_en);
> +       scpu_int_en |= mask;
> +       writel_relaxed(scpu_int_en, mux_data->reg_scpu_int_en);

So if you make that:

	mux_data->scpu_int_en |= mask;
	mux_data->scpu_isr_en |= BIT(data->hwirq);
	writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
	
Then you have two advantages:

 1) You spare the read

 2) Because you cache also the isr_en value you can make your demultiplex
    routine smarter:

	raw_spin_lock(&data->lock);
	isr = readl_relaxed(data->reg_isr);
	isr &= data->scpu_isr_en;
	raw_spin_unlock(&data->lock);

        while (isr) {
		i = __ffs(isr);
		isr &= ~BIT(i);

		if (!generic_handle_irq(irq_find_mapping(data->domain, i)))
			writel_relaxed(BIT(i), data->reg_isr);
	}

See? It clears out the masked interrupts right away from ISR and it avoids
the extra indirection of reading the irq -> mask table potentially several
times in the loop.

> +static int rtd119x_mux_set_affinity(struct irq_data *d,
> +			const struct cpumask *mask_val, bool force)
> +{
> +	/* Forwarding the affinity to the parent would affect all 32 interrupts. */
> +	return -EINVAL;

Why are you implementing that callback at all? The core checks it for NULL
already and returns an appropriate error code if something tries to set the
affinity of such an interrupt.

> +static struct irq_chip rtd119x_mux_irq_chip = {
> +	.name			= "rtd119x-mux",
> +	.irq_mask		= rtd119x_mux_mask_irq,
> +	.irq_unmask		= rtd119x_mux_unmask_irq,
> +	.irq_enable		= rtd119x_mux_enable_irq,
> +	.irq_disable		= rtd119x_mux_disable_irq,
> +	.irq_set_affinity	= rtd119x_mux_set_affinity,
> +};

> +enum rtd129x_iso_isr_bits {
> +	RTD1295_ISO_ISR_UR0_SHIFT = 2,
> +	RTD1295_ISO_ISR_IRDA_SHIFT = 5,
> +	RTD1295_ISO_ISR_I2C0_SHIFT = 8,
> +	RTD1295_ISO_ISR_I2C1_SHIFT = 11,
> +	RTD1295_ISO_ISR_RTC_HSEC_SHIFT,
> +	RTD1295_ISO_ISR_RTC_ALARM_SHIFT,
> +	RTD1295_ISO_ISR_GPIOA_SHIFT = 19,

That's really hard to read.

> +	RTD1295_ISO_ISR_UR0_SHIFT	= 2,
> +	RTD1295_ISO_ISR_IRDA_SHIFT	= 5,
> +	RTD1295_ISO_ISR_I2C0_SHIFT	= 8,
> +	RTD1295_ISO_ISR_I2C1_SHIFT	= 11,
> +	RTD1295_ISO_ISR_RTC_HSEC_SHIFT	= 12,
> +	RTD1295_ISO_ISR_RTC_ALARM_SHIFT = 13,
> +	RTD1295_ISO_ISR_GPIOA_SHIFT	= 19,

Can you see the difference?

> +	RTD1295_ISO_ISR_GPIODA_SHIFT,
> +	RTD1295_ISO_ISR_GPHY_DV_SHIFT = 29,
> +	RTD1295_ISO_ISR_GPHY_AV_SHIFT,
> +	RTD1295_ISO_ISR_I2C1_REQ_SHIFT,
> +};

> +static const struct rtd119x_irq_mux_info rtd129x_iso_irq_mux_info = {
> +	.isr_offset		= 0x0,
> +	.umsk_isr_offset	= 0x4,
> +	.scpu_int_en_offset	= 0x40,
> +	.isr_to_scpu_int_en_mask = rtd129x_iso_isr_to_scpu_int_en_mask,

If you make the struct member and the function name less convoluted you
can keep the nice tabular mode.

> +};
> +
> +static const struct rtd119x_irq_mux_info rtd129x_misc_irq_mux_info = {
> +	.umsk_isr_offset	= 0x8,
> +	.isr_offset		= 0xc,
> +	.scpu_int_en_offset	= 0x80,
> +	.isr_to_scpu_int_en_mask = rtd129x_misc_isr_to_scpu_int_en_mask,
> +};
> +
> +static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
> +	{
> +		.compatible = "realtek,rtd1295-iso-irq-mux",
> +		.data = &rtd129x_iso_irq_mux_info,

Tabular again, please

> +	}, {

Please make that seperate lines

        },
	{

So it's visually clear.

> +		.compatible = "realtek,rtd1295-misc-irq-mux",
> +		.data = &rtd129x_misc_irq_mux_info,
> +	}, {
> +	}
> +};
> +
> +static int __init rtd119x_irq_mux_init(struct device_node *node,
> +				       struct device_node *parent)
> +{
> +	struct rtd119x_irq_mux_data *data;
> +	const struct of_device_id *match;
> +	const struct rtd119x_irq_mux_info *info;
> +	void __iomem *base;
> +
> +	match = of_match_node(rtd1295_irq_mux_dt_matches, node);
> +	if (!match)
> +		return -EINVAL;
> +
> +	info = match->data;
> +	if (!info)
> +		return -EINVAL;
> +
> +	base = of_iomap(node, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->info = info;
> +	data->reg_isr		= base + info->isr_offset;

If you use tabular initialization then please for all struct members or
none. Inconsistent formatting disturbs the reading flow.

Thanks,

	tglx
