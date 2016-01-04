From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jan 2016 19:24:01 +0000
Subject: [PATCH v5 05/11] arm-cci PMU: Delay counter writes to pmu_enable
In-Reply-To: <1451908490-2615-6-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160104192401.GD17127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 11:54:44AM +0000, Suzuki K. Poulose wrote:
> Delay setting the event periods for enabled events to pmu::pmu_enable().
> We mark the event.hw->state PERF_HES_ARCH for the events that we know
> have their counts recorded and have been started.

Please add a comment to the code stating exactly what PERF_HES_ARCH
means for the CCI PMU driver, so it's easy to find.

> Since we reprogram the counters every time before count, we can set
> the counters for all the event counters which are !STOPPED && ARCH.
> 
> Grouping the writes to counters can ammortise the cost of the operation
> on PMUs where it is expensive (e.g, CCI-500).
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 0189f3a..c768ee4 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -916,6 +916,40 @@ static void hw_perf_event_destroy(struct perf_event *event)
>  	}
>  }
>  
> +/*
> + * Program the CCI PMU counters which have PERF_HES_ARCH set
> + * with the event period and mark them ready before we enable
> + * PMU.
> + */
> +void cci_pmu_update_counters(struct cci_pmu *cci_pmu)
> +{
> +	int i;
> +	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];

I think this can be:

	DECLARE_BITMAP(mask, cci_pmu->num_cntrs);

> +
> +	memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));

Likewise:

	bitmap_zero(mask, cci_pmu->num_cntrs);

> +
> +	for_each_set_bit(i, cci_pmu->hw_events.used_mask, cci_pmu->num_cntrs) {
> +		struct hw_perf_event *hwe;
> +
> +		if (!cci_pmu->hw_events.events[i]) {
> +			WARN_ON(1);
> +			continue;
> +		}
> +

		if (WARN_ON(!cci_pmu->hw_events.events[i]))
			continue;

> +		hwe = &cci_pmu->hw_events.events[i]->hw;
> +		/* Leave the events which are not counting */
> +		if (hwe->state & PERF_HES_STOPPED)
> +			continue;
> +		if (hwe->state & PERF_HES_ARCH) {
> +			set_bit(i, mask);
> +			hwe->state &= ~PERF_HES_ARCH;
> +			local64_set(&hwe->prev_count, CCI_CNTR_PERIOD);
> +		}
> +	}
> +
> +	pmu_write_counters(cci_pmu, mask, CCI_CNTR_PERIOD);
> +}
> +
>  static void cci_pmu_enable(struct pmu *pmu)
>  {
>  	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
> @@ -927,6 +961,7 @@ static void cci_pmu_enable(struct pmu *pmu)
>  		return;
>  
>  	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
> +	cci_pmu_update_counters(cci_pmu);
>  	__cci_pmu_enable();
>  	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
>  
> @@ -980,8 +1015,11 @@ static void cci_pmu_start(struct perf_event *event, int pmu_flags)
>  	/* Configure the counter unless you are counting a fixed event */
>  	if (!pmu_fixed_hw_idx(cci_pmu, idx))
>  		pmu_set_event(cci_pmu, idx, hwc->config_base);
> -
> -	pmu_event_set_period(event);
> +	/*
> +	 * Mark this counter, so that we can program the
> +	 * counter with the event_period. see cci_pmu_enable()
> +	 */
> +	hwc->state = PERF_HES_ARCH;

Why couldn't we have kept pmu_event_set_period here, and have that set
prev_count and PERF_HES_ARCH?

Then we'd be able to do the same betching for overflow too.

What am I missing?

Mark.

>  	pmu_enable_counter(cci_pmu, idx);
>  
>  	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
> -- 
> 1.7.9.5
> 
