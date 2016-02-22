From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 22 Feb 2016 15:14:46 +0000
Subject: [PATCH v6 08/12] __cci_pmu_enable: Make counter sync optional
In-Reply-To: <1453720877-24962-9-git-send-email-suzuki.poulose@arm.com>
References: <1453720877-24962-1-git-send-email-suzuki.poulose@arm.com>
 <1453720877-24962-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160222151446.GG3435@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 11:21:13AM +0000, Suzuki K. Poulose wrote:
> On CCI-500 writing to a counter requires turning the PMU on. So,
> syncing the counter state should not be performed for such special cases,
> while turning the PMU on. This patch makes the 'sync' operation based
> on an input parameter to allow reuse of the __cci_pmu_enable() function,
> rather than definig a new helper (and a corresponding helper for pmu_disable
> to match the new helper for the sake of readability).

I think it would be better to have _sync and _nosync function variants.
i.e. have:

__cci_pmu_enable_sync(struct cci_pmu *cci_pmu)
{	
	cci_pmu_sync_counters(cci_pmu);
	 __cci_pmu_enable_nosync(cci_pmu);
}

Mark.

> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 997ad36..9d700e1 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -88,6 +88,9 @@ static const struct of_device_id arm_cci_matches[] = {
>  #define CCI_PMU_MAX_HW_CNTRS(model) \
>  	((model)->num_hw_cntrs + (model)->fixed_hw_cntrs)
>  
> +#define CCI_CNTRS_SYNC		true
> +#define CCI_CNTRS_NOSYNC	false
> +
>  /* Types of interfaces that can generate events */
>  enum {
>  	CCI_IF_SLAVE,
> @@ -640,11 +643,12 @@ void cci_pmu_sync_counters(struct cci_pmu *cci_pmu)
>  }
>  
>  /* Should be called with cci_pmu->hw_events->pmu_lock held */
> -static void __cci_pmu_enable(struct cci_pmu *cci_pmu)
> +static void __cci_pmu_enable(struct cci_pmu *cci_pmu, bool sync)
>  {
>  	u32 val;
>  
> -	cci_pmu_sync_counters(cci_pmu);
> +	if (sync)
> +		cci_pmu_sync_counters(cci_pmu);
>  
>  	/* Enable all the PMU counters. */
>  	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
> @@ -960,7 +964,7 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
>  	}
>  
>  	/* Enable the PMU and sync possibly overflowed counters */
> -	__cci_pmu_enable(cci_pmu);
> +	__cci_pmu_enable(cci_pmu, CCI_CNTRS_SYNC);
>  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>  
>  	return IRQ_RETVAL(handled);
> @@ -1004,7 +1008,7 @@ static void cci_pmu_enable(struct pmu *pmu)
>  		return;
>  
>  	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
> -	__cci_pmu_enable(cci_pmu);
> +	__cci_pmu_enable(cci_pmu, CCI_CNTRS_SYNC);
>  	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
>  
>  }
> -- 
> 1.7.9.5
> 
