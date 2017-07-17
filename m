From: panand@redhat.com (Pratyush Anand)
Date: Mon, 17 Jul 2017 08:56:10 +0530
Subject: [PATCH] arm64: perf: Allow more than one cycle counter to be used
In-Reply-To: <5817e4915963d7fae5928a77d85f7e0c4dca290c.1498890614.git.panand@redhat.com>
References: <5817e4915963d7fae5928a77d85f7e0c4dca290c.1498890614.git.panand@redhat.com>
Message-ID: <32b8658a-e48d-308d-4c89-9d22161ec1a8@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Mark

On Saturday 01 July 2017 12:03 PM, Pratyush Anand wrote:
> Currently:
> $ perf stat -e cycles:u -e cycles:k  true
>
>  Performance counter stats for 'true':
>
>           2,24,699      cycles:u
>      <not counted>      cycles:k	(0.00%)
>
>        0.000788087 seconds time elapsed
>
> We can not count more than one cycle counter in one instance,because we
> allow to map cycle counter into PMCCNTR_EL0 only. However, if I did not
> miss anything then specification do not prohibit to use PMEVCNTR<n>_EL0
> for cycle count as well.
>
> Modify the code so that it still prefers to use PMCCNTR_EL0 for cycle
> counter, however allow to use PMEVCNTR<n>_EL0 if PMCCNTR_EL0 is already
> in use.
>
> After this patch:
>
> $ perf stat -e cycles:u -e cycles:k   true
>
>  Performance counter stats for 'true':
>
>           2,17,310      cycles:u
>           7,40,009      cycles:k
>
>        0.000764149 seconds time elapsed
>

Any comment/feedback?

> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  arch/arm64/kernel/perf_event.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 83a1b1ad189f..43c77314f345 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -846,17 +846,14 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
>
> -	/* Always place a cycle counter into the cycle counter. */
> +	/* Always prefer to place a cycle counter into the cycle counter. */
>  	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
> -		if (test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
> -			return -EAGAIN;
> -
> -		return ARMV8_IDX_CYCLE_COUNTER;
> +		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
> +			return ARMV8_IDX_CYCLE_COUNTER;
>  	}
>
>  	/*
> -	 * For anything other than a cycle counter, try and use
> -	 * the events counters
> +	 * Otherwise use events counters
>  	 */
>  	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
>  		if (!test_and_set_bit(idx, cpuc->used_mask))
>

-- 
Pratyush
