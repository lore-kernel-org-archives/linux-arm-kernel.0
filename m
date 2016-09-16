From: nleeder@codeaurora.org (Neil Leeder)
Date: Fri, 16 Sep 2016 11:33:39 -0400
Subject: [PATCH v4 2/2] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20160901163051.GA6731@leverpostej>
References: <1472576493-26382-1-git-send-email-nleeder@codeaurora.org>
 <1472576493-26382-3-git-send-email-nleeder@codeaurora.org>
 <20160901163051.GA6731@leverpostej>
Message-ID: <27f91809-f968-e278-7887-d0f9af275502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thank you for the thorough review. I will post an updated patchset which addresses
all of your comments. There is just one outstanding comment which I have a question about:

On 9/1/2016 12:30 PM, Mark Rutland wrote:
> On Tue, Aug 30, 2016 at 01:01:33PM -0400, Neil Leeder wrote:

>> +static int l2_cache__event_init(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hml2_pmu *slice;
>> +	struct perf_event *sibling;
>> +	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(event->pmu);
>> +
>> +	if (event->attr.type != l2cache_pmu->pmu.type)
>> +		return -ENOENT;
>> +
>> +	if (hwc->sample_period) {
>> +		dev_warn(&l2cache_pmu->pdev->dev, "Sampling not supported\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (event->cpu < 0) {
>> +		dev_warn(&l2cache_pmu->pdev->dev, "Per-task mode not supported\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	/* We cannot filter accurately so we just don't allow it. */
>> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
>> +	    event->attr.exclude_hv || event->attr.exclude_idle) {
>> +		dev_warn(&l2cache_pmu->pdev->dev, "Can't exclude execution levels\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (((L2_EVT_GROUP(event->attr.config) > L2_EVT_GROUP_MAX) ||
>> +	    (L2_EVT_PREFIX(event->attr.config) != 0) ||
>> +	    (L2_EVT_REG(event->attr.config) != 0)) &&
>> +	    (event->attr.config != L2CYCLE_CTR_RAW_CODE)) {
>> +		dev_warn(&l2cache_pmu->pdev->dev, "Invalid config %llx\n",
>> +			 event->attr.config);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Don't allow groups with mixed PMUs, except for s/w events */
>> +	if (event->group_leader->pmu != event->pmu &&
>> +	    !is_software_event(event->group_leader)) {
>> +		dev_warn(&l2cache_pmu->pdev->dev,
>> +			 "Can't create mixed PMU group\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	list_for_each_entry(sibling, &event->group_leader->sibling_list,
>> +			    group_entry)
>> +		if (sibling->pmu != event->pmu &&
>> +		    !is_software_event(sibling)) {
>> +			dev_warn(&l2cache_pmu->pdev->dev,
>> +				 "Can't create mixed PMU group\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +	hwc->idx = -1;
>> +	hwc->config_base = event->attr.config;
>> +
>> +	/*
>> +	 * Ensure all events are on the same cpu so all events are in the
>> +	 * same cpu context, to avoid races on pmu_enable etc.
>> +	 */
>> +	slice = get_hml2_pmu(event->cpu);
>> +	event->cpu = slice->on_cpu;
> 
> This could put an event on a different CPU to its group siblings, which
> is broken.

This is the same logic as in arm-ccn.c:arm_ccn_pmu_event_init(), where there
is a single CPU designated as the CPU to be used for all events. All
events for this slice are forced to slice->on_cpu which is the CPU set in the
cpumask for this slice.

I'm not sure how this can put an event on a different CPU to its group siblings?

Thanks,
Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
