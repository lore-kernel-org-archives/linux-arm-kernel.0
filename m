From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Nov 2015 18:06:51 +0000
Subject: [PATCHv2 2/4] arm-cci: Get the status of a counter
In-Reply-To: <1445346326-30820-3-git-send-email-suzuki.poulose@arm.com>
References: <1445346326-30820-1-git-send-email-suzuki.poulose@arm.com>
 <1445346326-30820-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151104180651.GG23860@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 02:05:24PM +0100, Suzuki K. Poulose wrote:
> Add helper routines to get the counter status and the event
> programmed on it.
> 
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: arm at kernel.org
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 5435d87..1a75010 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -647,11 +647,21 @@ static void pmu_enable_counter(struct cci_pmu *cci_pmu, int idx)
>  	pmu_write_register(cci_pmu, 1, idx, CCI_PMU_CNTR_CTRL);
>  }
>  
> +static u32 pmu_get_counter_ctrl(struct cci_pmu *cci_pmu, int idx)
> +{
> +	return pmu_read_register(cci_pmu, idx, CCI_PMU_CNTR_CTRL) & 0x1;
> +}

Given the function is called pmu_get_counter_ctrl, why the '& 1'?

Either this should return the raw value, or the function should be
renamed to something like pmu_counter_is_enabled, and made bool.

> +
>  static void pmu_set_event(struct cci_pmu *cci_pmu, int idx, unsigned long event)
>  {
>  	pmu_write_register(cci_pmu, event, idx, CCI_PMU_EVT_SEL);
>  }
>  
> +static u32 pmu_get_event(struct cci_pmu *cci_pmu, int idx)
> +{
> +	return pmu_read_register(cci_pmu, idx, CCI_PMU_EVT_SEL);
> +}
> +

Other than the above this looks fine to me.

Thanks,
Mark.
