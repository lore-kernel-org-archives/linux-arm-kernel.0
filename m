From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 22:31:20 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <1259611151.2076.101.camel@pasglop>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
	<alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
	<1259611151.2076.101.camel@pasglop>
Message-ID: <alpine.LFD.2.00.0911302225050.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Dec 2009, Benjamin Herrenschmidt wrote:
> Well, thing is, in cases where we have a sane PIC, the PIC itself is
> perfectly good at keeping the source and anything of the same priority
> or lower masked while we handle an irq.

Unfortunately the majority of PICs does not fall into that category.
 
> So disabling local CPU IRQs will basically add an unnecessary blocking
> of both timer interrupts and perfmon interrupts while doing so.
> 
> Yes, all driver interrupt handlers -should- be only running short amount
> of code in their handlers but you know how it is. The drift introduced
> on timer and perfmon events can be a problem, the later might even make
> it difficult to figure out what an -interrupt- is taking more time than
> it should.

The timer problem only affects the old style tick/jiffies driven
hardware where you have no continous clock source for keeping track of
time. Even x86 managed to do something about that recently :)

Are the perf events on power generally coming through the standard irq
handler code path and/or sensitive to local_irq_disable() ?

> I would suggest we timestamp the handlers in the core btw and warn if
> they take too long so we get a chance to track down the bad guys.

The hassle is to find a time which we think is appropriate as a
threshold which is of course depending on the cpu power of a
system. Also I wonder whether we'd need to make such a warning thing
aware of irq nesting.

Thanks,

	tglx
