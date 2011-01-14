From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Fri, 14 Jan 2011 19:49:32 +0100
Subject: [PATCH 01/54] ARM: core irq_data conversion.
In-Reply-To: <20110114162417.GA23154@n2100.arm.linux.org.uk>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130132532.GB15575@mail.wantstofly.org>
	<20110114162417.GA23154@n2100.arm.linux.org.uk>
Message-ID: <20110114184932.GY15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 04:24:17PM +0000, Russell King - ARM Linux wrote:

> >  static void route_irq(struct irq_desc *desc, unsigned int irq, unsigned int cpu)
> >  {
> > -	pr_debug("IRQ%u: moving from cpu%u to cpu%u\n", irq, desc->node, cpu);
> > +	pr_debug("IRQ%u: moving from cpu%u to cpu%u\n", irq, desc->irq_data.node, cpu);
> >  
> >  	raw_spin_lock_irq(&desc->lock);
> > -	desc->chip->set_affinity(irq, cpumask_of(cpu));
> > +	desc->irq_data.chip->irq_set_affinity(&desc->irq_data,
> > +					      cpumask_of(cpu), false);
> 
> Shouldn't this be 'true' to force the IRQ to move?  The old CPU is
> going down so it's not really optional.

Right, that makes sense.  Can you make that change?
