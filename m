From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 11 Jun 2013 15:45:25 +0200 (CEST)
Subject: [PATCH v3 1/6] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <51B7280B.7080604@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1370536034-23956-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.LFD.2.02.1306111045520.22970@ionos>
 <alpine.LFD.2.02.1306111525180.22970@ionos>
 <51B7280B.7080604@gmail.com>
Message-ID: <alpine.LFD.2.02.1306111539310.22970@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jun 2013, Sebastian Hesselbarth wrote:

> On 06/11/13 15:30, Thomas Gleixner wrote:
> > On Tue, 11 Jun 2013, Thomas Gleixner wrote:
> > 
> > > On Thu, 6 Jun 2013, Sebastian Hesselbarth wrote:
> > > 
> > > > This patch adds an irqchip driver for the main interrupt controller
> > > > found
> > > > on Marvell Orion SoCs (Kirkwood, Dove, Orion5x, Discovery Innovation).
> > > > Corresponding device tree documentation is also added.
> > > > 
> > > > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > 
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Second thoughts:
> > 
> > > +static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc
> > > *desc)
> > > +{
> > > +	struct irq_domain *d = irq_get_handler_data(irq);
> > > +	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, irq);
> > > +	u32 stat = readl_relaxed(gc->reg_base + ORION_BRIDGE_IRQ_CAUSE) &
> > > +		gc->mask_cache;
> > 
> > In init you map the first irq of that chip and install the chain
> > handler for it. Now if that first irq fires, isn't that set in the
> > cause register as well? And what acks that first irq?
> 
> It is "acked" by acking all unmasked bridge irqs.

Ok. A comment would be nice.

But what about the bit in of that first irq in the cause register? If
it's set on entry you call generic_handle_irq() for that as well. So
if it's set you need to mask it in stat. If not, then it wants a
comment.

Thanks,

	tglx
