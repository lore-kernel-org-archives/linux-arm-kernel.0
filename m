From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 28 Nov 2009 22:50:02 +0100 (CET)
Subject: [PATCH] warn about shared irqs requesting IRQF_DISABLED registered
	with setup_irq
In-Reply-To: <20091128200344.GA1272@pengutronix.de>
References: <20091127195857.GB28193@n2100.arm.linux.org.uk>
	<1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911272234460.24119@localhost.localdomain>
	<20091128200344.GA1272@pengutronix.de>
Message-ID: <alpine.LFD.2.00.0911282239430.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Nov 2009, Uwe Kleine-K?nig wrote:

> On Fri, Nov 27, 2009 at 11:18:00PM +0100, Thomas Gleixner wrote:
> > On Fri, 27 Nov 2009, Uwe Kleine-K?nig wrote:
> > 
> > > IRQF_DISABLED is not guaranteed on shared irqs.  There is already a
> > > warning in place for irqs registered with request_irq (introduced in
> > > 470c66239ef03).  Move it to __setup_irq, this way it triggers for both
> > > request_irq and setup_irq.
> > > 
> > > One irq that is now warned about is the timer tick on at91 (ARCH=arm).
> > 
> > And how does that help ? The interrupt is shared between the timer and
> > the debug port. There is nothing you can do about that.
> > 
> > The interupt handlers are called in order of setup. The AT91 timer
> > irq is set up first and if that's not the case then it needs to be
> > fixed and the only way to catch it is in the affected interrupt
> > handler.
>
> Russell already suggests to save (and restore) irqs in the handler
> before (and after resp.) calling the clockevent functions.

What about analysing the code and verifying that the setup order is
correct ?

Adding save/restore_irq just because you have no clue what the code
does is utter nonsense.

Thanks,

	tglx
