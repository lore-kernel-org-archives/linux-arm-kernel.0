From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 16 Jun 2017 12:02:55 +0200
Subject: [PATCH v3 2/6] irqchip: meson: add support for gpio interrupt
 controller
In-Reply-To: <d37dae42-77df-72b7-0898-a4873ccbbcce@arm.com>
References: <20170615161804.32658-1-jbrunet@baylibre.com>
 <20170615161804.32658-3-jbrunet@baylibre.com>
 <d37dae42-77df-72b7-0898-a4873ccbbcce@arm.com>
Message-ID: <1497607375.3086.40.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-06-16 at 10:35 +0100, Marc Zyngier wrote:
> + Heiner.
> 
> On 15/06/17 17:18, Jerome Brunet wrote:
> > Add support for the interrupt gpio controller found on Amlogic's meson
> > SoC family.
> > 
> > Unlike what the IP name suggest, it is not directly linked to the gpio
> > subsystem. This separate controller is able to spy on the SoC pad. It is
> > essentially a 256 to 8 router with a filtering block to select level or
> > edge and polarity. The number of actual mappable inputs depends on the
> > SoC.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> > ?drivers/irqchip/Kconfig??????????|???8 +
> > ?drivers/irqchip/Makefile?????????|???1 +
> > ?drivers/irqchip/irq-meson-gpio.c | 407
> > +++++++++++++++++++++++++++++++++++++++
> > ?3 files changed, 416 insertions(+)
> > ?create mode 100644 drivers/irqchip/irq-meson-gpio.c
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 478f8ace2664..be577a7512cc 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -301,3 +301,11 @@ config QCOM_IRQ_COMBINER
> > ?	help
> > ?	??Say yes here to add support for the IRQ combiner devices embedded
> > ?	??in Qualcomm Technologies chips.
> > +
> > +config MESON_IRQ_GPIO
> > +???????bool "Meson GPIO Interrupt Multiplexer"
> > +???????depends on ARCH_MESON || COMPILE_TEST
> > +???????select IRQ_DOMAIN
> > +???????select IRQ_DOMAIN_HIERARCHY
> > +???????help
> > +?????????Support Meson SoC Family GPIO Interrupt Multiplexer
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index b64c59b838a0..95bf2715850e 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -76,3 +76,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-
> > eznps.o
> > ?obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
> > ?obj-$(CONFIG_STM32_EXTI)?		+= irq-stm32-exti.o
> > ?obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> > +obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
> > diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
> > gpio.c
> > new file mode 100644
> > index 000000000000..3b6d0ffec357
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-meson-gpio.c
> > @@ -0,0 +1,407 @@
> > +/*
> > + * Copyright (c) 2015 Endless Mobile, Inc.
> > + * Author: Carlo Caione <carlo@endlessm.com>
> > + * Copyright (c) 2016 BayLibre, SAS.
> > + * Author: Jerome Brunet <jbrunet@baylibre.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of version 2 of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.??See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + * The full GNU General Public License is included in this distribution
> > + * in the file called COPYING.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +
> > +#define NUM_UPSTREAM_IRQ 8
> > +#define MAX_INPUT_MUX 256
> > +
> > +#define REG_EDGE_POL	0x00
> > +#define REG_PIN_03_SEL	0x04
> > +#define REG_PIN_47_SEL	0x08
> > +#define REG_FILTER_SEL	0x0c
> > +
> > +#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
> > +#define REG_EDGE_POL_EDGE(x)	BIT(x)
> > +#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
> > +#define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
> > +#define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
> > +
> > +struct meson_gpio_irq_params {
> > +	unsigned int nr_hwirq;
> > +};
> > +
> > +static const struct meson_gpio_irq_params meson8b_params = {
> > +	.nr_hwirq = 119,
> > +};
> > +
> > +static const struct meson_gpio_irq_params gxbb_params = {
> > +	.nr_hwirq = 133,
> > +};
> > +
> > +static const struct meson_gpio_irq_params gxl_params = {
> > +	.nr_hwirq = 110,
> > +};
> > +
> > +static const struct of_device_id meson_irq_gpio_matches[] = {
> > +	{ .compatible = "amlogic,meson8b-gpio-intc", .data =
> > &meson8b_params },
> > +	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data =
> > &gxbb_params },
> > +	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params
> > },
> > +	{ }
> > +};
> > +
> > +struct meson_gpio_irq_controller {
> > +	unsigned int nr_hwirq;
> > +	void __iomem *base;
> > +	u32 upstream_irq[NUM_UPSTREAM_IRQ];
> > +	DECLARE_BITMAP(map, NUM_UPSTREAM_IRQ);
> 
> upstream_irq doesn't mean much. You use "channel" elsewhere, which makes
> a bit more sense (and map could become channel_map).
> 
> This NUM_UPSTREAM_IRQ could potentially become a SoC-specific parameter
> (I wouldn't be surprised if a new SoC would have more of these).

I kind of hesitated on this.

The way the channel settings are entangled in the registers (2 reg for channel
select, 1 for filtering) make it unlikely to change this way, at least no w/o
some other change that would require some other adaptation.

Also, there this comment in "include/linux/bitmap.h" :

?* Note that nbits should be always a compile time evaluable constant.
?* Otherwise many inlines will generate horrible code.

Finally there was your advice from the v2 to not make the driver unnecessarily
complicated.

I figured that if we ever get chip with a different number of irq, no to
different so that it can reasonably fit in this driver, the rework would not be
that complicated. 

Would you agree ?

> 
> > +	spinlock_t lock;
> > +};
> > +
> > +static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller
> > *ctl,
> > +				???????unsigned int reg, u32 mask, u32 val)
> > +{
> > +	u32 tmp;
> > +
> > +	tmp = readl_relaxed(ctl->base + reg);
> > +	tmp &= ~mask;
> > +	tmp |= val;
> > +	writel_relaxed(tmp, ctl->base + reg);
> > +}
> > +
> > +static int
> > +meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
> > +			???????unsigned long??hwirq,
> > +			???????u32 **parent_hwirq)
> > +{
> > +	unsigned int reg, channel;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ctl->lock, flags);
> 
> You don't seem to take this spinlock in interrupt context. In that case,
> you don't need to use the _irqsave version. Same thing for the set_type
> callback.
> 

Ok. I also hesitated with the raw_spinlock version, which is used in several
other irqchip. I could not really understand when one should be used over the
other. Seems to be linked to the RT patch as far as I understood.

Is this version the one I should use ?

> > +
> > +	/* Find a free channel */
> > +	channel = find_first_zero_bit(ctl->map, NUM_UPSTREAM_IRQ);
> > +	if (channel >= NUM_UPSTREAM_IRQ) {
> > +		spin_unlock_irqrestore(&ctl->lock, flags);
> > +		pr_err("No channel available\n");
> > +		return -ENOSPC;
> > +	}
> > +
> > +	/* Mark the channel as used */
> > +	set_bit(channel, ctl->map);
> > +
> > +	/*
> > +	?* Setup the mux of the channel to route the signal of the pad
> > +	?* to the appropriate input of the GIC
> > +	?*/
> > +	reg = (channel < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
> 
> Make a helper for this (channel_to_reg?).

Ok. why not.

> 
> > +	meson_gpio_irq_update_bits(ctl, reg,
> > +				???0xff << REG_PIN_SEL_SHIFT(channel),
> > +				???hwirq << REG_PIN_SEL_SHIFT(channel));
> > +
> > +	/* Get the parent hwirq number assigned to this channel */
> > +	*parent_hwirq = &(ctl->upstream_irq[channel]);
> 
> A comment explaining how this simplifies the channel number computation
> at runtime would be great, it took me a moment to understand how this works.

Indeed, it took me a while to get back into it as well.
To be fair, it was your idea initially :P

> 
> > +
> > +	spin_unlock_irqrestore(&ctl->lock, flags);
> > +
> > +	pr_debug("hwirq %lu assigned to channel %d - parent %u\n",
> > +		?hwirq, channel, **parent_hwirq);
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned int
> > +meson_gpio_irq_get_channel(struct meson_gpio_irq_controller *ctl,
> > +			???u32 *parent_hwirq)
> > +{
> > +	return parent_hwirq - ctl->upstream_irq;
> > +}
> > +
> > +static void
> > +meson_gpio_irq_release_channel(struct meson_gpio_irq_controller *ctl,
> > +			???????u32 *parent_hwirq)
> > +{
> > +	unsigned int channel;
> > +
> > +	channel = meson_gpio_irq_get_channel(ctl, parent_hwirq);
> > +	clear_bit(channel, ctl->map);
> > +}
> > +
> > +static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
> > +				?????unsigned int type,
> > +				?????u32 *parent_hwirq)
> > +{
> > +	u32 val = 0;
> > +	unsigned int channel;
> > +	unsigned long flags;
> > +
> > +	channel = meson_gpio_irq_get_channel(ctl, parent_hwirq);
> > +
> > +	/*
> > +	?* The controller has a filter block to operate in either LEVEL or
> > +	?* EDGE mode, then signal is sent to the GIC. To enable LEVEL_LOW
> > and
> > +	?* EDGE_FALLING support (which the GIC does not support), the
> > filter
> > +	?* block is also able to invert the input signal it gets before
> > +	?* providing it to the GIC.
> > +	?*/
> > +	type &= IRQ_TYPE_SENSE_MASK;
> > +
> > +	if (type == IRQ_TYPE_EDGE_BOTH)
> > +		return -EINVAL;
> > +
> > +	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
> > +		val |= REG_EDGE_POL_EDGE(channel);
> > +
> > +	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
> > +		val |= REG_EDGE_POL_LOW(channel);
> > +
> > +	spin_lock_irqsave(&ctl->lock, flags);
> > +
> > +	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
> > +				???REG_EDGE_POL_MASK(channel), val);
> > +
> > +	spin_unlock_irqrestore(&ctl->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned int meson_gpio_irq_type_output(unsigned int type)
> > +{
> > +	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
> > +
> > +	type &= ~IRQ_TYPE_SENSE_MASK;
> > +
> > +	/*
> > +	?* The polarity of the signal provided to the GIC should always
> > +	?* be high.
> > +	?*/
> > +	if (sense & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> > +		type |= IRQ_TYPE_LEVEL_HIGH;
> > +	else if (sense & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
> > +		type |= IRQ_TYPE_EDGE_RISING;
> > +
> > +	return type;
> > +}
> > +
> > +static int meson_gpio_irq_set_type(struct irq_data *data, unsigned int
> > type)
> > +{
> > +	struct meson_gpio_irq_controller *ctl = data->domain->host_data;
> > +	u32 *parent_hwirq = irq_data_get_irq_chip_data(data);
> > +	int ret;
> > +
> > +	ret = meson_gpio_irq_type_setup(ctl, type, parent_hwirq);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return irq_chip_set_type_parent(data,
> > +					meson_gpio_irq_type_output(type));
> > +}
> > +
> > +static struct irq_chip meson_gpio_irq_chip = {
> > +	.name			= "meson-gpio-irqchip",
> > +	.irq_mask		= irq_chip_mask_parent,
> > +	.irq_unmask		= irq_chip_unmask_parent,
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_set_type		= meson_gpio_irq_set_type,
> > +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > +#ifdef CONFIG_SMP
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +#endif
> > +	.flags			= IRQCHIP_SET_TYPE_MASKED,
> > +};
> > +
> > +static int meson_gpio_irq_domain_translate(struct irq_domain *domain,
> > +					???struct irq_fwspec *fwspec,
> > +					???unsigned long *hwirq,
> > +					???unsigned int *type)
> > +{
> > +	if (is_of_node(fwspec->fwnode) && fwspec->param_count == 2) {
> > +		*hwirq	= fwspec->param[0];
> > +		*type	= fwspec->param[1];
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int meson_gpio_irq_allocate_gic_irq(struct irq_domain *domain,
> > +					???unsigned int virq,
> > +					???u32 hwirq,
> > +					???unsigned int type)
> > +{
> > +	struct irq_fwspec fwspec;
> > +
> > +	fwspec.fwnode = domain->parent->fwnode;
> > +	fwspec.param_count = 3;
> > +	fwspec.param[0] = 0;	/* SPI */
> > +	fwspec.param[1] = hwirq;
> > +	fwspec.param[2] = meson_gpio_irq_type_output(type);
> > +
> > +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> > +}
> > +
> > +static int meson_gpio_irq_domain_alloc(struct irq_domain *domain,
> > +				???????unsigned int virq,
> > +				???????unsigned int nr_irqs,
> > +				???????void *data)
> > +{
> > +	struct irq_fwspec *fwspec = data;
> > +	struct meson_gpio_irq_controller *ctl = domain->host_data;
> > +	unsigned long hwirq;
> > +	u32 *parent_hwirq;
> > +	unsigned int type;
> > +	int ret;
> > +
> > +	if (WARN_ON(nr_irqs != 1))
> > +		return -EINVAL;
> > +
> > +	ret = meson_gpio_irq_domain_translate(domain, fwspec, &hwirq,
> > &type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = meson_gpio_irq_request_channel(ctl, hwirq, &parent_hwirq);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = meson_gpio_irq_allocate_gic_irq(domain, virq,
> > +					??????*parent_hwirq, type);
> > +	if (ret < 0) {
> > +		pr_err("failed to allocate gic irq %u\n", *parent_hwirq);
> 
> Release the requested channel?

Oops ...

> 
> > +		return ret;
> > +	}
> > +
> > +	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> > +				??????&meson_gpio_irq_chip, parent_hwirq);
> > +
> > +	return 0;
> > +}
> > +
> > +static void meson_gpio_irq_domain_free(struct irq_domain *domain,
> > +				???????unsigned int virq,
> > +				???????unsigned int nr_irqs)
> > +{
> > +	struct meson_gpio_irq_controller *ctl = domain->host_data;
> > +	struct irq_data *irq_data;
> > +	u32 *parent_hwirq;
> > +
> > +	if (WARN_ON(nr_irqs != 1))
> > +		return;
> > +
> > +	irq_domain_free_irqs_parent(domain, virq, 1);
> > +
> > +	irq_data = irq_domain_get_irq_data(domain, virq);
> > +	parent_hwirq = irq_data_get_irq_chip_data(irq_data);
> > +
> > +	meson_gpio_irq_release_channel(ctl, parent_hwirq);
> > +}
> > +
> > +static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
> > +	.alloc		= meson_gpio_irq_domain_alloc,
> > +	.free		= meson_gpio_irq_domain_free,
> > +	.translate	= meson_gpio_irq_domain_translate,
> > +};
> > +
> > +static int __init meson_gpio_irq_parse_dt(struct device_node *node,
> > +					??struct meson_gpio_irq_controller
> > *ctl)
> > +{
> > +	const struct of_device_id *match;
> > +	const struct meson_gpio_irq_params *params;
> > +	int ret;
> > +
> > +	match = of_match_node(meson_irq_gpio_matches, node);
> > +	if (!match)
> > +		return -ENODEV;
> > +
> > +	params = match->data;
> > +	ctl->nr_hwirq = params->nr_hwirq;
> > +
> > +	ret = of_property_read_variable_u32_array(node,
> > +						??"amlogic,upstream-
> > interrupts",
> > +						??ctl->upstream_irq,
> > +						??NUM_UPSTREAM_IRQ,
> > +						??NUM_UPSTREAM_IRQ);
> > +	if (ret < 0) {
> > +		pr_err("can't get %d upstream interrupts\n",
> > NUM_UPSTREAM_IRQ);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init meson_gpio_irq_of_init(struct device_node *node,
> > +					?struct device_node *parent)
> > +{
> > +	struct irq_domain *domain, *parent_domain;
> > +	struct meson_gpio_irq_controller *ctl;
> > +	int ret;
> > +
> > +	if (!parent) {
> > +		pr_err("missing parent interrupt node\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	parent_domain = irq_find_host(parent);
> > +	if (!parent_domain) {
> > +		pr_err("unable to obtain parent domain\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
> > +	if (!ctl)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&ctl->lock);
> > +
> > +	ctl->base = of_iomap(node, 0);
> > +	if (!ctl->base) {
> > +		ret = -ENOMEM;
> > +		goto free_ctl;
> > +	}
> > +
> > +	bitmap_zero(ctl->map, NUM_UPSTREAM_IRQ);
> 
> The bitmap has already been cleared (kzalloc baby!).

indeed

> 
> > +
> > +	ret = meson_gpio_irq_parse_dt(node, ctl);
> > +	if (ret)
> > +		goto free_upstream_irq;
> > +
> > +	domain = irq_domain_create_hierarchy(parent_domain, 0, ctl-
> > >nr_hwirq,
> > +					?????of_node_to_fwnode(node),
> > +					?????&meson_gpio_irq_domain_ops,
> > +					?????ctl);
> > +	if (!domain) {
> > +		pr_err("failed to add domain\n");
> > +		ret = -ENODEV;
> > +		goto free_upstream_irq;
> > +	}
> > +
> > +	pr_info("%d to %d gpio interrupt mux initialized\n",
> > +		ctl->nr_hwirq, NUM_UPSTREAM_IRQ);
> > +
> > +	return 0;
> > +
> > +free_upstream_irq:
> > +	iounmap(ctl->base);
> > +free_ctl:
> > +	kfree(ctl);
> > +
> > +	return ret;
> > +}
> > +
> > +IRQCHIP_DECLARE(meson_gpio_intc, "amlogic,meson-gpio-intc",
> > +		meson_gpio_irq_of_init);
> > 
> 
> Overall, this seems cleaner than Heiner's version (probably because it
> is less ambitious). I'm looking forward to reviewing a series that will
> be first agreed between both Heiner and you.

Noted

> 
> Thanks,
> 
> 	M.
