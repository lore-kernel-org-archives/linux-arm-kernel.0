From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 18 May 2018 15:57:06 +0100
Subject: [PATCH 6/6] arm64: perf: Add support for chaining counters
In-Reply-To: <1526638943-2110-7-git-send-email-suzuki.poulose@arm.com>
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
 <1526638943-2110-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <5ff704da-b767-33d7-68c4-7aa02f83ac0a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing now that I've actually looked at the Arm ARM...

On 18/05/18 11:22, Suzuki K Poulose wrote:
[...]
> +static inline void armv8pmu_write_event_type(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx = hwc->idx;
> +
> +	/*
> +	 * For chained events, write the high counter event type
> +	 * followed by the low counter.
> +	 */
> +	if (armv8pmu_event_is_chained(event)) {
> +		u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN;
> +
> +		/* Set the filters as that of the main event for chain */
> +		chain_evt |= hwc->config_base & ~ARMV8_PMU_EVTYPE_EVENT;

The description of the chain event says that the filtering must only be 
set on the lower counter, and that the chain event itself should be set 
to count everything.

> +		armv8pmu_write_evtype(idx, chain_evt);
> +		isb();
> +		idx--;
> +	}
> +
> +	armv8pmu_write_evtype(idx, hwc->config_base);

It also says that the 'real' event should be set up first and the chain 
event second, with the rather ominous warning of "If software does not 
program the event in this way, the count becomes UNPREDICTABLE."

Robin.
