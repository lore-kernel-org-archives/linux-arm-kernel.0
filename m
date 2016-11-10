From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Nov 2016 16:54:06 +0000
Subject: [PATCH v4 1/5] arm64: perf: Basic uncore counter support for
 Cavium ThunderX SOC
In-Reply-To: <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
References: <cover.1477741719.git.jglauber@cavium.com>
 <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
Message-ID: <20161110165405.GH4418@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

Apologies for the delay in getting to this.

On Sat, Oct 29, 2016 at 01:55:29PM +0200, Jan Glauber wrote:
> diff --git a/drivers/perf/uncore/uncore_cavium.c b/drivers/perf/uncore/uncore_cavium.c
> new file mode 100644
> index 0000000..a7b4277
> --- /dev/null
> +++ b/drivers/perf/uncore/uncore_cavium.c
> @@ -0,0 +1,351 @@
> +/*
> + * Cavium Thunder uncore PMU support.
> + *
> + * Copyright (C) 2015,2016 Cavium Inc.
> + * Author: Jan Glauber <jan.glauber@cavium.com>
> + */
> +
> +#include <linux/cpufeature.h>
> +#include <linux/numa.h>
> +#include <linux/slab.h>

I believe the following includes are necessary for APIs and/or data
explicitly referenced by the driver code:

#include <linux/atomic.h>
#include <linux/cpuhotplug.h>
#include <linux/cpumask.h>
#include <linux/device.h>
#include <linux/errno.h>
#include <linux/io.h>
#include <linux/kernel.h>
#include <linux/list.h>
#include <linux/pci.h>
#include <linux/perf_event.h>
#include <linux/printk.h>
#include <linux/smp.h>
#include <linux/sysfs.h>
#include <linux/types.h>

#include <asm/local64.h>

... please add those here.

[...]

> +/*
> + * Some notes about the various counters supported by this "uncore" PMU
> + * and the design:
> + *
> + * All counters are 64 bit long.
> + * There are no overflow interrupts.
> + * Counters are summarized per node/socket.
> + * Most devices appear as separate PCI devices per socket with the exception
> + * of OCX TLK which appears as one PCI device per socket and contains several
> + * units with counters that are merged.

As a general note, as I commented on the QC L2 PMU driver [1,2], we need
to figure out if we should be aggregating physical PMUs or not.

Judging by subsequent patches, each unit has individual counters and
controls, and thus we cannot atomically read/write counters or controls
across them. As such, I do not think we should aggregate them, and
should expose them separately to userspace.

That will simplify a number of things (e.g. the CPU migration code no
longer has to iterate over a list of units).

> + * Some counters are selected via a control register (L2C TAD) and read by
> + * a number of counter registers, others (L2C CBC, LMC & OCX TLK) have
> + * one dedicated counter per event.
> + * Some counters are not stoppable (L2C CBC & LMC).
> + * Some counters are read-only (LMC).
> + * All counters belong to PCI devices, the devices may have additional
> + * drivers but we assume we are the only user of the counter registers.
> + * We map the whole PCI BAR so we must be careful to forbid access to
> + * addresses that contain neither counters nor counter control registers.
> + */
> +
> +void thunder_uncore_read(struct perf_event *event)
> +{
> +	struct thunder_uncore *uncore = to_uncore(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	struct thunder_uncore_unit *unit;
> +	u64 prev, delta, new = 0;
> +
> +	node = get_node(hwc->config, uncore);
> +
> +	/* read counter values from all units on the node */
> +	list_for_each_entry(unit, &node->unit_list, entry)
> +		new += readq(hwc->event_base + unit->map);
> +
> +	prev = local64_read(&hwc->prev_count);
> +	local64_set(&hwc->prev_count, new);
> +	delta = new - prev;
> +	local64_add(delta, &event->count);
> +}
> +
> +int thunder_uncore_add(struct perf_event *event, int flags, u64 config_base,
> +		       u64 event_base)
> +{
> +	struct thunder_uncore *uncore = to_uncore(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	int id;
> +
> +	node = get_node(hwc->config, uncore);
> +	id = get_id(hwc->config);
> +
> +	if (!cmpxchg(&node->events[id], NULL, event))
> +		hwc->idx = id;

Judging by thunder_uncore_event_init() and get_id(), the specific
counter to use is chosen by the user, rather than allocated as
necessary. Yet the block comment before thunder_uncore_read() said only
some events have a dedicated counter.

This does not seem right. Why are we not choosing a relevant counter
dynamically?

As Will commented, we shouldn't need a full-barrier cmpxchg() here; the
pmu::{add,del} are serialised by the core perf code as ctx->lock has to
be held (and we have no interrupt to worry about). If we want to use
cmpxchg() for convenience, it can be a cmpxchg_relaxed().

> +	if (hwc->idx == -1)
> +		return -EBUSY;
> +
> +	hwc->config_base = config_base;
> +	hwc->event_base = event_base;
> +	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> +
> +	if (flags & PERF_EF_START)
> +		uncore->pmu.start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}
> +
> +void thunder_uncore_del(struct perf_event *event, int flags)
> +{
> +	struct thunder_uncore *uncore = to_uncore(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct thunder_uncore_node *node;
> +	int i;
> +
> +	event->pmu->stop(event, PERF_EF_UPDATE);
> +
> +	/*
> +	 * For programmable counters we need to check where we installed it.
> +	 * To keep this function generic always test the more complicated
> +	 * case (free running counters won't need the loop).
> +	 */
> +	node = get_node(hwc->config, uncore);
> +	for (i = 0; i < node->num_counters; i++) {
> +		if (cmpxchg(&node->events[i], event, NULL) == event)
> +			break;

Likewise, this can be cmpxchg_relaxed().

[...]

> +int thunder_uncore_event_init(struct perf_event *event)
> +{

> +	uncore = to_uncore(event->pmu);
> +	if (!uncore)
> +		return -ENODEV;

Given to_uncore() uses container_of(), we can lose the check here; the
result cannot be NULL.

> +	if (!uncore->event_valid(event->attr.config & UNCORE_EVENT_ID_MASK))
> +		return -EINVAL;

Judging by the header, it looks like the node gets dropped in the high
bits. I'm not sure it makes sense to encode that in the user ABI given
the aggregation comments above.

In x86 uncore PMU drivers, one cpu per node is exposed in the cpumask,
and that's how they target nodes. We should either do that, or have
completely separate instances.

Either way, that will also remove the need for exposing the varying
NODE_SHIFT under sysfs.

> +
> +	/* check NUMA node */
> +	node = get_node(event->attr.config, uncore);
> +	if (!node) {
> +		pr_debug("Invalid NUMA node selected\n");
> +		return -EINVAL;
> +	}

... and this to, since the node will either be implicit in the cpu
performing the monitoring, or in the PMU instance the event was
requested from.

> +
> +	hwc->config = event->attr.config;
> +	hwc->idx = -1;
> +	return 0;
> +}

I believe that we should also check that the leader (and siblings) are compatible.

Something like l2x0_pmu_group_is_valid in arch/arm/mm/cache-l2x0-pmu.c.

We also need to ensure that the events in a group are all on the same
CPU (the one exposed via the cpumask). The l2x0 PMU also does this in
its event_init path.

[...]

> +	cpuhp_state_add_instance_nocalls(CPUHP_AP_UNCORE_CAVIUM_ONLINE,
> +                                         &uncore->node);

> +	ret = perf_pmu_register(&uncore->pmu, uncore->pmu.name, -1);
> +	if (ret)
> +		goto fail;

> +fail:
> +	node_id = 0;
> +	while (uncore->nodes[node_id]) {
> +		node = uncore->nodes[node_id];
> +
> +		list_for_each_entry_safe(unit, tmp, &node->unit_list, entry) {
> +			if (unit->pdev) {
> +				if (unit->map)
> +					iounmap(unit->map);
> +				pci_dev_put(unit->pdev);
> +			}
> +			kfree(unit);
> +		}
> +		kfree(uncore->nodes[node_id]);
> +		node_id++;
> +	}
> +	return ret;
> +}

Shouldn't we remove the instance from the cpuhp state machine in the
failure path?

[...]

> diff --git a/drivers/perf/uncore/uncore_cavium.h b/drivers/perf/uncore/uncore_cavium.h
> new file mode 100644
> index 0000000..b5d64b5
> --- /dev/null
> +++ b/drivers/perf/uncore/uncore_cavium.h
> @@ -0,0 +1,71 @@
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/perf_event.h>

I believe this header also needs:

#include <linux/cpumask.h>
#include <linux/kernel.h>
#include <linux/stringify.h>
#include <linux/sysfs.h>
#include <linux/types.h>

> +
> +#undef pr_fmt
> +#define pr_fmt(fmt)     "thunderx_uncore: " fmt

IIRC this needs to be set before including <linux/printk.h>. Does this
work reliably, given that printk.h is likely included first?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/466764.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/466768.html
