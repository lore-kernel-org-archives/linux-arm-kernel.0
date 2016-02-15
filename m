From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Feb 2016 09:14:15 +0000
Subject: [PATCH] irqchip: irq-mvebu-odmi: new driver
In-Reply-To: <1455522162-16425-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455522162-16425-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <56C196E7.2060106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 15/02/16 07:42, Thomas Petazzoni wrote:
> This commits adds a new irqchip driver that handles the ODMI
> controller found on Marvell 7K/8K processors. The ODMI controller
> provide MSI interrupt functionality to on-board peripherals, much like
> the GIC-v2m.

May I suggest a title that says a bit more than just "new driver"?
Something a bit more descriptive like "Platform MSI support"?

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../marvell,odmi-controller.txt                    |  36 +++
>  drivers/irqchip/Kconfig                            |   4 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-mvebu-odmi.c                   | 270 +++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
>  create mode 100644 drivers/irqchip/irq-mvebu-odmi.c
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> new file mode 100644
> index 0000000..a2470af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> @@ -0,0 +1,36 @@
> +
> +* Marvell ODMI for MSI support
> +
> +Some Marvell SoCs have an On-Die Message Interrupt (ODMI) controller
> +which can be used by on-board peripheral for MSI interrupts.
> +
> +Required properties:
> +
> +- compatible	       : The value here should contain "marvell,odmi-controller".
> +
> +- interrupt,controller : Identifies the node as an interrupt controller.
> +
> +- msi-controller       : Identifies the node as an MSI controller.
> +
> +- marvell,odmi-frames  : Number of ODMI frames available. Each frame
> +                         provides a number of events.
> +
> +- reg		       : List of register definitions, one for each
> +                         ODMI frame.
> +
> +- marvell,spi-base     : List of GIC base SPI interrupts, one for each
> +                         ODMI frame.

Please add a pointer to the GIC documentation, so that it is explicit
what SPIs are. Also, is the SPI number 0 based? or 32 based? Looking at
the code, it looks to be 32-based.

Please document the need for an "interrupt-parent" property, which may
be implicit in a DT, but fundamental to the understanding of the system.

> +
> +Example:
> +
> +	odmi: odmi at 300000 {
> +		compatible = "marvell,odmi-controller";
> +		interrupt-controller;
> +		msi-controller;
> +		marvell,odmi-frames = <4>;
> +		reg = <0x300000 0x4000>,
> +		      <0x304000 0x4000>,
> +		      <0x308000 0x4000>,
> +		      <0x30C000 0x4000>;
> +		marvell,spi-base = <128>, <136>, <144>, <152>;
> +	};
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 715923d..18bed3c 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -217,3 +217,7 @@ config IRQ_MXS
>  	def_bool y if MACH_ASM9260 || ARCH_MXS
>  	select IRQ_DOMAIN
>  	select STMP_DEVICE
> +
> +config MVEBU_ODMI
> +	bool
> +	select GENERIC_MSI_IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 18caacb..29c388f 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -59,3 +59,4 @@ obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
>  obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
>  obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
>  obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
> +obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
> diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
> new file mode 100644
> index 0000000..c3e00b9
> --- /dev/null
> +++ b/drivers/irqchip/irq-mvebu-odmi.c
> @@ -0,0 +1,270 @@
> +/*
> + * Copyright (C) 2016 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#define pr_fmt(fmt) "GIC-ODMI: " fmt
> +
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#define GICP_ODMIN_SET			0x40
> +#define   GICP_ODMI_INT_NUM_SHIFT	12
> +#define GICP_ODMIN_GM_EP_R0		0x110
> +#define GICP_ODMIN_GM_EP_R1		0x114
> +#define GICP_ODMIN_GM_EA_R0		0x108
> +#define GICP_ODMIN_GM_EA_R1		0x118
> +
> +/*
> + * We don't support the group events, so we simply have 8 interrupts
> + * per frame.
> + */
> +#define NODMIS_PER_FRAME 8
> +
> +struct odmi_data {
> +	struct resource res;
> +	void __iomem *base;
> +	unsigned int spi_base;
> +	unsigned long bm;

So you keep a bitmap per frame? That seems a bit odd - see below.

> +};
> +
> +static struct odmi_data *odmis;
> +static unsigned int odmis_count;
> +
> +/*
> + * Lock protecting the allocation bitmap embedded in the odmi_data
> + * structure. Only one spinlock is used, since allocation/freeing of
> + * MSI interrupts is infrequent.
> + */
> +static DEFINE_SPINLOCK(odmis_lock);
> +
> +static int odmi_set_affinity(struct irq_data *irq_data,
> +			       const struct cpumask *mask, bool force)
> +{
> +	int ret;
> +
> +	ret = irq_chip_set_affinity_parent(irq_data, mask, force);
> +	if (ret == IRQ_SET_MASK_OK)
> +		ret = IRQ_SET_MASK_OK_DONE;

I'm planning to fix GICv2 so that we don't need that anymore (much like
Antoine did got GICv3 in his Alpine series).

> +
> +	return ret;
> +}
> +
> +static void odmi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct odmi_data *odmi = NULL;
> +	phys_addr_t addr;
> +	unsigned int odmi_offset, i;
> +
> +	/* Search the ODMI frame handling this interrupt */
> +	for (i = 0; i < odmis_count; i++) {
> +		if (data->hwirq >= odmis[i].spi_base &&
> +		    data->hwirq < (odmis[i].spi_base + NODMIS_PER_FRAME)) {
> +			odmi = &odmis[i];
> +			break;
> +		}
> +	}

So assume that instead of a bitmap per frame, you have a global one, and
hwirq is just the bit number in the bitmap. You have 8 interrupts per
frame, so you can compute things like this:

odmi = &odmi[data->hwirq >> 3];
odmi_offset = odmi->spi_base + (data->hwirq & 3);

Job done.

> +
> +	if (WARN_ON(!odmi))
> +		return;
> +
> +	odmi_offset = (data->hwirq - odmi->spi_base);
> +
> +	addr = odmi->res.start + GICP_ODMIN_SET;
> +
> +	msg->address_hi = upper_32_bits(addr);
> +	msg->address_lo = lower_32_bits(addr);
> +	msg->data = odmi_offset << GICP_ODMI_INT_NUM_SHIFT;
> +}
> +
> +static struct irq_chip odmi_irq_chip = {
> +	.name			= "ODMI",
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_affinity	= odmi_set_affinity,
> +	.irq_compose_msi_msg	= odmi_compose_msi_msg,
> +};
> +
> +static int odmi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs, void *args)
> +{
> +	struct odmi_data *odmi = NULL;
> +	struct irq_fwspec fwspec;
> +	struct irq_data *d;
> +	unsigned int offset, hwirq;
> +	int i, ret;
> +
> +	spin_lock(&odmis_lock);
> +	for (i = 0; i < odmis_count; i++) {
> +		offset = find_first_zero_bit(&odmis[i].bm, NODMIS_PER_FRAME);
> +		if (offset < NODMIS_PER_FRAME) {
> +			__set_bit(offset, &odmis[i].bm);
> +			odmi = &odmis[i];
> +			break;
> +		}
> +	}
> +	spin_unlock(&odmis_lock);

And this becomes much simpler.

> +
> +	if (!odmi)
> +		return -ENOSPC;
> +
> +	hwirq = odmi->spi_base + offset;
> +
> +	fwspec.fwnode = domain->parent->fwnode;
> +	fwspec.param_count = 3;
> +	fwspec.param[0] = GIC_SPI;
> +	fwspec.param[1] = hwirq - 32;
> +	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +	if (ret) {
> +		pr_err("Cannot allocate parent IRQ\n");
> +		spin_lock(&odmis_lock);
> +		__clear_bit(offset, &odmi->bm);
> +		spin_unlock(&odmis_lock);
> +		return ret;
> +	}
> +
> +	/* Configure the interrupt line to be edge */
> +	d = irq_domain_get_irq_data(domain->parent, virq);
> +	d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
> +
> +	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> +				      &odmi_irq_chip, NULL);
> +
> +	return 0;
> +}
> +
> +static void odmi_irq_domain_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct odmi_data *odmi = NULL;
> +	unsigned int offset;
> +	int i;
> +
> +	/*
> +	 * Check if the hwirq number is valid, and if so, to which
> +	 * ODMI frame it belongs
> +	 */
> +	spin_lock(&odmis_lock);
> +	for (i = 0; i < odmis_count; i++) {
> +		if (d->hwirq >= odmis[i].spi_base &&
> +		    d->hwirq < (odmis[i].spi_base + NODMIS_PER_FRAME)) {
> +			odmi = &odmis[i];
> +			offset = d->hwirq - odmis[i].spi_base;
> +			break;
> +		}
> +	}
> +	spin_unlock(&odmis_lock);

And that too.

> +
> +	if (!odmi) {
> +		pr_err("Failed to teardown msi. Invalid hwirq %lu\n", d->hwirq);
> +		return;
> +	}
> +
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +
> +	/* Actually free the MSI */
> +	spin_lock(&odmis_lock);
> +	__clear_bit(offset, &odmi->bm);
> +	spin_unlock(&odmis_lock);
> +}
> +
> +static const struct irq_domain_ops odmi_domain_ops = {
> +	.alloc	= odmi_irq_domain_alloc,
> +	.free	= odmi_irq_domain_free,
> +};
> +
> +static struct irq_chip odmi_msi_irq_chip = {
> +	.name	= "ODMI",
> +};
> +
> +static struct msi_domain_ops odmi_msi_ops = {
> +};
> +
> +static struct msi_domain_info odmi_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> +	.ops	= &odmi_msi_ops,
> +	.chip	= &odmi_msi_irq_chip,
> +};
> +
> +static int __init mvebu_odmi_init(struct device_node *node,
> +				  struct device_node *parent)
> +{
> +	struct irq_domain *inner_domain, *plat_domain;
> +	int ret, i;
> +
> +	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
> +		return -EINVAL;
> +
> +	odmis = kcalloc(odmis_count, sizeof(struct odmi_data), GFP_KERNEL);
> +	if (!odmis)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < odmis_count; i++) {
> +		struct odmi_data *odmi = &odmis[i];
> +
> +		ret = of_address_to_resource(node, i, &odmi->res);
> +		if (ret)
> +			goto err_unmap;
> +
> +		odmi->base = of_io_request_and_map(node, i, "odmi");
> +		if (IS_ERR(odmi->base)) {
> +			ret = PTR_ERR(odmi->base);
> +			goto err_unmap;
> +		}
> +
> +		if (of_property_read_u32_index(node, "marvell,spi-base",
> +					       i, &odmi->spi_base)) {
> +			ret = -EINVAL;
> +			goto err_unmap;
> +		}
> +	}
> +
> +	inner_domain = irq_domain_create_linear(of_node_to_fwnode(node),
> +						odmis_count * NODMIS_PER_FRAME,
> +						&odmi_domain_ops, NULL);
> +	if (!inner_domain) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	inner_domain->parent = irq_find_host(parent);
> +
> +	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
> +						     &odmi_msi_domain_info,
> +						     inner_domain);
> +	if (!plat_domain) {
> +		ret = -ENOMEM;
> +		goto err_remove_inner;
> +	}
> +
> +	return 0;
> +
> +err_remove_inner:
> +	irq_domain_remove(inner_domain);
> +err_unmap:
> +	for (i = 0; i < odmis_count; i++) {
> +		struct odmi_data *odmi = &odmis[i];
> +
> +		if (odmi->base && !IS_ERR(odmi->base))
> +			iounmap(odmis[i].base);
> +	}
> +	kfree(odmis);
> +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(mvebu_odmi, "marvell,odmi-controller", mvebu_odmi_init);
> 

It otherwise looks pretty good to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
