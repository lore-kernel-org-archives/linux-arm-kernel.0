From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Feb 2016 17:36:59 +0000
Subject: [RFC PATCH 1/7] arm64/perf: Basic uncore counter support for
 Cavium ThunderX
In-Reply-To: <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
References: <cover.1455295032.git.jglauber@cavium.com>
 <8bd93a25e069ed6428bc6c21fc53270962ccafcc.1455295032.git.jglauber@cavium.com>
Message-ID: <20160212173658.GD20262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:55:06PM +0100, Jan Glauber wrote:
> Provide uncore facilities for non-CPU performance counter units.
> Based on Intel/AMD uncore pmu support.
> 
> The uncore PMUs can be found under /sys/bus/event_source/devices.
> All counters are exported via sysfs in the corresponding events
> files under the PMU directory so the perf tool can list the event names.

It turns out that "uncore" covers quite a lot of things.

Where exactly do the see counters live? system, socket, cluster?

Are there potentially multiple instances of a given PMU in the system?
e.g. might each clutster have an instance of an L2 PMU?

If I turn off a set of CPUs, do any "uncore" PMUs lost context or become
inaccessible?

Otherwise, are they associated with some power domain?

> There are 2 points that are special in this implementation:
> 
> 1) The PMU detection solely relies on PCI device detection. If a
>    matching PCI device is found the PMU is created. The code can deal
>    with multiple units of the same type, e.g. more than one memory
>    controller.

I see below that the driver has an initcall that runs regardless of
whether the PCI device exists, and looks at the MIDR. That's clearly not
string PCI device detection.

Why is this not a true PCI driver that only gets probed if the PCI
device exists? 

> 2) Counters are summarized across the different units of the same type,
>    e.g. L2C TAD 0..7 is presented as a single counter (adding the
>    values from TAD 0 to 7). Although losing the ability to read a
>    single value the merged values are easier to use and yield
>    enough information.

I'm not sure I follow this. What is easier? What are you doing, and what
are you comparing that with to say that your approach is easier?

It sounds like it should be possible to handle multiple counters like
this, so I don't follow why you want to amalgamate them in-kernel.

[...]

> +#include <asm/cpufeature.h>
> +#include <asm/cputype.h>

I don't see why you should need these two if this is truly an uncore
device probed solely from PCI.

> +void thunder_uncore_read(struct perf_event *event)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev, new = 0;
> +	s64 delta;
> +	int i;
> +
> +	/*
> +	 * since we do not enable counter overflow interrupts,
> +	 * we do not have to worry about prev_count changing on us
> +	 */

Without overflow interrupts, how do you ensure that you account for
overflow in a reasonable time window (i.e. before the counter runs past
its initial value)?

> +
> +	prev = local64_read(&hwc->prev_count);
> +
> +	/* read counter values from all units */
> +	for (i = 0; i < uncore->nr_units; i++)
> +		new += readq(map_offset(hwc->event_base, uncore, i));

There's no bit to determine whether an overflow occurred?

> +
> +	local64_set(&hwc->prev_count, new);
> +	delta = new - prev;
> +	local64_add(delta, &event->count);
> +}
> +
> +void thunder_uncore_del(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = event_to_thunder_uncore(event);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int i;
> +
> +	event->pmu->stop(event, PERF_EF_UPDATE);
> +
> +	for (i = 0; i < uncore->num_counters; i++) {
> +		if (cmpxchg(&uncore->events[i], event, NULL) == event)
> +			break;
> +	}
> +	hwc->idx = -1;
> +}

Why not just place the event at uncode->events[hwc->idx] ?

Theat way removing the event is trivial.

> +int thunder_uncore_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore *uncore;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* we do not support sampling */
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	/* counters do not have these bits */
> +	if (event->attr.exclude_user	||
> +	    event->attr.exclude_kernel	||
> +	    event->attr.exclude_host	||
> +	    event->attr.exclude_guest	||
> +	    event->attr.exclude_hv	||
> +	    event->attr.exclude_idle)
> +		return -EINVAL;

We should _really_ make these features opt-in at the core level. It's
crazy that each and every PMU drivers has to explicitly test and reject
things it doesn't support.

> +
> +	/* and we do not enable counter overflow interrupts */

That statement raises far more questions than it answers.

_why_ do we not user overflow interrupts?

> +
> +	uncore = event_to_thunder_uncore(event);
> +	if (!uncore)
> +		return -ENODEV;
> +	if (!uncore->event_valid(event->attr.config))
> +		return -EINVAL;
> +
> +	hwc->config = event->attr.config;
> +	hwc->idx = -1;
> +
> +	/* and we don't care about CPU */

Actually, you do. You want the perf core to serialize accesses via the
same CPU, so all events _must_ be targetted at the same CPU. Otherwise
there are a tonne of problems you don't even want to think about.

You _must_ ensure this kernel-side, regardless of what the perf tool
happens to do.

See the arm-cci and arm-ccn drivers for an example.

You can also follow the migration approach used there to allow you to
retain counting across a hotplug.

[...]

> +static int __init thunder_uncore_init(void)
> +{
> +	unsigned long implementor = read_cpuid_implementor();
> +	unsigned long part_number = read_cpuid_part_number();
> +	u32 variant;
> +
> +	if (implementor != ARM_CPU_IMP_CAVIUM ||
> +	    part_number != CAVIUM_CPU_PART_THUNDERX)
> +		return -ENODEV;
> +
> +	/* detect pass2 which contains different counters */
> +	variant = MIDR_VARIANT(read_cpuid_id());
> +	if (variant == 1)
> +		thunder_uncore_version = 1;
> +	pr_info("PMU version: %d\n", thunder_uncore_version);
> +
> +	return 0;
> +}

You should call out these differences in the commmit message.

Mark.
