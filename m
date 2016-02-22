From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Feb 2016 14:49:54 +0000
Subject: [PATCH v6 02/12] arm-cci: Group writes to counter
In-Reply-To: <1453720877-24962-3-git-send-email-suzuki.poulose@arm.com>
References: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
 <1453720877-24962-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160222144954.GE3435@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 11:21:07AM +0000, Suzuki K. Poulose wrote:
> Add a helper to group the writes to PMU counter, this will be
> used to delay setting the event period to pmu::pmu_enable()
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V5:
>   - Use the prev_count from event->hw for the counter value, than
>     using a single value for all the counters.
> ---
>  drivers/bus/arm-cci.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index ee47e6b..936fa9b 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -771,6 +771,21 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
>  		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
>  }
>  
> +static void __maybe_unused
> +pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
> +{
> +	int i;
> +	struct cci_pmu_hw_events *cci_hw = &cci_pmu->hw_events;
> +
> +	for_each_set_bit(i, mask, cci_pmu->num_cntrs) {
> +		struct perf_event *event = cci_hw->events[i];
> +
> +		if (WARN_ON(!event))
> +			continue;
> +		pmu_write_counter(event, (u32)local64_read(&event->hw.prev_count));
> +	}
> +}

I think the cast can go here. The truncation will happen implicitly
anyway.

Mark.


> +
>  static u64 pmu_event_update(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> -- 
> 1.7.9.5
> 
