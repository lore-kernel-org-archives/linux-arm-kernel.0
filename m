From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Oct 2016 17:33:13 +0100
Subject: [PATCH v2 1/9] irqchip: meson: add support for gpio interrupt
 controller
In-Reply-To: <1476890480-8884-2-git-send-email-jbrunet@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <ec297647-1ab7-7e6b-5945-be8360f92421@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome,

On 19/10/16 16:21, Jerome Brunet wrote:
> Add support for the interrupt gpio controller found on Amlogic's meson
> SoC family.
> 
> Unlike what the IP name suggest, it is not directly linked to the gpio
> subsystem. It is actually an independent IP that is able to spy on the
> SoC pad. For that purpose, it can mux and filter (edge or level and
> polarity) any single SoC pad to one of the 8 GIC's interrupts it owns.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/irqchip/Kconfig          |   9 +
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-meson-gpio.c | 423 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
>  create mode 100644 drivers/irqchip/irq-meson-gpio.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 82b0b5daf3f5..168837263e80 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -279,3 +279,12 @@ config EZNPS_GIC
>  config STM32_EXTI
>  	bool
>  	select IRQ_DOMAIN
> +
> +config MESON_GPIO_IRQ
> +       bool "Meson GPIO Interrupt Multiplexer"
> +       depends on ARCH_MESON || COMPILE_TEST
> +       select IRQ_DOMAIN
> +       select IRQ_DOMAIN_HIERARCHY
> +       help
> +         Support Meson SoC Family GPIO Interrupt Multiplexer
> +
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index e4dbfc85abdb..33f913d037d0 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -74,3 +74,4 @@ obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
> +obj-$(CONFIG_MESON_GPIO_IRQ)		+= irq-meson-gpio.o
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> new file mode 100644
> index 000000000000..869b4df8c483
> --- /dev/null
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -0,0 +1,423 @@
> +/*
> + * Copyright (c) 2015 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * The full GNU General Public License is included in this distribution
> + * in the file called COPYING.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define IRQ_FREE (-1)
> +
> +#define REG_EDGE_POL	0x00
> +#define REG_PIN_03_SEL	0x04
> +#define REG_PIN_47_SEL	0x08
> +#define REG_FILTER_SEL	0x0c
> +
> +#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
> +#define REG_EDGE_POL_EDGE(x)	BIT(x)
> +#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
> +#define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
> +#define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
> +
> +struct meson_gpio_irq_params {
> +	unsigned int nhwirq;
> +	irq_hw_number_t *source;
> +	int nsource;
> +};
> +
> +struct meson_gpio_irq_domain {

The name of that structure is utterly confusing, as it doesn't contain
anything related to an IRQ domain. Can you please clarify its usage?

> +	void __iomem *base;
> +	int *map;
> +	const struct meson_gpio_irq_params *params;
> +};
> +
> +struct meson_gpio_irq_chip_data {
> +	void __iomem *base;
> +	int index;
> +};
> +
> +static irq_hw_number_t meson_parent_hwirqs[] = {
> +	64, 65, 66, 67, 68, 69, 70, 71,
> +};

If that a guarantee that these numbers will always represent the parent
interrupt? It feels a bit odd not to get that information directly from
the device tree, in the form of a device specific property. Something like:

	upstream-interrupts = <64 65 66 ... >;

or even as a base/range:

	upstream-interrupts = <64 8>;

Also, how does it work if you have more than a single device like this?
This driver seems a do a great deal of dynamic allocation, and yet its
core resource is completely static... Please pick a side! ;-)

> +
> +static const struct meson_gpio_irq_params meson8_params = {
> +	.nhwirq  = 134,
> +	.source  = meson_parent_hwirqs,
> +	.nsource = ARRAY_SIZE(meson_parent_hwirqs),

I find it utterly confusing that you are calling source something that
is an output for this controller. It makes my brain melt, and I don't
like the feeling.

> +};
> +
> +static const struct meson_gpio_irq_params meson8b_params = {
> +	.nhwirq  = 119,
> +	.source  = meson_parent_hwirqs,
> +	.nsource = ARRAY_SIZE(meson_parent_hwirqs),
> +};
> +
> +static const struct meson_gpio_irq_params meson_gxbb_params = {
> +	.nhwirq  = 133,
> +	.source  = meson_parent_hwirqs,
> +	.nsource = ARRAY_SIZE(meson_parent_hwirqs),
> +};

Same thing. How big is the variability of these structures? Are we going
to see more of those? or is that now set into stone?

+Mark: what's the policy to describe this kind of things?

> +
> +static const struct of_device_id meson_irq_gpio_matches[] = {
> +	{
> +		.compatible = "amlogic,meson8-gpio-intc",

If it's an independent IP (as described in the commit message),
shouldn't in be rescribed in a more SoC-independent way?

> +		.data = &meson8_params
> +	},
> +	{
> +		.compatible = "amlogic,meson8b-gpio-intc",
> +		.data = &meson8b_params
> +	},
> +	{
> +		.compatible = "amlogic,meson-gxbb-gpio-intc",
> +		.data = &meson_gxbb_params
> +	},
> +	{}
> +};
> +
> +static void meson_gpio_irq_update_bits(void __iomem *base, unsigned int reg,
> +				       u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(base + reg);
> +	tmp &= ~mask;
> +	tmp |= val;
> +
> +	writel(tmp, base + reg);

Can't you use the relaxed accessors?

> +}
> +
> +static int meson_gpio_irq_get_index(struct meson_gpio_irq_domain *domain_data,
> +				    int hwirq)
> +{
> +	int i;
> +
> +	for (i = 0; i < domain_data->params->nsource; i++) {
> +		if (domain_data->map[i] == hwirq)
> +			return i;
> +	}
> +
> +	return -1;

I'm a bit worried by this function. If you need an allocator, then
having a simple bitmap is much better than iterating over an array.

If you're using this to go from a hwirq to the structure describing your
interrupt, this is wrong. You should never have to look-up something
based on a hwirq, because that's what irq domains are for.

> +}
> +
> +static int mesion_gpio_irq_map_source(struct meson_gpio_irq_domain *domain_data,
> +				      irq_hw_number_t hwirq,
> +				      irq_hw_number_t *source)
> +{
> +	int index;
> +	unsigned int reg;
> +
> +	index = meson_gpio_irq_get_index(domain_data, IRQ_FREE);

So assuming you turn this into a proper bitmap driven allocator...

> +	if (index < 0) {
> +		pr_err("No irq available\n");
> +		return -ENOSPC;
> +	}
> +
> +	domain_data->map[index] = hwirq;

this can go away, as there is hardly any point in tracking the hwirq on
its own. Actually, the whole map[] array looks totally useless.

> +
> +	reg = (index < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
> +	meson_gpio_irq_update_bits(domain_data->base, reg,
> +				   0xff << REG_PIN_SEL_SHIFT(index),
> +				   hwirq << REG_PIN_SEL_SHIFT(index));
> +
> +	*source = domain_data->params->source[index];
> +
> +	pr_debug("hwirq %lu assigned to channel %d - source %lu\n",
> +		 hwirq, index, *source);
> +
> +	return index;
> +}
> +
> +static int meson_gpio_irq_type_setup(unsigned int type, void __iomem *base,
> +				     int index)
> +{
> +	u32 val = 0;
> +
> +	type &= IRQ_TYPE_SENSE_MASK;
> +
> +	if (type == IRQ_TYPE_EDGE_BOTH)
> +		return -EINVAL;
> +
> +	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
> +		val |= REG_EDGE_POL_EDGE(index);
> +
> +	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
> +		val |= REG_EDGE_POL_LOW(index);
> +
> +	meson_gpio_irq_update_bits(base, REG_EDGE_POL,
> +				   REG_EDGE_POL_MASK(index), val);
> +
> +	return 0;
> +}
> +
> +static unsigned int meson_gpio_irq_type_output(unsigned int type)
> +{
> +	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
> +
> +	type &= ~IRQ_TYPE_SENSE_MASK;
> +
> +	/*
> +	 * If the polarity of interrupt is low, the controller will
> +	 * invert the signal for gic
> +	 */
> +	if (sense & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> +		type |= IRQ_TYPE_LEVEL_HIGH;
> +	else if (sense & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
> +		type |= IRQ_TYPE_EDGE_RISING;
> +
> +	return type;
> +}
> +
> +static int meson_gpio_irq_set_type(struct irq_data *data, unsigned int type)
> +{
> +	struct meson_gpio_irq_chip_data *cd = irq_data_get_irq_chip_data(data);
> +	int ret;
> +
> +	pr_debug("set type of hwirq %lu to %u\n", data->hwirq, type);
> +
> +	ret = meson_gpio_irq_type_setup(type, cd->base, cd->index);
> +	if (ret)
> +		return ret;
> +
> +	return irq_chip_set_type_parent(data,
> +					meson_gpio_irq_type_output(type));
> +}
> +
> +static struct irq_chip meson_gpio_irq_chip = {
> +	.name			= "meson-gpio-irqchip",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_type		= meson_gpio_irq_set_type,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +#endif
> +};
> +
> +static int meson_gpio_irq_domain_translate(struct irq_domain *domain,
> +					   struct irq_fwspec *fwspec,
> +					   unsigned long *hwirq,
> +					   unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 2)
> +			return -EINVAL;

You can write this as:

	if (is_of_node() && fwspec->... == 2) {

> +
> +		*hwirq	= fwspec->param[0];
> +		*type	= fwspec->param[1];
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int meson_gpio_irq_allocate_gic_irq(struct irq_domain *domain,
> +					   unsigned int virq,
> +					   irq_hw_number_t source,
> +					   unsigned int type)
> +{
> +	struct irq_fwspec fwspec;
> +
> +	if (!irq_domain_get_of_node(domain->parent))
> +		return -EINVAL;

How can you end-up here if the translate operation has failed?

> +
> +	fwspec.fwnode = domain->parent->fwnode;
> +	fwspec.param_count = 3;
> +	fwspec.param[0] = 0;	/* SPI */
> +	fwspec.param[1] = source;
> +	fwspec.param[2] = meson_gpio_irq_type_output(type);
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +}
> +
> +static int meson_gpio_irq_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq,
> +				       unsigned int nr_irqs,
> +				       void *data)
> +{
> +	struct irq_fwspec *fwspec = data;
> +	struct meson_gpio_irq_domain *domain_data = domain->host_data;
> +	struct meson_gpio_irq_chip_data *cd;
> +	unsigned long hwirq, source;
> +	unsigned int type;
> +	int i, index, ret;
> +
> +	ret = meson_gpio_irq_domain_translate(domain, fwspec, &hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	pr_debug("irq %d, nr_irqs %d, hwirqs %lu\n", virq, nr_irqs, hwirq);
> +
> +	for (i = 0; i < nr_irqs; i++) {

This is a pattern that gets repeated over and over, for no good reason.
The only reason we have this nr_irqs thing is to handle things like
multi-MSI, where we have to *guarantee* that the hwirqs are allocated in
a contiguous manner.

Here, you don't enforce that guarantee, so you'd rather have a big fat:

	if (WARN_ON(nr_irqs != 1))
		return -EINVAL;

and get rid of that loop, because I cannot imagine a case where you'd
allocate more than a single interrupt@a time.

> +		index = mesion_gpio_irq_map_source(domain_data, hwirq + i,
> +						   &source);
> +		if (index < 0)
> +			return index;
> +
> +		ret = meson_gpio_irq_type_setup(type, domain_data->base,
> +						index);
> +		if (ret)
> +			return ret;

Why do you have to to this here? This should be handled by the core code
already.

> +
> +		cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +		if (!cd)
> +			return -ENOMEM;
> +
> +		cd->base = domain_data->base;
> +		cd->index = index;

So what is the exact purpose of this structure? The base address is
essentially a global, or could be directly derived from the domain. The
index is only used in set_type, and is the index of the pin connected to
the GIC. It looks to me like you could have:

		irq_hw_number_t *out_line = &meson_parent_hwirqs[index];

> +
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &meson_gpio_irq_chip, cd);

and this written as

		irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
					      out_line);

In your set_type function, you just compute the index back:

	irq_hw_number_t *out_line = irq_data_get_irq_chip_data(data);
	irq_hw_number_t index = out_line - meson_parent_hwirqs;

and you're done.

> +
> +		ret = meson_gpio_irq_allocate_gic_irq(domain, virq + i,
> +						      source, type);

Resource leak on error.

> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void meson_gpio_irq_domain_free(struct irq_domain *domain,
> +				       unsigned int virq,
> +				       unsigned int nr_irqs)
> +{
> +	struct meson_gpio_irq_domain *domain_data = domain->host_data;
> +	struct meson_gpio_irq_chip_data *cd;
> +	struct irq_data *irq_data;
> +	int i;
> +
> +	for (i = 0; i < nr_irqs; i++) {

Same comment as above.

> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> +		cd = irq_data_get_irq_chip_data(irq_data);
> +
> +		domain_data->map[cd->index] = IRQ_FREE;
> +		kfree(cd);
> +	}
> +
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +
> +}
> +
> +static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
> +	.alloc		= meson_gpio_irq_domain_alloc,
> +	.free		= meson_gpio_irq_domain_free,
> +	.translate	= meson_gpio_irq_domain_translate,
> +};
> +
> +static int __init
> +meson_gpio_irq_init_domain(struct device_node *node,
> +			   struct meson_gpio_irq_domain *domain_data,
> +			   const struct meson_gpio_irq_params *params)
> +{
> +	int i;
> +	int nsource = params->nsource;
> +	int *map;
> +
> +	map = kcalloc(nsource, sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nsource; i++)
> +		map[i] = IRQ_FREE;
> +
> +	domain_data->map = map;

You should now be able to kill most or all of this.

> +	domain_data->params = params;
> +
> +	return 0;
> +}
> +
> +static int __init meson_gpio_irq_of_init(struct device_node *node,
> +					 struct device_node *parent)
> +{
> +	struct irq_domain *domain, *parent_domain;
> +	const struct of_device_id *match;
> +	const struct meson_gpio_irq_params *params;
> +	struct meson_gpio_irq_domain *domain_data;
> +	int ret;
> +
> +	match = of_match_node(meson_irq_gpio_matches, node);
> +	if (!match)
> +		return -ENODEV;
> +	params = match->data;
> +
> +	if (!parent) {
> +		pr_err("missing parent interrupt node\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent);
> +	if (!parent_domain) {
> +		pr_err("unable to obtain parent domain\n");
> +		return -ENXIO;
> +	}
> +
> +	domain_data = kzalloc(sizeof(*domain_data), GFP_KERNEL);
> +	if (!domain_data)
> +		return -ENOMEM;
> +
> +	domain_data->base = of_iomap(node, 0);
> +	if (!domain_data->base) {
> +		ret = -ENOMEM;
> +		goto out_free_dev;
> +	}
> +
> +	ret = meson_gpio_irq_init_domain(node, domain_data, params);
> +	if (ret < 0)
> +		goto out_free_dev_content;
> +
> +	domain = irq_domain_add_hierarchy(parent_domain, 0, params->nhwirq,
> +					  node, &meson_gpio_irq_domain_ops,
> +					  domain_data);

Please be consistent in using the fwnode API instead of the of_node one.

> +
> +	if (!domain) {
> +		pr_err("failed to allocated domain\n");
> +		ret = -ENOMEM;
> +		goto out_free_dev_content;
> +	}
> +
> +	pr_info("%d to %d gpio interrupt mux initialized\n",
> +		params->nhwirq, params->nsource);
> +
> +	return 0;
> +
> +out_free_dev_content:
> +	kfree(domain_data->map);
> +	iounmap(domain_data->base);
> +
> +out_free_dev:
> +	kfree(domain_data);
> +
> +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(meson8_gpio_intc, "amlogic,meson8-gpio-intc",
> +		meson_gpio_irq_of_init);
> +IRQCHIP_DECLARE(meson8b_gpio_intc, "amlogic,meson8b-gpio-intc",
> +		meson_gpio_irq_of_init);
> +IRQCHIP_DECLARE(gxbb_gpio_intc, "amlogic,meson-gxbb-gpio-intc",
> +		meson_gpio_irq_of_init);
> 

Overall, this driver is a bit of a mess. Tons of structures that don't
make much sense, and a false sense of being able to support multiple
instances of the device.

I'll let Mark comment on the DT side of things.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
