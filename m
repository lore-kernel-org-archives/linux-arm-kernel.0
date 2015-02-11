From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Feb 2015 14:14:37 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <32372622.IiYZ15O7e1@vostro.rjw.lan>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150211091159.GE7119@twins.programming.kicks-ass.net>
 <20150211111516.GB9154@leverpostej>
 <32372622.IiYZ15O7e1@vostro.rjw.lan>
Message-ID: <20150211141437.GK9154@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 02:31:18PM +0000, Rafael J. Wysocki wrote:
> On Wednesday, February 11, 2015 11:15:17 AM Mark Rutland wrote:
> > On Wed, Feb 11, 2015 at 09:11:59AM +0000, Peter Zijlstra wrote:
> > > On Tue, Feb 10, 2015 at 08:48:36PM +0000, Mark Rutland wrote:
> > > > From f390ccbb31f06efee49b4469943c8d85d963bfb5 Mon Sep 17 00:00:00 2001
> > > > From: Mark Rutland <mark.rutland@arm.com>
> > > > Date: Tue, 10 Feb 2015 20:14:33 +0000
> > > > Subject: [PATCH] genirq: allow mixed IRQF_NO_SUSPEND requests
> > > > 
> > > > In some cases a physical IRQ line may be shared between devices from
> > > > which we expect interrupts during suspend (e.g. timers) and those we do
> > > > not (e.g. anything we cut the power to). Where a driver did not request
> > > > the interrupt with IRQF_NO_SUSPEND, it's unlikely that it can handle
> > > > being called during suspend, and it may bring down the system.
> > > > 
> > > > This patch adds logic to automatically mark the irqactions for these
> > > > potentially unsafe handlers as disabled during suspend, leaving actions
> > > > with IRQF_NO_SUSPEND enabled. If an interrupt is raised on a shared line
> > > > during suspend, only the handlers requested with IRQF_NO_SUSPEND will be
> > > > called. The handlers requested without IRQF_NO_SUSPEND will be skipped
> > > > as if they had immediately returned IRQF_NONE.
> > > > 
> > > > Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > Aw gawd.. not that again.
> > 
> > I agree this isn't pretty, but at least it doesn't require the HW
> > description to know about Linux internals, and it can work for !DT
> > systems.
> > 
> > I'm really not happy with placing Linux implementation details into
> > DTBs.
> > 
> > > So Rafael and tglx went over this a few months ago I think:
> > > 
> > >   lkml.kernel.org/r/26580319.OZP7jvJnA9 at vostro.rjw.lan
> > > 
> > > is the last series I could find. Maybe Rafael can summarize?
> > 
> > I can't get at any commentary from that link, unfortunately.
> > 
> > Rafael?
> 
> Well, the commentary is not there, because both I and Thomas implicitly agreed
> on one thing: We cannot add any suspend-related checks to the interrupt handling
> hot path, because that will affect everyone including people who don't use
> suspend at all and who *really* care about interrupt handling performance.

That's fair enough, and I'm happy to avoid that by other means.

My fundamental objection(s) to the current approach is that we create a
binding for a non-existent device that people will abuse without
considering the consequences. All we will end up with is more DTBs
containing the mux regardless of wether the drivers (or hardware) are
actually safe with a shared line.

So with the changes moves out of the hot-path (e.g. with shuffling
to/from a suspended_actions list in the pm code), is there some issue
that I have not considered?

Thanks,
Mark.
