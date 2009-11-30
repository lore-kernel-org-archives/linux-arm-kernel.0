From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 30 Nov 2009 15:24:40 +0100 (CET)
Subject: Get rid of IRQF_DISABLED - (was [PATCH] genirq: warn about
	IRQF_SHARED|IRQF_DISABLED)
In-Reply-To: <1259589780.26472.18.camel@laptop>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.0911301225110.24119@localhost.localdomain>
	<1259589780.26472.18.camel@laptop>
Message-ID: <alpine.LFD.2.00.0911301519120.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2009, Peter Zijlstra wrote:
> On Mon, 2009-11-30 at 14:54 +0100, Thomas Gleixner wrote:
> > The correct solution IMNSHO is to get rid of IRQF_DISABLED and run
> > interrupt handlers always with interrupts disabled and require them
> > not to reenable interrupts themself.
> > 
> > Thoughts ?
> 
> I'm all for removing that brain damage:
> 
>   http://lkml.org/lkml/2009/3/2/33

Darn, I knew that we discussed that before, but my memory tricked me
into believing that it was years ago :)

> We should convert the broken hardware PIO and 3com interrupt things to
> threaded interrupts, and simply mandate all IRQ handlers run short and
> with IRQs disabled.

The ide stuff seems to be the only one which uses
local_irq_enable_in_hardirq() so that at least it tripped over lockdep
already.

What's the 3com wreckage about ?

> Except I guess that will upset some of the IRQ priority folks, like
> power, where they (iirc) have a stack per irq prio level.

Is that actually used ? Ben ?
 
> But its not like the core kernel knows about these nesting rules and can
> actually track any of that muck.

True.

	tglx
 
