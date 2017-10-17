From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Oct 2017 16:06:21 +0100
Subject: [PATCH v5 2/6] perf: hisi: Add support for HiSilicon SoC uncore
 PMU driver
In-Reply-To: <1503389277-134131-3-git-send-email-zhangshaokun@hisilicon.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
 <1503389277-134131-3-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20171017150621.nfoto5fhma24zvve@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Apologies for the delay for this review.

Largely this seems to look OK, but there are a couple of things which
stick out.

On Tue, Aug 22, 2017 at 04:07:53PM +0800, Shaokun Zhang wrote:
> +int hisi_uncore_pmu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hisi_pmu *hisi_pmu;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * We do not support sampling as the counters are all
> +	 * shared by all CPU cores in a CPU die(SCCL). Also we
> +	 * do not support attach to a task(per-process mode)
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +
> +	/* counters do not have these bits */
> +	if (event->attr.exclude_user	||
> +	    event->attr.exclude_kernel	||
> +	    event->attr.exclude_host	||
> +	    event->attr.exclude_guest	||
> +	    event->attr.exclude_hv	||
> +	    event->attr.exclude_idle)
> +		return -EINVAL;
> +
> +	/*
> +	 *  The uncore counters not specific to any CPU, so cannot
> +	 *  support per-task
> +	 */
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Validate if the events in group does not exceed the
> +	 * available counters in hardware.
> +	 */
> +	if (!hisi_validate_event_group(event))
> +		return -EINVAL;
> +
> +	/*
> +	 * We don't assign an index until we actually place the event onto
> +	 * hardware. Use -1 to signify that we haven't decided where to put it
> +	 * yet.
> +	 */
> +	hwc->idx		= -1;
> +	hwc->config_base	= event->attr.config;

Are all event codes valid?

e.g. is it possible that some value passed by the user would cause a
problem were it written to the hardware?

I see that you only use the low 8 bits of the config field elsewhere, so
it might make sense to sanity check that here rather than having to mask
it elsewhere.

That would make future extension safer, since no-one could be relying on
passing a dodgy value in.

> +
> +	hisi_pmu = to_hisi_pmu(event->pmu);
> +	/* Enforce to use the same CPU for all events in this PMU */
> +	event->cpu = hisi_pmu->on_cpu;

I think you need to check hisi_pmu->on_cpu != -1, otherwise we can
accidentally create a task-bound event if a cluster is offline, and I'm
not sure how the perf core code would handle here.

> +
> +	return 0;
> +}

[...]

> +int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *hisi_pmu;
> +
> +	hisi_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +
> +	/*
> +	 * If the CPU is associated with the PMU, set it in online_cpus of
> +	 * the PMU.
> +	 */
> +	if (cpumask_test_cpu(cpu, &hisi_pmu->associated_cpus))
> +		cpumask_set_cpu(cpu, &hisi_pmu->online_cpus);
> +	else
> +		return 0;

This would be a bit nicer as:

	if (!cpumask_test_cpu(cpu, &hisi_pmu->associated_cpus))
		return 0;

	cpumask_set_cpu(cpu, &hisi_pmu->online_cpus);


However, I don't think you need hisi_pmu::online_cpus. That's only used
for the online/offline callbacks, and you can use the
hisi_pmu::associated_cpus mask in hisi_uncore_pmu_offline_cpu(), and
avoid altering any mask here.

> +
> +	/* If another CPU is already managing this PMU, simply return. */
> +	if (hisi_pmu->on_cpu != -1)
> +		return 0;
> +
> +	/* Use this CPU in cpumask for event counting */
> +	hisi_pmu->on_cpu = cpu;
> +
> +	/* Overflow interrupt also should use the same CPU */
> +	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
> +
> +	return 0;
> +}
> +
> +int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pmu *hisi_pmu;
> +	cpumask_t pmu_online_cpus;
> +	unsigned int target;
> +
> +	hisi_pmu = hlist_entry_safe(node, struct hisi_pmu, node);
> +
> +	/*
> +	 * If the CPU is online with the PMU, clear it in online_cpus of
> +	 * the PMU.
> +	 */
> +	if (!cpumask_test_and_clear_cpu(cpu, &hisi_pmu->online_cpus) ||
> +	    (hisi_pmu->on_cpu != cpu))
> +		return 0;
> +
> +	hisi_pmu->on_cpu = -1;
> +
> +	/* Any other CPU associated with the PMU is still online */
> +	cpumask_and(&pmu_online_cpus, &hisi_pmu->online_cpus, cpu_online_mask);
> +	target = cpumask_any_but(&pmu_online_cpus, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;

I think you can get rid of hisi_pmu::online_cpus, and replace the mask
manipulation above with:

	/* Nothing to do if this CPU doesn't own the PMU */
	if (hisi_pmu->on_cpu != cpu)
		return 0;
	
	/* Give up ownership of the PMU */
	hisi_pmu->on_cpu = -1;

	/* Choose a new CPU to migrate ownership of the PMU to */
	cpumask_and(&pmu_online_cpus, &hisi_pmu->associated_cpus,
		    cpu_online_mask)
	target = cpumask_any_but(&pmu_online_cpus, cpu);
	if (target >= nr_cpu_ids)
		return 0;

> +
> +	perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
> +	/* Use this CPU for event counting */
> +	hisi_pmu->on_cpu = target;
> +	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
> +
> +	return 0;
> +}
> +
> +/*
> + * Check whether the CPU is associated with this uncore PMU by SCCL_ID,
> + * if true, set the associated cpumask of the uncore PMU.
> + */
> +void hisi_uncore_pmu_set_cpumask_by_sccl(void *arg)

Perhaps:

hisi_uncore_pmu_check_associate_cpu(struct hisi_pmu *pmu)

It's not clear to me why the arg is a void pointer.

> +{
> +	struct hisi_pmu *hisi_pmu = (struct hisi_pmu *)arg;

This cast shouldn't be necessary.

> +	u32 sccl_id;
> +
> +	hisi_read_sccl_and_ccl_id(&sccl_id, NULL);
> +	if (sccl_id == hisi_pmu->sccl_id)
> +		cpumask_set_cpu(smp_processor_id(), &hisi_pmu->associated_cpus);
> +}

[...]

> +/* Generic pmu struct for different pmu types */
> +struct hisi_pmu {
> +	struct pmu pmu;
> +	const struct hisi_uncore_ops *ops;
> +	struct hisi_pmu_hwevents pmu_events;
> +	/*
> +	 * online_cpus: All online CPUs associated with the PMU
> +	 * associated_cpus: All CPUs associated with the PMU who is
> +	 * initialised when probe.
> +	 */
> +	cpumask_t online_cpus, associated_cpus;
> +	/* CPU used for counting */
> +	int on_cpu;
> +	int irq;
> +	struct device *dev;
> +	struct hlist_node node;
> +	u32 sccl_id;
> +	u32 ccl_id;
> +	/* Hardware information for different pmu types */
> +	void __iomem *base;
> +	/* the ID of the PMU modules */
> +	u32 id;

Is this what hte documentation referred to as the index-id?

It might make sense to call it index_id.

> +	int num_counters;
> +	int counter_bits;
> +};

Thanks,
Mark.
