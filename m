From: jamie@shareable.org (Jamie Lokier)
Date: Sun, 29 Nov 2009 15:18:40 +0000
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED
	registered with setup_irq
In-Reply-To: <20091129102635.GA22653@pengutronix.de>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
	<alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
	<20091129023118.GA21529@shareable.org>
	<20091129102635.GA22653@pengutronix.de>
Message-ID: <20091129151840.GA30813@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Sun, Nov 29, 2009 at 02:31:18AM +0000, Jamie Lokier wrote:
> > Thomas Gleixner wrote:
> > > What about analysing the code and verifying that the setup order is
> > > correct ?
> > > 
> > > Adding save/restore_irq just because you have no clue what the code
> > > does is utter nonsense.
> > 
> > Wouldn't it be quite a lot nicer if generic setup moved the
> > IRQF_DISABLED handler to be first in the list, if that actually works
> > in a useful way rather than simply being a quirk that irqs are
> > disabled for the first one?
> Hmm, what happens if an ISR runs with irqs disabled even though it
> doesn't expect it?  I wouldn't bet that nothing breaks.

Moving the IRQF_DISABLED handler to be first will run an ISR with
interrupts disabled which *does* expect it, so that's good.

According to this thread, at the moment when you have multiple
IRQF_DISABLED|IRQF_SHARED ISRs, only the first one is run with
interrupts disabled.

In fact I don't see why the kernel cannot put _all_ of the
IRQ_DISABLED handlers at the beginning of the list, traverse those
with interrupts disabled, then enable interrupts them for the
remaining handlers.

> IMHO the best is if a warning is printed or registering fails if shared
> irq actions don't agree about wanting IRQF_DISABLED.

On the hardware in question, the debug and timer interrupts share a
line, and I'm guessing only the timer interrupt should have IRQF_DISABLED.

Or we could do away with this silliness and just switch everything to
threaded interrupts with RT-priorities ;-)

-- Jamie
