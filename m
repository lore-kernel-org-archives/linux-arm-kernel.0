From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 23:00:56 +0100
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
	<CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
Message-ID: <20110823220056.GK3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 11:53:42PM +0200, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 23, 2011 at 11:51 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> and the boot runs very slowly. ?Reverting the series merged in 56f0be
> >> appears to resolve the issue,
> >
> > In fact, the patch from:
> >
> > https://patchwork.kernel.org/patch/1083602/
> >
> > is sufficient to make the calltrace go away.
> 
> Yes, that's true but the added might_sleep() discovered an actual bug
> here, so I still think it's better to keep it there.
> 
> If proper fix is difficult, I think doing something like if
> (!in_atomic()) try_to_freeze() with big fat warning explaining what's
> broken and how it should be fixed should do it for now if the proper
> fix is gonna take some time. That way, we document what's broken where
> it's broken and get to keep the useful debugging annotation.

How does that solve it?  IRQs disabled from assembly, which doesn't touch
the preempt counter.
