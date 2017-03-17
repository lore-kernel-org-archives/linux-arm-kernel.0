From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 20:01:54 +0000
Subject: [PATCH v21 13/13] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
In-Reply-To: <20170206185015.12296-14-fu.wei@linaro.org>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
Message-ID: <20170317200153.GF15909@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei at linaro.org wrote:
> +static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
> +					int index)
> +{
> +	struct platform_device *pdev;
> +	int irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
> +	int no_irq = 1;
> +
> +	/*
> +	 * According to SBSA specification the size of refresh and control
> +	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 ? 0xFFF).
> +	 */
> +	struct resource res[] = {
> +		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
> +		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
> +		DEFINE_RES_IRQ(irq),
> +	};
> +
> +	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
> +		 wd->refresh_frame_address, wd->control_frame_address,
> +		 wd->timer_interrupt, wd->timer_flags);
> +
> +	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
> +		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!wd->timer_interrupt)
> +		pr_warn(FW_BUG "failed to get the Watchdog interrupt.\n");

I've not been able to find where the ACPI spec says that zero is not a
valid GSIV. This may simply be an oversight/ambiguity in the spec.

Is there any statement to that effect?

> +	else if (irq <= 0)
> +		pr_warn("failed to map the Watchdog interrupt.\n");
> +	else
> +		no_irq = 0;
> +
> +	/*
> +	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
> +	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
> +	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
> +	 * info below by matching this name.
> +	 */
> +	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
> +					       ARRAY_SIZE(res) - no_irq);

This no_irq variable is messy and confusing.

Get rid of no_irq, and replace it with nr_res, initialised to
ARRAY_SIZE(res). If there's no interrupt, subtract one.

[...]

> +	for_each_platform_timer(platform_timer) {
> +		if (is_watchdog(platform_timer)) {
> +			ret = gtdt_import_sbsa_gwdt(platform_timer, i);
> +			if (ret)
> +				break;
> +			i++;
> +		}
> +	}
> +
> +	if (i)
> +		pr_info("found %d SBSA generic Watchdog(s).\n", i);

My reading of SBSA is that there is one watchdog in the system.

Is that not the case?

[...]

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b5..c899df1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -219,6 +219,7 @@ config ARM_SBSA_WATCHDOG
>  	tristate "ARM SBSA Generic Watchdog"
>  	depends on ARM64
>  	depends on ARM_ARCH_TIMER
> +	depends on ACPI_GTDT || !ACPI

I don't think this is necessary.

This series hasn't touched this driver code at all.

Thanks,
Mark.
