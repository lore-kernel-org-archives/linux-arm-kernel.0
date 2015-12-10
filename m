From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 15:32:23 +0000
Subject: [PATCHv3 3/5] arm-cci: Add routines to enable/disable all counters
In-Reply-To: <1447783407-18027-4-git-send-email-suzuki.poulose@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151210153222.GE495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:03:25PM +0000, Suzuki K. Poulose wrote:
> Adds helper routines to disable the counter controls for
> all the counters on the CCI PMU and restore it back, by
> preserving the original state in caller provided mask.
> 
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>   - Rename the functions to pmu_restore_counters, pmu_disable_counters
>   - Added comment describing why we use a private mask
> ---
>  drivers/bus/arm-cci.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 48936c8..91a9d5d 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -669,6 +669,44 @@ pmu_get_event(struct cci_pmu *cci_pmu, int idx)
>  	return pmu_read_register(cci_pmu, idx, CCI_PMU_EVT_SEL);
>  }
>  
> +
> +/*
> + * For all counters on the CCI-PMU, disable any 'enabled' counters,
> + * saving the changed counters in the mask, so that we can restore
> + * it later using pmu_restore_counters. The mask is private to the
> + * caller. We cannot rely on the used_mask maintained by the CCI_PMU
> + * as it only tells us if the counter is assigned to perf_event or not.
> + * The state of the perf_event cannot be locked by the PMU layer, hence
> + * we check the individual counter status (which can be locked by
> + * cci_pm->hw_events->pmu_lock).
> + */
> +static void __maybe_unused
> +pmu_disable_counters(struct cci_pmu *cci_pmu, unsigned long *mask)
> +{
> +	int i;
> +
> +	for (i = 0; i < cci_pmu->num_cntrs; i++) {
> +		if (pmu_counter_is_enabled(cci_pmu, i)) {
> +			set_bit(i, mask);
> +			pmu_disable_counter(cci_pmu, i);
> +		} else
> +			clear_bit(i, mask);

Can we not assume a clean mask to begin with?

> +	}
> +}
> +
> +/*
> + * Restore the status of the counters. Reversal of the pmu_disable_counters().
> + * For each counter set in the mask, enable the counter back.
> + */
> +static void __maybe_unused
> +pmu_restore_counters(struct cci_pmu *cci_pmu, unsigned long *mask)

This would probably be better with s/restore/enable/ for consistency
with pmu_disable_counters.

Other than that this looks fine to me.

Mark.

> +{
> +	int i;
> +
> +	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
> +		pmu_enable_counter(cci_pmu, i);
> +}
> +
>  /*
>   * Returns the number of programmable counters actually implemented
>   * by the cci
> -- 
> 1.7.9.5
> 
