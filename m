From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Nov 2012 10:16:42 +0100
Subject: [PATCH 2/6] irqchip: sunxi: Add irq controller driver
In-Reply-To: <50A5ECBF.9060304@denx.de>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1353019586-21043-3-git-send-email-maxime.ripard@free-electrons.com>
 <50A5ECBF.9060304@denx.de>
Message-ID: <50A6047A.8090609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Le 16/11/2012 08:35, Stefan Roese a ?crit :
> On 11/15/2012 11:46 PM, Maxime Ripard wrote:
> 
> <snip>
> 
>> diff --git a/drivers/irqchip/irq-sunxi.c b/drivers/irqchip/irq-sunxi.c
>> new file mode 100644
>> index 0000000..9dcb323
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-sunxi.c
>> @@ -0,0 +1,173 @@
>> +/*
>> + * Allwinner A1X SoCs IRQ chip driver.
>> + *
>> + * Copyright (C) 2012 Maxime Ripard
>> + *
>> + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> + *
>> + * Based on code from
>> + * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
>> + * Benn Huang <benn@allwinnertech.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <linux/irqchip/sunxi.h>
>> +
>> +#define SUNXI_IRQ_PROTECTION_REG	0x08
>> +#define SUNXI_IRQ_NMI_CTRL_REG		0x0c
>> +#define SUNXI_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
>> +#define SUNXI_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
>> +#define SUNXI_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
>> +#define SUNXI_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
>> +
>> +static void __iomem *sunxi_irq_base;
>> +static struct irq_domain *sunxi_irq_domain;
>> +
>> +void sunxi_irq_ack(struct irq_data *irqd)
>> +{
>> +	unsigned int irq = irqd_to_hwirq(irqd);
>> +	unsigned int irq_off = irq % 32;
>> +	int reg = irq / 32;
>> +	u32 val;
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(reg));
>> +	writel(val & ~(1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(reg));
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_MASK_REG(reg));
>> +	writel(val | (1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_MASK_REG(reg));
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_PENDING_REG(reg));
>> +	writel(val | (1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_PENDING_REG(reg));
> 
> Are you sure that you need to touch all those 23registers to ack the
> interrupt? I know that the original code provided by Allwinner does
> exactly this. My tests have shown though, that writing to the pending
> reg is enough.

Ok, I'll test that and remove the first two writes then.

> 
>> +}
>> +
>> +static void sunxi_irq_mask(struct irq_data *irqd)
>> +{
>> +	unsigned int irq = irqd_to_hwirq(irqd);
>> +	unsigned int irq_off = irq % 32;
>> +	int reg = irq / 32;
>> +	u32 val;
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(reg));
>> +	writel(val & ~(1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(reg));
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_MASK_REG(reg));
>> +	writel(val | (1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_MASK_REG(reg));
> 
> I unmasked all interrupts in the mask register in the init function.
> Then only using the enable register for masking/unmasking seems to be
> enough. What do you think?

That's reasonable I guess. It will be in the v2.

>> +}
>> +
>> +static void sunxi_irq_unmask(struct irq_data *irqd)
>> +{
>> +	unsigned int irq = irqd_to_hwirq(irqd);
>> +	unsigned int irq_off = irq % 32;
>> +	int reg = irq / 32;
>> +	u32 val;
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(reg));
>> +	writel(val | (1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(reg));
>> +
>> +	val = readl(sunxi_irq_base + SUNXI_IRQ_MASK_REG(reg));
>> +	writel(val & ~(1 << irq_off),
>> +	       sunxi_irq_base + SUNXI_IRQ_MASK_REG(reg));
>> +
>> +	/* Must clear pending bit when enabled */
>> +	if (irq == 0)
>> +		writel(1, sunxi_irq_base + SUNXI_IRQ_PENDING_REG(0));
> 
> Again. Might be that one register is enough here.

Ok.

>> +}
>> +
>> +static struct irq_chip sunxi_irq_chip = {
>> +	.name		= "sunxi_irq",
>> +	.irq_ack	= sunxi_irq_ack,
>> +	.irq_mask	= sunxi_irq_mask,
>> +	.irq_unmask	= sunxi_irq_unmask,
>> +};
>> +
>> +static int sunxi_irq_map(struct irq_domain *d, unsigned int virq,
>> +			 irq_hw_number_t hw)
>> +{
>> +	irq_set_chip(virq, &sunxi_irq_chip);
>> +	irq_set_handler(virq, handle_level_irq);
> 
> irq_set_chip_and_handler()

Ok.

>> +	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct irq_domain_ops sunxi_irq_ops = {
>> +	.map = sunxi_irq_map,
>> +	.xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +static int __init sunxi_of_init(struct device_node *node,
>> +				struct device_node *parent)
>> +{
>> +	sunxi_irq_base = of_iomap(node, 0);
>> +	if (!sunxi_irq_base)
>> +		panic("%s: unable to map IC registers\n",
>> +			node->full_name);
>> +
>> +	/* Disable all interrupts */
>> +	writel(0, sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(0));
>> +	writel(0, sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(1));
>> +	writel(0, sunxi_irq_base + SUNXI_IRQ_ENABLE_REG(2));
>> +
>> +	/* Mask all the interrupts */
>> +	writel(0xffffffff, sunxi_irq_base + SUNXI_IRQ_MASK_REG(0));
>> +	writel(0xffffffff, sunxi_irq_base + SUNXI_IRQ_MASK_REG(1));
>> +	writel(0xffffffff, sunxi_irq_base + SUNXI_IRQ_MASK_REG(2));
> 
> Here is where I wrote 0 to the mask registers.
> 
>> +	/* Clear all the pending interrupts */
>> +	writel(0xffffffff, sunxi_irq_base + SUNXI_IRQ_PENDING_REG(0));
>> +	writel(0xffffffff, sunxi_irq_base + SUNXI_IRQ_PENDING_REG(1));
>> +	writel(0xffffffff, sunxi_irq_base + SUNXI_IRQ_PENDING_REG(2));
>> +
>> +	/* Enable protection mode */
>> +	writel(0x01, sunxi_irq_base + SUNXI_IRQ_PROTECTION_REG);
>> +
>> +	/* Configure the external interrupt source type */
>> +	writel(0x00, sunxi_irq_base + SUNXI_IRQ_NMI_CTRL_REG);
>> +
>> +	sunxi_irq_domain = irq_domain_add_linear(node, 3 * 32,
>> +						 &sunxi_irq_ops, NULL);
>> +	if (!sunxi_irq_domain)
>> +		panic("%s: unable to create IRQ domain\n", node->full_name);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct of_device_id sunxi_irq_dt_ids[] __initconst = {
>> +	{ .compatible = "allwinner,sunxi-ic", .data = sunxi_of_init }
>> +};
>> +
>> +void __init sunxi_init_irq(void)
>> +{
>> +	of_irq_init(sunxi_irq_dt_ids);
>> +}
>> +
>> +asmlinkage void __exception_irq_entry sunxi_handle_irq(struct pt_regs *regs)
>> +{
>> +	u32 irq, reg;
>> +	int i;
>> +
>> +	for (i = 0; i < 3; i++) {
>> +		reg = readl(sunxi_irq_base + SUNXI_IRQ_PENDING_REG(i));
>> +		if (reg == 0)
>> +			continue;
>> +		irq = ilog2(reg);
>> +		break;
>> +	}
>> +	irq = irq_find_mapping(sunxi_irq_domain, irq);
>> +	handle_IRQ(irq, regs);
> 
> Why don't you use the interrupt-vector register to get the active
> interrupt source? Here is my version:
> 
> asmlinkage void __exception_irq_entry sunxi_handle_irq(struct pt_regs *regs)
> {
> 	u32 irq;
> 
> 	irq = readl(int_base + SW_INT_VECTOR_REG) >> 2;
> 	irq = irq_find_mapping(sunxi_vic_domain, irq);
> 	handle_IRQ(irq, regs);
> }
> 
> I suggest you give it a try.

It definitely looks nicer. I'll try that and update.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
