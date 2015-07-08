From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Jul 2015 16:30:53 +0100
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <1436166548-34920-2-git-send-email-majun258@huawei.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
Message-ID: <559D422D.1000307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Aside from all the comments Thomas had, the following aspect is worrying
me a bit:

On 06/07/15 08:09, Ma Jun wrote:
> This patch contains the mbigen interrupt controller driver.

[...]

> +static int mbigen_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct mbigen_chip *chip = d->domain->host_data;
> +       u32 ofst, mask;
> +       u32 val, nid, hwirq;
> +       void __iomem *addr;
> +
> +       if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> +               return -EINVAL;

You seem to be supporting both edge and level triggered interrupts.

Given that the ITS is edge triggered only, I must assume you have some
code to regenerate an edge if the wired interrupt is level triggered,
and that the line level is still high when you perform the EOI...

> +
> +       nid = GET_NODE_NUM(d->hwirq);
> +       hwirq = HWIRQ_OFFSET(d->hwirq);
> +
> +       ofst = hwirq / 32 * 4;
> +       mask = 1 << (hwirq % 32);
> +
> +       addr = chip->base + MBIGEN_TYPE_REG_ADDR(nid, ofst);
> +       raw_spin_lock(&chip->lock);
> +       val = readl_relaxed(addr);
> +
> +       if (type == IRQ_TYPE_LEVEL_HIGH)
> +               val |= mask;
> +       else if (type == IRQ_TYPE_EDGE_RISING)
> +               val &= ~mask;
> +
> +       writel_relaxed(val, addr);
> +       raw_spin_unlock(&chip->lock);
> +
> +       return 0;
> +}
> +
> +static void mbigen_mask_irq(struct irq_data *data)
> +{
> +       irq_chip_mask_parent(data);
> +}
> +
> +static void mbigen_unmask_irq(struct irq_data *data)
> +{
> +       irq_chip_unmask_parent(data);
> +}
> +
> +static int mbigen_set_affinity(struct irq_data *data,
> +                              const struct cpumask *mask,
> +                              bool force)
> +{
> +       int ret;
> +
> +       ret = irq_chip_set_affinity_parent(data, mask, force);
> +       return ret;
> +}
> +
> +static void mbigen_irq_eoi(struct irq_data *d)
> +{
> +       irq_chip_eoi_parent(d);

... but this function doesn't have any code dealing with injecting an
edge on detecting a level high.

So how does it work? Either you're missing some logic here, or you don't
really support level interrupts.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
