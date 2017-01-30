From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jan 2017 15:19:02 +0000
Subject: [PATCH v8] perf: add qcom l2 cache perf events driver
In-Reply-To: <1484592767-23687-1-git-send-email-nleeder@codeaurora.org>
References: <1484592767-23687-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <20170130151901.GB1160@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Apologies for the delay in getting to this.

This is largely looking good now.

I have a couple of concerns with the hotplug logic, but I think we can
solve those without too much pain. More on that below.

On Mon, Jan 16, 2017 at 01:52:47PM -0500, Neil Leeder wrote:

> +#define L2PMRESR_EN             ((u64)1 << 63)

Nit: please use BIT_ULL() for consistency with other definitions below.

> +#define L2_COUNTER_RELOAD       BIT_ULL(31)
> +#define L2_CYCLE_COUNTER_RELOAD BIT_ULL(63)

[...]

> +#define L2CPUSRSELR_EL1         S3_3_c15_c0_6
> +#define L2CPUSRDR_EL1           S3_3_c15_c0_7

I should have realsied this before, but some old toolchains don't
support this format, as we discovered in commit 72c5839515260dce
("arm64: gicv3: Allow GICv3 compilation with older binutils").

So I think we need to use sys_reg() for these, i.e.

#define SYS_L2CPUSRSELR_EL1	sys_reg(3, 3, 15, 0, 6)
#defing SYS_L2CPUSRDR_EL1	sys_reg(3, 3, 15, 0, 7)

... and correspondingly we need to use {read_write}_sysreg_s() to
perform accesses to those.

[...]

> +static DEFINE_RAW_SPINLOCK(l2_access_lock);
> +
> +/**
> + * set_l2_indirect_reg: write value to an L2 register
> + * @reg: Address of L2 register.
> + * @value: Value to be written to register.
> + *
> + * Use architecturally required barriers for ordering between system register
> + * accesses
> + */
> +static void set_l2_indirect_reg(u64 reg, u64 val)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&l2_access_lock, flags);
> +	write_sysreg(reg, L2CPUSRSELR_EL1);
> +	isb();
> +	write_sysreg(val, L2CPUSRDR_EL1);
> +	isb();
> +	raw_spin_unlock_irqrestore(&l2_access_lock, flags);
> +}

This is fine as is, but just for my understanding, I take it that the
locking is only strictly required to be per-cluster?

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
> +			"Failed to reset on cluster with cpu %d\n",
> +			cpumask_first(&cluster->cluster_cpus));
> +}

We only ever call these in the probe path, which I don't think is
sufficient. We can boot with a limited set of CPUs since commit
44dbcc93ab67145b ("arm64: Fix behavior of maxcpus=N"), so this might not
reset all the PMU hardware.

I also assume that if a cluster is hotplugged off, the PMU hardware may
lose state (i.e. it is not in an always-on domain separated from the
CPUs), and therefore may need to be reset after CPUs have been
hotplugged in.

We can cater for both of these by moving the reset call into the hotplug
callback. I've give na a concrete example below for that.


[...]

> +		counter_reg = (idx * IA_L2_REG_OFFSET) + IA_L2PMXEVCNTR_BASE;
> +		set_l2_indirect_reg(counter_reg, value & GENMASK(31, 0));

We should drop the masking here; it's not necessary given we only
program a fixed value. Were it necessary, there'd be a potential
mismatch with prev_count.

[...]

> +		counter_reg = (idx * IA_L2_REG_OFFSET) + IA_L2PMXEVCNTR_BASE;
> +		value = get_l2_indirect_reg(counter_reg);

Given this pattern crops up a few times, can we drop something like:

#define reg_idx(reg, i)		((i * IA_L2_REG_OFFSET) + reg ## _BASE)

... at the top of the file, so we can write this inline:

		value = get_l2_indirect_reg(reg_idx(IA_L2PMXEVCNTR, idx));

[...]

> +static int l2_cache_filter_match(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hw_perf_event *chwc;
> +	struct cluster_pmu *cluster = get_cluster_pmu(event->cpu);
> +	struct l2cache_pmu *l2cache_pmu;
> +	struct perf_event *conflict_event;
> +	unsigned int group = L2_EVT_GROUP(hwc->config_base);
> +
> +	/*
> +	 * Check for column exclusion: event column already in use by another
> +	 * event. This is for events which are not in the same group.
> +	 * Conflicting events in the same group are detected in event_init.
> +	 */
> +
> +	if (test_bit(group, cluster->used_groups)) {

Nit: this nesting is more painful than is necessary to read. Please
invert the condition and use an early return here.

> +		conflict_event =
> +			cluster->events[cluster->group_to_counter[group]];
> +		if (conflict_event != event) {

If it's possible for conflict_event == event, it sounds like this is
fragile to the order events are added or removed.

When does conflict_event == event?

> +			l2cache_pmu = to_l2cache_pmu(event->pmu);
> +			chwc = &conflict_event->hw;
> +			dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
> +				    "column exclusion between events %lx %lx\n",
> +				    hwc->config_base, chwc->config_base);

This could happen fairly often, and even with ratelimiting we're doing
unnecessary work. Can we get rid of the debug logic here?

[...]

> +static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct cluster_pmu *cluster;
> +	cpumask_t cluster_online_cpus;
> +	struct l2cache_pmu *l2cache_pmu;
> +
> +	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
> +	cluster = get_cluster_pmu(cpu);

As far as I can tell, the probe path doesn't verify that we've set this
for each cluster. Either we should ensure that in the probe path, or
check for !cluster here.

It feels very odd to use the global l2cache_pmu here in conjunction with
an instance from the hotplug callback. Either we shouldn't use the
instance API, or we should dynamically allocate the per-cpu cluster_pmu
for each l2cache_pmu we register.

I'd prefer the latter, since that will end up more consistent with what
we may need to do for other system PMUs. We'll have to add an
l2cache_pmu parameter to get_cluster_pmu(), but that doesn't look too
painful.

> +	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
> +		    cpu_online_mask);
> +
> +	if (cpumask_weight(&cluster_online_cpus) == 1) {
> +		/* all CPUs on this cluster were down, use this one */
> +		cluster->on_cpu = cpu;
> +		cpumask_set_cpu(cpu, &l2cache_pmu->cpumask);
> +		WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
> +	}
> +
> +	return 0;
> +}
> +
> +static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct cluster_pmu *cluster;
> +	struct l2cache_pmu *l2cache_pmu;
> +	cpumask_t cluster_online_cpus;
> +	unsigned int target;
> +
> +	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &l2cache_pmu->cpumask))
> +		return 0;
> +	cluster = get_cluster_pmu(cpu);
> +	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
> +		    cpu_online_mask);
> +
> +	/* Any other CPU for this cluster which is still online */
> +	target = cpumask_any_but(&cluster_online_cpus, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
> +	cluster->on_cpu = target;
> +	cpumask_set_cpu(target, &l2cache_pmu->cpumask);
> +	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
> +
> +	return 0;
> +}

To ensure that we reliably reset clusters, and so as to avoid redundant
cpumask copies, I think we should rewrite the hotplug callbacks
something like as follows.

We'd use cluster->on_cpu == -1 to indicate when a cluster doesn't have
an assigned owner. In the probe path, we'd request IRQs in a disabled
state, and we'd register the notifier *with* calls, so that it sets up
all (currently online) CPUs automatically, and handles hotplug in the
same way.

static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
{
	struct cluster_pmu *cluster;
	struct l2cache_pmu *l2cache_pmu;

	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
	cluster = get_cluster_pmu(l2cache_pmu, cpu);
	if (!cluster)
		return 0;

	/* If a CPU is already managing this cluster, we're done */
	if (cluster->on_cpu != -1)
		return 0;
	
	/*
	 * This is the first onlined CPU in the cluster. Take ownership
	 * of the cluster PMU, and make sure it's in a sane state.
	 */
	cluster->on_cpu = cpu;
	cpumask_set_cpu(cpu, &l2cache_pmu->cpumask);

	cluster_pmu_reset();
	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
	enable_irq(cluster->irq);

	return 0;
}

static int l2cache_pmu_offline_cpu(unsigned int cpu)
{
	struct cluster_pmu *cluster;
	struct l2cache_pmu *l2cache_pmu;
	int target;

	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
	cluster = get_cluster_pmu(l2cache_pmu, cpu);
	if (!cluster)
		return 0;

	/* If another CPU is managing this cluster, we're done */
	if (cluster->on_cpu != cpu)
		return;

	/* Give up ownership of the cluster */
	cpumask_clear_cpu(cpu, &l2cache_pmu->cpumask);
	cluster->on_cpu = -1;

	/* Try to find a new owner */
	target = cpumask_any_any(cpu_online_mask, &cluster->cluster_cpus);
	if (target >= nr_cpu_ids) {
		disable_irq(cluster->irq);
		return 0;
	}

	/* Hand the cluster over to the new owner */
	perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
	cluster->on_cpu = target;
	cpumask_set_cpu(target, &l2cache_pmu->cpumask);
	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));

	return 0;
}

[...]

> +static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev->parent);
> +	struct platform_device *sdev = to_platform_device(dev);
> +	struct l2cache_pmu *l2cache_pmu = data;
> +	struct cluster_pmu *cluster;
> +	struct acpi_device *device;
> +	unsigned long fw_cluster_id;
> +	int cpu;
> +	int err;
> +	int irq;
> +
> +	if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
> +		return -ENODEV;
> +
> +	if (kstrtol(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
> +		dev_err(&pdev->dev, "unable to read ACPI uid\n");
> +		return -ENODEV;
> +	}
> +
> +	irq = platform_get_irq(sdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"Failed to get valid irq for cluster %ld\n",
> +			fw_cluster_id);
> +		return irq;
> +	}
> +
> +	cluster = devm_kzalloc(&pdev->dev, sizeof(*cluster), GFP_KERNEL);
> +	if (!cluster)
> +		return -ENOMEM;
> +

Please allocate this at the start of the function. That way we don't
have to defer assigning things to it (e.g. the irq below, which looks
out of place).

> +	cluster->l2cache_pmu = l2cache_pmu;
> +	for_each_present_cpu(cpu) {
> +		if (topology_physical_package_id(cpu) == fw_cluster_id) {
> +			cpumask_set_cpu(cpu, &cluster->cluster_cpus);
> +			per_cpu(pmu_cluster, cpu) = cluster;
> +		}
> +	}

Sorry to go back-and-forth on this particular point, but I am worried
that this is a little fragile, since the topology stuff is largely a
guess, and I can imagine it might change in future.

What exactly is the fw_cluster_id? Is it always a particular Aff<N>
field? Might it differ in future?

> +	cluster->irq = irq;
> +
> +	if (cpumask_empty(&cluster->cluster_cpus)) {
> +		dev_err(&pdev->dev, "No CPUs found for L2 cache instance %ld\n",
> +			fw_cluster_id);
> +		return -ENODEV;
> +	}

This can happen if nr_cpus is capped. So this should probably be a
dev_warn(), rather than a dev_err().

> +
> +	/* Pick one CPU to be the preferred one to use in the cluster */
> +	cluster->on_cpu = cpumask_first(&cluster->cluster_cpus);

With the notifier rework:

	cluster->on_cpu = -1;

> +	if (irq_set_affinity(irq, cpumask_of(cluster->on_cpu))) {
> +		dev_err(&pdev->dev,
> +			"Unable to set irq affinity (irq=%d, cpu=%d)\n",
> +			irq, cluster->on_cpu);
> +		return -ENODEV;
> +	}

... and this can go too. However, we will need:

	irq_set_status_flags(irq, IRQ_NOAUTOEN);

... to ensure that we don't enable the IRQ until we've reset the HW and
are ready to handle it.

> +
> +	err = devm_request_irq(&pdev->dev, irq, l2_cache_handle_irq,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			       "l2-cache-pmu", cluster);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Unable to request IRQ%d for L2 PMU counters\n", irq);
> +		return err;
> +	}
> +
> +	dev_info(&pdev->dev,
> +		 "Registered L2 cache PMU instance %ld with %d CPUs\n",
> +		 fw_cluster_id, cpumask_weight(&cluster->cluster_cpus));
> +
> +	spin_lock_init(&cluster->pmu_lock);
> +	cpumask_set_cpu(cluster->on_cpu, &l2cache_pmu->cpumask);
> +
> +	cluster_pmu_reset(cluster);

... and the cpumask manipulation and reset can disappear, given the
hotplug callback should handle that.

> +	l2cache_pmu->num_pmus++;
> +
> +	return 0;
> +}
> +
> +static int l2_cache_pmu_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	struct l2cache_pmu *l2cache_pmu;
> +
> +	l2cache_pmu =
> +		devm_kzalloc(&pdev->dev, sizeof(*l2cache_pmu), GFP_KERNEL);
> +	if (!l2cache_pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, l2cache_pmu);
> +	l2cache_pmu->pmu = (struct pmu) {
> +		/* suffix is instance id for future use with multiple sockets */
> +		.name		= "l2cache_0",
> +		.task_ctx_nr    = perf_invalid_context,
> +		.pmu_enable	= l2_cache_pmu_enable,
> +		.pmu_disable	= l2_cache_pmu_disable,
> +		.event_init	= l2_cache_event_init,
> +		.add		= l2_cache_event_add,
> +		.del		= l2_cache_event_del,
> +		.start		= l2_cache_event_start,
> +		.stop		= l2_cache_event_stop,
> +		.read		= l2_cache_event_read,
> +		.attr_groups	= l2_cache_pmu_attr_grps,
> +		.filter_match   = l2_cache_filter_match,
> +	};
> +
> +	l2cache_pmu->num_counters = get_num_counters();
> +	l2cache_pmu->pdev = pdev;
> +	l2_cycle_ctr_idx = l2cache_pmu->num_counters - 1;
> +	l2_counter_present_mask = GENMASK(l2cache_pmu->num_counters - 2, 0) |
> +		BIT(L2CYCLE_CTR_BIT);
> +
> +	cpumask_clear(&l2cache_pmu->cpumask);
> +
> +	/* Read cluster info and initialize each cluster */
> +	err = device_for_each_child(&pdev->dev, l2cache_pmu,
> +				    l2_cache_pmu_probe_cluster);
> +	if (err < 0)
> +		return err;

As mentioned above, if nr_cpus is capped, we might have discovered a
cluster for which all the CPUs are !possible (and therefore !present).
We should be able to continue without the cluster in that case.

However, we should verify that each present cpu is associated with a
cluster. e.g.

	for_each_present_cpu(cpu) {
		if (per_cpu(pmu_cluster, cpu))
			continue;

		pr_err("Didn't find an L2 cluster for cpu%d\n", cpu);
		return -EINVAL;
	}

> +
> +	if (l2cache_pmu->num_pmus == 0) {
> +		dev_err(&pdev->dev, "No hardware L2 cache PMUs found\n");
> +		return -ENODEV;
> +	}
> +
> +	err = cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
> +					       &l2cache_pmu->node);

We'll need to use cpuhp_state_add_instance() here to ensure we get
consistent reset behaviour.

Thanks,
Mark.
