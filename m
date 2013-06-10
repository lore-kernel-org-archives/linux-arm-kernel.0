From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 10 Jun 2013 13:36:11 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVNdy_cffR7JYNVfs40QJ9eF4Y8UKL7ZsRPOTOegghFkaQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Ming Lei wrote:

> > That isn't clear.  It is documented that USB completion handlers are
> > called with local interrupts disabled.  An IRQ arriving before the
> 
> Is there any good reason to do URB giveback with interrupt disabled?

That's a good question.  Offhand I can't think of any drivers that rely
on this -- although there certainly are places where callback routines
use spin_lock() rather than spin_lock_irq() or spin_lock_irqsave(),
because they know that interrupts are already disabled.

However, changing a documented API is not something to be done lightly.  
You would have to audit _every_ USB driver to make sure no trouble
would arise.

> IMO, disabling IRQs isn't necessary for completing URB since the
> complete() of URBs for same endpoint is reentrant.

Whether it is _necessary_ isn't the point.  It is _documented_, and 
therefore it cannot be changed easily.

> > tasklet starts up might therefore be serviced during the short interval
> > before the tasklet disables local interrupts, but if that happens it
> 
> Tasklet doesn't disable local interrupts.

It is documented that interrupts will be disabled while the completion 
handler runs.  Therefore the tasklet _must_ disable local interrupts.

> > would mean that the completion handler would be delayed.
> 
> Yes, the tasklet schedule delay is introduced to URB completion, but
> the delay doesn't have much side effect about completing URB.

What about delays that occur because a separate interrupt is serviced
before the URB's completion handler is called?  With the current code
that can't happen, but with your scheme it can.

> For async transfer, generally, it should have no effect since there should
> have URBs queued on the qh queue before submitting URB.

That's not how the Bulk-Only mass-storage protocol works.  There are
times when the protocol _requires_ bulk packets not to be submitted
until a particular URB has completed.

Since mass-storage is an important use case for USB, its requirements 
should not be ignored.

> > In effect, you are prioritizing other IRQs higher than USB completion
> > handlers.
> 
> Both other IRQs and HCD's IRQ are prioritizing the URB completion.

I don't understand that sentence.  "Prioritizing" means "assigning a 
priority to".  IRQs and HCDs don't assign priorities to anything; 
priorities are assigned by human programmers.

> > Nevertheless, the total time spent with interrupts disabled
> > will remain the same.
> 
> No, the total time spent with interrupts disabled does not remain same,
> since no local IRQs are disabled during URB giveback anymore.

That is a bug.  Local IRQs must be disabled during URB giveback.

> > (There's one other side effect that perhaps you haven't considered.
> > When multiple URBs are addressed to the same endpoint, their completion
> > handlers are called in order of URB completion, which is the same as
> > the order of URB submission unless an URB is cancelled.  By delegating
> > the completion handlers to tasklets, and particularly by using per-CPU
> > tasklets, you may violate this behavior.)
> 
> Even though URB giveback is handled by hard interrupt handler, it still can't
> guarantee that 100%,  please see below:
> 
> - interrupt for URB A comes in CPU 0, and handled, then HCD private
> lock is released, and usb_hcd_giveback_urb() is called to complete URB A
> 
> - interrupt for URB B comes in CPU 1 just before CPU0 releases HCD private
> lock, so CPU1 holds the private lock when CPU 0 releases the lock and
> handles the HCD interrupt.
> 
> So now just like two CPUs are racing, if CPU0 wins, URB A is completed
> first, otherwise URB B is completed first.

Although you didn't say so, I assume you mean that A and B are URBs for 
the same endpoint.  This means they use the same host controller and 
hence they use the same IRQ line.

When an interrupt is handled, it is not possible for a second interrupt
to arrive on the same IRQ line before the handler for the first 
interrupt returns.  The kernel disables the IRQ line when the first 
interrupt occurs, and keeps it disabled until all the handlers are 
finished.  Therefore the scenario you described cannot occur.

> With introducing completing URB in percpu tasklet, the situation is
> just very similar.

No, it isn't, for the reason given above.

> On ehci hcd, it can make sure that by always letting CPU0 complete all URBs
> (use ehci->scanning/ehci->need_rescan flag), but the patch can change percpu
> tasklet to tasklet to meet the demand.

Or perhaps you could assign each endpoint to a particular tasklet.

> > As I understand it, the tradeoff between hardirq and softirq is
> > generally unimportant.  It does matter a lot in realtime settings --
> 
> I don't think so, and obviously softirq allows IRQs to be served quickly,
> otherwise why is softirq and tasklet introduced? and why so many drivers
> are using tasklet/softirq?

This is part of what I would like to hear Thomas and Steve comment on.

Alan Stern
