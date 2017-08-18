From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Aug 2017 11:53:57 +0100
Subject: [RFC 3/3] irqchip: Add Realtek RTD1295 mux driver
In-Reply-To: <20170817101140.32000-4-afaerber@suse.de>
References: <20170817101140.32000-1-afaerber@suse.de>
 <20170817101140.32000-4-afaerber@suse.de>
Message-ID: <da3b236f-08ec-837a-de18-4c22b30ce5ca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/17 11:11, Andreas F?rber wrote:
> This irq mux driver is derived from the RTD1295 vendor DT and assumes a linear
> mapping between intr_en and intr_status registers. Code for RTD119x indicates
> this may not always be the case (i2c_3).
> 
> The register initialization was copied from QNAP's mach-rtk119x/rtk_irq_mux.c
> as a boot fix, without full insights into what exactly this is changing (TODO).
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-rtd119x-mux.c | 201 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 drivers/irqchip/irq-rtd119x-mux.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e88d856cc09c..46202a0b7d96 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> +obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd119x-mux.o
> diff --git a/drivers/irqchip/irq-rtd119x-mux.c b/drivers/irqchip/irq-rtd119x-mux.c
> new file mode 100644
> index 000000000000..c6c1ba126bf3
> --- /dev/null
> +++ b/drivers/irqchip/irq-rtd119x-mux.c
> @@ -0,0 +1,201 @@
> +/*
> + * Realtek RTD129x IRQ mux
> + *
> + * Copyright (c) 2017 Andreas F?rber
> + *
> + * SPDX-License-Identifier: GPL-2.0+
> + */
> +
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
> +
> +struct rtd119x_irq_mux_info {
> +	unsigned intr_status;
> +	unsigned intr_en;

nit: these would be better named with a "_offset" suffix, in order to
better distinguish them from the structure below.

> +};
> +
> +struct rtd119x_irq_mux_data {
> +	void __iomem *intr_status;
> +	void __iomem *intr_en;
> +	int irq;
> +	struct irq_domain *domain;
> +	spinlock_t lock;
> +};
> +
> +static void rtd119x_mux_irq_handle(struct irq_desc *desc)
> +{
> +	struct rtd119x_irq_mux_data *data = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	u32 intr_en, intr_status, status;
> +	int ret;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	spin_lock(&data->lock);
> +	intr_en     = readl(data->intr_en);
> +	intr_status = readl(data->intr_status);

All the readl/writel should be turned into their _relaxed versions.

> +	spin_unlock(&data->lock);
> +
> +	status = intr_status & intr_en;
> +	if (status != 0) {
> +		unsigned irq = __ffs(status);
> +		ret = generic_handle_irq(irq_find_mapping(data->domain, irq));
> +		if (ret == 0) {
> +			spin_lock(&data->lock);
> +			intr_status = readl(data->intr_status);
> +			intr_status |= BIT(irq - 1);
> +			writel(intr_status, data->intr_status);
> +			spin_unlock(&data->lock);
> +		}
> +	}

And what if status is 0? We keep the lock held forever?

> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void rtd119x_mux_mask_irq(struct irq_data *data)
> +{
> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
> +	u32 intr_status;
> +
> +	intr_status = readl(mux_data->intr_status);
> +	intr_status |= BIT(data->hwirq);
> +	writel(intr_status, mux_data->intr_status);

So you need a lock in the chained handler, but you don't need one here?
It doesn't feel right.

> +}
> +
> +static void rtd119x_mux_unmask_irq(struct irq_data *data)
> +{
> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
> +	u32 intr_en;
> +
> +	intr_en = readl(mux_data->intr_en);
> +	intr_en |= BIT(data->hwirq);
> +	writel(intr_en, mux_data->intr_en);

Same thing here.

> +}
> +
> +static int rtd119x_mux_set_affinity(struct irq_data *d,
> +			const struct cpumask *mask_val, bool force)
> +{
> +	struct rtd119x_irq_mux_data *mux_data = irq_data_get_irq_chip_data(d);
> +	struct irq_chip *chip = irq_get_chip(mux_data->irq);
> +	struct irq_data *data = irq_get_irq_data(mux_data->irq);
> +
> +	if (chip && chip->irq_set_affinity)
> +		return chip->irq_set_affinity(data, mask_val, force);

I'm always worried when I see this. It means that all of the interrupts
on the secondary chip move in one go, without the core code noticing.

One of these days, we'll have to address it.

> +
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip rtd119x_mux_irq_chip = {
> +	.name			= "rtd119x-mux",
> +	.irq_mask		= rtd119x_mux_mask_irq,
> +	.irq_unmask		= rtd119x_mux_unmask_irq,
> +	.irq_set_affinity	= rtd119x_mux_set_affinity,
> +};
> +
> +static int rtd119x_mux_irq_domain_xlate(struct irq_domain *d,
> +		struct device_node *controller,
> +		const u32 *intspec, unsigned int intsize,
> +		unsigned long *out_hwirq,
> +		unsigned int *out_type)
> +{
> +	if (irq_domain_get_of_node(d) != controller)
> +		return -EINVAL;
> +
> +	if (intsize < 1)
> +		return -EINVAL;
> +
> +	*out_hwirq = intspec[0];
> +	*out_type = 0;
> +
> +	return 0;
> +}

Please use irq_domain_xlate_onecell() instead.

> +
> +static int rtd119x_mux_irq_domain_map(struct irq_domain *d,
> +		unsigned int irq, irq_hw_number_t hw)
> +{
> +	struct rtd119x_irq_mux_data *data = d->host_data;
> +
> +	irq_set_chip_and_handler(irq, &rtd119x_mux_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, data);
> +	irq_set_probe(irq);
> +
> +	return 0;
> +}
> +
> +static struct irq_domain_ops rtd119x_mux_irq_domain_ops = {
> +	.xlate	= rtd119x_mux_irq_domain_xlate,
> +	.map	= rtd119x_mux_irq_domain_map,
> +};
> +
> +static int __init rtd119x_irq_mux_init(struct device_node *node,
> +				       struct device_node *parent,
> +				       const struct rtd119x_irq_mux_info *info)
> +{
> +	struct rtd119x_irq_mux_data *data;
> +	void __iomem *base;
> +	u32 val;
> +
> +	base = of_iomap(node, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->intr_status = base + info->intr_status;
> +	data->intr_en     = base + info->intr_en;
> +
> +	data->irq = irq_of_parse_and_map(node, 0);
> +	if (data->irq <= 0) {
> +		kfree(data);
> +		return -EINVAL;
> +	}
> +
> +	data->domain = irq_domain_add_linear(node, 32,
> +				&rtd119x_mux_irq_domain_ops, data);
> +	if (!data->domain) {
> +		kfree(data);
> +		return -ENOMEM;
> +	}
> +
> +	/* TODO Investigate why these are necessary (from downstream rtk119x rtk_irq_mux.c) */
> +	val = readl(data->intr_en);
> +	val &= ~BIT(2);
> +	writel(val, data->intr_en);
> +
> +	writel(BIT(2), data->intr_status);
> +
> +	irq_set_chained_handler_and_data(data->irq, rtd119x_mux_irq_handle, data);
> +
> +	return 0;
> +}
> +
> +static const struct rtd119x_irq_mux_info rtd1295_iso_irq_mux_info = {
> +	.intr_status	= 0x0,
> +	.intr_en	= 0x40,
> +};
> +
> +static int __init rtd1295_iso_irq_mux_init(struct device_node *node,
> +					   struct device_node *parent)
> +{
> +	return rtd119x_irq_mux_init(node, parent, &rtd1295_iso_irq_mux_info);
> +}
> +IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd1295_iso_irq_mux_init);
> +
> +static const struct rtd119x_irq_mux_info rtd1295_irq_mux_info = {
> +	.intr_status	= 0xc,
> +	.intr_en	= 0x80,
> +};
> +
> +static int __init rtd1295_irq_mux_init(struct device_node *node,
> +				       struct device_node *parent)
> +{
> +	return rtd119x_irq_mux_init(node, parent, &rtd1295_irq_mux_info);
> +}
> +IRQCHIP_DECLARE(rtd1295_mux, "realtek,rtd1295-irq-mux", rtd1295_irq_mux_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
