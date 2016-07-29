From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Jul 2016 11:18:11 +0100
Subject: [PATCH] clocksource: arm_arch_timer: Support reading clock rate
 from a driver
In-Reply-To: <1469784191-3998-1-git-send-email-zajec5@gmail.com>
References: <1469784191-3998-1-git-send-email-zajec5@gmail.com>
Message-ID: <20160729101811.GB21580@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Marc to Cc]

On Fri, Jul 29, 2016 at 11:23:11AM +0200, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> On some devices using arch code for reading clock rate doesn't work. So
> far the only option was to specify clock-frequency in a DT. This works
> only if a clock frequency doesn't have to be calculated on runtime.
> 
> On BCM53573 SoC (with Cortex-A7) there is ILP clock that needs its own
> driver. With this change we can query such clocks by using a standard:
> clocks = <&foo>;

The clock for the architected timer(s) are supposed to be configured
before entering Linux. The clock-frequency property is at best a dodgy
workaround, and this is even worse.

Please fix your firmware to configure and enabled this clock before
entering Linux, and to program CNTFRQ appropriately.

As this path stands, NAK.

As a more general note, you *must* update device tree bidnings if adding
properties.

Thanks,
Mark.

> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
>  drivers/clocksource/arm_arch_timer.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 5effd30..5ed98a2 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -14,6 +14,7 @@
>  #include <linux/smp.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
> +#include <linux/clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/clocksource.h>
>  #include <linux/interrupt.h>
> @@ -405,6 +406,16 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>  			arch_timer_rate = arch_timer_get_cntfrq();
>  	}
>  
> +	/* Get clk rate through clk driver if present */
> +	if (!arch_timer_rate) {
> +		struct clk *clk = of_clk_get(np, 0);
> +
> +		if (!IS_ERR(clk)) {
> +			if (!clk_prepare_enable(clk))
> +				arch_timer_rate = clk_get_rate(clk);
> +		}
> +	}
> +
>  	/* Check the timer frequency. */
>  	if (arch_timer_rate == 0)
>  		pr_warn("Architected timer frequency not available\n");
> -- 
> 1.8.4.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
