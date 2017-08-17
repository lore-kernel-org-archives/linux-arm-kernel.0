From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Thu, 17 Aug 2017 11:08:32 +0800
Subject: [PATCH v4 2/6] perf: hisi: Add support for HiSilicon SoC uncore
 PMU driver
In-Reply-To: <20170815101627.GC6090@leverpostej>
References: <1500984642-204676-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500984642-204676-3-git-send-email-zhangshaokun@hisilicon.com>
 <20170815101627.GC6090@leverpostej>
Message-ID: <4f2b8398-7628-29ac-188b-35eacbff512b@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2017/8/15 18:16, Mark Rutland wrote:
> Hi,
> 
> On Tue, Jul 25, 2017 at 08:10:38PM +0800, Shaokun Zhang wrote:
>> +/* Read Super CPU cluster and CPU cluster ID from MPIDR_EL1 */
>> +void hisi_read_sccl_and_ccl_id(u32 *sccl_id, u32 *ccl_id)
>> +{
>> +	u64 mpidr;
>> +
>> +	mpidr = read_cpuid_mpidr();
>> +	if (mpidr & MPIDR_MT_BITMASK) {
>> +		if (sccl_id)
>> +			*sccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 3);
>> +		if (ccl_id)
>> +			*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
>> +	} else {
>> +		if (sccl_id)
>> +			*sccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
>> +		if (ccl_id)
>> +			*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> +	}
>> +}
> 
> How exactly are SCCLs organised w.r.t. MPIDRS?
> 

For single-thread core, sccl_id is in MPIDR[aff2] and ccl_id is MPIDR[aff1];
For MT core, sccl_id is in MPIDR[aff3] and ccl_id in MPIDR[aff2].
I shall add comments here.

> Is this guaranteed to be correct for future SoCs?
> 

Sorry that it is uncertain.

> It would be nicer if this were described explicitly by FW rather than
> guessed at based on the MPIDR.
> 

Whilst I agree, we assume this isn't going to happen now and the logic
can be updated to support this if it we have more complex topology in
the future.

>> +static bool hisi_validate_event_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader = event->group_leader;
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
>> +	/* Include count for the event */
>> +	int counters = 1;
>> +
>> +	/*
>> +	 * We must NOT create groups containing mixed PMUs, although
>> +	 * software events are acceptable
>> +	 */
>> +	if (leader->pmu != event->pmu && !is_software_event(leader))
>> +		return false;
>> +
>> +	/* Increment counter for the leader */
>> +	counters++;
> 
> If this event is the leader, you account for it twice.
> 
> I guess you get away with that assuming you have at least two counters,
> but it's less than ideal.
> 

We update this as per
https://marc.info/?l=linux-arm-kernel&m=149096885106554&w=2
Any thoughts to avoid this issue?

>> +
>> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>> +			    group_entry) {
>> +		if (is_software_event(sibling))
>> +			continue;
>> +		if (sibling->pmu != event->pmu)
>> +			return false;
>> +		/* Increment counter for each sibling */
>> +		counters++;
>> +	}
>> +
>> +	/* The group can not count events more than the counters in the HW */
>> +	return counters <= hisi_pmu->num_counters;
>> +}
> 
> [...]
> 
>> +/*
>> + * Set the counter to count the event that we're interested in,
>> + * and enable counter and interrupt.
>> + */
>> +static void hisi_uncore_pmu_enable_event(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *hisi_pmu = to_hisi_pmu(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	/*
>> +	 * Write event code in event select registers(for DDRC PMU,
>> +	 * event has been mapped to fixed-purpose counter, there is
>> +	 * no need to write event type).
>> +	 */
>> +	if (hisi_pmu->ops->write_evtype)
>> +		hisi_pmu->ops->write_evtype(hisi_pmu, hwc->idx,
>> +					    HISI_GET_EVENTID(event));
> 
> It looks like this is the only op which might be NULL. It would be
> cleaner for the DDRC PMU code to provide an empty callback.
> 

Ok.

> [...]
> 
>> +struct hisi_pmu *hisi_pmu_alloc(struct device *dev, u32 num_cntrs)
>> +{
>> +	struct hisi_pmu *hisi_pmu;
>> +	struct hisi_pmu_hwevents *pmu_events;
>> +
>> +	hisi_pmu = devm_kzalloc(dev, sizeof(*hisi_pmu), GFP_KERNEL);
>> +	if (!hisi_pmu)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pmu_events = &hisi_pmu->pmu_events;
>> +	pmu_events->hw_events = devm_kcalloc(dev,
>> +					     num_cntrs,
>> +					     sizeof(*pmu_events->hw_events),
>> +					     GFP_KERNEL);
>> +	if (!pmu_events->hw_events)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pmu_events->used_mask = devm_kcalloc(dev,
>> +					     BITS_TO_LONGS(num_cntrs),
>> +					     sizeof(*pmu_events->used_mask),
>> +					     GFP_KERNEL);
> 
> How big can num_counters be?
> 

At the moment, the max num_counters is 0x10 for HHA PMU.

> Assuming it's not too big, it would be nicer to embed these within the
> hisi_pmu_hwevents.
> 

Ok, shall refactor hisi_pmu_hwevents, will use the max num_counters and
remove num_cntrs for hisi_pmu_alloc function.

> [...]
> 
>> +
>> +/* Generic pmu struct for different pmu types */
>> +struct hisi_pmu {
>> +	const char *name;
>> +	struct pmu pmu;
> 
> struct pmu has a name field. Why do we need another?
> 

It is redundant and shall remove it.

>> +	union {
>> +		u32 ddrc_chn_id;
>> +		u32 l3c_tag_id;
>> +		u32 hha_uid;
>> +	};
> 
> This would be simpler as a `u32 id` rather than a union.
> 

Ok.

>> +	int num_counters;
>> +	int num_events;
> 
> Subsequent patches intialise num_events, but it is never used. Was it
> supposed to be checked at event_init time? Or is it unnnecessary?
> 

Yes, it is unnecessary and shall remove it.

Thanks.
Shaokun

> Thanks,
> Mark.
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
> 
> .
> 
