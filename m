From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Nov 2018 08:10:27 +0000
Subject: [PATCH 09/16] irqchip: Add RDA8810PL interrupt driver
In-Reply-To: <20181120031958.GB5885@Mani-XPS-13-9360>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-10-manivannan.sadhasivam@linaro.org>
 <29ddffae-b61b-be92-c235-a79ecdf7512c@arm.com>
 <20181120031958.GB5885@Mani-XPS-13-9360>
Message-ID: <86r2fgrwy4.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[dropping the @rdamicro.com addresses, as they bounce...]

On Tue, 20 Nov 2018 03:19:58 +0000,
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> Hi Marc,
> 
> Thanks for the quick review!
> 
> On Mon, Nov 19, 2018 at 05:36:49PM +0000, Marc Zyngier wrote:
> > Manivannan,
> > 
> > On 19/11/2018 17:09, Manivannan Sadhasivam wrote:

> > > +static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
> > > +{
> > > +	if (flow_type & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
> > > +		irq_set_handler(data->irq, handle_edge_irq);
> > > +	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> > > +		irq_set_handler(data->irq, handle_level_irq);
> > 
> > So you don't need to set anything in your interrupt controller for this
> > to switch between level and edge? That'd be a first...
> >
> 
> Interrupt controller can only handle level triggered interrupts. Should
> I just remove irq_set_type callback itself?

No, keep it, but return -EINVAL on anything that doesn't match what
the controller actually supports.

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +struct irq_domain *rda_irq_domain;
> > 
> > static?
> > 
> 
> Ack.
> 
> > > +
> > > +static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
> > > +{
> > > +	u32 stat = readl(base + RDA_INTC_FINALSTATUS);
> > > +	u32 hwirq;
> > > +
> > > +	while (stat) {
> > > +		hwirq = __fls(stat);
> > > +		handle_domain_irq(rda_irq_domain, hwirq, regs);
> > > +		stat &= ~(1 << hwirq);
> > > +	}
> > > +}
> > > +
> > > +static struct irq_chip rda_irq_chip = {
> > > +	.name		= "rda-intc",
> > > +	.irq_ack	= rda_intc_mask_irq,
> > 
> > You're joking, right? What does it mean to implement both ack as mask
> > when you already have mask?
> > 
> 
> Right, but I just followed what other drivers were doing (irq-sa11x0). Will
> remove it.

As usual, seeing something in another driver doesn't mean it is
right. Also, StrongARM is an interesting piece of history, and taking
inspiration from it is mostly a bad idea.

[...]

> > > +static int __init rda8810_intc_init(struct device_node *node,
> > > +				    struct device_node *parent)
> > > +{
> > > +	base = of_io_request_and_map(node, 0, "rda-intc");
> > > +	if (!base)
> > > +		return -ENXIO;
> > > +	/*
> > > +	 * Mask, and invalid all interrupt sources
> > > +	 */
> > > +	writel(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
> > > +
> > > +	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
> > > +						  &rda_irq_domain_ops, base);
> > > +	WARN_ON(!rda_irq_domain);
> > 
> > Just WARN_ON(), and carry on? Please implement some error handling.
> > 
> 
> Sure. Which one would you recommend? Panic or returning -ENXIO?

Don't leak the IO space, return -ENOMEM.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
