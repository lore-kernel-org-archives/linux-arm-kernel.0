From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 22:54:23 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <1259617331.2076.146.camel@pasglop>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<1259611151.2076.101.camel@pasglop>
	<alpine.LFD.2.00.0911302225050.24119@localhost.localdomain>
	<1259617331.2076.146.camel@pasglop>
Message-ID: <alpine.LFD.2.00.0911302253570.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Dec 2009, Benjamin Herrenschmidt wrote:
> On Mon, 2009-11-30 at 22:31 +0100, Thomas Gleixner wrote:
> 
> > Are the perf events on power generally coming through the standard irq
> > handler code path and/or sensitive to local_irq_disable() ?
> 
> They are in HW yes. On ppc64, we do soft-disabling, which mean that we
> can still get the perf events within a local_irq_disable() region
> provided we don't get another interrupt within that region that forces
> us to hard disable so it would make the problem less bad I suppose.
> 
> > > I would suggest we timestamp the handlers in the core btw and warn
> > if
> > > they take too long so we get a chance to track down the bad guys.
> > 
> > The hassle is to find a time which we think is appropriate as a
> > threshold which is of course depending on the cpu power of a
> > system. Also I wonder whether we'd need to make such a warning thing
> > aware of irq nesting.
> 
> But if we always disable interrupts while running the handlers, we don't
> nest right ?

Right, in that case we do not and it's easy to instrument.

Thanks,

	tglx
