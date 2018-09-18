From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Sep 2018 13:16:35 +0100
Subject: [PATCH v2 3/4] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <20180918114718.GD16498@arm.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-4-shameerali.kolothum.thodi@huawei.com>
 <935f7572-38d7-070a-dba6-3f18189de4d3@arm.com>
 <a7481657-1551-8f3e-e679-8bfbee8f1ab4@huawei.com>
 <20180918114718.GD16498@arm.com>
Message-ID: <527f47d7-20a2-d74a-1b0a-9901b8981f91@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/18 12:47, Will Deacon wrote:
> On Mon, Sep 17, 2018 at 06:10:05PM +0100, John Garry wrote:
>>
>>>> +
>>>> +#define SMMU_EVENT_ATTR(_name, _id)                      \
>>>> +    (&((struct perf_pmu_events_attr[]) {                  \
>>>> +        { .attr = __ATTR(_name, 0444, smmu_pmu_event_show, NULL), \
>>>> +          .id = _id, }                          \
>>>> +    })[0].attr.attr)
>>>> +
>>>> +static struct attribute *smmu_pmu_events[] = {
>>>> +    SMMU_EVENT_ATTR(cycles, SMMU_PMU_CYCLES),
>>>> +    SMMU_EVENT_ATTR(transaction, SMMU_PMU_TRANSACTION),
>>>> +    SMMU_EVENT_ATTR(tlb_miss, SMMU_PMU_TLB_MISS),
>>>> +    SMMU_EVENT_ATTR(config_cache_miss, SMMU_PMU_CONFIG_CACHE_MISS),
>>>> +    SMMU_EVENT_ATTR(trans_table_walk, SMMU_PMU_TRANS_TABLE_WALK),
>>>> +    SMMU_EVENT_ATTR(config_struct_access,
>>>> SMMU_PMU_CONFIG_STRUCT_ACCESS),
>>>> +    SMMU_EVENT_ATTR(pcie_ats_trans_rq, SMMU_PMU_PCIE_ATS_TRANS_RQ),
>>>> +    SMMU_EVENT_ATTR(pcie_ats_trans_passed,
>>>> SMMU_PMU_PCIE_ATS_TRANS_PASSED),
>>>> +    NULL
>>>> +};
>>>> +
>>>> +static umode_t smmu_pmu_event_is_visible(struct kobject *kobj,
>>>> +                     struct attribute *attr, int unused)
>>>> +{
>>>> +    struct device *dev = kobj_to_dev(kobj);
>>>> +    struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
>>>> +    struct perf_pmu_events_attr *pmu_attr;
>>>> +
>>>> +    pmu_attr = container_of(attr, struct perf_pmu_events_attr,
>>>> attr.attr);
>>>> +
>>>> +    if (test_bit(pmu_attr->id, smmu_pmu->supported_events))
>>>> +        return attr->mode;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +static struct attribute_group smmu_pmu_events_group = {
>>>> +    .name = "events",
>>>> +    .attrs = smmu_pmu_events,
>>>> +    .is_visible = smmu_pmu_event_is_visible,
>>>> +};
>>>> +
>>>> +/* Formats */
>>>> +PMU_FORMAT_ATTR(event,           "config:0-15");
>>>> +PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
>>>> +PMU_FORMAT_ATTR(filter_span,       "config1:32");
>>>> +PMU_FORMAT_ATTR(filter_enable,       "config1:33");
>>>> +
>>>> +static struct attribute *smmu_pmu_formats[] = {
>>>> +    &format_attr_event.attr,
>>>> +    &format_attr_filter_stream_id.attr,
>>>> +    &format_attr_filter_span.attr,
>>>> +    &format_attr_filter_enable.attr,
>>>> +    NULL
>>>> +};
>>>> +
>>>> +static struct attribute_group smmu_pmu_format_group = {
>>>> +    .name = "format",
>>>> +    .attrs = smmu_pmu_formats,
>>>> +};
>>>> +
>>>> +static const struct attribute_group *smmu_pmu_attr_grps[] = {
>>>> +    &smmu_pmu_cpumask_group,
>>>> +    &smmu_pmu_events_group,
>>>> +    &smmu_pmu_format_group,
>>>> +    NULL,
>>>> +};
>>>> +
>>
>>
>> Question: If we wanted to add proper named event support for the
>> IMPLEMENTATION DEFINED events, how to add (if at all)?
>>
>> So currently the driver only supports the Architected events, which is fine.
>> And we support raw events for the IMPLEMENTATION DEFINED events
>> (0x80-0xFFFF).
>>
>> But to add named event support for the IMP DEF events, I assume we would
>> want to do something similar to arm64 CPU PMU events - that is, common
>> architected events in kernel pmu driver, and implementation defined events
>> defined in perf tool. However I don't know if it's even feasible considering
>> there does not seem to be a mandatory/standard PMCG ID register to detect
>> the implementation.
> 
> I guess we'd need something from firmware to identify the SMMU/PMU
> implementation, so that we could probe the driver correctly. Once we have
> that, it seems like it's just a matter of exposing a different name to
> userspace, like we do for the CPU PMU.

Indeed - in fact a while ago I raised it with the architects that PMCGs 
don't have an equivalent to IIDR, so you can't interpret the imp-def 
PMCG_ID_REGS without already knowing what the thing is some other way. 
For IORT it should already be somewhat feasible to figure out the 
implementation by way of chasing the node reference to figure out what 
device the the PMCG is part of, however that might require some sort of 
API between the PMCG driver and SMMUv3 (and other component) driver(s) 
to communicate runtime-probed stuff.

Robin.
