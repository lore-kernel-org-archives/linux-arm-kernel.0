From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 20 Oct 2017 11:17:41 +0100
Subject: [PATCH v8 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20171018092011.auey5hgpnjwkpsej@lakrids.cambridge.arm.com>
References: <20171010103303.32436-1-suzuki.poulose@arm.com>
 <20171010103303.32436-9-suzuki.poulose@arm.com>
 <20171018092011.auey5hgpnjwkpsej@lakrids.cambridge.arm.com>
Message-ID: <b6fbfa75-a420-7cba-2f94-05317e72a9b3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/17 10:20, Mark Rutland wrote:
> Hi Suzuki,
> 
> This generally looks good. My comments below are mostly minor, modulo
> the probing/hotplug bit at the end.
> 

...

>> +static void dsu_pmu_probe_pmu(void *data)
>> +{
>> +	struct dsu_pmu *dsu_pmu = data;
>> +	u64 num_counters;
>> +	u32 cpmceid[2];
>> +
>> +	num_counters = (__dsu_pmu_read_pmcr() >> CLUSTERPMCR_N_SHIFT) &
>> +						CLUSTERPMCR_N_MASK;
>> +	/* We can only support upto 31 independent counters */
> 
> s/upto/up to/
> 
> Does the hardware spec allow for more than this?

No, the "counter" mask registers are 32bit wide, with Bit 31 reserved for the
Cycle counter.

> 
>> +	if (WARN_ON(num_counters > 31))
>> +		num_counters = 31;
>> +	dsu_pmu->num_counters = num_counters;
>> +	if (!dsu_pmu->num_counters)
>> +		return;
>> +	cpmceid[0] = __dsu_pmu_read_pmceid(0);
>> +	cpmceid[1] = __dsu_pmu_read_pmceid(1);
>> +	bitmap_from_u32array(dsu_pmu->cpmceid_bitmap,
>> +				DSU_PMU_MAX_COMMON_EVENTS,
>> +				cpmceid,
>> +				ARRAY_SIZE(cpmceid));
>> +}
> 
> [...]
> 
>> +
>> +static int dsu_pmu_device_probe(struct platform_device *pdev)
>> +{
>> +	int irq, rc, cpu;
>> +	struct dsu_pmu *dsu_pmu;
>> +	char *name;
>> +	static atomic_t pmu_idx = ATOMIC_INIT(-1);
>> +
>> +	dsu_pmu = dsu_pmu_alloc(pdev);
>> +	if (IS_ERR(dsu_pmu))
>> +		return PTR_ERR(dsu_pmu);
>> +
>> +	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
>> +		return rc;
>> +	}
>> +
>> +	rc = smp_call_function_any(&dsu_pmu->associated_cpus,
>> +					dsu_pmu_probe_pmu,
>> +					dsu_pmu, 1);
> 
> Can we probe the relevant CPUs in the same was as the qcom l2 pmu, using
> notifiers?
> 
> That way we'd work better with maxcpus=.
> 
> We have to do this cross-call in the arm_pmu driver because we need the
> name at probe time, but that doesn't apply here. We should be able to
> lazily initialize the set of events and number of counters.

OK, I will make the necessary changes.

Thanks a lot for the review.

Cheers
Suzuki
