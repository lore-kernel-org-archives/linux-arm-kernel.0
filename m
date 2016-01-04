From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jan 2016 19:03:53 +0000
Subject: [PATCH v5 03/11] arm-cci: Group writes to counter
In-Reply-To: <1451908490-2615-4-git-send-email-suzuki.poulose@arm.com>
References: <1451908490-2615-1-git-send-email-suzuki.poulose@arm.com>
 <1451908490-2615-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160104190353.GC17127@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 11:54:42AM +0000, Suzuki K. Poulose wrote:
> Add a helper to group the writes to PMU counter, this will be
> used to delay setting the event period to pmu::pmu_enable()
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/arm-cci.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index ce0d3ef..f6b8717 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -785,6 +785,21 @@ static void pmu_write_counter(struct perf_event *event, u32 value)
>  	__pmu_write_counter(cci_pmu, value, idx);
>  }
>  
> +/* Write a value to a given set of counters */
> +static void __pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
> +{
> +	int i;
> +
> +	for_each_set_bit(i, mask, cci_pmu->num_cntrs)
> +		__pmu_write_counter(cci_pmu, value, i);
> +}

I don't understand this as-is. Why do all the counters have the same
value?

> +static void __maybe_unused
> +pmu_write_counters(struct cci_pmu *cci_pmu, unsigned long *mask, u32 value)
> +{
> +	__pmu_write_counters(cci_pmu, mask, value);
> +}

Why are these not just one function for now?

Mark.
