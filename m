From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Apr 2015 18:55:18 +0100
Subject: [PATCH] clocksource: arm_global_timer: Detect if gt is usable
 with CPU_FREQ
In-Reply-To: <552BFED9.3020105@adapteva.com>
References: <552BFED9.3020105@adapteva.com>
Message-ID: <20150413175518.GM4076@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 06:37:29PM +0100, Ola Jeppsson wrote:
> Some Cortex A9 CPU:s (e.g. zynq) have the tick tied to the CPU
> frequency. On those CPU:s we cannot use the global-timer as a reliable
> clocksource with CPU frequency scaling enabled since this is not
> currently taken into account by the driver.

The global timer is _always_ tied to the CPU frequency -- it's fed by
PERIPHCLK, which must have a period which is a multiple of CLK.

> Add a "tied-to-cpu-freq" boolean to the global-timer dt node indicate
> this condition.

Is this indicating the truism above, or that the kernel is performing
frequency scaling? The latter is an OS property rather than a HW
property, and thus doesn't belong in the DT.

The SMP TWD driver tries to account for frequency scaling. Assuming that
works, the same should be possible here. Otherwise, the global timer is
simply unusable with any frequency scaling.

In either case the property seems pointless; all you care about is
whether the platform actually performs CPU frequency scaling.

Mark.

> 
> When the global-timer register function sees this property return
> immediately and don't register the clocksource.
> 
> Signed-off-by: Ola Jeppsson <ola@adapteva.com>
> ---
>  Documentation/devicetree/bindings/arm/global_timer.txt | 4 ++++
>  drivers/clocksource/arm_global_timer.c                 | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/global_timer.txt b/Documentation/devicetree/bindings/arm/global_timer.txt
> index bdae3a818793..465e02c17b5b 100644
> --- a/Documentation/devicetree/bindings/arm/global_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/global_timer.txt
> @@ -17,6 +17,10 @@
>  
>  - clocks : Should be phandle to a clock.
>  
> +** Timer node optional properties:
> +
> +- tied-to-cpu-freq : indicates that the timer scales with the CPU frequency.
> +
>  Example:
>  
>  	timer at 2c000600 {
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index e6833771a716..8913ebda3f09 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -268,6 +268,13 @@ static void __init global_timer_of_register(struct device_node *np)
>  		return;
>  	}
>  
> +#ifdef CONFIG_CPU_FREQ
> +	if (of_property_read_bool(np, "tied-to-cpu-freq")) {
> +		pr_warn("global-timer: tied to cpu frequency, not supported with scaling\n");
> +		return;
> +	}
> +#endif
> +
>  	gt_clk = of_clk_get(np, 0);
>  	if (!IS_ERR(gt_clk)) {
>  		err = clk_prepare_enable(gt_clk);
> -- 
> 2.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
