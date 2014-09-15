From: olof@lixom.net (Olof Johansson)
Date: Mon, 15 Sep 2014 00:13:04 -0700
Subject: [PATCH v4 15/18] ARM64 / ACPI: Parse GTDT to initialize arch timer
In-Reply-To: <1410530416-30200-16-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-16-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140915071304.GG26649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 10:00:13PM +0800, Hanjun Guo wrote:
> Using the information presented by GTDT to initialize the arch
> timer (not memory-mapped).
> 
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/time.c             |    7 ++
>  drivers/clocksource/arm_arch_timer.c |  117 ++++++++++++++++++++++++++++------
>  include/linux/clocksource.h          |    6 ++
>  3 files changed, 111 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
> index 1a7125c..42f9195 100644
> --- a/arch/arm64/kernel/time.c
> +++ b/arch/arm64/kernel/time.c
> @@ -35,6 +35,7 @@
>  #include <linux/delay.h>
>  #include <linux/clocksource.h>
>  #include <linux/clk-provider.h>
> +#include <linux/acpi.h>
>  
>  #include <clocksource/arm_arch_timer.h>
>  
> @@ -72,6 +73,12 @@ void __init time_init(void)
>  
>  	tick_setup_hrtimer_broadcast();
>  
> +	/*
> +	 * Since ACPI or FDT will only one be available in the system,
> +	 * we can use acpi_generic_timer_init() here safely
> +	 */
> +	acpi_generic_timer_init();
> +
>  	arch_timer_rate = arch_timer_get_rate();
>  	if (!arch_timer_rate)
>  		panic("Unable to initialise architected timer.\n");
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 5163ec1..397783f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/sched_clock.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/arch_timer.h>
>  #include <asm/virt.h>
> @@ -338,8 +339,12 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>  	if (arch_timer_rate)
>  		return;
>  
> -	/* Try to determine the frequency from the device tree or CNTFRQ */
> -	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> +	/*
> +	 * Try to determine the frequency from the device tree or CNTFRQ,
> +	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
> +	 */

If ACPI is enabled, the tree won't have been unflattened and there wouldn't be
a property to match. So I don't think the extra check is needed here.

If anything, add a check to make sure "np" is non-null instead.

> +	if (!acpi_disabled ||
> +	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
>  		if (cntbase)
>  			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
>  		else


-Olof
