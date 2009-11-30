From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 01 Dec 2009 06:59:11 +1100
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
Message-ID: <1259611151.2076.101.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-30 at 15:24 +0100, Thomas Gleixner wrote:
> 
> > Except I guess that will upset some of the IRQ priority folks, like
> > power, where they (iirc) have a stack per irq prio level.
> 
> Is that actually used ? Ben ?

Nah, we have 2 dedicated stacks.. one for external interrupts and one
for softirq. On embedded we also have a separate stack for the critical
interrupts and machine checks but both are special (critical interrupts
are aking to FIQ on ARM).

> > But its not like the core kernel knows about these nesting rules and
> can actually track any of that muck.
> 
> True.

Well, thing is, in cases where we have a sane PIC, the PIC itself is
perfectly good at keeping the source and anything of the same priority
or lower masked while we handle an irq.

So disabling local CPU IRQs will basically add an unnecessary blocking
of both timer interrupts and perfmon interrupts while doing so.

Yes, all driver interrupt handlers -should- be only running short amount
of code in their handlers but you know how it is. The drift introduced
on timer and perfmon events can be a problem, the later might even make
it difficult to figure out what an -interrupt- is taking more time than
it should.

I would suggest we timestamp the handlers in the core btw and warn if
they take too long so we get a chance to track down the bad guys.

Cheers,
Ben.
