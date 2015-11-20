From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Nov 2015 10:56:37 +0000
Subject: [PATCH 08/10] irqchip: add LPC32xx interrupt controller driver
In-Reply-To: <1447982925-30138-9-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
 <1447982925-30138-9-git-send-email-vz@mleia.com>
Message-ID: <564EFC65.10803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/15 01:28, Vladimir Zapolskiy wrote:
> The change adds improved support of NXP LPC32xx MIC, SIC1 and SIC2
> interrupt controllers.
> 
> This is a list of new features in comparison to the legacy driver:
> * irq types are taken from device tree settings, no more need to
>   hardcode them,
> * old driver is based on irq_domain_add_legacy, which causes problems
>   with handling MIC hardware interrupt 0 produced by SIC1,
> * there is one driver for MIC, SIC1 and SIC2, no more need to handle
>   them separately, e.g. have two separate handlers for SIC1 and SIC2,
> * the driver does not have any dependencies on hardcoded register
>   offsets,
> * the driver is much simpler for comprehension and more maintainable,
> * SPARSE_IRQS option is supported.
> 
> The change disables compilation of a legacy driver found at
> arch/arm/mach-lpc32xx/irq.c, the file will be removed in a separate
> commit.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/Kconfig                |   2 +
>  arch/arm/mach-lpc32xx/Makefile  |   2 +-
>  arch/arm/mach-lpc32xx/phy3250.c |   1 -
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-lpc32xx.c   | 227 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 231 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/irqchip/irq-lpc32xx.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cc11f1..1f2c03f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -597,6 +597,8 @@ config ARCH_LPC32XX
>  	select CPU_ARM926T
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_IDE
> +	select MULTI_IRQ_HANDLER
> +	select SPARSE_IRQ
>  	select USE_OF
>  	help
>  	  Support for the NXP LPC32XX family of processors
> diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
> index b1023c0..2a28f645 100644
> --- a/arch/arm/mach-lpc32xx/Makefile
> +++ b/arch/arm/mach-lpc32xx/Makefile
> @@ -2,6 +2,6 @@
>  # Makefile for the linux kernel.
>  #
>  
> -obj-y	:= irq.o common.o serial.o
> +obj-y	:= common.o serial.o
>  obj-y	+= pm.o suspend.o wakeup.o
>  obj-y	+= phy3250.o
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index 60f3392..92e8574 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -259,7 +259,6 @@ static const char *const lpc32xx_dt_compat[] __initconst = {
>  DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
>  	.atag_offset	= 0x100,
>  	.map_io		= lpc32xx_map_io,
> -	.init_irq	= lpc32xx_init_irq,
>  	.init_machine	= lpc3250_machine_init,
>  	.dt_compat	= lpc32xx_dt_compat,
>  	.restart	= lpc23xx_restart,
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 177f78f..21008a6 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
>  obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
>  obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
> +obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
>  obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
>  obj-$(CONFIG_ARCH_MVEBU)		+= irq-armada-370-xp.o
>  obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o
> diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
> new file mode 100644
> index 0000000..fcf281b
> --- /dev/null
> +++ b/drivers/irqchip/irq-lpc32xx.c
> @@ -0,0 +1,227 @@
> +/*
> + * Copyright 2015 Vladimir Zapolskiy <vz@mleia.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <asm/exception.h>
> +
> +#define LPC32XX_INTC_MASK		0x00
> +#define LPC32XX_INTC_RAW		0x04
> +#define LPC32XX_INTC_STAT		0x08
> +#define LPC32XX_INTC_POL		0x0C
> +#define LPC32XX_INTC_TYPE		0x10
> +#define LPC32XX_INTC_FIQ		0x14
> +
> +#define IRQS_PER_CONTROLLER		32
> +
> +struct lpc32xx_irq_chip {
> +	void __iomem *base;
> +	struct irq_domain *domain;
> +	struct irq_chip chip;
> +};
> +
> +static struct lpc32xx_irq_chip *lpc32xx_mic_data;
> +
> +static inline u32 lpc32xx_ic_read(struct irq_domain *id, u32 reg)
> +{
> +	struct lpc32xx_irq_chip *ic = (struct lpc32xx_irq_chip *)id->host_data;

Nit: No need for a cast.

Also, it is a bit weird to use the domain as the anchor for your
chip-specific data. You end up following two pointers to get to it in
most cases (irq_data -> domain -> chip), which could be avoided by using
irq_data->chip_data.

> +
> +	return readl(ic->base + reg);

You should be able to use *_relaxed accessors.

> +}
> +
> +static inline void lpc32xx_ic_write(struct irq_domain *id, u32 reg, u32 val)
> +{
> +	struct lpc32xx_irq_chip *ic = (struct lpc32xx_irq_chip *)id->host_data;
> +
> +	writel(val, ic->base + reg);
> +}
> +
> +static void lpc32xx_irq_mask(struct irq_data *d)
> +{
> +	u32 val, mask = BIT(d->hwirq);
> +
> +	val = lpc32xx_ic_read(d->domain, LPC32XX_INTC_MASK) & ~mask;
> +	lpc32xx_ic_write(d->domain, LPC32XX_INTC_MASK, val);
> +}
> +
> +static void lpc32xx_irq_unmask(struct irq_data *d)
> +{
> +	u32 val, mask = BIT(d->hwirq);
> +
> +	val = lpc32xx_ic_read(d->domain, LPC32XX_INTC_MASK) | mask;
> +	lpc32xx_ic_write(d->domain, LPC32XX_INTC_MASK, val);
> +}
> +
> +static void lpc32xx_irq_ack(struct irq_data *d)
> +{
> +	u32 mask = BIT(d->hwirq);
> +
> +	lpc32xx_ic_write(d->domain, LPC32XX_INTC_RAW, mask);
> +}
> +
> +static int lpc32xx_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +	struct irq_domain *domain = d->domain;
> +	u32 val, mask = BIT(d->hwirq);
> +	bool high, edge;
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		edge = true;
> +		high = true;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		edge = true;
> +		high = false;
> +		break;
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		edge = false;
> +		high = true;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		edge = false;
> +		high = false;
> +		break;
> +	default:
> +		pr_info("unsupported irq type %d\n", type);
> +		return -EINVAL;
> +	}
> +
> +	irqd_set_trigger_type(d, type);
> +
> +	val = lpc32xx_ic_read(domain, LPC32XX_INTC_POL);
> +	if (high)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +	lpc32xx_ic_write(domain, LPC32XX_INTC_POL, val);
> +
> +	val = lpc32xx_ic_read(domain, LPC32XX_INTC_TYPE);
> +	if (edge) {
> +		val |= mask;
> +		irq_set_handler_locked(d, handle_edge_irq);
> +	} else {
> +		val &= ~mask;
> +		irq_set_handler_locked(d, handle_level_irq);
> +	}
> +	lpc32xx_ic_write(domain, LPC32XX_INTC_TYPE, val);
> +
> +	return 0;
> +}
> +
> +static void __exception_irq_entry lpc32xx_handle_irq(struct pt_regs *regs)
> +{
> +	u32 hwirq;
> +
> +	do {
> +		hwirq = lpc32xx_ic_read(lpc32xx_mic_data->domain,
> +					LPC32XX_INTC_STAT);
> +		if (hwirq)
> +			handle_domain_irq(lpc32xx_mic_data->domain,
> +					  ffs(hwirq) - 1, regs);
> +	} while (hwirq);

If you imagine a case where you have multiple interrupts pending, you
only handle a single interrupt, and go back reading the status register,
which is going to be expensive.

You may want to handle all the interrupts described in your status
before looping again.

> +}
> +
> +static void lpc32xx_sic_handler(struct irq_desc *desc)
> +{
> +	struct lpc32xx_irq_chip *ic = irq_desc_get_handler_data(desc);
> +	struct irq_domain *domain = ic->domain;
> +	u32 hwirq;
> +
> +	do {
> +		hwirq = lpc32xx_ic_read(domain, LPC32XX_INTC_STAT);
> +		if (hwirq)
> +			generic_handle_irq(irq_find_mapping(domain,
> +							    ffs(hwirq) - 1));
> +	} while (hwirq);

Same here. Also, you're missing chained_irq_enter/exit.

> +}
> +
> +static int lpc32xx_irq_domain_map(struct irq_domain *id, unsigned int virq,
> +				  irq_hw_number_t hw)
> +{
> +	struct lpc32xx_irq_chip *ic = (struct lpc32xx_irq_chip *)id->host_data;
> +
> +	irq_set_chip_and_handler(virq, &ic->chip, handle_level_irq);
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_noprobe(virq);
> +

This is where you should populate the irq_data chip_data field.

> +	return 0;
> +}
> +
> +static void lpc32xx_irq_domain_unmap(struct irq_domain *id, unsigned int virq)
> +{
> +	irq_set_chip_and_handler(virq, NULL, NULL);
> +}
> +
> +static const struct irq_domain_ops lpc32xx_irq_domain_ops = {
> +	.map    = lpc32xx_irq_domain_map,
> +	.unmap	= lpc32xx_irq_domain_unmap,
> +	.xlate  = irq_domain_xlate_twocell,
> +};
> +
> +static int __init lpc32xx_of_ic_init(struct device_node *node,
> +				     struct device_node *parent)
> +{
> +	int parent_irq, i;
> +	struct lpc32xx_irq_chip *irqc;
> +
> +	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
> +	if (!irqc)
> +		return -ENOMEM;
> +
> +	irqc->chip.irq_ack = lpc32xx_irq_ack;
> +	irqc->chip.irq_mask = lpc32xx_irq_mask;
> +	irqc->chip.irq_unmask = lpc32xx_irq_unmask;
> +	irqc->chip.irq_set_type = lpc32xx_irq_set_type;
> +	irqc->chip.name = of_get_property(node, "interrupt-controller-name",
> +					  NULL);
> +
> +	irqc->base = of_iomap(node, 0);
> +	if (!irqc->base) {
> +		pr_err("%s: unable to map registers\n", node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	irqc->domain = irq_domain_add_linear(node, IRQS_PER_CONTROLLER,
> +					     &lpc32xx_irq_domain_ops, irqc);
> +	if (!irqc->domain) {
> +		pr_err("unable to add irq domain\n");
> +		iounmap(irqc->base);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < of_irq_count(node); i++) {
> +		parent_irq = irq_of_parse_and_map(node, i);
> +		if (parent_irq)
> +			irq_set_chained_handler_and_data(parent_irq,
> +						 lpc32xx_sic_handler, irqc);
> +	}
> +
> +	if (of_device_is_compatible(node, "nxp,lpc3220-mic")) {
> +		lpc32xx_mic_data = irqc;
> +		set_handle_irq(lpc32xx_handle_irq);
> +	}
> +
> +	lpc32xx_ic_write(irqc->domain, LPC32XX_INTC_MASK, 0x00);
> +	lpc32xx_ic_write(irqc->domain, LPC32XX_INTC_POL, 0x00);
> +	lpc32xx_ic_write(irqc->domain, LPC32XX_INTC_TYPE, 0x00);
> +
> +	return 0;
> +}
> +IRQCHIP_DECLARE(nxp_lpc32xx_mic, "nxp,lpc3220-mic", lpc32xx_of_ic_init);
> +IRQCHIP_DECLARE(nxp_lpc32xx_sic, "nxp,lpc3220-sic", lpc32xx_of_ic_init);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
