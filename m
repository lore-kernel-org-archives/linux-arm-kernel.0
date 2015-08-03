From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 3 Aug 2015 16:36:29 +0200 (CEST)
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <20150803153004.4a74d99a@bbrezillon>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
 <alpine.DEB.2.11.1507201103550.18576@nanos> <20150720193726.GJ15539@piout.net>
 <alpine.DEB.2.11.1507202245310.18576@nanos>
 <alpine.DEB.2.11.1508021100390.3825@nanos>
 <20150802094028.GN12596@twins.programming.kicks-ass.net>
 <20150803153004.4a74d99a@bbrezillon>
Message-ID: <alpine.DEB.2.11.1508031619230.3825@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Aug 2015, Boris Brezillon wrote:
> On Sun, 2 Aug 2015 11:40:28 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Aug 02, 2015 at 11:10:21AM +0200, Thomas Gleixner wrote:
> > > I think Boris Brezillon had implemented it at some point, but it was
> > > shot down for reasons I can't remember. 
> > 
> > You weren't around at the time.. DT people didn't like it, said they
> > didn't like having to make up fake hardware in their DT crap.
> 
> I don't know who was right, but the fact is they won't be inclined to
> take such an approach unless the virtual demuxer is not exposed in the
> DT, which is almost impossible since irq users are identifying their
> irq lines with a phandle to the interrupt controller and an interrupt
> id (usually extracted from the datasheet).

I really have no idea why DT folks think that virtual devices are not
suitable for DT entries. Marks working assumption from the old thread:

 > This sounds like a DT-workaround for a Linux implementation problem,
 > and I don't think this the right way to solve your problem.

is simply wrong. This has nothing to do with a Linux implementation
problem. It's a sensible workaround for braindamaged hardware at the
proper abstraction level.

> Anyway, below is a solution providing a way to disable specific
> handlers without reworking the way we are modeling shared interrupts.
> Thomas, I know you were not in favor of the proposed approach, but,
> AFAICT, it does not add any conditional path to the interrupt handling
> path (which, IIRC, was one of your requirements), and is simple enough
> to be used by people really needing it.
> 
> There's probably other drawback I haven't noticed, so please don't
> hesitate to share your thoughts.

Yes, aside of the bloat, it needs special handling in free_irq() as
well.

Thanks,

	tglx
