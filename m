From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 15:26:08 +0000
Subject: [PATCHv3 1/5] arm-cci: Refactor CCI PMU enable/disable methods
In-Reply-To: <1447783407-18027-2-git-send-email-suzuki.poulose@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151210152608.GC495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:03:23PM +0000, Suzuki K. Poulose wrote:
> This patch refactors the CCI PMU driver code a little bit to
> make it easier share the code for enabling/disabling the CCI
> PMU. This will be used by the hooks to work around the special cases
> where writing to a counter is not always that easy(e.g, CCI-500)
> 
> No functional changes.

Looks sensible to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index ee47e6b..f5793b9 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -667,6 +667,26 @@ static u32 pmu_get_max_counters(void)
>  		CCI_PMCR_NCNT_MASK) >> CCI_PMCR_NCNT_SHIFT;
>  }
>  
> +/* Should be called with cci_pmu->hw_events->pmu_lock held */
> +static void __cci_pmu_enable(void)
> +{
> +	u32 val;
> +
> +	/* Enable all the PMU counters. */
> +	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
> +	writel(val, cci_ctrl_base + CCI_PMCR);
> +}
> +
> +/* Should be called with cci_pmu->hw_events->pmu_lock held */
> +static void __cci_pmu_disable(void)
> +{
> +	u32 val;
> +
> +	/* Disable all the PMU counters. */
> +	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
> +	writel(val, cci_ctrl_base + CCI_PMCR);
> +}
> +
>  static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *event)
>  {
>  	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
> @@ -880,16 +900,12 @@ static void cci_pmu_enable(struct pmu *pmu)
>  	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
>  	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
>  	unsigned long flags;
> -	u32 val;
>  
>  	if (!enabled)
>  		return;
>  
>  	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
> -
> -	/* Enable all the PMU counters. */
> -	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
> -	writel(val, cci_ctrl_base + CCI_PMCR);
> +	__cci_pmu_enable();
>  	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
>  
>  }
> @@ -899,13 +915,9 @@ static void cci_pmu_disable(struct pmu *pmu)
>  	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
>  	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
>  	unsigned long flags;
> -	u32 val;
>  
>  	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
> -
> -	/* Disable all the PMU counters. */
> -	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
> -	writel(val, cci_ctrl_base + CCI_PMCR);
> +	__cci_pmu_disable();
>  	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
>  }
>  
> -- 
> 1.7.9.5
> 
