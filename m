From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 22 Mar 2013 23:15:44 +0100
Subject: [PATCH v4 5/5] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303222055.57400.arnd@arndb.de>
References: <201303221843.37668.heiko@sntech.de>
 <201303221846.46473.heiko@sntech.de> <201303222055.57400.arnd@arndb.de>
Message-ID: <201303222315.44882.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. M?rz 2013, 21:55:57 schrieb Arnd Bergmann:
> On Friday 22 March 2013, Heiko St?bner wrote:
> > +	interrupt-controller at 4a000000 {
> > +		compatible = "samsung,s3c24xx-irq";
> > +		reg = <0x4a000000 0x100>;
> > +		interrupt-controller;
> > +
> > +		intc:intc {
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +		};
> > +
> > +		subintc:subintc {
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +		};
> > +	};
> 
> I think this is not a comformant binding because the parent node
> is marked "interrupt-controller" but does not itself have a
> #interrupt-cells property.
> 
> One way to resolve this would probably be to fold the sub-nodes into
> the parent and always use #interrupt-cells = <3> or maybe <4>
> so you can identify which sub-node the interrupt is meant for.
> 
> Also, I think you are missing a description of what the two or
> three cells represent.

yep, folding them together sounds interesting, see below.


> > +static int s3c_irq_xlate_subintc(struct irq_domain *d, struct
> > device_node *n, +			const u32 *intspec, unsigned int intsize,
> > +			irq_hw_number_t *out_hwirq, unsigned int *out_type)
> > +{
> > +	struct s3c_irq_intc *intc = d->host_data;
> > +	struct s3c_irq_intc *parent_intc = intc->parent;
> > +	struct s3c_irq_data *irq_data = &intc->irqs[intspec[0]];
> > +	struct s3c_irq_data *parent_irq_data;
> > +
> > +	int irqno;
> > +
> > +	if (WARN_ON(intsize < 3))
> > +		return -EINVAL;
> > +
> > +	*out_hwirq = intspec[0];
> > +	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> > +
> > +	irqno = irq_create_mapping(parent_intc->domain, intspec[2]);
> > +	if (irqno < 0) {
> > +		pr_err("irq: could not map parent interrupt\n");
> > +		return irqno;
> > +	}
> 
> So the third cell in this is the interrupt number of the main controller
> that the irq cascades into, while the first cell is the number of the
> cascaded controller, correct?

right

> If you want to fold everything into one node, it's probably best to
> put the irq number of the main controller into the first cell all the
> time, and use the second cell to describe the number in the second cell.

Not all main interrupts are parent interrupts, so it would be difficult to 
distinguish between main interrupts that are a parent and the ones that are 
not - is a "-1" a valid cell-value for interrupts?
	<main_irq -1 trigger_type> /* directly used main interrupt */
	<main_irq child_irq trigger_type> /* sub-interrupt */

Or are you thinking of something like:
	<main_irq is_a_parent child_irq trigger_type>


I looked a bit more thru the other irqchips and it seems the bcm2835 is doing 
something similar but without having a parent relationship:
	<controller-num irq-num>

so this could be adapted to:
	<controller-num irq-num parent-num trigger_type>

controller-num being 0 for intc, 1 for subintc, 2 intc2 . The controller 
itself knows if it's a sub- or main controller - when it should handle the 
parent-number or simply ignore it.


> The alternative would be to have three completely separate nodes,
> and then you can describe the parent-child relationship like
> 
> intc: interrupt-controller at 4a000000 {
> 	compatible = "samsung,s3c2416-intc";
> 	reg = <0x4a000000 0x18>;
> 	interrupt-controller;
> 	#interrupt-cells = <2>;
> };
> 
> subintc: interrupt-controller at 4a000018 {
> 	compatible = "samsung,s3c2416-subintc";
> 	reg = <0x4a000018 0x28>;
> 	interrupt-controller;
> 	#interrupt-cells = <3>;
> 	interrupt-parent = <&intc>;
> 	interrupts  = <28 0>, <23 0>, <15 0>, <31 0>, <16 0>, <17 0>, <18 0>, <9
> 0>; };


The first two iterations had separate nodes, but the interrupt controller 
posseses more interesting registers that are shared between all of the 
controllers, so it did sound better to have them together.

Also the interrupts property is most likely not able to accurately describe 
the parent relationship, as the interrupts are very much different in all 
s3c24xx SoCs - I would need to tell every sub-interrupt where it cascasdes 
from, because most of them do different things on different s3c24xx SoCs.

I did start with this approach, using the interrupt index as mapping for the 
hwirq - interrupts[0] for hwirq 0 and so on. But it looked ugly. Using only 
one interrupts element per sub-group would require per-SoC mapping data to be 
present in the driver, indicating that interrupts[0] is responsible for bits 
0,1,2 and so on.

Therefore the idea of handling the parent relationship in the device-nodes 
interrupt property sounds much nicer :-)


Heiko
