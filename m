From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 17:02:41 +0000
Subject: [PATCH 04/15] ARM: mxs: Add interrupt support
In-Reply-To: <20101130135623.GH20449@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-5-git-send-email-shawn.guo@freescale.com>
	<20101130135623.GH20449@pengutronix.de>
Message-ID: <20101130170241.GD2377@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 02:56:23PM +0100, Uwe Kleine-K?nig wrote:
> > +	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> > +	ldr	\base, =icoll_base
> Maybe it's worth to hardcode the base address if only a single cpu is
> compiled in?  And what about setting the base register in
> get_irqnr_preamble?
> 
> > +	ldr	\base, [\base]
> > +	ldr	\irqnr, [\base, #0x70]
> > +	cmp	\irqnr, #0x7F
> > +	moveqs	\irqnr, #0
> Hmm, you only need that cmp+moveqs because you cannot be sure that an
> irq is pending, right.  Maybe it would make sense not to check for irqs
> in a loop?  (This is a arm-global thing, Russell?)  (BTW, you're lucky,
> for your irq controller it's only ugly to check if there is an irq
> pending.  IIRC ns9xxx has a race here.)

It always makes sense to check for more IRQs after you've processed
the first one before returning.  Entering and exiting from the calling
context is very expensive compared to looping back to check for further
interrupts.

It's also possible for interrupts to be received on a core, but there
to be no IRQ pending in the controller.  So you can't guarantee that
you have work to do just because the CPU entered the IRQ vector.  This
is especially true with level-activated IRQ sources.
