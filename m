From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jul 2018 13:49:05 +0100
Subject: [PATCH v4 4/7] arm_pmu: Tidy up clear_event_idx call backs
In-Reply-To: <1530568788-26458-5-git-send-email-suzuki.poulose@arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
 <1530568788-26458-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180703124905.75uttsh7xrrzh55q@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 10:59:45PM +0100, Suzuki K Poulose wrote:
> The armpmu uses get_event_idx callback to allocate an event
> counter for a given event, which marks the selected counter
> as "used". Now, when we delete the counter, the arm_pmu goes
> ahead and clears the "used" bit and then invokes the "clear_event_idx"
> call back, which kind of splits the job between the core code
> and the backend. To keep things tidy, mandate the implementation
> of clear_event_idx() and add it for exisiting backends.
> This will be useful for adding the chained event support, where
> we leave the event idx maintenance to the backend.
> 
> Also, when an event is removed from the PMU, reset the hw.idx
> to indicate that a counter is not allocated for this event,
> to help the backends do better checks. This will be also used
> for the chain counter support.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v3:
>  - Add clear_event_idx call back for backends.
> ---
>  arch/arm/kernel/perf_event_v6.c | 8 ++++++++
>  arch/arm/kernel/perf_event_v7.c | 9 +++++++++
>  arch/arm64/kernel/perf_event.c  | 7 +++++++
>  drivers/perf/arm_pmu.c          | 7 +++----
>  4 files changed, 27 insertions(+), 4 deletions(-)

I beleive this is missing the xscale PMU code.

Otherwiwse, this looks good to me.

Thanks,
Mark.

> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 0729f98..1ae99de 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -411,6 +411,12 @@ armv6pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  	}
>  }
>  
> +static void armv6pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> +				     struct perf_event *event)
> +{
> +	clear_bit(event->hw.idx, cpuc->used_mask);
> +}
> +
>  static void armv6pmu_disable_event(struct perf_event *event)
>  {
>  	unsigned long val, mask, evt, flags;
> @@ -491,6 +497,7 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->read_counter	= armv6pmu_read_counter;
>  	cpu_pmu->write_counter	= armv6pmu_write_counter;
>  	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
> +	cpu_pmu->clear_event_idx = armv6pmu_clear_event_idx;
>  	cpu_pmu->start		= armv6pmu_start;
>  	cpu_pmu->stop		= armv6pmu_stop;
>  	cpu_pmu->map_event	= armv6_map_event;
> @@ -541,6 +548,7 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->read_counter	= armv6pmu_read_counter;
>  	cpu_pmu->write_counter	= armv6pmu_write_counter;
>  	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
> +	cpu_pmu->clear_event_idx = armv6pmu_clear_event_idx;
>  	cpu_pmu->start		= armv6pmu_start;
>  	cpu_pmu->stop		= armv6pmu_stop;
>  	cpu_pmu->map_event	= armv6mpcore_map_event;
> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> index fd7ce01..acb49a9 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/arch/arm/kernel/perf_event_v7.c
> @@ -1058,6 +1058,12 @@ static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  	return -EAGAIN;
>  }
>  
> +static void armv7pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> +				     struct perf_event *event)
> +{
> +	clear_bit(event->hw.idx, cpuc->used_mask);
> +}
> +
>  /*
>   * Add an event filter to a given event. This will only work for PMUv2 PMUs.
>   */
> @@ -1167,6 +1173,7 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->read_counter	= armv7pmu_read_counter;
>  	cpu_pmu->write_counter	= armv7pmu_write_counter;
>  	cpu_pmu->get_event_idx	= armv7pmu_get_event_idx;
> +	cpu_pmu->clear_event_idx = armv7pmu_clear_event_idx;
>  	cpu_pmu->start		= armv7pmu_start;
>  	cpu_pmu->stop		= armv7pmu_stop;
>  	cpu_pmu->reset		= armv7pmu_reset;
> @@ -1637,6 +1644,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  	bool venum_event = EVENT_VENUM(hwc->config_base);
>  	bool krait_event = EVENT_CPU(hwc->config_base);
>  
> +	armv7pmu_clear_event_idx(cpuc, event);
>  	if (venum_event || krait_event) {
>  		bit = krait_event_to_bit(event, region, group);
>  		clear_bit(bit, cpuc->used_mask);
> @@ -1966,6 +1974,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  	bool venum_event = EVENT_VENUM(hwc->config_base);
>  	bool scorpion_event = EVENT_CPU(hwc->config_base);
>  
> +	armv7pmu_clear_event_idx(cpuc, event);
>  	if (venum_event || scorpion_event) {
>  		bit = scorpion_event_to_bit(event, region, group);
>  		clear_bit(bit, cpuc->used_mask);
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 66a2ffd..ac66851 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -778,6 +778,12 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  	return -EAGAIN;
>  }
>  
> +static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
> +				  struct perf_event *event)
> +{
> +	clear_bit(event->hw.idx, cpuc->used_mask);
> +}
> +
>  /*
>   * Add an event filter to a given event. This will only work for PMUv2 PMUs.
>   */
> @@ -956,6 +962,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
>  	cpu_pmu->read_counter		= armv8pmu_read_counter,
>  	cpu_pmu->write_counter		= armv8pmu_write_counter,
>  	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
> +	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
>  	cpu_pmu->start			= armv8pmu_start,
>  	cpu_pmu->stop			= armv8pmu_stop,
>  	cpu_pmu->reset			= armv8pmu_reset,
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 8cad6b5..a288810 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -238,11 +238,10 @@ armpmu_del(struct perf_event *event, int flags)
>  
>  	armpmu_stop(event, PERF_EF_UPDATE);
>  	hw_events->events[idx] = NULL;
> -	clear_bit(idx, hw_events->used_mask);
> -	if (armpmu->clear_event_idx)
> -		armpmu->clear_event_idx(hw_events, event);
> -
> +	armpmu->clear_event_idx(hw_events, event);
>  	perf_event_update_userpage(event);
> +	/* Clear the allocated counter */
> +	hwc->idx = -1;
>  }
>  
>  static int
> -- 
> 2.7.4
> 
