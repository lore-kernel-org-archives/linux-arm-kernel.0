From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 18 May 2018 15:22:21 +0200
Subject: [PATCH 10/17] irqchip/irq-mvebu-sei: add new driver for Marvell
 SEI
In-Reply-To: <20180502111744.5391afff@windsurf.home>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-11-miquel.raynal@bootlin.com>
 <20180502111744.5391afff@windsurf.home>
Message-ID: <20180518152221.0c3583fc@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, 2 May 2018 11:17:44 +0200, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Sat, 21 Apr 2018 15:55:30 +0200, Miquel Raynal wrote:
> 
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 5ed465ab1c76..6b5b75cb4694 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -73,6 +73,7 @@ obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
> >  obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
> >  obj-$(CONFIG_MSCC_OCELOT_IRQ)		+= irq-mscc-ocelot.o
> >  obj-$(CONFIG_MVEBU_GICP)		+= irq-mvebu-gicp.o
> > +obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
> >  obj-$(CONFIG_MVEBU_ICU)			+= irq-mvebu-icu.o
> >  obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
> >  obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o  
> 
> Alphabetic ordering would put SEI after PIC I guess :)

Sure.

> 
> > diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
> > new file mode 100644
> > index 000000000000..5c12c74e3f09
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-mvebu-sei.c
> > @@ -0,0 +1,449 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR X11  
> 
> License for code is GPL-2.0 only. We use GPL-2.0 OR X11 for Device
> Trees.

I did not know, thanks for the explanation.

> 
> > +#define pr_fmt(fmt) "mvebu-sei: " fmt
> > +
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/msi.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/irqchip.h>
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +#define GICP_SET_SEI_OFFSET	0x30
> > +#define GICP_CLR_SEI_OFFSET	GICP_SET_SEI_OFFSET  
> 
> Why do you have this concept of set/clr if there is only one register ?
> I assume that if there is only a "set" register, it means that SEI
> interrupts can only be edge triggered, contrary to NSR interrupts,
> which have separate set/clr to support level-triggered interrupts.
> 
> Having only a "set" offset means that we can rely on the existing
> "struct msi_msg" to convey both the MSI doorbell address and payload,
> and we don't need the mvebu_gicp_get_doorbells() hack.

I misunderstood the specification at first (when copying code from the
gicp driver), and then continued in my mistake. I removed the whole
doorbell thing.

> 
> > +/* Cause register */
> > +#define GICP_SECR(idx)		(0x0  + (idx * 0x4))
> > +/* Mask register */
> > +#define GICP_SEMR(idx)		(0x20 + (idx * 0x4))  
> 
> Minor nit: order register definitions by order of increasing offset,
> i.e the GICP_SET_SEI_OFFSET should be defined here.

Ok.

> 
> > +#define SEI_IRQ_NB_PER_REG	32
> > +#define SEI_IRQ_REG_NB		2  
> 
> s/NB/COUNT/

Changed.

> 
> > +#define SEI_IRQ_NB		(SEI_IRQ_NB_PER_REG * SEI_IRQ_REG_NB)  
> 
> Ditto.
> 
> > +#define SEI_IRQ_REG_IDX(irq_id)	(irq_id / SEI_IRQ_NB_PER_REG)
> > +#define SEI_IRQ_REG_BIT(irq_id)	(irq_id % SEI_IRQ_NB_PER_REG)
> > +
> > +struct mvebu_sei_interrupt_range {
> > +	u32 first;
> > +	u32 number;
> > +};
> > +
> > +struct mvebu_sei {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct resource *res;
> > +	struct irq_domain *ap_domain;
> > +	struct irq_domain *cp_domain;
> > +	struct mvebu_sei_interrupt_range ap_interrupts;
> > +	struct mvebu_sei_interrupt_range cp_interrupts;
> > +	/* Lock on MSI allocations/releases */
> > +	spinlock_t cp_msi_lock;
> > +	DECLARE_BITMAP(cp_msi_bitmap, SEI_IRQ_NB);
> > +};
> > +
> > +static int mvebu_sei_domain_to_sei_irq(struct mvebu_sei *sei,
> > +				       struct irq_domain *domain,
> > +				       irq_hw_number_t hwirq)
> > +{
> > +	if (domain == sei->ap_domain)
> > +		return sei->ap_interrupts.first + hwirq;
> > +	else
> > +		return sei->cp_interrupts.first + hwirq;  
> 
> I am not entirely clear whether we need subnodes or not in this
> binding, but I guess we do because we have one subset of the interrupts
> that are wired interrupts, and another part that are MSI triggered.
> 
> Perhaps this is one aspect on which Marc Zyngier can comment ?
> 
> > +static void mvebu_sei_reset(struct mvebu_sei *sei)
> > +{
> > +	u32 reg_idx;
> > +
> > +	for (reg_idx = 0; reg_idx < SEI_IRQ_REG_NB; reg_idx++) {
> > +		/* Clear all cause bits */
> > +		writel(0xFFFFFFFF, sei->base + GICP_SECR(reg_idx));
> > +		/* Enable all interrupts */
> > +		writel(0, sei->base + GICP_SEMR(reg_idx));  
> 
> Enabling interrupts by default ? This looks weird. They should only be
> enabled... when enabled.

That's right, no need to enable them here.

> 
> > +int mvebu_sei_get_doorbells(struct device_node *dn, phys_addr_t *set,
> > +			    phys_addr_t *clr)
> > +{
> > +	struct platform_device *pdev;
> > +	struct mvebu_sei *sei;
> > +
> > +	pdev = of_find_device_by_node(dn->parent);
> > +	if (!pdev)
> > +		return -ENODEV;
> > +
> > +	sei = platform_get_drvdata(pdev);
> > +	if (!sei)
> > +		return -ENODEV;
> > +
> > +	*set = (phys_addr_t)(sei->res->start + GICP_SET_SEI_OFFSET);
> > +	*clr = (phys_addr_t)(sei->res->start + GICP_CLR_SEI_OFFSET);
> > +
> > +	return 0;
> > +}  
> 
> As I said above, I believe this hack is not needed, because SEIs are
> edge-triggered, and we have a single SET_SEI_OFFSET MSI doorbell
> address to convey, which makes "struct msi_msg" as it is today
> sufficient.

Removed.

> 
> > +static void mvebu_sei_mask_irq(struct irq_data *d)
> > +{
> > +	struct mvebu_sei *sei = irq_data_get_irq_chip_data(d);
> > +	u32 reg_idx = SEI_IRQ_REG_IDX(d->hwirq);  
> 
> This doesn't look right. The d->hwirq is relative to the beginning of
> the domain, while you should use sei_irq here. For example, the SEI
> n?32 (first interrupt in the second register) will have d->hwirq = 11,
> because it is the 11th SEI interrupt for the CP. So here, you will
> conclude that reg_idx = 0, while it should be reg_idx = 1.

This is true. I did not saw it because... well... all interrupts were
enabled by default.

> 
> > +	u32 sei_irq = mvebu_sei_domain_to_sei_irq(sei, d->domain, d->hwirq);
> > +	u32 irq_mask = BIT(SEI_IRQ_REG_BIT(sei_irq));
> > +	u32 reg;
> > +
> > +	/* 1 disables the interrupt */
> > +	reg =  readl(sei->base + GICP_SEMR(reg_idx));
> > +	writel(reg | irq_mask, sei->base + GICP_SEMR(reg_idx));  
> 
> Personal taste here, but I prefer:
> 
> 	reg =  readl(sei->base + GICP_SEMR(reg_idx));
> 	reg |= BIT(SEI_IRQ_REG_BIT(sei_irq));
> 	writel(reg, sei->base + GICP_SEMR(reg_idx));

No problem.

> 
> > +static void mvebu_sei_unmask_irq(struct irq_data *d)
> > +{
> > +	struct mvebu_sei *sei = irq_data_get_irq_chip_data(d);
> > +	u32 reg_idx = SEI_IRQ_REG_IDX(d->hwirq);  
> 
> Same mistake as above I believe.
> 
> > +	u32 sei_irq = mvebu_sei_domain_to_sei_irq(sei, d->domain, d->hwirq);
> > +	u32 irq_mask = BIT(SEI_IRQ_REG_BIT(sei_irq));
> > +	u32 reg;
> > +
> > +	/* 0 enables the interrupt */
> > +	reg = readl(sei->base + GICP_SEMR(reg_idx));
> > +	writel(reg & ~irq_mask, sei->base + GICP_SEMR(reg_idx));  
> 
> And same nitpick comment :-)
> 
> > +static int mvebu_sei_irq_domain_alloc(struct irq_domain *domain,
> > +				      unsigned int virq, unsigned int nr_irqs,
> > +				      void *args)  
> 
> I think the coding style says that arguments should be aligned, no ?
> 
> > +{
> > +	struct mvebu_sei *sei = domain->host_data;
> > +	struct irq_fwspec *fwspec = args;
> > +	struct irq_chip *irq_chip;
> > +	int sei_hwirq, hwirq;
> > +	int ret;
> > +
> > +	/* Software only supports single allocations for now */
> > +	if (nr_irqs != 1)
> > +		return -ENOTSUPP;
> > +
> > +	if (domain == sei->ap_domain) {
> > +		irq_chip = &mvebu_sei_ap_wired_irq_chip;
> > +		hwirq = fwspec->param[0];
> > +	} else {
> > +		irq_chip = &mvebu_sei_cp_msi_irq_chip;
> > +		spin_lock(&sei->cp_msi_lock);
> > +		hwirq = bitmap_find_free_region(sei->cp_msi_bitmap, SEI_IRQ_NB,
> > +						0);
> > +		spin_unlock(&sei->cp_msi_lock);
> > +		if (hwirq < 0)
> > +			return -ENOSPC;
> > +	}
> > +
> > +	sei_hwirq = mvebu_sei_domain_to_sei_irq(sei, domain, hwirq);
> > +
> > +	fwspec->fwnode = domain->parent->fwnode;
> > +	fwspec->param_count = 3;
> > +	fwspec->param[0] = GIC_SPI;
> > +	fwspec->param[1] = sei_hwirq;
> > +	fwspec->param[2] = IRQ_TYPE_EDGE_RISING;  
> 
> Maybe it's me being confused, but I thought all SEI interrupts were
> muxed together to a single SPI for the parent GIC. But here, you
> allocate different SPIs at the GIC level. Intuitively, this doesn't
> look good. Haven't you copy/pasted too much from the gicp driver, where
> we have a 1:1 mapping between interrupts coming into the GICP and
> interrupts signaled by the GICP to the GIC, while here we have a N:1
> mapping, with N interrupts coming into the GICP_SEI, and only one
> interrupt leaving the GICP_SEI to the GIC ?

I am a bit in troubles understanding what fwspec->param[1] exactly
means here. I suppose I should s/sei_hwirq/0/ as there is only one SPI
interrupt to refer to?

Maybe Marc can comment on this too?

> 
> > +static const struct irq_domain_ops mvebu_sei_ap_domain_ops = {
> > +	.xlate = irq_domain_xlate_onecell,
> > +	.alloc = mvebu_sei_irq_domain_alloc,
> > +	.free = mvebu_sei_irq_domain_free,
> > +};
> > +
> > +static const struct irq_domain_ops mvebu_sei_cp_domain_ops = {
> > +	.xlate = irq_domain_xlate_twocell,
> > +	.alloc = mvebu_sei_irq_domain_alloc,
> > +	.free = mvebu_sei_irq_domain_free,
> > +};  
> 
> Why do you need two cells for the interrupts coming from the CP and
> only one cell for the interrupts coming from the AP ?
> 
> For thermal in the AP, you do:
> 
> +					interrupt-parent = <&sei_wired_controller>;
> +					interrupts = <18>;
> 
> i.e, you don't specify an interrupt type. For thermal in the CP, you do:
> 
> +				interrupts-extended =
> +					<&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
> 
> here you specify an interrupt type. I'm not sure why you have this
> difference. Even more so because I think a SEI level interrupt is not
> possible, since you only have a "SET" register and no "CLR" register.

and then you wrote:

<quote>
> OK, my comment is not very correct here, I'm comparing apple to
> oranges. The former its an interrupt directly pointing to the GICP_SEI,
> while the latter is an interrupt of the ICU, which itself will notify
> the GICP_SEI through an MSI.

> However, I'm still confused as to why you have .xlate =
> irq_domain_xlate_twocell for the mvebu_sei_cp_domain_ops. I think there
> is no need for ->xlate() call back here because it's going to be a MSI
> domain.
</quote>

For thermal in the AP I should probably add an IRQ_TYPE_LEVEL_HIGH in
order to describe properly the interrupt (wired).

I also removed the .xlate entry for the CP domain, I was not sure it
was useless for MSI but it looks it is.

> 
> Some guidance from Marc here might be useful perhaps.
> 
> 
> > +static int mvebu_sei_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *node = pdev->dev.of_node, *parent, *child;
> > +	struct irq_domain *parent_domain, *plat_domain;
> > +	struct mvebu_sei *sei;
> > +	const __be32 *property;
> > +	u32 top_level_spi, size;
> > +	int ret;
> > +
> > +	sei = devm_kzalloc(&pdev->dev, sizeof(*sei), GFP_KERNEL);
> > +	if (!sei)
> > +		return -ENOMEM;
> > +
> > +	sei->dev = &pdev->dev;
> > +
> > +	spin_lock_init(&sei->cp_msi_lock);
> > +
> > +	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!sei->res) {
> > +		dev_err(sei->dev, "Failed to retrieve SEI resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	sei->base = devm_ioremap(sei->dev, sei->res->start,
> > +				 resource_size(sei->res));
> > +	if (!sei->base) {
> > +		dev_err(sei->dev, "Failed to remap SEI resource\n");
> > +		return -ENODEV;
> > +	}  
> 
> Use devm_ioremap_resource() here, and remove the error handling of
> platform_get_resource(), because it's already taken care of by
> devm_ioremap_resource().

Good tip, I'll remember.

> 
> > +	/*
> > +	 * Reserve the single (top-level) parent SPI IRQ from which all the
> > +	 * interrupts handled by this driver will be signaled.
> > +	 */
> > +	top_level_spi = irq_of_parse_and_map(node, 0);
> > +	if (top_level_spi <= 0) {
> > +		dev_err(sei->dev, "Failed to retrieve top-level SPI IRQ\n");
> > +		return -ENODEV;
> > +	}  
> 
> Rather than top_level_spi, something like parent_irq would make more
> sense to me.

Renamed.

> 
> > +	irq_set_chained_handler(top_level_spi, mvebu_sei_handle_cascade_irq);
> > +	irq_set_handler_data(top_level_spi, sei);
> > +
> > +	/*
> > +	 * SEIs in the range [ 0; 20] are wired and come from the AP.
> > +	 * SEIs in the range [21; 63] are CP SEI and are triggered through MSIs.
> > +	 *
> > +	 * Each SEI 'domain' is represented as a subnode.
> > +	 */
> > +
> > +	/* Get a reference to the parent domain to create a hierarchy */
> > +	parent = of_irq_find_parent(node);
> > +	if (!parent) {
> > +		dev_err(sei->dev, "Failed to find parent IRQ node\n");
> > +		ret = -ENODEV;
> > +		goto dispose_irq;
> > +	}
> > +
> > +	parent_domain = irq_find_host(parent);
> > +	if (!parent_domain) {
> > +		dev_err(sei->dev, "Failed to find parent IRQ domain\n");
> > +		ret = -ENODEV;
> > +		goto dispose_irq;
> > +	}
> > +
> > +	/* Create the 'wired' hierarchy */
> > +	child = of_find_node_by_name(node, "sei-wired-controller");
> > +	if (!child) {
> > +		dev_err(sei->dev, "Missing 'sei-wired-controller' subnode\n");
> > +		ret = -ENODEV;
> > +		goto dispose_irq;
> > +	}  
> 
> Don't forget to of_node_put(child) once you're done using this DT node
> reference.

Ok.

> 
> > +
> > +	property = of_get_property(child, "reg", &size);
> > +	if (!property || size != (2 * sizeof(u32))) {
> > +		dev_err(sei->dev, "Missing subnode 'reg' property\n");
> > +		ret = -ENODEV;
> > +		goto dispose_irq;
> > +	}  
> 
> As Rob said, I don't think the "reg" property is appropriate for this
> usage.

I will change.

> 
> > +	sei->ap_interrupts.first = be32_to_cpu(property[0]);
> > +	sei->ap_interrupts.number = be32_to_cpu(property[1]);
> > +	sei->ap_domain = irq_domain_create_hierarchy(parent_domain, 0,
> > +						     sei->ap_interrupts.number,
> > +						     of_node_to_fwnode(child),
> > +						     &mvebu_sei_ap_domain_ops,
> > +						     sei);
> > +	if (!sei->ap_domain) {
> > +		dev_err(sei->dev, "Failed to create AP IRQ domain\n");
> > +		ret = -ENOMEM;
> > +		goto dispose_irq;
> > +	}
> > +
> > +	/* Create the 'MSI' hierarchy */
> > +	child = of_find_node_by_name(node, "sei-msi-controller");
> > +	if (!child) {
> > +		dev_err(sei->dev, "Missing 'sei-msi-controller' subnode\n");
> > +		ret = -ENODEV;
> > +		goto remove_ap_domain;
> > +	}  
> 
> Ditto: missing of_node_put(child) somewhere below to balance
> of_find_node_by_name().

Ok.

> 
> > +	property = of_get_property(child, "reg", &size);
> > +	if (!property || size != (2 * sizeof(u32))) {
> > +		dev_err(sei->dev, "Missing subnode 'reg' property\n");
> > +		ret = -ENODEV;
> > +		goto remove_ap_domain;
> > +	}
> > +
> > +	sei->cp_interrupts.first = be32_to_cpu(property[0]);
> > +	sei->cp_interrupts.number = be32_to_cpu(property[1]);
> > +	sei->cp_domain = irq_domain_create_hierarchy(parent_domain, 0,
> > +						     sei->cp_interrupts.number,
> > +						     of_node_to_fwnode(child),
> > +						     &mvebu_sei_cp_domain_ops,
> > +						     sei);
> > +	if (!sei->cp_domain) {
> > +		pr_err("Failed to create CPs IRQ domain\n");
> > +		ret = -ENOMEM;
> > +		goto remove_ap_domain;
> > +	}
> > +
> > +	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(child),
> > +						     &mvebu_sei_msi_domain_info,
> > +						     sei->cp_domain);
> > +	if (!plat_domain) {
> > +		pr_err("Failed to create CPs MSI domain\n");
> > +		ret = -ENOMEM;
> > +		goto remove_cp_domain;
> > +	}  
> 
> 
> 
> > +
> > +	platform_set_drvdata(pdev, sei);
> > +
> > +	mvebu_sei_reset(sei);  
> 
> Please do the reset *before* registering the IRQ domains, it's more
> logical to have the HW ready and then expose it to Linux rather than
> the opposite.

Sure.

> 
> It would be nice to have the review from Marc on this driver,
> especially on whether the SEI is properly modeled in terms of IRQ
> domains;
> 
> > diff --git a/drivers/irqchip/irq-mvebu-sei.h b/drivers/irqchip/irq-mvebu-sei.h
> > new file mode 100644
> > index 000000000000..f0c12a441923
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-mvebu-sei.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __MVEBU_SEI_H__
> > +#define __MVEBU_SEI_H__
> > +
> > +#include <linux/types.h>
> > +
> > +struct device_node;
> > +
> > +int mvebu_sei_get_doorbells(struct device_node *dn, phys_addr_t *set,
> > +			    phys_addr_t *clr);
> > +
> > +#endif /* __MVEBU_SEI_H__ */  
> 
> This header file can be removed if you drop mvebu_sei_get_doorbells(),
> as suggested above.

Indeed.

> 
> Best regards,
> 
> Thomas

Thanks!
Miqu?l
