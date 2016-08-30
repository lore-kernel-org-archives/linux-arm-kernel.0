From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 18:32:25 +0100
Subject: [PATCH] arm/perf: Fix pmu percpu irq handling at hotplug.
In-Reply-To: <20160826094800.GD13554@arm.com>
References: <CALJ9ZPMixfGKspzaz+vTGQZG4EaQB5Futss-aC-Z+8oztVX9Nw@mail.gmail.com>
 <20160819142514.GB28422@leverpostej>
 <20160826094800.GD13554@arm.com>
Message-ID: <20160830173224.GN1223@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 26, 2016 at 10:48:00AM +0100, Will Deacon wrote:
> On Fri, Aug 19, 2016 at 03:25:14PM +0100, Mark Rutland wrote:
> > On Thu, Aug 18, 2016 at 01:24:38PM -0700, Yabin Cui wrote:
> > >    If the cpu pmu is using a percpu irq: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> > >    ? ? ??
> > >    1. When a cpu is down, we should disable pmu irq on ? ? ? ? ? ? ? ? ? ? ?
> > >    that cpu. Otherwise, if the cpu is still down when ? ? ? ? ? ? ? ? ? ? ? ?
> > >    the last perf event is released, the pmu irq can't ? ? ? ? ? ? ? ? ? ? ? ?
> > >    be freed. Because the irq is still enabled on the ? ? ? ? ? ? ? ? ? ? ? ?
> > >    offlined cpu. And following perf_event_open() ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> > >    syscalls will fail. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> > >
> > >    2. When a cpu is up, we should enable pmu irq on ? ? ? ? ? ? ? ? ? ? ? ? ?
> > >    that cpu. Otherwise, profiling tools can't sample ? ? ? ? ? ? ? ? ? ? ? ?
> > >    events on the cpu before all perf events are ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> > >    released, because pmu irq is disabled on that cpu. ? ? ? ? ? ? ? ? ? ? ? ?

[...]

> > Rather than adding more moving parts to the IRQ manipulation logic, I'd
> > rather we rework the IRQ manipulation logic to:
> > 
> > * At probe time, request all the interrupts. If we can't, bail out and
> >   fail the probe.
> > 
> > * Upon hotplug in (and at probe time), configure the affinity and
> >   enable the relevant interrupt(s).
> > 
> > * Upon hotplug out, disable the relevant interrupt.

> > I'm taking a look at doing the above, but I don't yet have a patch.
> 
> Any update on this? I'd quite like to do *something* to fix the issues
> reported here.

Apologies for the delay.

I've been away from my development hardware for the last week, so I
ahven't fought with this for a few days.

Given it's requiring that I practically rewrite of_pmu_irq_cfg and
friends, it may be better to take Yabin's patch for the timebeing if you
want a quick fix for this particular issue.

Thanks,
Mark.
