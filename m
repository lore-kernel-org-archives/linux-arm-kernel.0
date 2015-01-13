From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 13 Jan 2015 18:00:17 +0100
Subject: [RFC PATCH] irqchip: add dumb demultiplexer implementation
In-Reply-To: <alpine.DEB.2.11.1501131117120.17382@nanos>
References: <alpine.DEB.2.11.1412162125000.17382@nanos>
 <1420725159-20720-1-git-send-email-boris.brezillon@free-electrons.com>
 <alpine.DEB.2.11.1501131117120.17382@nanos>
Message-ID: <20150113180017.66efeda7@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jan 2015 11:38:14 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > +/**
> > + *	handle_dumb_demux_irq - Dumb demuxer irq handle function.
> > + *	@irq:	the interrupt number
> > + *	@desc:	the interrupt description structure for this irq
> > + *
> > + *	Dumb demux interrupts are sent from a demultiplexing interrupt handler
> > + *	which is not able to decide which child interrupt interrupt handler
> > + *	should be called.
> > + *
> > + *	Note: The caller is expected to handle the ack, clear, mask and
> > + *	unmask issues if necessary.
> > + */
> > +irqreturn_t
> > +handle_dumb_demux_irq(unsigned int irq, struct irq_desc *desc)
> > +{
> > +	irqreturn_t retval = IRQ_NONE;
> > +
> > +	raw_spin_lock(&desc->lock);
> > +
> > +	if (!irq_may_run(desc))
> > +		goto out_unlock;
> > +
> > +	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
> > +	kstat_incr_irqs_this_cpu(irq, desc);
> > +
> > +	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
> > +		desc->istate |= IRQS_PENDING;
> > +		goto out_unlock;
> > +	}
> > +
> > +	retval = handle_irq_event_no_spurious_check(desc);
> > +
> > +out_unlock:
> > +	raw_spin_unlock(&desc->lock);
> > +
> > +	return retval;
> > +}
> > +EXPORT_SYMBOL_GPL(handle_dumb_demux_irq);
> 
> This should go into the new file as well, so it gets compiled out when
> not enabled.

Actually, I can't move that function out of kernel/irq/chip.c because
it calls irq_may_run which is statically defined in this file.
Should I export this function or just enclose it in a
#ifdef DUMB_IRQ_DEMUX section ?


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
