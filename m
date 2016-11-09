From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 9 Nov 2016 17:54:13 +0000
Subject: [PATCH v7] soc: qcom: add l2 cache perf events driver
In-Reply-To: <1477687813-11412-1-git-send-email-nleeder@codeaurora.org>
References: <1477687813-11412-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20161109175413.GE17020@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Apologies for the delay in replying to this.

This is looking good. I have a few specific comments and a couple of
general concerns below.

Will, please see the bit below about cluster/socket aggregation (grep
for your name).

On Fri, Oct 28, 2016 at 04:50:13PM -0400, Neil Leeder wrote:
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>

While scanning the driver. I noticed a number of other headers that are
required for things the driver explicitly references. Please add the
following so that we're not relying on (fragile) transitive includes:

#include <linux/bitops.h>
#include <linux/bug.h>
#include <linux/cpuhotplug.h>
#include <linux/cpumask.h>
#include <linux/device.h>
#include <linux/errno.h>
#include <linux/kernel.h>
#include <linux/list.h>
#include <linux/percpu.h>
#include <linux/smp.h>
#include <linux/spinlock.h>
#include <linux/sysfs.h>
#include <linux/types.h>

#include <asm/barrier.h>
#include <asm/local64.h>
#include <asm/sysreg.h>

[...]

> +/*
> + * Aggregate PMU. Implements the core pmu functions and manages
> + * the hardware PMUs.
> + */
> +struct l2cache_pmu {
> +	struct hlist_node node;
> +	u32 num_pmus;
> +	struct pmu pmu;
> +	int num_counters;
> +	cpumask_t cpumask;
> +	struct platform_device *pdev;
> +};
> +
> +/*
> + * The cache is made up of one or more clusters, each cluster has its own PMU.
> + * Each cluster is associated with one or more CPUs.
> + * This structure represents one of the hardware PMUs.
> + *
> + * Events can be envisioned as a 2-dimensional array. Each column represents
> + * a group of events. There are 8 groups. Only one entry from each
> + * group can be in use at a time. When an event is assigned a counter
> + * by *_event_add(), the counter index is assigned to group_to_counter[group].

If I've followed correctly, this means each group has a dedicated
counter?

I take it groups are not symmetric (i.e. each column has different
events)? Or does each column contain the same events?

Is there any overlap?

> + * This allows *filter_match() to detect and reject conflicting events in
> + * the same group.
> + * Events are specified as 0xCCG, where CC is 2 hex digits specifying
> + * the code (array row) and G specifies the group (column).
> + *
> + * In addition there is a cycle counter event specified by L2CYCLE_CTR_RAW_CODE
> + * which is outside the above scheme.
> + */
> +struct hml2_pmu {

It's not clear to me what "hml2" is, and now we seem to use "cluster"
and "hml2" interchangeably in comments and code. Can you please define
what "hml2" is in a comment, mentioning that we refer to this (or its
container?) as a cluster?

Can we also please s/hml2/cluster/ in the code, for consistency?

> +	struct perf_event *events[MAX_L2_CTRS];
> +	struct l2cache_pmu *l2cache_pmu;
> +	DECLARE_BITMAP(used_counters, MAX_L2_CTRS);
> +	DECLARE_BITMAP(used_groups, L2_EVT_GROUP_MAX + 1);
> +	int group_to_counter[L2_EVT_GROUP_MAX + 1];
> +	int irq;
> +	/* The CPU that is used for collecting events on this cluster */
> +	int on_cpu;
> +	/* All the CPUs associated with this cluster */
> +	cpumask_t cluster_cpus;

I'm still uncertain about aggregating all cluster PMUs into a larger
PMU, given the cluster PMUs are logically independent (at least in terms
of the programming model).

However, from what I understand the x86 uncore PMU drivers aggregate
symmetric instances of uncore PMUs (and also aggregate across packages
to the same logical PMU).

Whatever we do, it would be nice for the uncore drivers to align on a
common behaviour (and I think we're currently going the oppposite route
with Cavium's uncore PMU). Will, thoughts?

> +	spinlock_t pmu_lock;
> +};

[...]

> +static void hml2_pmu__set_resr(struct hml2_pmu *cluster,
> +			       u32 event_group, u32 event_cc)
> +{
> +	u64 field;
> +	u64 resr_val;
> +	u32 shift;
> +	unsigned long flags;
> +
> +	shift = L2PMRESR_GROUP_BITS * event_group;
> +	field = ((u64)(event_cc & L2PMRESR_GROUP_MASK) << shift) | L2PMRESR_EN;

The L2PMRESR_EN isn't part of the shifted field...

> +
> +	spin_lock_irqsave(&cluster->pmu_lock, flags);
> +
> +	resr_val = get_l2_indirect_reg(L2PMRESR);
> +	resr_val &= ~(L2PMRESR_GROUP_MASK << shift);
> +	resr_val |= field;

... so can we please or that in on a separate line here, e.g.

	resr_val |= L2PMRESR_EN;

That said, do we need to set this bit each time we program an event?

> +	set_l2_indirect_reg(L2PMRESR, resr_val);
> +
> +	spin_unlock_irqrestore(&cluster->pmu_lock, flags);
> +}

[...]

> +static void l2_cache__event_update_from_cluster(struct perf_event *event,
> +						struct hml2_pmu *cluster)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 delta64, prev, now;
> +	u32 delta;
> +	u32 idx = hwc->idx;
> +
> +	do {
> +		prev = local64_read(&hwc->prev_count);
> +		now = hml2_pmu__counter_get_value(idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
> +
> +	if (idx == l2_cycle_ctr_idx) {
> +		/*
> +		 * The cycle counter is 64-bit so needs separate handling
> +		 * of 64-bit delta.
> +		 */
> +		delta64 = now - prev;
> +		local64_add(delta64, &event->count);
> +	} else {
> +		/*
> +		 * 32-bit counters need the unsigned 32-bit math to handle
> +		 * overflow and now < prev
> +		 */
> +		delta = now - prev;
> +		local64_add(delta, &event->count);
> +	}
> +}

I believe you can get rid of the delta/delta64 split with something like
the below (with a 64-bit delta):

	/*
	 * The cycle counter is 64-bit, but all other counters are
	 * 32-bit, and we must handle 32-bit overflow explicitly.
	 */
	delta = now - prev;
	if (idx != l2_cycle_ctr_idx)
		delta &= 0xffffffff;
	
	local64_add(delta, &event->count);

> +
> +static void l2_cache__cluster_set_period(struct hml2_pmu *cluster,
> +				       struct hw_perf_event *hwc)
> +{
> +	u64 base = L2_MAX_PERIOD - (L2_CNT_PERIOD - 1);

Is L2_CNT_PERIOD a hw-derived value? Or just something that happened to
be small enough to avoid overflow in testing?

> +	u32 idx = hwc->idx;
> +	u64 prev = local64_read(&hwc->prev_count);
> +	u64 value;
> +
> +	/*
> +	 * Limit the maximum period to prevent the counter value
> +	 * from overtaking the one we are about to program.
> +	 * Use a starting value which is high enough that after
> +	 * an overflow, interrupt latency will not cause the count
> +	 * to reach the base value. If the previous value
> +	 * is below the base, increase it to be above the base
> +	 * and update prev_count accordingly. Otherwise if
> +	 * the previous value is already above the base
> +	 * nothing needs to be done to prev_count.
> +	 */
> +	if (prev < base) {
> +		value = base + prev;
> +		local64_set(&hwc->prev_count, value);
> +	} else {
> +		value = prev;
> +	}
> +
> +	hml2_pmu__counter_set_value(idx, value);
> +}

Given that we don't do sampling, and are only using the interrupt to
prevent losing events in the case of overflow, I think we can use a
constant value to handle all cases.

Additionally, I think we need to handle the cycle counter separately,
since it has a different width. Something like the below (perhaps with
different constants):

static void l2_cache__cluster_set_period(struct hml2_pmu *cluster,
					 struct hw_perf_event *hwc)
{
	u64 new;
	
	/*
	 * We limit the max period to half of the max counter value so
	 * that even in the case of extreme interrupt latency the
	 * counter will (hopefully) not wrap past its initial value.
	 */
	if (hwc->idx == l2_cycle_ctr_idx)
		new = BIT_ULL(63);
	else
		new = BIT_ULL(31); 
	
	local64_set(&hwc->prev_count, new);

	hml2_pmu__counter_set_value(idx, new);
}

> +static int l2_cache__get_event_idx(struct hml2_pmu *cluster,
> +				   struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE) {
> +		if (test_and_set_bit(l2_cycle_ctr_idx, cluster->used_counters))
> +			return -EAGAIN;
> +
> +		return l2_cycle_ctr_idx;
> +	}
> +
> +	for (idx = 0; idx < cluster->l2cache_pmu->num_counters - 1; idx++) {
> +		if (!test_and_set_bit(idx, cluster->used_counters)) {
> +			set_bit(L2_EVT_GROUP(hwc->config_base),
> +				cluster->used_groups);
> +			return idx;
> +		}
> +	}
> +	/* The counters are all in use. */
> +	return -EAGAIN;
> +}

Are we racing with another bitmap manipulation here? Or can we split the find
and set of the bit, i.e.

	int num_ctrs = cluster->l2cache_pmu->num_counters;

	int idx = find_first_zero_bit(cluster->used_counters, num_ctrs);
	if (idx == num_ctrs)
		return -EAGAIN;
	set_bit(idx, cluster->used_counters)

Otherwise, I think the outer loop can use for_each_clear_bit().

[...]

> +static int l2_cache__event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hml2_pmu *cluster;
> +	struct perf_event *sibling;
> +	struct l2cache_pmu *l2cache_pmu;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	l2cache_pmu = to_l2cache_pmu(event->pmu);
> +
> +	if (hwc->sample_period) {
> +		dev_warn(&l2cache_pmu->pdev->dev, "Sampling not supported\n");
> +		return -EOPNOTSUPP;
> +	}

Please remove these dev_warns, or at lease relegate them to ratelimited
debug messages rather than warning messages. Users can easily trigger
these by accident and/or when probing capabilities in the usual fashion,
and there's no need for them.

The CCN driver is an unfortunate bad example in this respect.

[...]

> +	/* Don't allow groups with mixed PMUs, except for s/w events */
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader)) {
> +		dev_warn(&l2cache_pmu->pdev->dev,
> +			 "Can't create mixed PMU group\n");
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
> +			    group_entry)
> +		if (sibling->pmu != event->pmu &&
> +		    !is_software_event(sibling)) {
> +			dev_warn(&l2cache_pmu->pdev->dev,
> +				 "Can't create mixed PMU group\n");
> +			return -EINVAL;
> +		}
> +
> +	/* Ensure all events in a group are on the same cpu */
> +	cluster = get_hml2_pmu(event->cpu);
> +	if ((event->group_leader != event) &&
> +	    (cluster->on_cpu != event->group_leader->cpu)) {
> +		dev_warn(&l2cache_pmu->pdev->dev,
> +			 "Can't create group on CPUs %d and %d",
> +			 event->cpu, event->group_leader->cpu);
> +		return -EINVAL;
> +	}

It's probably worth also checking that the events are co-schedulable
(e.g. they don't conflict column-wise).

[...]

> +static void l2_cache__event_start(struct perf_event *event, int flags)
> +{
> +	struct hml2_pmu *cluster;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +	u32 config;
> +	u32 event_cc, event_group;
> +
> +	hwc->state = 0;
> +
> +	cluster = get_hml2_pmu(event->cpu);
> +	l2_cache__cluster_set_period(cluster, hwc);
> +
> +	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE) {
> +		hml2_pmu__set_evccntcr(0x0);

Nit: s/0x0/0/ -- there's no other hex usage to be consistent with, and a
single digit is clearer.

> +	} else {
> +		config = hwc->config_base;
> +		event_cc    = L2_EVT_CODE(config);
> +		event_group = L2_EVT_GROUP(config);
> +
> +		hml2_pmu__set_evcntcr(idx, 0x0);

Nit: s/0x0/0/ -- as above.

> +		hml2_pmu__set_evtyper(idx, event_group);
> +		hml2_pmu__set_resr(cluster, event_group, event_cc);
> +		hml2_pmu__set_evfilter_sys_mode(idx);
> +	}
> +
> +	hml2_pmu__counter_enable_interrupt(idx);
> +	hml2_pmu__counter_enable(idx);
> +}
> +
> +static void l2_cache__event_stop(struct perf_event *event, int flags)
> +{
> +	struct hml2_pmu *cluster;
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	if (!(hwc->state & PERF_HES_STOPPED)) {

It's better to have an early return, e.g.

	/* If already stopped, we have nothing to do */
	if (hwc->state & PERF_HES_STOPPED)
		return;

	...
	remaining logic here, not in a block
	...

> +		cluster = get_hml2_pmu(event->cpu);
> +		hml2_pmu__counter_disable_interrupt(idx);
> +		hml2_pmu__counter_disable(idx);
> +
> +		if (flags & PERF_EF_UPDATE)
> +			l2_cache__event_update_from_cluster(event, cluster);
> +		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	}
> +}
> +
> +static int l2_cache__event_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +	int err = 0;
> +	struct hml2_pmu *cluster;
> +
> +	cluster = get_hml2_pmu(event->cpu);
> +
> +	idx = l2_cache__get_event_idx(cluster, event);
> +	if (idx < 0) {
> +		err = idx;
> +		return err;
> +	}

You can return idx directly and avoid the block here.

> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	cluster->events[idx] = event;
> +	cluster->group_to_counter[L2_EVT_GROUP(hwc->config_base)] = idx;
> +	local64_set(&hwc->prev_count, 0ULL);

Nit: s/0ULL/0/

[...]

> +static int l2_cache_filter_match(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hml2_pmu *cluster = get_hml2_pmu(event->cpu);
> +	unsigned int group = L2_EVT_GROUP(hwc->config_base);
> +
> +	/* check for column exclusion: group already in use by another event */
> +	if (test_bit(group, cluster->used_groups) &&
> +	    cluster->events[cluster->group_to_counter[group]] != event)
> +		return 0;
> +
> +	return 1;
> +}

I'm still not keen on this. I'm still hoping to kill off filter_match,
as for many reasons it is not great, and I know that x86 have similar
scheduling requirements, and somehow manage without this.

It would be worth adding justification for this in a comment block
above, such as why you need this, and why this won't result in
sub-optimal behaviour.

[...]

> +	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
> +		return -ENODEV;
> +
> +	if (kstrtol(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
> +		dev_err(&pdev->dev, "unable to read ACPI uid\n");
> +		return -ENODEV;
> +	}

> +	cluster->l2cache_pmu = l2cache_pmu;
> +	for_each_present_cpu(cpu) {
> +		if (topology_physical_package_id(cpu) == fw_cluster_id) {
> +			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
> +			per_cpu(pmu_cluster, cpu) = cluster;
> +		}
> +	}

I'm still uneasy about this.

The topology_* API doesn't have a well-defined mapping to the MPIDR.Aff*
levels, which itself also don't have a well-defined mapping to your
hardware's clusters (and therefore fw_cluster_id).

Thus, I'm rather worried that this is going to get broken easily, either
by changes in the kernel, or in future HW revisions where the mapping of
clusters to MPIDR.Aff* fields changes.

[...]

> +	err = devm_request_irq(&pdev->dev, irq, l2_cache__handle_irq,
> +			       IRQF_NOBALANCING, "l2-cache-pmu", cluster);

I believe this also needs IRQF_NO_THREAD.

[...]

> +	cluster->pmu_lock = __SPIN_LOCK_UNLOCKED(cluster->pmu_lock);
	
Please use:

	spin_lock_init(&cluster->pmu_lock);

[...]

> +	platform_set_drvdata(pdev, l2cache_pmu);
> +	l2cache_pmu->pmu = (struct pmu) {
> +		/* suffix is instance id for future use with multiple sockets */
> +		.name		= "l2cache_0",

Sorry to go back and forth on this, but as above with the aggregation
comments, we might not need/want the suffix after all, or we might want
per-cluster PMUs.

> +		.task_ctx_nr    = perf_invalid_context,
> +		.pmu_enable	= l2_cache__pmu_enable,
> +		.pmu_disable	= l2_cache__pmu_disable,
> +		.event_init	= l2_cache__event_init,
> +		.add		= l2_cache__event_add,
> +		.del		= l2_cache__event_del,
> +		.start		= l2_cache__event_start,
> +		.stop		= l2_cache__event_stop,
> +		.read		= l2_cache__event_read,
> +		.attr_groups	= l2_cache_pmu_attr_grps,
> +		.filter_match   = l2_cache_filter_match,
> +	};

As a general note, can we please s/__/_/ for function names? The double
underscore gains us nothing.

[...]

> +	l2_counter_present_mask = GENMASK(l2cache_pmu->num_counters - 2, 0) |
> +		L2PM_CC_ENABLE;

This looks confusing, and it's the only use of L2PM_CC_ENABLE.

Perhaps use BIT(L2CYCLE_CTR_BIT) instead, and get rid of L2PM_CC_ENABLE?

[...]

> +	err = perf_pmu_register(&l2cache_pmu->pmu, l2cache_pmu->pmu.name, -1);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "Error %d registering L2 cache PMU\n", err);
> +		return err;
> +	}
> +
> +	dev_info(&pdev->dev, "Registered L2 cache PMU using %d HW PMUs\n",
> +		 l2cache_pmu->num_pmus);
> +
> +	err = cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
> +					       &l2cache_pmu->node);
> +
> +	return err;
> +}

Can we race with hotplug? I believe the hotplug callback registration
should come before the perf_pmu_register()

> +static int l2_cache_pmu_remove(struct platform_device *pdev)
> +{
> +	struct l2cache_pmu *l2cache_pmu =
> +		to_l2cache_pmu(platform_get_drvdata(pdev));
> +
> +	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
> +					       &l2cache_pmu->node);
> +	perf_pmu_unregister(&l2cache_pmu->pmu);
> +	return 0;
> +}

Mirroring the above, I think we should unregister the PMU before
removing the hotplug callbacks.

Thanks,
Mark.
