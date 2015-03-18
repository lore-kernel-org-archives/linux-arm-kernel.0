From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Mar 2015 18:34:23 +0000
Subject: [PATCH v10 17/21] clocksource / arch_timer: Parse GTDT to
 initialize arch timer
In-Reply-To: <1426077587-1561-18-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-18-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150318183423.GK10863@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 12:39:43PM +0000, Hanjun Guo wrote:
> Using the information presented by GTDT (Generic Timer Description Table)
> to initialize the arch timer (not memory-mapped).
> 
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/time.c             |   7 ++
>  drivers/clocksource/arm_arch_timer.c | 132 ++++++++++++++++++++++++++++-------
>  include/linux/clocksource.h          |   6 ++
>  3 files changed, 118 insertions(+), 27 deletions(-)

Daniel, can we have your Ack on this patch please? The intention is to
merge the whole series via the arm64 tree.

Cheers.

Will

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
> index a3025e7..ea62fc7 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -22,6 +22,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/sched_clock.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/arch_timer.h>
>  #include <asm/virt.h>
> @@ -371,8 +372,12 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
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
>  		if (cntbase)
>  			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
>  		else
> @@ -691,28 +696,8 @@ static void __init arch_timer_common_init(void)
>  	arch_timer_arch_init();
>  }
>  
> -static void __init arch_timer_init(struct device_node *np)
> +static void __init arch_timer_init(void)
>  {
> -	int i;
> -
> -	if (arch_timers_present & ARCH_CP15_TIMER) {
> -		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
> -		return;
> -	}
> -
> -	arch_timers_present |= ARCH_CP15_TIMER;
> -	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
> -		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
> -	arch_timer_detect_rate(NULL, np);
> -
> -	/*
> -	 * If we cannot rely on firmware initializing the timer registers then
> -	 * we should use the physical timers instead.
> -	 */
> -	if (IS_ENABLED(CONFIG_ARM) &&
> -	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
> -			arch_timer_use_virtual = false;
> -
>  	/*
>  	 * If HYP mode is available, we know that the physical timer
>  	 * has been configured to be accessible from PL1. Use it, so
> @@ -731,13 +716,39 @@ static void __init arch_timer_init(struct device_node *np)
>  		}
>  	}
>  
> -	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
> -
>  	arch_timer_register();
>  	arch_timer_common_init();
>  }
> -CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_init);
> -CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_init);
> +
> +static void __init arch_timer_of_init(struct device_node *np)
> +{
> +	int i;
> +
> +	if (arch_timers_present & ARCH_CP15_TIMER) {
> +		pr_warn("arch_timer: multiple nodes in dt, skipping\n");
> +		return;
> +	}
> +
> +	arch_timers_present |= ARCH_CP15_TIMER;
> +	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
> +		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
> +
> +	arch_timer_detect_rate(NULL, np);
> +
> +	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
> +
> +	/*
> +	 * If we cannot rely on firmware initializing the timer registers then
> +	 * we should use the physical timers instead.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM) &&
> +	    of_property_read_bool(np, "arm,cpu-registers-not-fw-configured"))
> +			arch_timer_use_virtual = false;
> +
> +	arch_timer_init();
> +}
> +CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
> +CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
>  
>  static void __init arch_timer_mem_init(struct device_node *np)
>  {
> @@ -804,3 +815,70 @@ static void __init arch_timer_mem_init(struct device_node *np)
>  }
>  CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
>  		       arch_timer_mem_init);
> +
> +#ifdef CONFIG_ACPI
> +static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt)
> +		return 0;
> +
> +	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> +			: ACPI_LEVEL_SENSITIVE;
> +
> +	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> +			: ACPI_ACTIVE_HIGH;
> +
> +	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> +}
> +
> +/* Initialize per-processor generic timer */
> +static int __init arch_timer_acpi_init(struct acpi_table_header *table)
> +{
> +	struct acpi_table_gtdt *gtdt;
> +
> +	if (arch_timers_present & ARCH_CP15_TIMER) {
> +		pr_warn("arch_timer: already initialized, skipping\n");
> +		return -EINVAL;
> +	}
> +
> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +
> +	arch_timers_present |= ARCH_CP15_TIMER;
> +
> +	arch_timer_ppi[PHYS_SECURE_PPI] =
> +		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
> +		gtdt->secure_el1_flags);
> +
> +	arch_timer_ppi[PHYS_NONSECURE_PPI] =
> +		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
> +		gtdt->non_secure_el1_flags);
> +
> +	arch_timer_ppi[VIRT_PPI] =
> +		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
> +		gtdt->virtual_timer_flags);
> +
> +	arch_timer_ppi[HYP_PPI] =
> +		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
> +		gtdt->non_secure_el2_flags);
> +
> +	/* Get the frequency from CNTFRQ */
> +	arch_timer_detect_rate(NULL, NULL);
> +
> +	/* Always-on capability */
> +	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +
> +	arch_timer_init();
> +	return 0;
> +}
> +
> +/* Initialize all the generic timers presented in GTDT */
> +void __init acpi_generic_timer_init(void)
> +{
> +	if (acpi_disabled)
> +		return;
> +
> +	acpi_table_parse(ACPI_SIG_GTDT, arch_timer_acpi_init);
> +}
> +#endif
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 9c78d15..2b2e1f8 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -244,4 +244,10 @@ extern void clocksource_of_init(void);
>  static inline void clocksource_of_init(void) {}
>  #endif
>  
> +#ifdef CONFIG_ACPI
> +void acpi_generic_timer_init(void);
> +#else
> +static inline void acpi_generic_timer_init(void) { }
> +#endif
> +
>  #endif /* _LINUX_CLOCKSOURCE_H */
> -- 
> 1.9.1
> 
> 
