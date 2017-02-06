From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Feb 2017 15:48:15 +0000
Subject: [PATCH v9] perf: add qcom l2 cache perf events driver
In-Reply-To: <1486161081-28409-1-git-send-email-nleeder@codeaurora.org>
References: <1486161081-28409-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20170206154814.GA4190@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Thanks for addressing my comments so quickly; this is looking much
better now. I have some comments below, which are mostly w.r.t. simple
cleanups.

I still have concerns with the filter_match callback, which I've
elaborated on below. I would be happy to take this (with the fixups) if
we can drop the filter_match for now.

[..]

> +#define reg_idx(reg, i)         ((i * IA_L2_REG_OFFSET) + reg##_BASE)
> +

My bad, but we should wrap the i in parens to avoid bad expansions:

#define reg_idx(reg, i)         (((i) * IA_L2_REG_OFFSET) + reg##_BASE)

[...]

> +static void cluster_pmu_reset_on_cluster(void *x)
> +{
> +	/* Reset all ctrs */
> +	set_l2_indirect_reg(L2PMCR, L2PMCR_RESET_ALL);
> +	set_l2_indirect_reg(L2PMCNTENCLR, l2_counter_present_mask);
> +	set_l2_indirect_reg(L2PMINTENCLR, l2_counter_present_mask);
> +	set_l2_indirect_reg(L2PMOVSCLR, l2_counter_present_mask);
> +}
> +
> +static inline void cluster_pmu_reset(struct cluster_pmu *cluster)
> +{
> +	cpumask_t *mask = &cluster->cluster_cpus;
> +
> +	if (smp_call_function_any(mask, cluster_pmu_reset_on_cluster, NULL, 1))
> +		dev_err(&cluster->l2cache_pmu->pdev->dev,
> +			"Failed to reset on cluster with CPU%d\n",
> +			cpumask_first(&cluster->cluster_cpus));
> +
> }

We don't need the cross-call any more; this is called from a CPU in the
relevant cluster in the hotplug online callback. Can we please replace
both of these with:

static inline void cluster_pmu_reset(void)
{
	/* Reset all ctrs */
	set_l2_indirect_reg(L2PMCR, L2PMCR_RESET_ALL);
	set_l2_indirect_reg(L2PMCNTENCLR, l2_counter_present_mask);
	set_l2_indirect_reg(L2PMINTENCLR, l2_counter_present_mask);
	set_l2_indirect_reg(L2PMOVSCLR, l2_counter_present_mask);
}

... calling that directly from the hotplug online callback.

[...]

> +static irqreturn_t l2_cache_handle_irq(int irq_num, void *data)
> +{
> +	struct cluster_pmu *cluster = data;
> +	int num_counters = cluster->l2cache_pmu->num_counters;
> +	u32 ovsr;
> +	int idx;
> +
> +	ovsr = cluster_pmu_getreset_ovsr();
> +	if (!cluster_pmu_has_overflowed(ovsr))
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(idx, cluster->used_counters, num_counters) {
> +		struct perf_event *event = cluster->events[idx];
> +		struct hw_perf_event *hwc;
> +
> +		if (!cluster_pmu_counter_has_overflowed(ovsr, idx))
> +			continue;

Can the OVSR have a bit set for an event which is no longer in the
cluster->events array?

For example, if we get into l2_cache_event_del() with IRQs disabled, but
the event overflows immediately before we disable the event, what
happens once we exit l2_cache_event_del() and enable interrupts?

Do we need to clear the overflow bit when we remove an event?

Regardless, to save us future pain, can we please add:

		if (WARN_ON_ONCE(!event))
			continue;

... before we potentially try to dereference the event pointer in
l2_cache_event_update(event).

> +
> +		l2_cache_event_update(event);
> +		hwc = &event->hw;
> +
> +		l2_cache_cluster_set_period(cluster, hwc);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[...]

> +static int l2_cache_filter_match(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(event->pmu);
> +	struct cluster_pmu *cluster = get_cluster_pmu(l2cache_pmu, event->cpu);
> +	unsigned int group = L2_EVT_GROUP(hwc->config_base);
> +
> +	if (hwc->config_base == L2CYCLE_CTR_RAW_CODE)
> +		return 1;
> +
> +	/*
> +	 * Check for column exclusion: event column already in use by another
> +	 * event. This is for events which are not in the same group.
> +	 * Conflicting events in the same group are detected in event_init.
> +	 */
> +	if (test_bit(group, cluster->used_groups))
> +		return 0;
> +
> +	return 1;
> +}

I'm still concerned by this use of the filter_match callback, because it
depends on the set of other active events, and can change as other
events are scheduled in and out.

When we schedule in two conflicting events A and B in order, B will fail
its filter match. When we scheduled out A and B in order, B will succeed
its filter match.

The perf core does not expect this inconsistency, and this appears to
break the timing update logic in event_sched_out(), when unconditionally
called from ctx_sched_out() as part of perf_rotate_context().

I would feel much happier if we dropped l2_cache_filter_match(), at
least for the timebeing, and handled this as we do for other cases of
intra-pmu resource contention.

We can then consider the filter_match addition on its own at a later
point.

[...]

> +static struct cluster_pmu *l2_cache_associate_cpu_with_cluster(
> +	struct l2cache_pmu *l2cache_pmu, int cpu)
> +{
> +	u64 mpidr;
> +	int cpu_cluster_id;
> +	struct cluster_pmu *cluster;
> +
> +	/*
> +	 * This assumes that the cluster_id is in MPIDR[aff1] for
> +	 * single-threaded cores, and MPIDR[aff2] for multi-threaded
> +	 * cores. This logic will have to be updated if this changes.
> +	 */
> +	mpidr = read_cpuid_mpidr();
> +	if (mpidr & MPIDR_MT_BITMASK)
> +		cpu_cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
> +	else
> +		cpu_cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	list_for_each_entry(cluster, &l2cache_pmu->clusters, next) {
> +		if (cluster->cluster_id == cpu_cluster_id) {
> +			dev_info(&l2cache_pmu->pdev->dev,
> +				 "CPU%d associated with cluster %d\n", cpu,
> +				 cluster->cluster_id);
> +			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
> +			*per_cpu_ptr(l2cache_pmu->pmu_cluster, cpu) = cluster;
> +			return cluster;
> +		}
> +	}
> +	return 0;
> +}

Given the function prototype: s/0/NULL/

Otherwise, this looks fine. Thanks for reworking this.

[...]

> +	/* Read cluster info and initialize each cluster */
> +	err = device_for_each_child(&pdev->dev, l2cache_pmu,
> +				    l2_cache_pmu_probe_cluster);
> +	if (err < 0)
> +		return err;

We never expect a positive return value, so this should be:

	if (err)
		return err;

Thanks,
Mark.
