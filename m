From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 15:42:52 +0000
Subject: [PATCHv3 5/5] arm-cci: CCI-500: Work around PMU counter writes
In-Reply-To: <1447783407-18027-6-git-send-email-suzuki.poulose@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151210154251.GG495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:03:27PM +0000, Suzuki K. Poulose wrote:
> The CCI PMU driver sets the event counter to the half of the maximum
> value(2^31) it can count before we start the counters via
> pmu_event_set_period(). This is done to give us the best chance to
> handle the overflow interrupt, taking care of extreme interrupt latencies.
> 
> However, CCI-500 comes with advanced power saving schemes, which
> disables the clock to the event counters unless the counters are enabled to
> count (PMCR.CEN). This prevents the driver from writing the period to the
> counters before starting them.  Also, there is no way we can reset the
> individual event counter to 0 (PMCR.RST resets all the counters, losing
> their current readings). However the value of the counter is preserved and
> could be read back, when the counters are not enabled.
> 
> So we cannot reliably use the counters and compute the number of events
> generated during the sampling period since we don't have the value of the
> counter at start.
> 
> This patch works around this issue by changing writes to the counter
> with the following steps.
> 
>  1) Disable all the counters (remembering any counters which were enabled)
>  2) Save the current event and program the target counter to count an
>     invalid event, which by spec is guaranteed to not-generate any events.
>  3) Enable the target counter.
>  4) Enable the CCI PMU
>  5) Write to the target counter.
>  6) Disable the CCI PMU and the target counter
>  7) Restore the event back on the target counter.
>  8) Restore the status of the all the counters
> 
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 88b612f..6020a02 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -835,6 +835,52 @@ static void __pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
>  	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
>  }
>  
> +#ifdef CONFIG_ARM_CCI500_PMU
> +
> +/*
> + * CCI-500 has advanced power saving policies, which could gate the
> + * clocks to the PMU counters, which makes the writes to them ineffective.
> + * The only way to write to those counters is when the global counters
> + * are enabled and the particular counter is enabled.
> + *
> + * So we do the following :
> + *
> + * 1) Disable all the PMU counters, saving their current state
> + * 2) Save the programmed event, and write an invalid event code
> + *    to the event control register for the counter, so that the
> + *    counters are not modified.
> + * 3) Enable the counter control for the counter.
> + * 4) Enable the global PMU profiling
> + * 5) Set the counter value
> + * 6) Disable the counter, global PMU.
> + * 7) Restore the event in the target counter
> + * 8) Restore the status of the rest of the counters.
> + *
> + * We choose an event code which has very little chances of getting
> + * assigned a valid code for step(2). We use the highest possible
> + * event code (0x1f) for the master interface 0.
> + */
> +#define CCI500_INVALID_EVENT	((CCI500_PORT_M0 << CCI500_PMU_EVENT_SOURCE_SHIFT) | \
> +				 (CCI500_PMU_EVENT_CODE_MASK << CCI500_PMU_EVENT_CODE_SHIFT))
> +static void cci500_pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
> +{
> +	unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
> +	u32 event;
> +
> +	pmu_disable_counters(cci_pmu, mask);
> +	event = pmu_get_event(cci_pmu, idx);
> +	pmu_set_event(cci_pmu, idx, CCI500_INVALID_EVENT);
> +	pmu_enable_counter(cci_pmu, idx);
> +	__cci_pmu_enable();
> +	__pmu_write_counter(cci_pmu, value, idx);
> +	__cci_pmu_disable();
> +	pmu_disable_counter(cci_pmu, idx);
> +	pmu_set_event(cci_pmu, idx, event);
> +	pmu_restore_counters(cci_pmu, mask);
> +}
> +
> +#endif	/* CONFIG_ARM_CCI500_PMU */
> +
>  static void pmu_write_counter(struct perf_event *event, u32 value)
>  {
>  	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
> @@ -1422,6 +1468,7 @@ static struct cci_pmu_model cci_pmu_models[] = {
>  			},
>  		},
>  		.validate_hw_event = cci500_validate_hw_event,
> +		.write_counter	= cci500_pmu_write_counter,
>  	},

This should work, but it seems very heavyweight given we do it for each
write.

Can we not amortize this by using the {start,commit,cancel}_txn hooks?

Either we can handle 1-4 and 6-8 in those, or we can copy everything
into a shadow state and apply it all in one go at commit_txn time.

Or is that not possible for some reason I've missed?

Thanks,
Mark.
