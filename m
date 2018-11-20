From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 20 Nov 2018 08:49:58 +0530
Subject: [PATCH 09/16] irqchip: Add RDA8810PL interrupt driver
In-Reply-To: <29ddffae-b61b-be92-c235-a79ecdf7512c@arm.com>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-10-manivannan.sadhasivam@linaro.org>
 <29ddffae-b61b-be92-c235-a79ecdf7512c@arm.com>
Message-ID: <20181120031958.GB5885@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks for the quick review!

On Mon, Nov 19, 2018 at 05:36:49PM +0000, Marc Zyngier wrote:
> Manivannan,
> 
> On 19/11/2018 17:09, Manivannan Sadhasivam wrote:
> > Add interrupt driver for RDA Micro RDA8810PL SoC.
> > 
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/mach-rda/Kconfig      |   1 +
> >  drivers/irqchip/Kconfig        |   4 ++
> >  drivers/irqchip/Makefile       |   1 +
> >  drivers/irqchip/irq-rda-intc.c | 116 +++++++++++++++++++++++++++++++++
> >  4 files changed, 122 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-rda-intc.c
> > 
> > diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> > index dafab78d7aab..29012bc68ca4 100644
> > --- a/arch/arm/mach-rda/Kconfig
> > +++ b/arch/arm/mach-rda/Kconfig
> > @@ -3,5 +3,6 @@ menuconfig ARCH_RDA
> >  	depends on ARCH_MULTI_V7
> >  	select COMMON_CLK
> >  	select GENERIC_IRQ_CHIP
> > +	select RDA_INTC
> >  	help
> >  	  This enables support for the RDA Micro 8810PL SoC family.
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 51a5ef0e96ed..9d54645870ad 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -195,6 +195,10 @@ config JCORE_AIC
> >  	help
> >  	  Support for the J-Core integrated AIC.
> >  
> > +config RDA_INTC
> > +	bool
> > +	select IRQ_DOMAIN
> > +
> >  config RENESAS_INTC_IRQPIN
> >  	bool
> >  	select IRQ_DOMAIN
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 794c13d3ac3d..417108027e40 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
> >  obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
> >  obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
> >  obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
> > +obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> > diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
> > new file mode 100644
> > index 000000000000..89be55a11823
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-rda-intc.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * RDA8810PL SoC irqchip driver
> > + *
> > + * Copyright RDA Microelectronics Company Limited
> > + * Copyright (c) 2017 Andreas F?rber
> > + * Copyright (c) 2018 Manivannan Sadhasivam
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_address.h>
> > +
> > +#include <asm/irq.h>
> > +#include <asm/exception.h>
> > +
> > +#define RDA_INTC_FINALSTATUS	0x00
> > +#define RDA_INTC_STATUS		0x04
> > +#define RDA_INTC_MASK_SET	0x08
> > +#define RDA_INTC_MASK_CLR	0x0c
> > +#define RDA_INTC_WAKEUP_MASK	0x18
> > +#define RDA_INTC_CPU_SLEEP	0x1c
> > +
> > +#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
> > +
> > +#define RDA_NR_IRQS 32
> > +
> > +void __iomem *base;
> 
> Should be static?
> 

Ack.

> > +
> > +static void rda_intc_mask_irq(struct irq_data *d)
> > +{
> > +	void __iomem *base = (void __iomem *)irq_data_get_irq_chip_data(d);
> 
> Aliases with the above. Please choose whether you want a global or a
> per-interrupt base.
> 

My bad. I wanted to have a global interrupt base for rda_handle_irq.
Will remove the per interrupt base.

> > +
> > +	writel(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);
> 
> writel_relaxed()
> 

Ack.

> > +}
> > +
> > +static void rda_intc_unmask_irq(struct irq_data *d)
> > +{
> > +	void __iomem *base = (void __iomem *)irq_data_get_irq_chip_data(d);
> > +
> > +	writel(BIT(d->hwirq), base + RDA_INTC_MASK_SET);
> 
> Same here.

Ack.

> 
> > +}
> > +
> > +static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
> > +{
> > +	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
> > +		irq_set_handler(data->irq, handle_edge_irq);
> > +	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> > +		irq_set_handler(data->irq, handle_level_irq);
> 
> So you don't need to set anything in your interrupt controller for this
> to switch between level and edge? That'd be a first...
>

Interrupt controller can only handle level triggered interrupts. Should
I just remove irq_set_type callback itself?

> > +
> > +	return 0;
> > +}
> > +
> > +struct irq_domain *rda_irq_domain;
> 
> static?
> 

Ack.

> > +
> > +static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
> > +{
> > +	u32 stat = readl(base + RDA_INTC_FINALSTATUS);
> > +	u32 hwirq;
> > +
> > +	while (stat) {
> > +		hwirq = __fls(stat);
> > +		handle_domain_irq(rda_irq_domain, hwirq, regs);
> > +		stat &= ~(1 << hwirq);
> > +	}
> > +}
> > +
> > +static struct irq_chip rda_irq_chip = {
> > +	.name		= "rda-intc",
> > +	.irq_ack	= rda_intc_mask_irq,
> 
> You're joking, right? What does it mean to implement both ack as mask
> when you already have mask?
> 

Right, but I just followed what other drivers were doing (irq-sa11x0). Will
remove it.

> > +	.irq_mask	= rda_intc_mask_irq,
> > +	.irq_unmask	= rda_intc_unmask_irq,
> > +	.irq_set_type	= rda_intc_set_type,
> > +	.irq_disable	= rda_intc_mask_irq,
> 
> What is this disable for? Implementing enable/disable only makes sense
> if their different implementation differs from mask/unmask (and that
> they add some real value, such as allocating resource).
> 

Okay. Will remove this callback also.

> > +};
> > +
> > +static int rda_irq_map(struct irq_domain *d,
> > +		       unsigned int virq, irq_hw_number_t hw)
> > +{
> > +	irq_set_status_flags(virq, IRQ_LEVEL);
> > +	irq_set_chip_and_handler(virq, &rda_irq_chip, handle_level_irq);
> 
> The set_type callback is specially puzzling when you set everything to
> be level...
> 

As said above, set_type callback will be removed since the hardware
can't handle any other interrupt types.

> > +	irq_set_chip_data(virq, d->host_data);
> > +	irq_set_probe(virq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops rda_irq_domain_ops = {
> > +	.map = rda_irq_map,
> > +	.xlate = irq_domain_xlate_onecell,
> 
> ... and don't have any way to express an edge interrupt in DT.
> 

Above comment applies here.

> > +};
> > +
> > +static int __init rda8810_intc_init(struct device_node *node,
> > +				    struct device_node *parent)
> > +{
> > +	base = of_io_request_and_map(node, 0, "rda-intc");
> > +	if (!base)
> > +		return -ENXIO;
> > +	/*
> > +	 * Mask, and invalid all interrupt sources
> > +	 */
> > +	writel(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
> > +
> > +	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
> > +						  &rda_irq_domain_ops, base);
> > +	WARN_ON(!rda_irq_domain);
> 
> Just WARN_ON(), and carry on? Please implement some error handling.
> 

Sure. Which one would you recommend? Panic or returning -ENXIO?

Thanks,
Mani

> > +
> > +	set_handle_irq(rda_handle_irq);
> > +
> > +	return 0;
> > +}
> > +
> > +IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
> > 
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
