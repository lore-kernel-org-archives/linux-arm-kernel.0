From: youlin.pei@mediatek.com (Youlin Pei)
Date: Fri, 14 Oct 2016 16:13:24 +0800
Subject: [PATCH 2/3] irqchip: mtk-cirq: Add mediatek mtk-cirq implement
In-Reply-To: <20161013092808.3c4181dd@arm.com>
References: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
 <1476335194-26604-3-git-send-email-youlin.pei@mediatek.com>
 <20161013092808.3c4181dd@arm.com>
Message-ID: <1476432804.5408.34.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
Thanks for your review.
On Thu, 2016-10-13 at 09:28 +0100, Marc Zyngier wrote:
> On Thu, 13 Oct 2016 13:06:33 +0800
> Youlin Pei <youlin.pei@mediatek.com> wrote:
> 
> > This commit add the mtk-cirq implement for mt2701.

> Can you please expand this a bit?

Okay, I will improve it as following:

In Mediatek SOCs, the CIRQ is a low power interrupt controller designed
to works outside MCUSYS which comprises with Cortex-Ax cores,CCI and
GIC.

The CIRQ controller is integrated in between MCUSYS(include Cortex-Ax,
CCI and GIC) and interrupt sources as the second level interrupt
controller. The external interrupts which outside MCUSYS will feed
through CIRQ then bypass to GIC. CIRQ can monitors all edge trigger
interupts. When an edge interrupt is triggered, CIRQ can record the
status and generate a pulse signal to GIC when flush command executed.

When system enters sleep mode, MCUSYS will be turned off to improve
power consumption, also GIC is power down. The edge trigger interrupts
will be lost in this scenario without CIRQ.

This patch provides the CIRQ irqchip implement.

> 
> > 
> > Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>
> > ---
> >  drivers/irqchip/Makefile       |    2 +-
> >  drivers/irqchip/irq-mtk-cirq.c |  257 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 258 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/irqchip/irq-mtk-cirq.c
> > 
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 4c203b6..eee95c6 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -59,7 +59,7 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
> >  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
> >  obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
> >  obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
> > -obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
> > +obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
> >  obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
> >  obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
> >  obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
> > diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
> > new file mode 100644
> > index 0000000..544767d
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-mtk-cirq.c
> > @@ -0,0 +1,257 @@
> > +/*
> > + * Copyright (c) 2016 MediaTek Inc.
> > + * Author: Youlin.Pei <youlin.pei@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/syscore_ops.h>
> > +
> > +#define CIRQ_MASK_SET	0xC0
> > +#define CIRQ_MASK_CLR	0x100
> > +#define CIRQ_SENS_SET	0x180
> > +#define CIRQ_SENS_CLR	0x1C0
> > +#define CIRQ_POL_SET	0x240
> > +#define CIRQ_POL_CLR	0x280
> > +#define CIRQ_CONTROL	0x300
> > +
> > +#define CIRQ_EN		0x1
> > +#define CIRQ_EDGE	0x2
> > +#define CIRQ_FLUSH	0x4
> > +
> > +#define CIRQ_IRQ_NUM    0x200
> > +
> > +struct mtk_cirq_chip_data {
> > +	void __iomem *base;
> > +	unsigned int ext_irq_start;
> > +};
> > +
> > +struct mtk_cirq_chip_data *cirq_data;
> 
> Any reason why this is not static?

My fault, will fix it in next version.

> 
> > +
> > +static void mtk_cirq_write_mask(struct irq_data *data, unsigned int offset)
> > +{
> > +	struct mtk_cirq_chip_data *chip_data = data->chip_data;
> > +	unsigned int cirq_num = data->hwirq - chip_data->ext_irq_start;
> 
> I wonder why you have to compute this offset. Ideally, data->hwirq
> should be the bit position (starting at zero). The fact that you have
> an offset between the pin number in this driver and the IRQ number in
> the GIC or sysirq should be resolved at alloc time.

Okay, will fix it in next version.

> 
> > +	u32 mask = 1 << (cirq_num % 32);
> > +
> > +	writel(mask, chip_data->base + offset + (cirq_num / 32) * 4);
> > +}
> > +
> > +static void mtk_cirq_mask(struct irq_data *data)
> > +{
> > +	mtk_cirq_write_mask(data, CIRQ_MASK_SET);
> > +	irq_chip_mask_parent(data);
> > +}
> > +
> > +static void mtk_cirq_unmask(struct irq_data *data)
> > +{
> > +	mtk_cirq_write_mask(data, CIRQ_MASK_CLR);
> > +	irq_chip_unmask_parent(data);
> > +}
> > +
> > +static int mtk_cirq_set_type(struct irq_data *data, unsigned int type)
> > +{
> > +	int ret;
> > +
> > +	switch (type & IRQ_TYPE_SENSE_MASK) {
> > +	case IRQ_TYPE_EDGE_FALLING:
> > +		mtk_cirq_write_mask(data, CIRQ_POL_CLR);
> > +		mtk_cirq_write_mask(data, CIRQ_SENS_CLR);
> > +		break;
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		mtk_cirq_write_mask(data, CIRQ_POL_SET);
> > +		mtk_cirq_write_mask(data, CIRQ_SENS_CLR);
> > +		break;
> > +	case IRQ_TYPE_LEVEL_LOW:
> > +		mtk_cirq_write_mask(data, CIRQ_POL_CLR);
> > +		mtk_cirq_write_mask(data, CIRQ_SENS_SET);
> > +		break;
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		mtk_cirq_write_mask(data, CIRQ_POL_SET);
> > +		mtk_cirq_write_mask(data, CIRQ_SENS_SET);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	data = data->parent_data;
> > +	ret = data->chip->irq_set_type(data, type);
> > +	return ret;
> > +}
> > +
> > +static struct irq_chip mtk_cirq_chip = {
> > +	.name			= "MT_CIRQ",
> > +	.irq_mask		= mtk_cirq_mask,
> > +	.irq_unmask		= mtk_cirq_unmask,
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_set_type		= mtk_cirq_set_type,
> > +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > +#ifdef CONFIG_SMP
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +#endif
> > +};
> 
> I'm surprised that you don't implement irq_set_wake. Do you wake-up on
> *any* interrupt?

The CIRQ controller don't have the wake up function, so irq_set_wake
is not implemented.

> 
> > +
> > +static int mtk_cirq_domain_translate(struct irq_domain *d,
> > +				     struct irq_fwspec *fwspec,
> > +				     unsigned long *hwirq,
> > +				     unsigned int *type)
> > +{
> > +	if (is_of_node(fwspec->fwnode)) {
> > +		if (fwspec->param_count != 3)
> > +			return -EINVAL;
> > +
> > +		/* No PPI should point to this domain */
> > +		if (fwspec->param[0] != 0)
> > +			return -EINVAL;
> > +
> > +		/* cirq support irq number check */
> > +		if (fwspec->param[1] < ;)
> > +			return -EINVAL;
> > +
> > +		*hwirq = fwspec->param[1];
> 
> So if you turn this into:
> 
> 		*hwirq = fwspec->param[1] - cirq_data->ext_irq_start;
> 
> and drop the above offset computing in your write function, you'd have
> something that'd make a bit more sense.

Okay, will fix it in next version. Thanks!

> 
> > +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int mtk_cirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> > +				 unsigned int nr_irqs, void *arg)
> > +{
> > +	int i;
> > +	irq_hw_number_t hwirq;
> > +	struct irq_fwspec *fwspec = arg;
> > +	struct irq_fwspec parent_fwspec = *fwspec;
> > +
> > +	if (fwspec->param_count != 3)
> > +		return -EINVAL;
> > +
> > +	/* cirq doesn't support PPI */
> > +	if (fwspec->param[0])
> > +		return -EINVAL;
> > +
> > +	if (fwspec->param[1] < cirq_data->ext_irq_start)
> > +		return -EINVAL;
> > +
> > +	hwirq = fwspec->param[1];
> > +	for (i = 0; i < nr_irqs; i++)
> > +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> > +					      &mtk_cirq_chip,
> > +					      domain->host_data);
> > +
> > +	parent_fwspec.fwnode = domain->parent->fwnode;
> > +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> > +					    &parent_fwspec);
> > +}
> > +
> > +static const struct irq_domain_ops cirq_domain_ops = {
> > +	.translate	= mtk_cirq_domain_translate,
> > +	.alloc		= mtk_cirq_domain_alloc,
> > +	.free		= irq_domain_free_irqs_common,
> > +};
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mtk_cirq_suspend(void)
> > +{
> > +	u32 value;
> > +
> > +	/* set edge_only mode, record edge-triggerd interrupts */
> > +	/* enable cirq */
> > +	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
> > +	value |= (CIRQ_EDGE | CIRQ_EN);
> > +	writel(value, cirq_data->base + CIRQ_CONTROL);
> > +	return 0;
> > +}
> > +
> > +static void mtk_cirq_resume(void)
> > +{
> > +	u32 value;
> > +
> > +	/* flush recored interrupts, will send signals to parent controller */
> > +	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
> > +	writel(value | CIRQ_FLUSH, cirq_data->base + CIRQ_CONTROL);
> > +
> > +	/* disable cirq */
> > +	value = readl_relaxed(cirq_data->base + CIRQ_CONTROL);
> > +	value &= ~(CIRQ_EDGE | CIRQ_EN);
> > +	writel(value, cirq_data->base + CIRQ_CONTROL);
> > +}
> > +
> > +static struct syscore_ops mtk_cirq_syscore_ops = {
> > +	.suspend	= mtk_cirq_suspend,
> > +	.resume		= mtk_cirq_resume,
> > +};
> > +
> > +static void mtk_cirq_syscore_init(void)
> > +{
> > +	register_syscore_ops(&mtk_cirq_syscore_ops);
> > +}
> > +#else
> > +static inline void mtk_cirq_syscore_init(void) {}
> > +#endif
> > +
> > +static int __init mtk_cirq_of_init(struct device_node *node,
> > +				   struct device_node *parent)
> > +{
> > +	struct irq_domain *domain, *domain_parent;
> > +	int ret;
> > +
> > +	domain_parent = irq_find_host(parent);
> > +	if (!domain_parent) {
> > +		pr_err("mtk_cirq: interrupt-parent not found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	cirq_data = kzalloc(sizeof(*cirq_data), GFP_KERNEL);
> > +	if (!cirq_data)
> > +		return -ENOMEM;
> > +
> > +	cirq_data->base = of_iomap(node, 0);
> > +	if (!cirq_data->base) {
> > +		pr_err("mtk_cirq: unable to map cirq register\n");
> > +		ret = -ENXIO;
> > +		goto out_free;
> > +	}
> > +
> > +	if (of_property_read_u32(node, "mediatek,ext-irq-start",
> > +				 &cirq_data->ext_irq_start)) {
> > +		ret = -EINVAL;
> > +		goto out_free;
> > +	}
> > +
> > +	domain = irq_domain_add_hierarchy(domain_parent, 0, CIRQ_IRQ_NUM, node,
> > +					  &cirq_domain_ops, cirq_data);
> > +	if (!domain) {
> > +		ret = -ENOMEM;
> > +		goto out_unmap;
> > +	}
> > +
> > +	mtk_cirq_syscore_init();
> > +
> > +	return 0;
> > +
> > +out_unmap:
> > +	iounmap(cirq_data->base);
> > +out_free:
> > +	kfree(cirq_data);
> > +	return ret;
> > +}
> > +
> > +IRQCHIP_DECLARE(mtk_cirq, "mediatek,mt2701-cirq", mtk_cirq_of_init);
> 
> Thanks,
> 
> 	M.
Thanks,
Youlin 
