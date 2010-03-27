From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 09:16:02 +0000
Subject: request_irq in I2C driver causes kernel to freeze during probe,
	but if done later - no problem!
In-Reply-To: <4BAD4FDE.2010904@atmel.com>
References: <4BAD406A.7070208@atmel.com>
	<20100326232421.GG29179@n2100.arm.linux.org.uk>
	<4BAD4FDE.2010904@atmel.com>
Message-ID: <20100327091602.GH29179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 01:22:54AM +0100, Ulf Samuelsson wrote:
> Russell King - ARM Linux skrev:
> > On Sat, Mar 27, 2010 at 12:16:58AM +0100, Ulf Samuelsson wrote:
> >> If the interrupt is executing, then we would see some I2C communication
> >> as a result, but we do not see this, before the kernel freezes.
> >>
> >> The interrupt is (and should be) called on the falling edge of the
> >> interrupt.
> >>
> >> I am currently scratching my head, and need help with ideas...
> > 
> > Do you always return IRQ_HANDLED from this handler, or do you return
> > IRQ_NONE if it does no work?
> > 
> > If you always return IRQ_HANDLED even if no work was done, it could be
> > that you're spinning on this interrupt, and because you're returning
> > IRQ_HANDLED, the core interrupt handling code thinks progress is being
> > made.
> > 
> > If you return IRQ_NONE, then the "bad IRQ" detection code will kick in
> > and disable the IRQ, which should result in some further progress.
> > 
> 
> Thanks for fast reply.
> 
> This is my interrupt routine, which always return IRQ_HANDLED.
> sysfs shows that "mxt->invalid_irq_counter" is never incremented
> even after I successfully enable the interrupt in sysfs.
> 
> mxt->dwork will always access the I2C bus but we dont see that.
> 
> static irqreturn_t mxt_irq_handler(int irq, void *_mxt)
> {
> 	struct	mxt_data *mxt = _mxt;
> 	unsigned long	flags;
> 	mxt->irq_counter++;
> 	spin_lock_irqsave(&mxt->lock, flags);
> 
> 	if (mxt_valid_interrupt()) {
> 		/* Macro, always returning 1  on these boards */
> 		cancel_delayed_work(&mxt->dwork);
> 		schedule_delayed_work(&mxt->dwork, 0);
> 		mxt->valid_irq_counter++;
> 	} else {
> 		mxt->invalid_irq_counter++;
> 	}
> 	spin_unlock_irqrestore(&mxt->lock, flags);
> 
> 	return IRQ_HANDLED;

So yes, you're going to spin indefinitely when you receive the first valid
interrupt.

1. Your device raises an interrupt.
2. The CPU gets interrupted.
3. The kernel reads the IRQ number and calls your handler.
4. The handler schedules the delayed work and returns.
5. The kernel checks for any further pending interrupt, and finds the same
   interrupt is still raised, and calls your handler.
6. The handler schedules the delayed work and returns.
7. The kernel checks for any further pending interrupt, and finds the same
   interrupt is still raised, and calls your handler.
8. The handler schedules the delayed work and returns.
9. The kernel checks for any further pending interrupt, and finds the same
   interrupt is still raised, and calls your handler.
10. The handler schedules the delayed work and returns.
11. The kernel checks for any further pending interrupt, and finds the same
   interrupt is still raised, and calls your handler.
...

You must clear the interrupt, or disable the interrupt source.  Or make
use of the kernel's threaded IRQs which will deal with the interrupt
masking and running your handler in thread context for you.
