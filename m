From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 15:33:13 +0000
Subject: [PATCHv3 2/5] arm-cci: Get the status of a counter
In-Reply-To: <1447783407-18027-3-git-send-email-suzuki.poulose@arm.com>
References: <1447783407-18027-1-git-send-email-suzuki.poulose@arm.com>
 <1447783407-18027-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151210153312.GF495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:03:24PM +0000, Suzuki K. Poulose wrote:
> Add helper routines to get the counter status and the event
> programmed on it.
> 
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - Rename pmu_counter_get_ctrl => pmu_counter_is_enabled()

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/bus/arm-cci.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index f5793b9..48936c8 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -652,11 +652,23 @@ static void pmu_enable_counter(struct cci_pmu *cci_pmu, int idx)
>  	pmu_write_register(cci_pmu, 1, idx, CCI_PMU_CNTR_CTRL);
>  }
>  
> +static bool __maybe_unused
> +pmu_counter_is_enabled(struct cci_pmu *cci_pmu, int idx)
> +{
> +	return (pmu_read_register(cci_pmu, idx, CCI_PMU_CNTR_CTRL) & 0x1) != 0;
> +}
> +
>  static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
>  {
>  	pmu_write_register(cci_pmu, event, idx, CCI_PMU_EVT_SEL);
>  }
>  
> +static u32 __maybe_unused
> +pmu_get_event(struct cci_pmu *cci_pmu, int idx)
> +{
> +	return pmu_read_register(cci_pmu, idx, CCI_PMU_EVT_SEL);
> +}
> +
>  /*
>   * Returns the number of programmable counters actually implemented
>   * by the cci
> -- 
> 1.7.9.5
> 
