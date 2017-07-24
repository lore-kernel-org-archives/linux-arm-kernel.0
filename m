From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Mon, 24 Jul 2017 22:50:20 +0800
Subject: [PATCH v2 6/6] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <1500892161-17634-7-git-send-email-suzuki.poulose@arm.com>
References: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
 <1500892161-17634-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170724224953.00003297@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Jul 2017 11:29:21 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
> The DSU integrates one or more cores with an L3 memory system, control
> logic, and external interfaces to form a multicore cluster. The PMU
> allows counting the various events related to L3, SCU etc, along with
> providing a cycle counter.
> 
> The PMU can be accessed via system registers, which are common
> to the cores in the same cluster. The PMU registers follow the
> semantics of the ARMv8 PMU, mostly, with the exception that
> the counters record the cluster wide events.
> 
> This driver is mostly based on the ARMv8 and CCI PMU drivers.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
A few quick comments.

Jonathan
> ---
>  arch/arm64/include/asm/arm_dsu_pmu.h | 124 +++++
>  drivers/perf/Kconfig                 |   9 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/arm_dsu_pmu.c           | 877 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1011 insertions(+)
>  create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
>  create mode 100644 drivers/perf/arm_dsu_pmu.c
> 
> diff --git a/arch/arm64/include/asm/arm_dsu_pmu.h b/arch/arm64/include/asm/arm_dsu_pmu.h
> new file mode 100644
> index 0000000..e7276fd
> --- /dev/null
> +++ b/arch/arm64/include/asm/arm_dsu_pmu.h
> @@ -0,0 +1,124 @@
<snip>
> +static inline void __dsu_pmu_counter_interrupt_disable(int counter)
> +{
> +	write_sysreg_s(BIT(counter), CLUSTERPMINTENCLR_EL1);
> +	isb();
> +}
> +
> +
> +static inline u32 __dsu_pmu_read_pmceid(int n)
> +{
> +	switch (n) {
> +	case 0:
> +		return read_sysreg_s(CLUSTERPMCEID0_EL1);
> +	case 1:
> +		return read_sysreg_s(CLUSTERPMCEID1_EL1);
> +	default:
> +		BUILD_BUG();
> +		return 0;
> +	}
> +}
What is the benefit of having this lot in a header?  Is it to support future
additional drivers? If not, why not just push them down into the c code.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index e5197ff..ee3d7d1 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -17,6 +17,15 @@ config ARM_PMU_ACPI
>  	depends on ARM_PMU && ACPI
>  	def_bool y
>  
> +config ARM_DSU_PMU
> +	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
> +	depends on ARM64 && PERF_EVENTS
> +	  help
> +	  Provides support for performance monitor unit in ARM DynamIQ Shared
> +	  Unit (DSU). The DSU integrates one or more cores  with an L3 memory
> +	  system, control logic. The PMU allows counting various events related
> +	  to DSU.
> +
>  config QCOM_L2_PMU
>  	bool "Qualcomm Technologies L2-cache PMU"
>  	depends on ARCH_QCOM && ARM64 && ACPI
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 6420bd4..0adb4f6 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
>  obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> +obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
>  obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>  obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>  obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> new file mode 100644
> index 0000000..60b2c03
> --- /dev/null
> +++ b/drivers/perf/arm_dsu_pmu.c
<snip>
> +
> +/*
> + * Make sure the group of events can be scheduled at once
> + * on the PMU.
> + */
> +static int dsu_pmu_validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	struct dsu_hw_events fake_hw;
> +
> +	if (event->group_leader == event)
> +		return 0;
> +
> +	memset(fake_hw.used_mask, 0, sizeof(fake_hw.used_mask));
> +	if (!dsu_pmu_validate_event(event->pmu, &fake_hw, leader))
> +		return -EINVAL;
> +	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
> +		if (!dsu_pmu_validate_event(event->pmu, &fake_hw, sibling))
> +			return -EINVAL;
> +	}
> +	if (dsu_pmu_validate_event(event->pmu, &fake_hw, event))
Perhaps a comment to say why in this case validate_event has the opposite
meaning to the others cases above? (not !dsu_pmu_validate_event())
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int dsu_pmu_event_init(struct perf_event *event)
> +{
> +	struct dsu_pmu *dsu_pmu = to_dsu_pmu(event->pmu);
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (!dsu_pmu_event_supported(dsu_pmu, event->attr.config))
> +		return -EOPNOTSUPP;
> +
> +	/* We cannot support task bound events */
> +	if (event->cpu < 0) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support per-task counters\n");
> +		return -EINVAL;
> +	}
> +
> +	/* We don't support sampling */
> +	if (is_sampling_event(event)) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support sampling events\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (has_branch_stack(event) ||
> +	    event->attr.exclude_user ||
> +	    event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv ||
> +	    event->attr.exclude_idle ||
> +	    event->attr.exclude_host ||
> +	    event->attr.exclude_guest) {
> +		dev_dbg(dsu_pmu->pmu.dev, "Can't support filtering\n");
> +		return -EINVAL;
> +	}
> +
> +	if (dsu_pmu_validate_group(event))
> +		return -EINVAL;
> +
> +	event->cpu = cpumask_first(&dsu_pmu->active_cpu);
> +	if (event->cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	event->hw.config_base = event->attr.config;
> +	return 0;
> +}
> +
> +static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
> +{
> +	struct dsu_pmu *dsu_pmu;
> +
> +	dsu_pmu = devm_kzalloc(&pdev->dev, sizeof(*dsu_pmu), GFP_KERNEL);
> +	if (!dsu_pmu)
> +		return ERR_PTR(-ENOMEM);
A blank line here would make it a little more readable
> +	raw_spin_lock_init(&dsu_pmu->pmu_lock);
And one here.
> +	return dsu_pmu;
> +}
> +
> +/**
> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
> + */
> +static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
> +{
> +	int i = 0, n, cpu;
> +	struct device_node *cpu_node;
> +
> +	n = of_count_phandle_with_args(dev, "cpus", NULL);
> +	if (n <= 0)
> +		goto out;
> +	for (; i < n; i++) {
> +		cpu_node = of_parse_phandle(dev, "cpus", i);
> +		if (!cpu_node)
> +			break;
> +		cpu = of_device_node_get_cpu(cpu_node);
> +		of_node_put(cpu_node);
> +		if (cpu >= nr_cpu_ids)
> +			break;
It rather seems like this is an error we would not want to skip over.
> +		cpumask_set_cpu(cpu, mask);
> +	}
> +out:
> +	return i > 0;
Cleaner to actually return appropriate errors from within
this function and pass them all the way up.
> +}
> +
> +/*
> + * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
> + */
> +static void dsu_pmu_probe_pmu(void *data)
> +{
> +	struct dsu_pmu *dsu_pmu = data;
> +	u64 cpmcr;
> +	u32 cpmceid[2];
> +
> +	if (WARN_ON(!cpumask_test_cpu(smp_processor_id(),
> +		&dsu_pmu->supported_cpus)))
> +		return;
> +	cpmcr = __dsu_pmu_read_pmcr();
> +	dsu_pmu->num_counters = ((cpmcr >> CLUSTERPMCR_N_SHIFT) &
> +					CLUSTERPMCR_N_MASK);
> +	if (!dsu_pmu->num_counters)
> +		return;
> +	cpmceid[0] = __dsu_pmu_read_pmceid(0);
> +	cpmceid[1] = __dsu_pmu_read_pmceid(1);
> +	bitmap_from_u32array(dsu_pmu->cpmceid_bitmap,
> +				DSU_PMU_MAX_COMMON_EVENTS,
> +				cpmceid,
> +				ARRAY_SIZE(cpmceid));
> +}
> +
> +static void dsu_pmu_cleanup_dev(struct dsu_pmu *dsu_pmu)
> +{
> +	cpuhp_state_remove_instance(dsu_pmu_cpuhp_state, &dsu_pmu->cpuhp_node);
> +	irq_set_affinity_hint(dsu_pmu->irq, NULL);
> +}
> +
> +static int dsu_pmu_probe(struct platform_device *pdev)
> +{
> +	int irq, rc, cpu;
> +	struct dsu_pmu *dsu_pmu;
> +	char *name;
> +
> +	static atomic_t pmu_idx = ATOMIC_INIT(-1);
> +
> +
One blank line only.
> +	dsu_pmu = dsu_pmu_alloc(pdev);
> +	if (!dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->supported_cpus)) {
> +		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
> +		return -EINVAL;
> +	}
> +
> +	rc = smp_call_function_any(&dsu_pmu->supported_cpus,
> +					dsu_pmu_probe_pmu,
> +					dsu_pmu, 1);
> +	if (rc)
> +		return rc;
> +	if (!dsu_pmu->num_counters)
> +		return -ENODEV;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_warn(&pdev->dev, "Failed to find IRQ\n");
> +		return -EINVAL;
> +	}
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_%d",
> +				PMUNAME, atomic_inc_return(&pmu_idx));
> +	rc = devm_request_irq(&pdev->dev, irq, dsu_pmu_handle_irq,
> +					0, name, dsu_pmu);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "Failed to request IRQ %d\n", irq);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Find one CPU in the DSU to handle the IRQs.
> +	 * It is highly unlikely that we would fail
> +	 * to find one, given the probing has succeeded.
> +	 */
> +	cpu = dsu_pmu_get_online_cpu(dsu_pmu);
> +	if (cpu >= nr_cpu_ids)
> +		return -ENODEV;
> +	cpumask_set_cpu(cpu, &dsu_pmu->active_cpu);
> +	rc = irq_set_affinity_hint(irq, &dsu_pmu->active_cpu);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "Failed to force IRQ affinity for %d\n",
> +					 irq);
> +		return rc;
> +	}
It is a little unusual that you have the above two elements inline
here, but have a function to unwind them.  Just makes it a little
harder to read and leads to missing things like...
> +
> +	platform_set_drvdata(pdev, dsu_pmu);
> +	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
> +						&dsu_pmu->cpuhp_node);
> +	if (rc)
I believe irq_set_affinity_hit(dsu_pmu->irq, NULL) would make sense
here.
> +		return rc;
> +
> +	dsu_pmu->irq = irq;
> +	dsu_pmu->pmu = (struct pmu) {
> +		.task_ctx_nr	= perf_invalid_context,
> +
> +		.pmu_enable	= dsu_pmu_enable,
> +		.pmu_disable	= dsu_pmu_disable,
> +		.event_init	= dsu_pmu_event_init,
> +		.add		= dsu_pmu_add,
> +		.del		= dsu_pmu_del,
> +		.start		= dsu_pmu_start,
> +		.stop		= dsu_pmu_stop,
> +		.read		= dsu_pmu_read,
> +
> +		.attr_groups	= dsu_pmu_attr_groups,
> +	};
> +
> +	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
> +
> +	if (!rc)
> +		dev_info(&pdev->dev, "Registered %s with %d event counters",
> +				name, dsu_pmu->num_counters);
> +	else
> +		dsu_pmu_cleanup_dev(dsu_pmu);
It is cleaner to have the error handled as the 'exceptional'
element.  Slightly more code, but easier to read.
i.e.

	if (rc) {
		dsu_pmu_cleanup_dev(dsu_pmu);
		return rc;
	}

	dev_info(...)

> +	return rc;
> +}
> +
> +static int dsu_pmu_device_remove(struct platform_device *pdev)
The difference in naming style between this and probe is a little
confusing.

Why not dsu_pmu_remove?
> +{
> +	struct dsu_pmu *dsu_pmu = platform_get_drvdata(pdev);
> +
> +	dsu_pmu_cleanup_dev(dsu_pmu);
> +	perf_pmu_unregister(&dsu_pmu->pmu);
The remove order should be the reverse of probe.
It just makes it more 'obviously' right and saves reviewer time.
If there is a reason not to do this, there should be a comment saying
why.

> +	return 0;
> +}
> +
> +static const struct of_device_id dsu_pmu_of_match[] = {
> +	{ .compatible = "arm,dsu-pmu", },
> +	{},
> +};
> +
> +static struct platform_driver dsu_pmu_driver = {
> +	.driver = {
> +		.name	= DRVNAME,
> +		.of_match_table = of_match_ptr(dsu_pmu_of_match),
> +	},
> +	.probe = dsu_pmu_probe,
> +	.remove = dsu_pmu_device_remove,
> +};
> +
> +static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> +{
> +	int dst;
> +	struct dsu_pmu *dsu_pmu = container_of(node,
> +						struct dsu_pmu, cpuhp_node);
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
> +		return 0;
> +
> +	dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
> +	if (dst < nr_cpu_ids) {
> +		cpumask_set_cpu(dst, &dsu_pmu->active_cpu);
> +		perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
> +		irq_set_affinity_hint(dsu_pmu->irq, &dsu_pmu->active_cpu);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init dsu_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +					DRVNAME,
> +					NULL,
> +					dsu_pmu_cpu_teardown);
> +	if (ret < 0)
> +		return ret;
> +	dsu_pmu_cpuhp_state = ret;
I'm just curious - what prevents this initialization being done in probe
rather than init?

> +	return platform_driver_register(&dsu_pmu_driver);
> +}
> +
> +static void __exit dsu_pmu_exit(void)
> +{
> +	platform_driver_unregister(&dsu_pmu_driver);
> +	cpuhp_remove_multi_state(dsu_pmu_cpuhp_state);
> +}
> +
> +module_init(dsu_pmu_init);
> +module_exit(dsu_pmu_exit);
> +
> +MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
> +MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
> +MODULE_LICENSE("GPL v2");
