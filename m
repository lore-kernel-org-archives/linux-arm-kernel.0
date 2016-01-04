From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jan 2016 19:01:16 +0000
Subject: [PATCH v5 02/11] arm-cci: Refactor pmu_write_counter
In-Reply-To: <1451908490-2615-3-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160104190115.GB17127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 11:54:41AM +0000, Suzuki K. Poulose wrote:
> Refactor pmu_write_counter to add __pmu_write_counter() which
> will actually write to the counter once the event is validated.
> This can be used by hooks specific to CCI PMU model to program
> the counter, where the event is already validated.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 3786879..ce0d3ef 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -767,16 +767,22 @@ static u32 pmu_read_counter(struct perf_event *event)
>  	return value;
>  }
>  
> +static void __pmu_write_counter(struct cci_pmu *cci_pmu, u32 value, int idx)
> +{
> +	pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
> +}
> +
>  static void pmu_write_counter(struct perf_event *event, u32 value)
>  {
>  	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
>  	struct hw_perf_event *hw_counter = &event->hw;
>  	int idx = hw_counter->idx;
>  
> -	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
> +	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
>  		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
> -	else
> -		pmu_write_register(cci_pmu, value, idx, CCI_PMU_CNTR);
> +		return;
> +	}
> +	__pmu_write_counter(cci_pmu, value, idx);
>  }
>  
>  static u64 pmu_event_update(struct perf_event *event)
> -- 
> 1.7.9.5
> 
