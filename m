From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 14 Apr 2015 08:41:04 +0100
Subject: [PATCH] clocksource: arm_global_timer: Detect if gt is usable
 with CPU_FREQ
In-Reply-To: <552BFED9.3020105@adapteva.com>
References: <552BFED9.3020105@adapteva.com>
Message-ID: <552CC490.4010002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Adding Pete and Maxime

Hi Ola,
Thankyou for sending the patch,

I like the Idea, but I have some specific concerns which would break 
existing SOCs.

On 13/04/15 18:37, Ola Jeppsson wrote:
> Some Cortex A9 CPU:s (e.g. zynq) have the tick tied to the CPU
> frequency. On those CPU:s we cannot use the global-timer as a reliable
> clocksource with CPU frequency scaling enabled since this is not
> currently taken into account by the driver.
>
> Add a "tied-to-cpu-freq" boolean to the global-timer dt node indicate
> this condition.
>
> When the global-timer register function sees this property return
> immediately and don't register the clocksource.
>
> Signed-off-by: Ola Jeppsson <ola@adapteva.com>
> ---
>   Documentation/devicetree/bindings/arm/global_timer.txt | 4 ++++
>   drivers/clocksource/arm_global_timer.c                 | 7 +++++++
>   2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> index bdae3a818793..465e02c17b5b 100644
> --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> @@ -17,6 +17,10 @@
>
>   - clocks : Should be phandle to a clock.
>
> +** Timer node optional properties:
> +
> +- tied-to-cpu-freq : indicates that the timer scales with the CPU frequency.
> +
>   Example:
>
>   	timer at 2c000600 {
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index e6833771a716..8913ebda3f09 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -268,6 +268,13 @@ static void __init global_timer_of_register(struct device_node *np)
>   		return;
>   	}
>
> +#ifdef CONFIG_CPU_FREQ
> +	if (of_property_read_bool(np, "tied-to-cpu-freq")) {
> +		pr_warn("global-timer: tied to cpu frequency, not supported with scaling\n");
> +		return;
> +	}
> +#endif
> +

This patch would not let the SOC like STiH415/416 or zynq with 
"tied-to-cpu-freq" property to boot with multi_v7_defconfig. Which is 
not correct thing to do, as STi SOC's do not use cpufreq driver however 
the tick is tied to this clocksource.



--srini

>   	gt_clk = of_clk_get(np, 0);
>   	if (!IS_ERR(gt_clk)) {
>   		err = clk_prepare_enable(gt_clk);
>
