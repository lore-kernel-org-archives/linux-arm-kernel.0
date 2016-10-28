From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 28 Oct 2016 21:55:03 +0200 (CEST)
Subject: [PATCH v2] irqchip/bcm2836: Prevent spurious interrupts
In-Reply-To: <87bmy4qxnb.fsf@eliezer.anholt.net>
References: <20161027182038.11312-1-eric@anholt.net>
 <alpine.DEB.2.20.1610281257230.4896@nanos>
 <87bmy4qxnb.fsf@eliezer.anholt.net>
Message-ID: <alpine.DEB.2.20.1610282141030.5053@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Oct 2016, Eric Anholt wrote:

> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Thu, 27 Oct 2016, Eric Anholt wrote:
> >
> >> From: Phil Elwell <phil@raspberrypi.org>
> >> 
> >> The old arch-specific IRQ macros included a dsb to ensure the

Which old arch-specific macros?

> >> write to clear the mailbox interrupt completed before returning
> >> from the interrupt.

That's not what the patch does. It makes sure that the interrupt it cleared
_before_ the IPI handler is called.

> >> The BCM2836 irqchip driver needs the same precaution to avoid
> >> spurious interrupts.

Please describe issues proper. Something like this:

  The interrupt demultiplexer code clears a pending mailbox interrupt by
  writing the pending bit back to the hardware, but it does not ensure that
  the write is completed before proceeding. This causes the machine to
  catch fire and scares my cat. <<-- Replace by a proper description.

  The write() macro which was used, when the driver was developed,
  contained the necessary data sycnhronization barrier, but it was replaced
  by writel() when the driver got merged without adding the explicit
  barrier after the write.

  Add and document the barrier.

Can you spot the difference?

>  		writel(1 << ipi, mailbox0);

		/* Barriers need to be documented with a comment */

> +		dsb(sy);
> 		handle_IPI(ipi, regs);

> > This is missing a fixes tag. I have no idea when that problem was
> > introduced, so I have no way to decide whether this needs to be tagged
> > stable or not.
> 
> This code has been there since introduction of the driver, so:
> 
> Fixes: 1a15aaa998dc ("irqchip: Add bcm2836 interrupt controller for Raspberry Pi 2")

So it want's a stable tag, right?
 
Thanks,

	tglx
