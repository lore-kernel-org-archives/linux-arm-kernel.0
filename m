From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 4 Feb 2015 18:59:29 +0000
Subject: [PATCH v8 17/21] clocksource / arch_timer: Parse GTDT to
 initialize arch timer
In-Reply-To: <1422881149-8177-18-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-18-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150204185929.GH22035@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 12:45:45PM +0000, Hanjun Guo wrote:
> Using the information presented by GTDT (Generic Timer Description Table)
> to initialize the arch timer (not memory-mapped).

Why are you not initializing the memory mapped timer ?

> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/time.c             |   7 ++
>  drivers/clocksource/arm_arch_timer.c | 132 ++++++++++++++++++++++++++++-------
>  include/linux/clocksource.h          |   6 ++
>  3 files changed, 118 insertions(+), 27 deletions(-)
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
> index 095c177..407aa63 100644
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
> @@ -370,8 +371,12 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
>  	if (arch_timer_rate)
>  		return;
>  
> -	/* Try to determine the frequency from the device tree or CNTFRQ */
> -	if (of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {
> +	/*
> +	 * Try to determine the frequency from the device tree or CNTFRQ,
> +	 * if ACPI is enabled, get the frequency from CNTFRQ ONLY.
> +	 */
> +	if (!acpi_disabled ||
> +	    of_property_read_u32(np, "clock-frequency", &arch_timer_rate)) {

This is getting a mess. cntbase tells you it is a memory mapped timer,
node pointer that you are probing through DT, and to top it all
acpi_disabled detects if you are probing in ACPI or DT mode.

I think this function should be simplified, this driver is also
pending a refactoring to split arch timer and the memory mapped one
so I think you'd better wait that work to make things simpler.

[...]

> +/* Initialize all the generic timers presented in GTDT */
> +void __init acpi_generic_timer_init(void)
> +{
> +	if (acpi_disabled)
> +		return;

acpi_disabled used again here, I repeat myself this is going to be
hard to track. You should try to organize the code something like:

if (acpi_disabled)
	timer_dt_probe();
else
	timer_acpi_probe();

mixing the code paths is getting unwieldy, see above to see my
reasoning.

> +
> +	acpi_table_parse(ACPI_SIG_GTDT, arch_timer_acpi_init);
> +}
> +#endif
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index abcafaa..af6155a 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -346,4 +346,10 @@ extern void clocksource_of_init(void);
>  static inline void clocksource_of_init(void) {}
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +void acpi_generic_timer_init(void);
> +#else
> +static inline void acpi_generic_timer_init(void) { }
> +#endif
> +

That's not nice, it is a generic header, arch specific stuff should be
avoided. I think you should have an ACPI generic layer similar to
clocksource_of_init(), and probe from there when matching the respective
timers.

Lorenzo
