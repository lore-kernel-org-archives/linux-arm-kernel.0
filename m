From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 24 Jul 2017 16:44:51 +0100
Subject: [PATCH v2 6/6] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20170724224953.00003297@huawei.com>
References: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
 <1500892161-17634-7-git-send-email-suzuki.poulose@arm.com>
 <20170724224953.00003297@huawei.com>
Message-ID: <7ac78a73-b06f-3af0-251e-41b0cc3013c5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,


On 24/07/17 15:50, Jonathan Cameron wrote:
> On Mon, 24 Jul 2017 11:29:21 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>> Add support for the Cluster PMU part of the ARM DynamIQ Shared Unit (DSU).
>> The DSU integrates one or more cores with an L3 memory system, control
>> logic, and external interfaces to form a multicore cluster. The PMU
>> allows counting the various events related to L3, SCU etc, along with
>> providing a cycle counter.
>>
>> The PMU can be accessed via system registers, which are common
>> to the cores in the same cluster. The PMU registers follow the
>> semantics of the ARMv8 PMU, mostly, with the exception that
>> the counters record the cluster wide events.
>>
>> This driver is mostly based on the ARMv8 and CCI PMU drivers.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> A few quick comments.

Thanks for the detailed look. Comments in line. Btw, please could you leave a
blank line after the quoted text and before your comment (like what I have
don here) ? That way, it is way may much easier to find your comments.

>
> Jonathan
>> ---

>>
>> diff --git a/arch/arm64/include/asm/arm_dsu_pmu.h b/arch/arm64/include/asm/arm_dsu_pmu.h
>> new file mode 100644
>> index 0000000..e7276fd
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/arm_dsu_pmu.h
>> @@ -0,0 +1,124 @@
> <snip>
>> +static inline void __dsu_pmu_counter_interrupt_disable(int counter)
>> +{
>> +	write_sysreg_s(BIT(counter), CLUSTERPMINTENCLR_EL1);
>> +	isb();
>> +}
>> +
>> +
>> +static inline u32 __dsu_pmu_read_pmceid(int n)
>> +{
>> +	switch (n) {
>> +	case 0:
>> +		return read_sysreg_s(CLUSTERPMCEID0_EL1);
>> +	case 1:
>> +		return read_sysreg_s(CLUSTERPMCEID1_EL1);
>> +	default:
>> +		BUILD_BUG();
>> +		return 0;
>> +	}
>> +}
> What is the benefit of having this lot in a header?  Is it to support future
> additional drivers? If not, why not just push them down into the c code.

As I mentioned in the cover letter, this is to keep the architecture specific code
separate so that we could easily add support for this on arm32 kernel.

>> --- /dev/null
>> +++ b/drivers/perf/arm_dsu_pmu.c
> <snip>
>> +
>> +/*
>> + * Make sure the group of events can be scheduled at once
>> + * on the PMU.
>> + */
>> +static int dsu_pmu_validate_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +	struct dsu_hw_events fake_hw;
>> +
>> +	if (event->group_leader == event)
>> +		return 0;
>> +
>> +	memset(fake_hw.used_mask, 0, sizeof(fake_hw.used_mask));
>> +	if (!dsu_pmu_validate_event(event->pmu, &fake_hw, leader))
>> +		return -EINVAL;
>> +	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
>> +		if (!dsu_pmu_validate_event(event->pmu, &fake_hw, sibling))
>> +			return -EINVAL;
>> +	}
>> +	if (dsu_pmu_validate_event(event->pmu, &fake_hw, event))
> Perhaps a comment to say why in this case validate_event has the opposite
> meaning to the others cases above? (not !dsu_pmu_validate_event())

Ah! Thanks for spotting. Thats a mistake. It should be !dsu_pmu_validate_event().
I will fix it in the next version. We are making sure that the event can be
scheduled, with the other events in the group already added.

>> +
>> +static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>> +{
>> +	struct dsu_pmu *dsu_pmu;
>> +
>> +	dsu_pmu = devm_kzalloc(&pdev->dev, sizeof(*dsu_pmu), GFP_KERNEL);
>> +	if (!dsu_pmu)
>> +		return ERR_PTR(-ENOMEM);
> A blank line here would make it a little more readable
>> +	raw_spin_lock_init(&dsu_pmu->pmu_lock);
> And one here.
>> +	return dsu_pmu;

It doesn't look that complex here, given it doesn't take the lock.
If it does help the reading, I could add it.

>> +}
>> +
>> +/**
>> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
>> + */
>> +static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>> +{
>> +	int i = 0, n, cpu;
>> +	struct device_node *cpu_node;
>> +
>> +	n = of_count_phandle_with_args(dev, "cpus", NULL);
>> +	if (n <= 0)
>> +		goto out;
>> +	for (; i < n; i++) {
>> +		cpu_node = of_parse_phandle(dev, "cpus", i);
>> +		if (!cpu_node)
>> +			break;
>> +		cpu = of_device_node_get_cpu(cpu_node);
>> +		of_node_put(cpu_node);
>> +		if (cpu >= nr_cpu_ids)
>> +			break;
> It rather seems like this is an error we would not want to skip over.

Ok. That makes sense to me. I can return -EINVAL here.

>> +		cpumask_set_cpu(cpu, mask);
>> +	}
>> +out:
>> +	return i > 0;
> Cleaner to actually return appropriate errors from within
> this function and pass them all the way up.

Sure, will do.

>> +static int dsu_pmu_probe(struct platform_device *pdev)
>> +{
>> +	int irq, rc, cpu;
>> +	struct dsu_pmu *dsu_pmu;
>> +	char *name;
>> +
>> +	static atomic_t pmu_idx = ATOMIC_INIT(-1);
>> +
>> +
> One blank line only.

Ok.

>> +	/*
>> +	 * Find one CPU in the DSU to handle the IRQs.
>> +	 * It is highly unlikely that we would fail
>> +	 * to find one, given the probing has succeeded.
>> +	 */
>> +	cpu = dsu_pmu_get_online_cpu(dsu_pmu);
>> +	if (cpu >= nr_cpu_ids)
>> +		return -ENODEV;
>> +	cpumask_set_cpu(cpu, &dsu_pmu->active_cpu);
>> +	rc = irq_set_affinity_hint(irq, &dsu_pmu->active_cpu);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "Failed to force IRQ affinity for %d\n",
>> +					 irq);
>> +		return rc;
>> +	}

> It is a little unusual that you have the above two elements inline
> here, but have a function to unwind them.  Just makes it a little
> harder to read and leads to missing things like...

The unwinding was added as a function to reuse the code. The "setup" steps
undone by the unwind doesn't look separate from what we do in the probe,
hence didn't go for a separate function.

>> +
>> +	platform_set_drvdata(pdev, dsu_pmu);
>> +	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
>> +						&dsu_pmu->cpuhp_node);
>> +	if (rc)
> I believe irq_set_affinity_hit(dsu_pmu->irq, NULL) would make sense
> here.

Yes, you're right. Otherwise we could hit a WARN_ON. I will rearrange
the probe code to a cleaner state.

>> +		return rc;
>> +
>> +	dsu_pmu->irq = irq;
>> +	dsu_pmu->pmu = (struct pmu) {
>> +		.task_ctx_nr	= perf_invalid_context,
>> +
>> +		.pmu_enable	= dsu_pmu_enable,
>> +		.pmu_disable	= dsu_pmu_disable,
>> +		.event_init	= dsu_pmu_event_init,
>> +		.add		= dsu_pmu_add,
>> +		.del		= dsu_pmu_del,
>> +		.start		= dsu_pmu_start,
>> +		.stop		= dsu_pmu_stop,
>> +		.read		= dsu_pmu_read,
>> +
>> +		.attr_groups	= dsu_pmu_attr_groups,
>> +	};
>> +
>> +	rc = perf_pmu_register(&dsu_pmu->pmu, name, -1);
>> +
>> +	if (!rc)
>> +		dev_info(&pdev->dev, "Registered %s with %d event counters",
>> +				name, dsu_pmu->num_counters);
>> +	else
>> +		dsu_pmu_cleanup_dev(dsu_pmu);
> It is cleaner to have the error handled as the 'exceptional'
> element.  Slightly more code, but easier to read.
> i.e.
>
> 	if (rc) {
> 		dsu_pmu_cleanup_dev(dsu_pmu);
> 		return rc;
> 	}
>
> 	dev_info(...)

Ok.

>
>> +	return rc;
>> +}
>> +
>> +static int dsu_pmu_device_remove(struct platform_device *pdev)
> The difference in naming style between this and probe is a little
> confusing.
>

Ok

> Why not dsu_pmu_remove?

Because it is callback for the platform device, which should eventually
remove the PMU and any other cleanups. I could rename the probe to match it,
i.e, dsu_pmu_device_probe().


>> +{
>> +	struct dsu_pmu *dsu_pmu = platform_get_drvdata(pdev);
>> +
>> +	dsu_pmu_cleanup_dev(dsu_pmu);
>> +	perf_pmu_unregister(&dsu_pmu->pmu);
> The remove order should be the reverse of probe.
> It just makes it more 'obviously' right and saves reviewer time.
> If there is a reason not to do this, there should be a comment saying
> why.
>

No, you're right. It should be in the reverse order, I will fix it.

>> +
>> +
>> +static int __init dsu_pmu_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>> +					DRVNAME,
>> +					NULL,
>> +					dsu_pmu_cpu_teardown);
>> +	if (ret < 0)
>> +		return ret;
>> +	dsu_pmu_cpuhp_state = ret;
> I'm just curious - what prevents this initialization being done in probe
> rather than init?
>

Because, you need to do that only one per system and rather than one per DSU.
There could be multiple DSUs connected via other links on a bigger platform.


Suzuki
