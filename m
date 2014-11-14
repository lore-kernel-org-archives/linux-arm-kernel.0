From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Nov 2014 18:35:43 +0000
Subject: [PATCH v6 4/6] ARM: mediatek: Add sysirq interrupt polarity
 support
In-Reply-To: <1415893029-2971-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1415893029-2971-1-git-send-email-yingjoe.chen@mediatek.com>
 <1415893029-2971-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <54664B7F.6090604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/14 15:37, Yingjoe Chen wrote:
> Mediatek SoCs have interrupt polarity support in sysirq which
> allows to invert polarity for given interrupt. Add this support
> using hierarchy irq domain.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/irqchip/Makefile         |   1 +
>  drivers/irqchip/irq-mtk-sysirq.c | 156 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mtk-sysirq.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 173bb5f..4e0f254 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
>  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o \
>  					   irq-bcm7120-l2.o
>  obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
> +obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> new file mode 100644
> index 0000000..976b7eb
> --- /dev/null
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -0,0 +1,156 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Joe.C <yingjoe.chen@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include "irqchip.h"
> +
> +#define MT6577_SYS_INTPOL_NUM	(224)
> +
> +struct mtk_sysirq_chip_data {
> +	spinlock_t lock;
> +	void __iomem *intpol_base;
> +};
> +
> +static int mtk_sysirq_set_type(struct irq_data *data, unsigned int type)
> +{
> +	irq_hw_number_t hwirq = data->hwirq;
> +	struct mtk_sysirq_chip_data *chip_data = data->chip_data;
> +	u32 offset, reg_index, value;
> +	unsigned long flags;
> +	int ret;
> +
> +	offset = hwirq & 0x1f;
> +	reg_index = hwirq >> 5;
> +
> +	spin_lock_irqsave(&chip_data->lock, flags);
> +	value = readl_relaxed(chip_data->intpol_base + reg_index * 4);
> +	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING) {
> +		if (type == IRQ_TYPE_LEVEL_LOW)
> +			type = IRQ_TYPE_LEVEL_HIGH;
> +		else
> +			type = IRQ_TYPE_EDGE_RISING;
> +		value |= (1 << offset);
> +	} else
> +		value &= ~(1 << offset);
> +	writel(value, chip_data->intpol_base + reg_index * 4);
> +
> +	data = data->parent_data;
> +	ret = data->chip->irq_set_type(data, type);
> +	spin_unlock_irqrestore(&chip_data->lock, flags);
> +	return ret;
> +}
> +
> +static struct irq_chip mtk_sysirq_chip = {
> +	.name			= "MT_SYSIRQ",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_type		= mtk_sysirq_set_type,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +};
> +
> +static int mtk_sysirq_domain_xlate(struct irq_domain *d,
> +				   struct device_node *controller,
> +				   const u32 *intspec, unsigned int intsize,
> +				   unsigned long *out_hwirq,
> +				   unsigned int *out_type)
> +{
> +	if (intsize < 3)
> +		return -EINVAL;
> +
> +	/* sysirq doesn't support PPI */
> +	if (intspec[0])
> +		return -EINVAL;
> +
> +	*out_hwirq = intspec[1];
> +	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
> +	return 0;
> +}
> +
> +static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *arg)
> +{
> +	int i;
> +	irq_hw_number_t hwirq;
> +	struct of_phandle_args *irq_data = arg;
> +
> +	if (irq_data->args_count < 3)
> +		return -EINVAL;
> +
> +	hwirq = irq_data->args[1];
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &mtk_sysirq_chip,
> +					      domain->host_data);
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);

This is exactly why you have this hack in the GIC driver. I'd suggest
the following instead:

{
[...]
	struct of_phandle_args *irq_data = arg;
	struct of_phandle_args gic_data = *irq_data;
[...]
	gic_data.np = domain->parent->of_node;
	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
					    &gic_data);
}

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
