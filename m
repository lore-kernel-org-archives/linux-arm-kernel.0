From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 31 Aug 2017 14:26:22 +0100
Subject: [RFC PATCH v9 5/7] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170831113508.GE15906@hc>
References: <20170829131238.4988-1-jglauber@cavium.com>
 <20170829131238.4988-6-jglauber@cavium.com>
 <09997d9f-0003-0eb0-63d1-9b31e26e2229@arm.com> <20170831113508.GE15906@hc>
Message-ID: <c6d79504-dfa8-a3fe-bd2b-20ac867e2514@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/17 12:35, Jan Glauber wrote:
> On Wed, Aug 30, 2017 at 11:03:00AM +0100, Suzuki K Poulose wrote:
>> On 29/08/17 14:12, Jan Glauber wrote:
>>> Add support for the PMU counters on Cavium SOC memory controllers.
>>>
>>> This patch also adds generic functions to allow supporting more
>>> devices with PMU counters.
>>>
>>> Properties of the LMC PMU counters:
>>> - not stoppable
>>> - fixed purpose
>>> - read-only
>>> - one PCI device per memory controller
>>>
>>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>>
>> Jan,
>>
>> Some minor comments below.
>>
>>> +static void cvm_pmu_del(struct perf_event *event, int flags)
>>> +{
>>> +	struct cvm_pmu_dev *pmu_dev = to_pmu_dev(event->pmu);
>>> +	struct hw_perf_event *hwc = &event->hw;
>>> +	int i;
>>> +
>>> +	event->pmu->stop(event, PERF_EF_UPDATE);
>>> +
>>> +	/*
>>> +	 * For programmable counters we need to check where we installed it.
>>> +	 * To keep this function generic always test the more complicated
>>> +	 * case (free running counters won't need the loop).
>>> +	 */
>>> +	for (i = 0; i < pmu_dev->num_counters; i++)
>>> +		if (cmpxchg(&pmu_dev->events[i], event, NULL) == event)
>>> +			break;
>>
>> Does this mean, it is the only way to map any given event (for programmable counters)
>> to a hardware counter ? What do we store in hwc->idx ? We have 2 additional
>> struct hw_perf_event_extra fields. We should be able to use one field to map it
>> back to the counter, isn't it ?
>
> Hmm, I might be able to use hwc-idx directly instead of the loop, will
> check that.
>
>>> +
>>> +	perf_event_update_userpage(event);
>>> +	hwc->idx = -1;
>>> +}
>>> +
>>
>> ...
>>
>>> +/* LMC events */
>>> +#define LMC_EVENT_IFB_CNT		0x1d0
>>> +#define LMC_EVENT_OPS_CNT		0x1d8
>>> +#define LMC_EVENT_DCLK_CNT		0x1e0
>>> +#define LMC_EVENT_BANK_CONFLICT1	0x360
>>> +#define LMC_EVENT_BANK_CONFLICT2	0x368
>>> +
>>> +#define CVM_PMU_LMC_EVENT_ATTR(_name, _id)						\
>>> +	&((struct perf_pmu_events_attr[]) {						\
>>> +		{									\
>>> +			__ATTR(_name, S_IRUGO, cvm_pmu_event_sysfs_show, NULL),		\
>>> +			_id,								\
>>> +			"lmc_event=" __stringify(_id),					\
>>> +		}									\
>>> +	})[0].attr.attr
>>> +
>>> +/* map counter numbers to register offsets */
>>> +static int lmc_events[] = {
>>> +	LMC_EVENT_IFB_CNT,
>>> +	LMC_EVENT_OPS_CNT,
>>> +	LMC_EVENT_DCLK_CNT,
>>> +	LMC_EVENT_BANK_CONFLICT1,
>>> +	LMC_EVENT_BANK_CONFLICT2,
>>> +};
>>> +
>>> +static int cvm_pmu_lmc_add(struct perf_event *event, int flags)
>>> +{
>>> +	struct hw_perf_event *hwc = &event->hw;
>>> +
>>> +	return cvm_pmu_add(event, flags, LMC_CONFIG_OFFSET,
>>> +			   lmc_events[hwc->config]);
>>> +}
>>> +
>>
>> Is there any reason why we can't use the LMC event code directly
>> here, avoiding the mapping altogether ?
>
> I wanted to avoid exposing the raw numbers (0x1d0 - 0x368) here.

Thats the primarily the reason why we expose the "aliases" in events/.
The other problem with adding another layer of mapping is, you are preventing
someone from actually mapping the raw code used by the perf tool (which is now
a mapping index) to the real raw code used by the hardware unless they have
the kernel source handy. If you choose to expose the raw numbers, like *all*
the other PMUs, the user can map it by looking up the manual.

Cheers
Suzuki
