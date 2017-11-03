From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 3 Nov 2017 14:34:30 +0000
Subject: [PATCH v9 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20171103122035.7jvgpn434thjoufr@lakrids.cambridge.arm.com>
References: <20171031172318.11823-1-suzuki.poulose@arm.com>
 <20171031172318.11823-9-suzuki.poulose@arm.com>
 <20171103122035.7jvgpn434thjoufr@lakrids.cambridge.arm.com>
Message-ID: <bea99cb3-5f4b-962f-2d8d-c2b2364db651@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/17 12:20, Mark Rutland wrote:
> Hi Suzuki,
> 
> This looks good, but there are a couple of edge cases I think that we
> need to handle, as noted below.
> 
> On Tue, Oct 31, 2017 at 05:23:18PM +0000, Suzuki K Poulose wrote:
>> Changes since V8:
> 
>>   - Fill in the "module" field for the PMU to prevent the module unload
>>     when the PMU is active.
> 
> Huh. For some reason I thought that was done automatically, but having
> looked, I see that it is not.
> 
> It looks like this is missing from the SPE PMU, and the CCN PMU. Would
> you mind fixing those up?
> 
> The only other PMU that I see affected is the AMD power PMU; I've pinged
> the maintainer separately.
> 
> [...]
> 
>> +The driver also exposes the CPUs connected to the DSU instance in "associated_cpus".
> 
> Just to check, is there a user of this?
> 
> I agree that it could be useful, but AFAICT the perf tool won't look at
> this, so it seems odd to expose it. I'd feel happier punting on exposing
> that so that we can settle on a common name for this across
> uncore/system PMUs.

It allows the user to identify the DSU instance to profile if there are
multiple DSUs on the system. Also this information can be used to identify
the "cpu" list that can be provided for -C option.

> 
> [...]
> 
>> +static void dsu_pmu_probe_pmu(void *data)
>> +{
> 
>> +	/* We can only support upto 31 independent counters */
> 
> Nit: s/upto/up to/
> 
> [...]
> 
>> +static void dsu_pmu_init_pmu(struct dsu_pmu *dsu_pmu)
>> +{
>> +	int cpu, rc;
>> +
>> +	cpu = dsu_pmu_get_online_cpu(dsu_pmu);
>> +	/* Defer, if we don't have any active CPUs in the DSU */
>> +	if (cpu >= nr_cpu_ids)
>> +		return;
>> +	rc = smp_call_function_single(cpu, dsu_pmu_probe_pmu, dsu_pmu, 1);
>> +	if (rc)
>> +		return;
>> +	/* Reset the interrupt overflow mask */
>> +	dsu_pmu_get_reset_overflow();
>> +	dsu_pmu_set_active_cpu(cpu, dsu_pmu);
>> +}
> 
> I think this can be simplified by only callnig this in the hotplug
> callback, and not donig the corss-call at all at driver init time. That
> way, we can do:
> 
> static void dsu_pmu_init_pmu(struct dsu_pmu *dsu_pmu)
> {
> 	if (dsu_pmu->num_counters == -1)
> 		dsu_pmu_probe_pmu(dsu_pmu);
> 	
> 	dsu_pmu_get_reset_overflow();
> }
> 
> ... which also means we can simplify the prototype of
> dsu_pmu_probe_pmu().
> 
> Note that the dsu_pmu_set_active_cpu() can be factored out to the
> caller, which is a little clearer, as I suiggest below.
> 
>> +static int dsu_pmu_device_probe(struct platform_device *pdev)
>> +{
> 
>> +	/*
>> +	 * We could defer probing the PMU details from the registers until
>> +	 * an associated CPU is online.
>> +	 */
>> +	dsu_pmu_init_pmu(dsu_pmu);
> 
> ... then we can drop this line ...
> 
>> +	platform_set_drvdata(pdev, dsu_pmu);
>> +	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
>> +						&dsu_pmu->cpuhp_node);
> 
> ... as this should set things up if a CPU is already online.
> 
> [...]

Got it, thats a good idea. I will change it.

> 
>> +static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
>> +						   cpuhp_node);
>> +
>> +	if (!cpumask_test_cpu(cpu, &dsu_pmu->associated_cpus))
>> +		return 0;
>> +
>> +	/* Initialise the PMU if necessary */
>> +	if (dsu_pmu->num_counters < 0)
>> +		dsu_pmu_init_pmu(dsu_pmu);
>> +	/* Set the active CPU if we don't have one */
>> +	if (cpumask_empty(&dsu_pmu->active_cpu))
>> +		dsu_pmu_set_active_cpu(cpu, dsu_pmu);
>> +	return 0;
>> +}
> 
> I don't think this is quite right, as if we've offlined all the
> associated CPUs, the DSCU itself may have been powered down, and we'll
> want to reset it when it's brought online.
> 
> I think we want this to be:
> 
> static int dsu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
> {
> 	struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
> 						   cpuhp_node);
> 	
> 	if (!cpumask_test_cpu(cpu, &dsu_pmu->associated_cpus))
> 		return 0;
> 	
> 	/* If the PMU is already managed, there's nothing to do */
> 	if (!cpumask_empty(&dsu_pmu->active_cpu))
> 		return 0;
> 
> 	/* Reset the PMU, and take ownership */
> 	dsu_pmu_init_pmu(dsu_pmu);
> 	dsu_pmu_set_active_cpu(cpu, dsu_pmu);
> 	
> 	return 0;
> }
> 
> [...]
> 
>> +static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> +{
> 
>> +	dsu_pmu_set_active_cpu(dst, dsu_pmu);
>> +	perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
> 
> In other PMU drivers, we do the migrate, then set the active CPU. That
> shouldn't matter, but for consistency, could we flip these around?

OK, will flip it.

> 
> Otherwise, this looks good to me.
> 
> With the above changes:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for the review. I will post the updated version.

Suzuki
