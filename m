From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Feb 2016 14:27:27 +0000
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160215140720.GA4053@hardcore>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
 <20160215140720.GA4053@hardcore>
Message-ID: <20160215142726.GD9732@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 03:07:20PM +0100, Jan Glauber wrote:
> Hi Mark,
> 
> thanks for reviewing! I'll need several mails to address all questions.
> 
> On Fri, Feb 12, 2016 at 05:36:59PM +0000, Mark Rutland wrote:
> > On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:
> > > Provide uncore facilities for non-CPU performance counter units.
> > > Based on Intel/AMD uncore pmu support.
> > > 
> > > The uncore PMUs can be found under /sys/bus/event_source/devices.
> > > All counters are exported via sysfs in the corresponding events
> > > files under the PMU directory so the perf tool can list the event names.
> > 
> > It turns out that "uncore" covers quite a lot of things.
> > 
> > Where exactly do the see counters live? system, socket, cluster?
> 
> Neither cluster nor socket, so I would say system. Where a system may
> consist of 2 nodes that mostly appear as one system.
> 
> > Are there potentially multiple instances of a given PMU in the system?
> > e.g. might each clutster have an instance of an L2 PMU?
> 
> Yes.
> 
> > If I turn off a set of CPUs, do any "uncore" PMUs lost context or become
> > inaccessible?
> 
> No, they are not related to CPUs.

Ok. So I should be able to concurrently hotplug random CPUs on/off while
this driver is running, without issues? No registers might be
clock-gated or similar?

I appreciate that they are not "related" to particular CPUs as such.

> > > 1) The PMU detection solely relies on PCI device detection. If a
> > >    matching PCI device is found the PMU is created. The code can deal
> > >    with multiple units of the same type, e.g. more than one memory
> > >    controller.
> > 
> > I see below that the driver has an initcall that runs regardless of
> > whether the PCI device exists, and looks at the MIDR. That's clearly not
> > string PCI device detection.
> > 
> > Why is this not a true PCI driver that only gets probed if the PCI
> > device exists? 
> 
> It is not a PCI driver because there are already drivers like edac that
> will access these PCI devices. The uncore driver only accesses the
> performance counters, which are not used by the other drivers.

Several drivers are accessing the same device?

That sounds somewhat scary.

> > > +#include <asm/cpufeature.h>
> > > +#include <asm/cputype.h>
> > 
> > I don't see why you should need these two if this is truly an uncore
> > device probed solely from PCI.
> 
> There are several passes of the hardware that have the same PCI device
> ID. Therefore I need the CPU variant to distinguish them. This could
> be done _after_ the PCI device is found but I found it easier to
> implement the check once in the common setup function.

Ok. Please call that out in the commit message.

> > > +int thunder_uncore_event_init(struct perf_event *event)
> > > +{
> > > +	struct hw_perf_event *hwc = &event->hw;
> > > +	struct thunder_uncore *uncore;
> > > +
> > > +	if (event->attr.type != event->pmu->type)
> > > +		return -ENOENT;
> > > +
> > > +	/* we do not support sampling */
> > > +	if (is_sampling_event(event))
> > > +		return -EINVAL;
> > > +
> > > +	/* counters do not have these bits */
> > > +	if (event->attr.exclude_user	||
> > > +	    event->attr.exclude_kernel	||
> > > +	    event->attr.exclude_host	||
> > > +	    event->attr.exclude_guest	||
> > > +	    event->attr.exclude_hv	||
> > > +	    event->attr.exclude_idle)
> > > +		return -EINVAL;
> > 
> > We should _really_ make these features opt-in at the core level. It's
> > crazy that each and every PMU drivers has to explicitly test and reject
> > things it doesn't support.
> 
> Completely agreed. Also, every sample code I looked at did
> check for other bits...
> 
> [...]
> 
> > > +
> > > +	uncore = event_to_thunder_uncore(event);
> > > +	if (!uncore)
> > > +		return -ENODEV;
> > > +	if (!uncore->event_valid(event->attr.config))
> > > +		return -EINVAL;
> > > +
> > > +	hwc->config = event->attr.config;
> > > +	hwc->idx = -1;
> > > +
> > > +	/* and we don't care about CPU */
> > 
> > Actually, you do. You want the perf core to serialize accesses via the
> > same CPU, so all events _must_ be targetted at the same CPU. Otherwise
> > there are a tonne of problems you don't even want to think about.
> 
> I found that perf added the events on every CPU in the system. Because
> the uncore events are not CPU related I wanted to avoid this. Setting
> cpumask to -1 did not work. Therefore I added a single CPU in the
> cpumask, see thunder_uncore_attr_show_cpumask().

I understand that, which is why I wrote:

> > You _must_ ensure this kernel-side, regardless of what the perf tool
> > happens to do.
> > 
> > See the arm-cci and arm-ccn drivers for an example.

Take a look at drivers/bus/arm-cci.c; specifically, what we do in
cci_pmu_event_init and cci_pmu_cpu_notifier.

This is the same thing that's done for x86 system PMUs. Take a look at
uncore_pmu_event_init in arch/x86/kernel/cpu/perf_event_intel_uncore.c.

Otherwise there are a number of situations where userspace might open
events on different CPUs, and you get some freaky results because the
perf core expects accesses to a PMU and its related data structures to
be strictly serialised through _some_ CPU (even if that CPU is
arbitrarily chosen).

For example, if CPU 0 was offline when one event was opened, then cpu0
was hotplugged, then a second event was opened, there would be an event
in the CPU1 context and another in the CPU0 context. Modification to the
PMU state is done per CPU-context in the core, and these would race
against each other given the lack of serialisation. Even with sufficient
locking to prevent outright corruption, things like event rotation would
race leading to very non-deterministic results.

Thanks,
Mark.
