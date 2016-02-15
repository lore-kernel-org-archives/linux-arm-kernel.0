From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Mon, 15 Feb 2016 15:07:20 +0100
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <20160212173658.GD20262@leverpostej>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
 <20160212173658.GD20262@leverpostej>
Message-ID: <20160215140720.GA4053@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thanks for reviewing! I'll need several mails to address all questions.

On Fri, Feb 12, 2016 at 05:36:59PM +0000, Mark Rutland wrote:
> On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:
> > Provide uncore facilities for non-CPU performance counter units.
> > Based on Intel/AMD uncore pmu support.
> > 
> > The uncore PMUs can be found under /sys/bus/event_source/devices.
> > All counters are exported via sysfs in the corresponding events
> > files under the PMU directory so the perf tool can list the event names.
> 
> It turns out that "uncore" covers quite a lot of things.
> 
> Where exactly do the see counters live? system, socket, cluster?

Neither cluster nor socket, so I would say system. Where a system may
consist of 2 nodes that mostly appear as one system.

> Are there potentially multiple instances of a given PMU in the system?
> e.g. might each clutster have an instance of an L2 PMU?

Yes.

> If I turn off a set of CPUs, do any "uncore" PMUs lost context or become
> inaccessible?

No, they are not related to CPUs.

[...]

> > 
> > 1) The PMU detection solely relies on PCI device detection. If a
> >    matching PCI device is found the PMU is created. The code can deal
> >    with multiple units of the same type, e.g. more than one memory
> >    controller.
> 
> I see below that the driver has an initcall that runs regardless of
> whether the PCI device exists, and looks at the MIDR. That's clearly not
> string PCI device detection.
> 
> Why is this not a true PCI driver that only gets probed if the PCI
> device exists? 

It is not a PCI driver because there are already drivers like edac that
will access these PCI devices. The uncore driver only accesses the
performance counters, which are not used by the other drivers.

[...]

> > +#include <asm/cpufeature.h>
> > +#include <asm/cputype.h>
> 
> I don't see why you should need these two if this is truly an uncore
> device probed solely from PCI.

There are several passes of the hardware that have the same PCI device
ID. Therefore I need the CPU variant to distinguish them. This could
be done _after_ the PCI device is found but I found it easier to
implement the check once in the common setup function.

[...]

> > +int thunder_uncore_event_init(struct perf_event *event)
> > +{
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	struct thunder_uncore *uncore;
> > +
> > +	if (event->attr.type != event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	/* we do not support sampling */
> > +	if (is_sampling_event(event))
> > +		return -EINVAL;
> > +
> > +	/* counters do not have these bits */
> > +	if (event->attr.exclude_user	||
> > +	    event->attr.exclude_kernel	||
> > +	    event->attr.exclude_host	||
> > +	    event->attr.exclude_guest	||
> > +	    event->attr.exclude_hv	||
> > +	    event->attr.exclude_idle)
> > +		return -EINVAL;
> 
> We should _really_ make these features opt-in at the core level. It's
> crazy that each and every PMU drivers has to explicitly test and reject
> things it doesn't support.

Completely agreed. Also, every sample code I looked at did
check for other bits...

[...]

> > +
> > +	uncore = event_to_thunder_uncore(event);
> > +	if (!uncore)
> > +		return -ENODEV;
> > +	if (!uncore->event_valid(event->attr.config))
> > +		return -EINVAL;
> > +
> > +	hwc->config = event->attr.config;
> > +	hwc->idx = -1;
> > +
> > +	/* and we don't care about CPU */
> 
> Actually, you do. You want the perf core to serialize accesses via the
> same CPU, so all events _must_ be targetted at the same CPU. Otherwise
> there are a tonne of problems you don't even want to think about.

I found that perf added the events on every CPU in the system. Because
the uncore events are not CPU related I wanted to avoid this. Setting
cpumask to -1 did not work. Therefore I added a single CPU in the
cpumask, see thunder_uncore_attr_show_cpumask().

> You _must_ ensure this kernel-side, regardless of what the perf tool
> happens to do.
> 
> See the arm-cci and arm-ccn drivers for an example.
> 
> You can also follow the migration approach used there to allow you to
> retain counting across a hotplug.
> 
> [...]
> 
> > +static int __init thunder_uncore_init(void)
> > +{
> > +	unsigned long implementor = read_cpuid_implementor();
> > +	unsigned long part_number = read_cpuid_part_number();
> > +	u32 variant;
> > +
> > +	if (implementor != ARM_CPU_IMP_CAVIUM ||
> > +	    part_number != CAVIUM_CPU_PART_THUNDERX)
> > +		return -ENODEV;
> > +
> > +	/* detect pass2 which contains different counters */
> > +	variant = MIDR_VARIANT(read_cpuid_id());
> > +	if (variant == 1)
> > +		thunder_uncore_version = 1;
> > +	pr_info("PMU version: %d\n", thunder_uncore_version);
> > +
> > +	return 0;
> > +}
> 
> You should call out these differences in the commmit message.

OK

> Mark.

Thanks, Jan
