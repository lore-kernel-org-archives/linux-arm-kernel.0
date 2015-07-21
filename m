From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 21 Jul 2015 15:07:24 +0000
Subject: [PATCH V5 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <alpine.DEB.2.11.1507172253520.18576@nanos>
References: <1437150300-8134-1-git-send-email-shenwei.wang@freescale.com>
 <1437150300-8134-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1507172253520.18576@nanos>
Message-ID: <BL2PR03MB370B72098E511CFE551588B83840@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thank you for the high-quality review. Please check my comments inline below.

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?7?17? 16:50
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH V5 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> 
> On Fri, 17 Jul 2015, Shenwei Wang wrote:
> > +++ b/drivers/irqchip/irq-imx-gpcv2.c
> > @@ -0,0 +1,311 @@
> > +
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
> > +#include <linux/syscore_ops.h>
> > +#include "irqchip.h"
> 
> This file is deprecated. Use linux/irqchip.h instead.
> 
Okay.

> > +static struct imx_irq_gpcv2 *gpcv2_get_chip_data(void) {
> > +	struct irq_data *data;
> > +	int virq;
> > +
> > +	/* Since GPCv2 is the default IRQ domain, its private data can
> > +	 * be gotten from any irq descriptor. Here we use interrupt #19
> > +	 * which is for snvs-rtc.
> > +	 */
> 
> Yuck. What kind of logic is that?
> 
> Use some random hardcoded number to find something which has been set by
> this driver?
> 
> > +	virq = irq_find_mapping(0, 19);
> > +
> > +	for (data = irq_get_irq_data(virq); data;
> > +	     data = data->parent_data) {
> > +		if (!data->domain)
> > +			continue;
> > +
> > +		if (!strcmp(data->domain->name, "GPCv2"))
> 
> So you are relying on internal knowledge of the irq domain code which sets the
> domain name to the chip name if the domain name is not initialized by other
> means.
> 
> Brilliant, NOT!
> 
> In other words you are interested in the irq chip associated with that domain and
> not with the domain itself.
> 
> Care to explain what you are trying to do and why you think there are no better
> ways to figure that out?
> 
When I wrote the driver, there were two options to let other modules like suspend 
and cpuidle drivers to access this instance of imx_irq_gpcv2:
Option #1 is to use the private data pointer of the irqdomain. 
Option #2 is to export a global variable here.
I selected option #1 because it could decouple this irq driver from those who may
use this instance. But option #2 is more direct and simple.
 
> > +			return data->chip_data;
> > +	}
> > +
> > +	return 0;
> 
> This wants to be 'return NULL;' if at all.
> 
Okay.

> > +}
> > +
> > +static int gpcv2_wakeup_source_save(void) {
> > +	struct imx_irq_gpcv2 *cd;
> > +	void __iomem *reg;
> > +	int i;
> > +
> > +	cd = gpcv2_get_chip_data();
> > +	if (!cd)
> > +		return 0;
> > +
> > +	for (i = 0; i < IMR_NUM; i++) {
> 
> Why is IMR_NUM a hard coded constant and not provided by DT?
> 
It can be provided by DT. However, as it is a fixed number and will never change once the 
Chip is produced I selected to hard code it.

> > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		cd->enabled_irqs[i] = readl_relaxed(reg);
> > +		writel_relaxed(cd->wakeup_sources[i], reg);
> > +	}
> > +
> > +	pr_devel("%s ----\r\n", __func__);
> > +	pr_devel("Enabled IRQ:\t %08X %08X %08X %08X\r\n",
> > +			cd->enabled_irqs[0],
> > +			cd->enabled_irqs[1],
> > +			cd->enabled_irqs[2],
> > +			cd->enabled_irqs[3]);
> > +	pr_devel("Wakeup Sources:\t %08X %08X %08X %08X\r\n",
> > +			cd->wakeup_sources[0],
> > +			cd->wakeup_sources[1],
> > +			cd->wakeup_sources[2],
> > +			cd->wakeup_sources[3]);
> 
> Do we really need this debug stuff in mainline?
> 
Ok to remove it.

> > +static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int
> > +on) {
> > +	unsigned int idx = d->hwirq / 32;
> > +	struct imx_irq_gpcv2 *cd = d->chip_data;
> > +	u32 mask, val;
> > +	unsigned long flags;
> > +	void __iomem *reg;
> 
> Can you come up with an even less readable way to arrange those declarations?
> 
Will change the declarations like following:
	u32 mask, val;
	unsigned long flags;
	void __iomem *reg;

	unsigned int idx = d->hwirq / 32;
	struct imx_irq_gpcv2 *cd = d->chip_data;

> > +	spin_lock_irqsave(&cd->lock, flags);
> 
> That wants to be a raw spinlock.
> 
Will change it to raw_spin_lock

> > +	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
> 
> This lacks a comment explaining the magic math
> 
> > +static void imx_gpcv2_irq_unmask(struct irq_data *d) {
> > +	void __iomem *reg;
> > +	struct imx_irq_gpcv2 *cd = d->chip_data;
> > +	u32 val;
> > +	unsigned long flags;
> 
> Another random variant of arranging declarations.
> 
Will change it like following:
	u32 val;
	unsigned long flags;
    void __iomem *reg;
    struct imx_irq_gpcv2 *cd = d->chip_data;

>>+	spin_lock_irqsave(&cd->lock, flags);
> 
> This callback is always called with interrupts disabled, so this wants to be
> raw_spin_lock()
> 
Okay. 

> > +	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
> > +	val = readl_relaxed(reg);
> > +	val &= ~(1 << d->hwirq % 32);
> > +	writel_relaxed(val, reg);
> > +	irq_chip_unmask_parent(d);
> 
> Why needs this to be called under cd->lock?
> 
You are right. Irq_chip_unmask_parent(d) should be moved under cd->lock.

> If there is a requirement to do so, then it needs a comment.
> 
> > +	spin_unlock_irqrestore(&cd->lock, flags);
> 
> > +static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
> > +				struct device_node *controller,
> > +				const u32 *intspec,
> > +				unsigned int intsize,
> > +				unsigned long *out_hwirq,
> > +				unsigned int *out_type)
> > +{
> > +	if (domain->of_node != controller)
> > +		return -EINVAL;	/* Shouldn't happen, really... */
> 
> Tail comments are horrible to read. Either your comment has a value then put it
> above the if construct or just get rid of it.
> 
Will remove it.

> > +static int __init imx_gpcv2_irqchip_init(struct device_node *node,
> > +			       struct device_node *parent) {
> > +	struct irq_domain *parent_domain, *domain;
> > +	int i, val;
> > +	struct imx_irq_gpcv2 *cd;
> > +
> > +	if (!parent) {
> > +		pr_err("%s: no parent, giving up\n", node->full_name);
> > +		return -ENODEV;
> > +	}
> > +
> > +	parent_domain = irq_find_host(parent);
> > +	if (!parent_domain) {
> > +		pr_err("%s: unable to obtain parent domain\n", node->full_name);
> > +		return -ENXIO;
> > +	}
> > +
> > +	cd = kzalloc(sizeof(struct imx_irq_gpcv2), GFP_KERNEL);
> > +	BUG_ON(!cd);
> 
> This BUG_ON does not make any sense as you just return an error code if
> something else goes wrong after that.
> 
Make sense. Will remove it.

> > +	cd->gpc_base = of_iomap(node, 0);
> > +	if (!cd->gpc_base) {
> > +		pr_err("fsl-gpcv2: unable to map gpc registers\n");
> > +		kzfree(cd);
> 
> Surely this needs kzfree because cd contains security relevant data, right?
> 
It is not secure data. Will change it to kfree.

> > +	/*
> > +	 * Due to hardware design requirement, need to make sure GPR
> 
> s/requirement/failure/ right?
> 
Agree.

> > +	 * interrupt(#32) is unmasked during RUN mode to avoid entering
> > +	 * DSM by mistake.
> > +	 */
> > +	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
> 
> Magic constant '~0x1' ?
> 
> > +
> > +	/* Mask the wakeup sources in M/F power domain */
> > +	cd->mfmix_mask[0] = 0x54010000;
> > +	cd->mfmix_mask[1] = 0xc00;
> > +	cd->mfmix_mask[2] = 0x0;
> > +	cd->mfmix_mask[3] = 0x400010;
> 
> Again, really intuitive and self explaining magic constants.
> 
> > +
> > +IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
> 
> I'm not a DT expert, but AFAIK there is a requirement to document the bindings
> somewhere. -ENODOCUMENT!
> 
Will add this string in Documentation/devicetree/bindings/power/fsl,imx-gpc.txt

> > +
> > +enum gpcv2_mode {
> > +	WAIT_CLOCKED,		/* wfi only */
> 
> Again, tail comments are horrible to read. Use proper KernelDoc if you want to
> document stuff. Though I doubt that any of these comments have any value at all.
> 
> Aside of that these names are pretty generic and prone to create a namespace
> clash sooner or later.
> 
Will remove the tail comments.

> > +	WAIT_UNCLOCKED,		/* WAIT */
> > +	WAIT_UNCLOCKED_POWER_OFF,	/* WAIT + SRPG */
> > +	STOP_POWER_ON,		/* just STOP */
> > +	STOP_POWER_OFF,		/* STOP + SRPG */
> > +};
> > +
> > +enum gpcv2_slot {
> 
> What is this enum for?
> 
It defined all the power domains that are controlled by GPCv2 block.

> > +	CORE0_A7,
> > +	CORE1_A7,
> > +	SCU_A7,
> > +	FAST_MEGA_MIX,
> > +	MIPI_PHY,
> > +	PCIE_PHY,
> > +	USB_OTG1_PHY,
> > +	USB_OTG2_PHY,
> > +	USB_HSIC_PHY,
> > +	CORE0_M4,
> 
> Namespace?
> 
> > +};
> 
> > +struct imx_irq_gpcv2 {
> > +	spinlock_t lock;
> 
>   raw_spinlock_t
> 
> > +	void __iomem *gpc_base;
> > +	struct regmap *anatop;
> > +	struct regmap *imx_src;
> > +	u32 wakeup_sources[IMR_NUM];
> > +	u32 enabled_irqs[IMR_NUM];
> > +	u32 mfmix_mask[IMR_NUM];
> > +	u32 wakeupmix_mask[IMR_NUM];
> > +	u32 lpsrmix_mask[IMR_NUM];
> > +	u32 cpu2wakeup;
> > +	void (*lpm_env_setup)(struct imx_irq_gpcv2 *);
> > +	void (*lpm_env_clean)(struct imx_irq_gpcv2 *);
> > +	void (*lpm_cpu_power_gate)(struct imx_irq_gpcv2 *, u32, bool);
> > +	void (*lpm_plat_power_gate)(struct imx_irq_gpcv2 *, bool);
> > +	void (*set_mode)(struct imx_irq_gpcv2 *, enum gpcv2_mode mode);
> > +	void (*standby)(struct imx_irq_gpcv2 *);
> > +	void (*suspend)(struct imx_irq_gpcv2 *);
> > +	void (*set_slot)(struct imx_irq_gpcv2 *cd, u32 index,
> > +			enum gpcv2_slot m_core, bool mode, bool ack);
> > +	void (*clear_slots)(struct imx_irq_gpcv2 *);
> > +	void (*lpm_enable_core)(struct imx_irq_gpcv2 *,
> > +			bool enable, u32 offset);
> > +
> > +
> > +	void (*suspend_fn_in_ocram)(void __iomem *ocram_vbase);
> > +	void __iomem *ocram_vbase;
> 
> How many of these struct members are actually relevant to this driver and what
> is the purpose of those? A proper KernelDoc comment would shed some light on
> it.
> 
This struct defines the properties and functions that GPCv2 block provides. Since GPCv2 has
two key functions: Irq wakeup source management and power management, the 
intention of the struct is to share data and methods among irqchip, suspend, and cpuidle drivers.

> > +};
> > +
> > +void ca7_cpu_resume(void);
> > +void imx7_suspend(void __iomem *ocram_vbase);
> 
> How is that related to the irqchip driver?
> 
These two functions are used by suspend driver.

Thanks,
Shenwei


> Thanks,
> 
> 	tglx
