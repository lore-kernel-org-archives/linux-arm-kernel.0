From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 10:48:00 +0100
Subject: [PATCH] arm/perf: Fix pmu percpu irq handling at hotplug.
In-Reply-To: <20160819142514.GB28422@leverpostej>
References: <CALJ9ZPMixfGKspzaz+vTGQZG4EaQB5Futss-aC-Z+8oztVX9Nw@mail.gmail.com>
 <20160819142514.GB28422@leverpostej>
Message-ID: <20160826094800.GD13554@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Fri, Aug 19, 2016 at 03:25:14PM +0100, Mark Rutland wrote:
> On Thu, Aug 18, 2016 at 01:24:38PM -0700, Yabin Cui wrote:
> >    If the cpu pmu is using a percpu irq: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> >    ? ? ??
> >    1. When a cpu is down, we should disable pmu irq on ? ? ? ? ? ? ? ? ? ? ?
> >    that cpu. Otherwise, if the cpu is still down when ? ? ? ? ? ? ? ? ? ? ? ?
> >    the last perf event is released, the pmu irq can't ? ? ? ? ? ? ? ? ? ? ? ?
> >    be freed. Because the irq is still enabled on the ? ? ? ? ? ? ? ? ? ? ? ?
> >    offlined cpu. And following perf_event_open() ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> >    syscalls will fail. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> >
> >    2. When a cpu is up, we should enable pmu irq on ? ? ? ? ? ? ? ? ? ? ? ? ?
> >    that cpu. Otherwise, profiling tools can't sample ? ? ? ? ? ? ? ? ? ? ? ?
> >    events on the cpu before all perf events are ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?
> >    released, because pmu irq is disabled on that cpu. ? ? ? ? ? ? ? ? ? ? ? ?
> 
> It also looks like if a CPU is taken down while events are active, a
> non-percpu interrupt will get migrated to another CPU, yet we don't
> retarget it if/when the CPU is brought back online. So we have at least
> three bugs with IRQ manipulation around hotplug.
> 
> Rather than adding more moving parts to the IRQ manipulation logic, I'd
> rather we rework the IRQ manipulation logic to:
> 
> * At probe time, request all the interrupts. If we can't, bail out and
>   fail the probe.
> 
> * Upon hotplug in (and at probe time), configure the affinity and
>   enable the relevant interrupt(s).
> 
> * Upon hotplug out, disable the relevant interrupt.
> 
> That way we have fewer moving parts that need to interact with each
> other (e.g. we don't need to inhibit hotplug in places), and we know
> early whether things will or will not work.
> 
> The {reserve,release}_hardware dance is largely a legacy thing that was
> there to cater for sharing the PMU with other subsystems, and we should
> be able to get rid of it.
> 
> I'm taking a look at doing the above, but I don't yet have a patch.

Any update on this? I'd quite like to do *something* to fix the issues
reported here.

Will
