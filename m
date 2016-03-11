From: stefan@agner.ch (Stefan Agner)
Date: Fri, 11 Mar 2016 10:11:43 -0800
Subject: [PATCH 01/18] irqchip: vf610-gpc: add Vybrid GPC IRQ controller
In-Reply-To: <20160311034137.169f22ae@arm.com>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-2-git-send-email-stefan@agner.ch>
 <20160311034137.169f22ae@arm.com>
Message-ID: <149aa5f1d250fd2ead2fecb861c6e49a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2016-03-10 19:41, Marc Zyngier wrote:
> On Wed,  9 Mar 2016 18:16:42 -0800
> Stefan Agner <stefan@agner.ch> wrote:
> 
> Hi Stefan,
> 
>> This patch introduces a driver for Vybrids GPC (Global Power
>> Controller). Vybrids GPC IP is simpler than the one found in
>> i.MX 6: There is no power gating control (GPC) and the GPC INTC
>> does not need to clear IRQ masks for an interrupt to get routed
>> to the GIC (the mask only applys for wake-up control).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/irqchip/Makefile        |   1 +
>>  drivers/irqchip/irq-vf610-gpc.c | 138 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 139 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-vf610-gpc.c
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 18caacb..0a77ac6 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
>>  obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
>>  obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
>>  obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
>> +obj-$(CONFIG_SOC_VF610)			+= irq-vf610-gpc.o
>>  obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
>>  obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
>>  obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
>> diff --git a/drivers/irqchip/irq-vf610-gpc.c b/drivers/irqchip/irq-vf610-gpc.c
>> new file mode 100644
>> index 0000000..2c6a043
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-vf610-gpc.c
>> @@ -0,0 +1,138 @@
>> +/*
>> + * Copyright (C) 2016 Toradex AG
>> + * Author: Stefan Agner <stefan@agner.ch>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + *
>> + * The GPC (General Power Controller) irqchip driver takes care of the
>> + * interrupt wakeup functionality.
>> + *
>> + * o All peripheral interrupts of the Vybrid SoC can be used as wakeup
>> + *   source from STOP mode. In LPSTOP mode however, the GPC is unpowered
>> + *   too and cannot be used to as a wakeup source. The WKPU (Wakeup Unit)
>> + *   is responsible for wakeups from LPSTOP modes.
>> + */
>> +
>> +#include <linux/cpu_pm.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +#include <linux/regmap.h>
>> +
>> +#define IMR_NUM			4
>> +#define VF610_GPC_IMR1		0x044
>> +#define VF610_GPC_MAX_IRQS	(IMR_NUM * 32)
>> +
>> +static void __iomem *gpc_base;
>> +
>> +static int vf610_gpc_irq_set_wake(struct irq_data *d, unsigned int on)
>> +{
>> +	unsigned int idx = d->hwirq / 32;
>> +	void __iomem *reg_imr = gpc_base + VF610_GPC_IMR1 + (idx * 4);
>> +	u32 mask = 1 << d->hwirq % 32;
>> +
>> +	if (on)
>> +		writel_relaxed(readl_relaxed(reg_imr) & ~mask, reg_imr);
>> +	else
>> +		writel_relaxed(readl_relaxed(reg_imr) | mask, reg_imr);
>> +
>> +	/*
>> +	 * Do *not* call into the parent, as the GIC doesn't have any
>> +	 * wake-up facility...
>> +	 */
>> +	return 0;
>> +}
>> +
>> +static struct irq_chip vf610_gpc_chip = {
>> +	.name			= "vf610-gpc",
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= irq_chip_unmask_parent,
>> +	.irq_enable		= irq_chip_enable_parent,
>> +	.irq_disable		= irq_chip_disable_parent,
> 
> Any reason why you are providing enable/disable methods? This driver
> seems to be GIC specific (various comments in the code), but the GIC
> doesn't implement those.

There is another IRQ controller between the CPU's IRQ controller and the
peripherals: the MSCM Interrupt Router
(drivers/irqchip/irq-vf610-mscm-ir.c).

This router allows to select to which CPU an interrupt gets routed
(VF6xx variants of Vybrid with a Cortex-A5 and Cortex-M4 core).

> 
>> +	.irq_eoi		= irq_chip_eoi_parent,
>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>> +	.irq_set_wake		= vf610_gpc_irq_set_wake,
>> +};
>> +
>> +static int vf610_gpc_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +				  unsigned int nr_irqs, void *arg)
>> +{
>> +	int i;
>> +	irq_hw_number_t hwirq;
>> +	struct irq_fwspec *fwspec = arg;
>> +	struct irq_fwspec parent_fwspec;
>> +
>> +	if (!irq_domain_get_of_node(domain->parent))
>> +		return -EINVAL;
>> +
>> +	if (fwspec->param_count != 2)
>> +		return -EINVAL;
>> +
>> +	hwirq = fwspec->param[0];
>> +	for (i = 0; i < nr_irqs; i++)
>> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +					      &vf610_gpc_chip, NULL);
>> +
>> +	parent_fwspec = *fwspec;
> 
> Now I'm confused. The next irqchip in the hierarchy cannot be the GIC,
> because that's the wrong fwspec format (the GIC expect 3 parameters).
> Glancing at patch #2, I can see that this points to the mscm, so maybe
> it is that the comments are just wrong?

The above should explain that...

So with this driver the domain hierarchy stacks 3 IRQ controllers

GPC -> MSCM-IR -> NVIC/GIC (depending on CPU)

> 
>> +	parent_fwspec.fwnode = domain->parent->fwnode;
>> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>> +					    &parent_fwspec);
>> +}
>> +
>> +static int vf610_gpc_domain_translate(struct irq_domain *d,
>> +					  struct irq_fwspec *fwspec,
>> +					  unsigned long *hwirq,
>> +					  unsigned int *type)
>> +{
>> +	if (WARN_ON(fwspec->param_count < 2))
>> +		return -EINVAL;
>> +	*hwirq = fwspec->param[0];
>> +	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops gpc_irq_domain_ops = {
>> +	.translate = vf610_gpc_domain_translate,
>> +	.alloc = vf610_gpc_domain_alloc,
>> +	.free = irq_domain_free_irqs_common,
>> +};
>> +
>> +static int __init vf610_gpc_of_init(struct device_node *node,
>> +			       struct device_node *parent)
>> +{
>> +	struct irq_domain *domain, *domain_parent;
>> +	int i;
>> +
>> +	domain_parent = irq_find_host(parent);
>> +	if (!domain_parent) {
>> +		pr_err("vf610_gpc: interrupt-parent not found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	gpc_base = of_io_request_and_map(node, 0, "gpc");
>> +	if (WARN_ON(!gpc_base))
>> +		return PTR_ERR(gpc_base);
> 
> If gpc_base is NULL, PTR_ERR(NULL) returns 0. Probably not what you
> want here...
> 

Hm, of_io_request_and_map actually returns a ERR_PTR, hence WARN_ON is
not appropriate as it is used here.

Will remove that and replace with

if (IS_ERR(gpc_base))
	return PTR_ERR(gpc_base);

>> +
>> +	domain = irq_domain_add_hierarchy(domain_parent, 0, VF610_GPC_MAX_IRQS,
>> +					  node, &gpc_irq_domain_ops, NULL);
>> +	if (!domain) {
>> +		iounmap(gpc_base);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Initially mask all interrupts for wakeup */
>> +	for (i = 0; i < IMR_NUM; i++)
>> +		writel_relaxed(~0, gpc_base + VF610_GPC_IMR1 + i * 4);
>> +
>> +	return 0;
>> +}
>> +IRQCHIP_DECLARE(vf610_gpc, "fsl,vf610-gpc", vf610_gpc_of_init);
> 
> It would be good to have some binding documentation as well.

Will add that

Thanks!

--
Stefan
