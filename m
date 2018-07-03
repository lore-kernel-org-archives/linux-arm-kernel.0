From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Jul 2018 14:00:27 +0100
Subject: [PATCH v4 7/7] arm64: perf: Add support for chaining event
 counters
In-Reply-To: <1530568788-26458-8-git-send-email-suzuki.poulose@arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
 <1530568788-26458-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180703130027.4nfd7pxml4ziyl5l@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 10:59:48PM +0100, Suzuki K Poulose wrote:
> Add support for 64bit event by using chained event counters
> and 64bit cycle counters.
> 
> PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
> forming a 64-bit counter. The low/even counter is programmed to count
> the event of interest, and the high/odd counter is programmed to count
> the CHAIN event, taken when the low/even counter overflows.
> 
> For CPU cycles, when 64bit mode is requested, the cycle counter
> is used in 64bit mode. If the cycle counter is not available,
> falls back to chaining.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v3:
>  - Rename format name from "bits64 => long"
>  - Address other comments on style.
> ---
>  arch/arm64/kernel/perf_event.c | 185 +++++++++++++++++++++++++++++++++++------
>  drivers/perf/arm_pmu.c         |  13 ++-
>  2 files changed, 164 insertions(+), 34 deletions(-)

> +static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
> +				   struct arm_pmu *cpu_pmu)
> +{
> +	int idx;
> +
> +	/*
> +	 * Chaining requires two consecutive event counters, where
> +	 * the lower idx must be even.
> +	 */
> +	for (idx = ARMV8_IDX_COUNTER0 + 1; idx < cpu_pmu->num_events; idx += 2) {
> +		if (!test_and_set_bit(idx, cpuc->used_mask)) {
> +			/* Check if the preceding even counter is available */
> +			if (!test_and_set_bit(idx - 1, cpuc->used_mask))
> +				return idx;
> +			/* Release the Odd counter */
> +			clear_bit(idx, cpuc->used_mask);
> +		}
> +	}
> +	return -EAGAIN;
> +}

This means that we'll sometimes fail to pack events, but I guess that
most of the time the rotation logic will save us.

We might need to defer counter allocation in future if that's a real
problem.

> @@ -665,14 +665,13 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
>  	int idx;
>  
>  	for (idx = 0; idx < armpmu->num_events; idx++) {
> -		/*
> -		 * If the counter is not used skip it, there is no
> -		 * need of stopping/restarting it.
> -		 */
> -		if (!test_bit(idx, hw_events->used_mask))
> -			continue;
> -
>  		event = hw_events->events[idx];
> +		/*
> +		 * If there is no event at this idx (e.g, an idx used
> +		 * by a chained event in Arm v8 PMUv3), skip it.
> +		 */
> +		if (!event)
> +			continue;

I think we can drop the comment here.

Other than the above and the xscale fixup, this looks good to me.

Have you thrown the perf fuzzer at this?

Thanks,
Mark.
