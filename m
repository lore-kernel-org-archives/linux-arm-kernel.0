From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 28 Jul 2015 14:27:42 +0000
Subject: [PATCH v7 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <20150728012452.GX12927@tiger>
References: <1438025400-5919-1-git-send-email-shenwei.wang@freescale.com>
 <1438025400-5919-2-git-send-email-shenwei.wang@freescale.com>
 <20150728012452.GX12927@tiger>
Message-ID: <CY1PR0301MB08438D52968A601F94DBB55C838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?7?27? 20:25
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; tglx at linutronix.de; jason at lakedaemon.net; Huang
> Yongcai-B20788; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v7 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Mon, Jul 27, 2015 at 02:29:59PM -0500, Shenwei Wang wrote:
> > diff --git a/drivers/irqchip/irq-imx-gpcv2.c
> > b/drivers/irqchip/irq-imx-gpcv2.c new file mode 100644 index
> > 0000000..3084f16
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-imx-gpcv2.c
> > @@ -0,0 +1,254 @@
> > +/*
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/slab.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/syscore_ops.h>
> > +
> > +#include <soc/imx/gpcv2.h>
> > +
> > +#define GPC_MAX_IRQS            		(IMR_NUM * 32)
> 
> IMR_NUM is a bit generic and should probably have a proper name space.
> 
> > +
> > +#define GPC_IMR1_CORE0				0x30
> > +#define GPC_IMR1_CORE1				0x40
> > +
> > +struct imx_gpcv2_irq *gpcv2_irq_instance;
> > +
> > +static int gpcv2_wakeup_source_save(void) {
> > +	struct imx_gpcv2_irq *cd;
> 
> We generally name variables in an abbrev of the types to make them intuitive.  I
> tried hard to map "cd" to "imx_gpcv2_irq" and failed.
> Can you help me on that?

CD is the abbreviation of chip data which is a member of irq_data.
 
> > +	void __iomem *reg;
> > +	int i;
> > +
> > +	cd = gpcv2_irq_instance;
> > +	if (!cd)
> > +		return 0;
> > +
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		cd->enabled_irqs[i] = readl_relaxed(reg);
> > +		writel_relaxed(cd->wakeup_sources[i], reg);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void gpcv2_wakeup_source_restore(void) {
> > +	struct imx_gpcv2_irq *cd;
> > +	void __iomem *reg;
> > +	int i;
> > +
> > +	cd = gpcv2_irq_instance;
> > +	if (!cd)
> > +		return;
> > +
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		writel_relaxed(cd->enabled_irqs[i], reg);
> > +		cd->wakeup_sources[i] = ~0;
> > +	}
> > +}
> > +
> > +static struct syscore_ops imx_gpcv2_syscore_ops = {
> > +	.suspend	= gpcv2_wakeup_source_save,
> > +	.resume		= gpcv2_wakeup_source_restore,
> > +};
> > +
> > +static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int
> > +on) {
> > +	struct imx_gpcv2_irq *cd = d->chip_data;
> > +	unsigned int idx = d->hwirq / 32;
> > +	unsigned long flags;
> > +	void __iomem *reg;
> > +	u32 mask, val;
> > +
> > +	raw_spin_lock_irqsave(&cd->rlock, flags);
> > +	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
> > +	mask = 1 << d->hwirq % 32;
> > +	val = cd->wakeup_sources[idx];
> > +
> > +	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
> > +	raw_spin_unlock_irqrestore(&cd->rlock, flags);
> > +
> > +	/*
> > +	 * Do *not* call into the parent, as the GIC doesn't have any
> > +	 * wake-up facility...
> > +	 */
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +static void imx_gpcv2_irq_unmask(struct irq_data *d) {
> > +	struct imx_gpcv2_irq *cd = d->chip_data;
> > +	void __iomem *reg;
> > +	u32 val;
> > +
> > +	raw_spin_lock(&cd->rlock);
> > +	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> > +	val = readl_relaxed(reg);
> > +	val &= ~(1 << d->hwirq % 32);
> > +	writel_relaxed(val, reg);
> > +	raw_spin_unlock(&cd->rlock);
> > +
> > +	irq_chip_unmask_parent(d);
> > +}
> > +
> > +static void imx_gpcv2_irq_mask(struct irq_data *d) {
> > +	struct imx_gpcv2_irq *cd = d->chip_data;
> > +	void __iomem *reg;
> > +	u32 val;
> > +
> > +	raw_spin_lock(&cd->rlock);
> > +	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> > +	val = readl_relaxed(reg);
> > +	val |= 1 << (d->hwirq % 32);
> > +	writel_relaxed(val, reg);
> > +	raw_spin_unlock(&cd->rlock);
> > +
> > +	irq_chip_mask_parent(d);
> > +}
> > +
> > +
> 
> One new line is enough.
> 
> > +static struct irq_chip imx_gpcv2_irq_chip = {
> > +	.name			= "GPCv2",
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_mask		= imx_gpcv2_irq_mask,
> > +	.irq_unmask		= imx_gpcv2_irq_unmask,
> > +	.irq_set_wake		= imx_gpcv2_irq_set_wake,
> > +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > +#ifdef CONFIG_SMP
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +#endif
> > +};
> > +
> > +static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
> > +				struct device_node *controller,
> > +				const u32 *intspec,
> > +				unsigned int intsize,
> > +				unsigned long *out_hwirq,
> > +				unsigned int *out_type)
> > +{
> > +	/* Shouldn't happen, really... */
> > +	if (domain->of_node != controller)
> > +		return -EINVAL;
> > +
> > +	/* Not GIC compliant */
> > +	if (intsize != 3)
> > +		return -EINVAL;
> > +
> > +	/* No PPI should point to this domain */
> > +	if (intspec[0] != 0)
> > +		return -EINVAL;
> > +
> > +	*out_hwirq = intspec[1];
> > +	*out_type = intspec[2];
> > +	return 0;
> > +}
> > +
> > +static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
> > +				  unsigned int irq, unsigned int nr_irqs,
> > +				  void *data)
> > +{
> > +	struct of_phandle_args *args = data;
> > +	struct of_phandle_args parent_args;
> > +	irq_hw_number_t hwirq;
> > +	int i;
> > +
> > +	/* Not GIC compliant */
> > +	if (args->args_count != 3)
> > +		return -EINVAL;
> > +
> > +	/* No PPI should point to this domain */
> > +	if (args->args[0] != 0)
> > +		return -EINVAL;
> > +
> > +	/* Can't deal with this */
> > +	hwirq = args->args[1];
> > +	if (hwirq >= GPC_MAX_IRQS)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
> > +				&imx_gpcv2_irq_chip, domain->host_data);
> > +	}
> > +	parent_args = *args;
> > +	parent_args.np = domain->parent->of_node;
> > +	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
> > +&parent_args); }
> > +
> > +static struct irq_domain_ops imx_gpcv2_irq_domain_ops = {
> > +	.xlate	= imx_gpcv2_domain_xlate,
> > +	.alloc	= imx_gpcv2_domain_alloc,
> > +	.free	= irq_domain_free_irqs_common,
> > +};
> > +
> > +
> > +
> 
> The new line is used so arbitrary.  One is enough.
> 
> > +static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> > +			       struct device_node *parent) {
> > +	struct irq_domain *parent_domain, *domain;
> > +	struct imx_gpcv2_irq *cd;
> > +	int i;
> > +
> > +	if (!parent) {
> > +		pr_err("%s: no parent, giving up\n", node->full_name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	parent_domain = irq_find_host(parent);
> > +	if (!parent_domain) {
> > +		pr_err("%s: unable to get parent domain\n", node->full_name);
> > +		return -ENXIO;
> > +	}
> > +
> > +	cd = kzalloc(sizeof(struct imx_gpcv2_irq), GFP_KERNEL);
> 
> A null pointer check is needed before it's used.
> 
> > +
> > +	cd->gpc_base = of_iomap(node, 0);
> > +	if (!cd->gpc_base) {
> > +		pr_err("fsl-gpcv2: unable to map gpc registers\n");
> > +		kfree(cd);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
> > +				node, &imx_gpcv2_irq_domain_ops, cd);
> > +	if (!domain) {
> > +		iounmap(cd->gpc_base);
> > +		kfree(cd);
> > +		return -ENOMEM;
> > +	}
> > +	irq_set_default_host(domain);
> > +
> > +	/* Initially mask all interrupts */
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
> > +		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
> > +		cd->wakeup_sources[i] = ~0;
> > +	}
> > +
> > +	/* Let CORE0 as the default CPU to wake up by GPC */
> > +	cd->cpu2wakeup = GPC_IMR1_CORE0;
> > +
> > +	gpcv2_irq_instance = cd;
> > +
> > +	register_syscore_ops(&imx_gpcv2_syscore_ops);
> > +
> > +	return 0;
> > +}
> > +
> > +
> 
> One is enough.
> 
> > +IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
> > +
> > +
> 
> One new line at end of file.
> 
> > diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h new
> > file mode 100644 index 0000000..7234928
> > --- /dev/null
> > +++ b/include/soc/imx/gpcv2.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __SOC_IMX_GPCV2_H__
> > +#define __SOC_IMX_GPCV2_H__
> > +
> > +#define IMR_NUM		4
> > +
> > +struct imx_gpcv2_irq {
> > +	struct raw_spinlock rlock;
> > +	void __iomem *gpc_base;
> > +	u32 wakeup_sources[IMR_NUM];
> > +	u32 enabled_irqs[IMR_NUM];
> > +	u32 cpu2wakeup;
> > +};
> 
> Please try hard to make it an internal data structure of irqchip driver.
> 
> > +
> > +void ca7_cpu_resume(void);
> > +void imx7_suspend(void __iomem *ocram_vbase);
> 
> Why do these declarations need to be in this header?

Just to resolve the compile errors.
 

> Shawn
> 
> > +
> > +#endif  /* __SOC_IMX_GPCV2_H__ */
> > --
> > 2.5.0.rc2
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
