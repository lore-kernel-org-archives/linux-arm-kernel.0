From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 28 Oct 2014 21:14:40 +0100 (CET)
Subject: [PATCH 1/3] genirq: Add support for priority-drop/deactivate
 interrupt controllers
In-Reply-To: <544FF183.9030705@arm.com>
References: <1414235215-10468-1-git-send-email-marc.zyngier@arm.com>
 <1414235215-10468-2-git-send-email-marc.zyngier@arm.com>
 <alpine.DEB.2.11.1410252144170.5308@nanos> <544E67D8.3020504@arm.com>
 <alpine.DEB.2.11.1410272158160.5308@nanos>
 <544FF183.9030705@arm.com>
Message-ID: <alpine.DEB.2.11.1410282054490.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Oct 2014, Marc Zyngier wrote:
> On 28/10/14 15:32, Thomas Gleixner wrote:
> > Let me make a few assumptions and correct me if I'm wrong as usual.
> > 
> > 1) The startup/shutdown procedure for such an interrupt is the
> >    expensive mask/unmask which you want to avoid for the actual
> >    handling case
> 
> Indeed.
> 
> > 2) In case of an actual interrupt the flow (ignoring locking) is:
> > 
> >    handle_xxx_irq()
> > 
> > 	mask_irq();	/* chip->irq_mask() maps to EOI */
> > 
> > 	if (!action || irq_disabled())
> > 	   return;
> > 
> > 	handle_actions();
> > 
> > 	if (irq_threads_active() || irq_disabled())
> > 	   return;
> > 
> > 	unmask_irq();	/* chip->irq_unmask() maps to DIR */
> > 
> >   So that is handle_level_irq() with the chip callbacks being:
> > 
> >    irq_startup  = gic_unmask
> >    irq_shutdown = gic_mask
> >    irq_unmask	= gic_dir
> >    irq_mask	= gic_eoi
> 
> So while this works really well for the interrupt handling part, it will
> break [un]mask_irq(). This is because you can only write to EOI for an
> interrupt that you have ACKed just before (anything else and the GIC
> state machine goes crazy). Basically, any use for EOI/DIR outside of the
> interrupt context itself (hardirq or thread) is really dangerous.

I really doubt that the DIR invocation is dangerous outside of
interrupt context. Otherwise your threaded scheme would not work at
all as the DIR invocation happens in thread context.

The nice thing about the lazy irq disable code is that the irq_mask(),
i.e. EOI, invocation actually happens always in hard interrupt
context. We should never invoke irq_mask() from any other context if
you supply a startup/shutdown function.

> If we had a flag like IRQCHIP_UNMASK_IS_STARTUP, we could distinguish
> this particular case, but that's borderline ugly.

Indeed. But I don't think it is required. See also below.

> > 4) In the lazy irq disable case if the interrupt fires mask_irq()
> >    [EOI] is good enough to silence it.
> > 
> >    Though in the enable_irq() case you cannot rely on the automatic
> >    resend of the interrupt when you unmask [DIR]. So we need to make
> >    sure that even in the level case (dunno whether that's supported in
> >    that mode) we end up calling the irq_retrigger() callback. But
> >    that's rather simple to achieve with a new chip flag.
> 
> I think this one breaks for the same reason as above. And an interrupt
> masked with EOI cannot easily be restarted without clearing the ACTIVE
> bit (and everything becomes even more of a complete madness).

So we already established that irq_mask()/EOI will only be called from
the actual interrupt context and irq_unmask()/DIR must be safe to be
called from any context in order to make the EOI/DIR based threaded
optimization work.

So the only interesting code path is enable_irq() which invokes
irq_enable() and then the resend/retrigger machinery. 

irq_enable() calls chip->irq_unmask(), i.e. DIR. So that clears the
ACTIVE bit and then the IRQ either gets resent by hardware (in case of
level as the device interrupt is still active) or retriggered by the
irq_retrigger() callback.

I might be wrong as usual, but if there is any restriction on DIR
versus the invocation context, your whole optimization scheme is hosed
anyway.

Thanks

	tglx
