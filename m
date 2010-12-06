From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Dec 2010 12:11:38 +0100 (CET)
Subject: [PATCH 3/5] msm: timer: SMP timer support for msm
In-Reply-To: <20101206102046.GD29563@n2100.arm.linux.org.uk>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-4-git-send-email-johlstei@codeaurora.org>
	<alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
	<20101206102046.GD29563@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1012061156100.2653@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Dec 2010, Russell King - ARM Linux wrote:

> On Mon, Dec 06, 2010 at 10:56:14AM +0100, Thomas Gleixner wrote:
> > > +	local_irq_save(flags);
> > > +	get_irq_chip(clock->irq.irq)->unmask(clock->irq.irq);
> > 
> > Why are you fiddling wiht the irqchip functions directly ? Please use
> > disable_irq/enable_irq if at all.
> 
> PPI.  The interrupt has to be enabled by the very same CPU that wants
> to receive the interrupt.  Other CPUs on the system do not have access
> to the interrupt enable bits for PPIs.

That's fine, but the code is called on that very cpu anyway, so
enable_irq() ends up calling the very same chip->unmask()
 
> That's something which genirq can't handle because it doesn't _actually_
> support real per-CPU interrupts - iow, ones which are truely private to
> CPU N.

So what you want to avoid are the enable/disable_irq() side effects
(setting/clearing the IRQ_DISABLED flags etc.) as they would apply to
the other cpus as well - which would be bogus of course.

We could actually solve that in the genirq code in a halfways simple
way. Now that we get the references to the irq descriptors via
irq_to_desc() we could add a function which marks an irq as percpu and
use the main irq descriptor as a place holder which allocates percpu
memory for the real descriptors. irq_to_desc() would lookup the main
descriptor and hand back the one for the current cpu if the percpu
pointer is set. That would allow you to use the generic functions at
least with some care (functions need to be called from migration
disabled code).

Thanks,

	tglx

 
