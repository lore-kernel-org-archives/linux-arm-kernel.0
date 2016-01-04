From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jan 2016 18:27:52 +0000
Subject: [PATCH v5 01/11] arm-cci: Define CCI counter period
In-Reply-To: <1451908490-2615-2-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160104181940.GA17127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 11:54:40AM +0000, Suzuki K. Poulose wrote:
> Instead of hard coding the period we program on the PMU
> counters, define a symbol.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index ee47e6b..3786879 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -85,6 +85,14 @@ static const struct of_device_id arm_cci_matches[] = {
>  #define CCI_PMU_CNTR_MASK		((1ULL << 32) -1)
>  #define CCI_PMU_CNTR_LAST(cci_pmu)	(cci_pmu->num_cntrs - 1)
>  
> +/*
> + * The CCI PMU counters have a period of 2^32. To account for the
> + * possiblity of extreme interrupt latency we program for a period of
> + * half that. Hopefully we can handle the interrupt before another 2^31
> + * events occur and the counter overtakes its previous value.
> + */
> +#define CCI_CNTR_PERIOD		(1UL << 31)
> +
>  #define CCI_PMU_MAX_HW_CNTRS(model) \
>  	((model)->num_hw_cntrs + (model)->fixed_hw_cntrs)
>  
> @@ -797,15 +805,8 @@ static void pmu_read(struct perf_event *event)
>  void pmu_event_set_period(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> -	/*
> -	 * The CCI PMU counters have a period of 2^32. To account for the
> -	 * possiblity of extreme interrupt latency we program for a period of
> -	 * half that. Hopefully we can handle the interrupt before another 2^31
> -	 * events occur and the counter overtakes its previous value.
> -	 */
> -	u64 val = 1ULL << 31;
> -	local64_set(&hwc->prev_count, val);
> -	pmu_write_counter(event, val);
> +	local64_set(&hwc->prev_count, CCI_CNTR_PERIOD);
> +	pmu_write_counter(event, CCI_CNTR_PERIOD);

I think this is a little misleading (and confusing), as we're conflating
the period with its inverse. This wouldn't work for any other value of
CCI_CNTR_PERIOD.

Perhaps s/PERIOD/START_VAL/, leaving everything else as-is?

Thanks,
Mark.
