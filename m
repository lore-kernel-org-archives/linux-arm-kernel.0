From: Wenyou.Yang@Microchip.com (Yang, Wenyou)
Date: Fri, 28 Apr 2017 09:33:01 +0800
Subject: [PATCH 2/3] ARM: at91: pm: allow selecting standby and suspend
 modes
In-Reply-To: <20170426160419.22401-2-alexandre.belloni@free-electrons.com>
References: <20170426160419.22401-1-alexandre.belloni@free-electrons.com>
 <20170426160419.22401-2-alexandre.belloni@free-electrons.com>
Message-ID: <64aebbf3-85e3-b146-b094-4ae0d2c9d81e@Microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/4/27 0:04, Alexandre Belloni wrote:
> While we can only select between "standby" and "mem" states for power
> management, the atmel platforms can actually support more modes.
>
> For both standby and mem, allow selecting which mode will be used using the
> atmel.pm_modes kernel parameter.
> By default, keep the current modes.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>   arch/arm/mach-at91/pm.c | 110 +++++++++++++++++++++++++++++++++---------------
>   arch/arm/mach-at91/pm.h |   3 +-
>   2 files changed, 78 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 1e03f1277f14..d08f032f9d94 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -15,6 +15,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
> +#include <linux/parser.h>
>   #include <linux/suspend.h>
>   
>   #include <linux/clk/at91_pmc.h>
> @@ -38,7 +39,17 @@ extern void at91_pinctrl_gpio_suspend(void);
>   extern void at91_pinctrl_gpio_resume(void);
>   #endif
>   
> -static struct at91_pm_data pm_data;
> +static const match_table_t pm_modes __initconst = {
> +	{ 0, "standby" },
> +	{ AT91_PM_SLOW_CLOCK, "ulp0" },
> +	{ AT91_PM_BACKUP, "backup" },
> +	{ -1, NULL },
> +};
> +
> +static struct at91_pm_data pm_data = {
> +	.standby_mode = 0,
> +	.suspend_mode = AT91_PM_SLOW_CLOCK,
> +};
>   
>   #define at91_ramc_read(id, field) \
>   	__raw_readl(pm_data.ramc[id] + field)
> @@ -68,14 +79,24 @@ static struct at91_pm_bu {
>   	phys_addr_t resume;
>   } *pm_bu;
>   
> -static suspend_state_t target_state;
> -
>   /*
>    * Called after processes are frozen, but before we shutdown devices.
>    */
>   static int at91_pm_begin(suspend_state_t state)
>   {
> -	target_state = state;
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		pm_data.mode = pm_data.suspend_mode;
> +		break;
> +
> +	case PM_SUSPEND_STANDBY:
> +		pm_data.mode = pm_data.standby_mode;
> +		break;
> +
> +	default:
> +		pm_data.mode = -1;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -124,7 +145,7 @@ static int at91_pm_verify_clocks(void)
>    */
>   int at91_suspend_entering_slow_clock(void)
>   {
> -	return (target_state == PM_SUSPEND_MEM);
> +	return (pm_data.mode >= AT91_PM_SLOW_CLOCK);
>   }
>   EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
>   
> @@ -144,14 +165,6 @@ static int at91_suspend_finish(unsigned long val)
>   
>   static void at91_pm_suspend(suspend_state_t state)
>   {
> -	if (pm_data.deepest_state == AT91_PM_BACKUP)
> -		if (state == PM_SUSPEND_MEM)
> -			pm_data.mode = AT91_PM_BACKUP;
> -		else
> -			pm_data.mode = AT91_PM_SLOW_CLOCK;
> -	else
> -		pm_data.mode = (state == PM_SUSPEND_MEM) ? AT91_PM_SLOW_CLOCK : 0;
> -
>   	if (pm_data.mode == AT91_PM_BACKUP) {
>   		pm_bu->suspended = 1;
>   
> @@ -168,38 +181,37 @@ static void at91_pm_suspend(suspend_state_t state)
>   	outer_resume();
>   }
>   
> +/*
> + * STANDBY mode has *all* drivers suspended; ignores irqs not marked as 'wakeup'
> + * event sources; and reduces DRAM power.  But otherwise it's identical to
> + * PM_SUSPEND_ON: cpu idle, and nothing fancy done with main or cpu clocks.
> + *
> + * AT91_PM_SLOW_CLOCK is like STANDBY plus slow clock mode, so drivers must
> + * suspend more deeply, the master clock switches to the clk32k and turns off
> + * the main oscillator
> + *
> + * AT91_PM_BACKUP turns off the whole SoC after placing the DDR in self refresh
> + */
>   static int at91_pm_enter(suspend_state_t state)
>   {
>   #ifdef CONFIG_PINCTRL_AT91
>   	at91_pinctrl_gpio_suspend();
>   #endif
> +
>   	switch (state) {
> -	/*
> -	 * Suspend-to-RAM is like STANDBY plus slow clock mode, so
> -	 * drivers must suspend more deeply, the master clock switches
> -	 * to the clk32k and turns off the main oscillator
> -	 */
>   	case PM_SUSPEND_MEM:
> +	case PM_SUSPEND_STANDBY:
>   		/*
>   		 * Ensure that clocks are in a valid state.
>   		 */
> -		if (!at91_pm_verify_clocks())
> +		if ((pm_data.mode >= AT91_PM_SLOW_CLOCK) &&
> +		    !at91_pm_verify_clocks())
>   			goto error;
>   
>   		at91_pm_suspend(state);
>   
>   		break;
>   
> -	/*
> -	 * STANDBY mode has *all* drivers suspended; ignores irqs not
> -	 * marked as 'wakeup' event sources; and reduces DRAM power.
> -	 * But otherwise it's identical to PM_SUSPEND_ON: cpu idle, and
> -	 * nothing fancy done with main or cpu clocks.
> -	 */
> -	case PM_SUSPEND_STANDBY:
> -		at91_pm_suspend(state);
> -		break;
> -
>   	case PM_SUSPEND_ON:
>   		cpu_do_idle();
>   		break;
> @@ -210,8 +222,6 @@ static int at91_pm_enter(suspend_state_t state)
>   	}
>   
>   error:
> -	target_state = PM_SUSPEND_ON;
> -
>   #ifdef CONFIG_PINCTRL_AT91
>   	at91_pinctrl_gpio_resume();
>   #endif
> @@ -223,7 +233,6 @@ static int at91_pm_enter(suspend_state_t state)
>    */
>   static void at91_pm_end(void)
>   {
> -	target_state = PM_SUSPEND_ON;
>   }
>   
>   
> @@ -494,6 +503,10 @@ static void __init at91_pm_bu_sram_init(void)
>   	struct device_node *node;
>   	struct platform_device *pdev = NULL;
>   
> +	if ((pm_data.standby_mode != AT91_PM_BACKUP) &&
> +	    (pm_data.suspend_mode != AT91_PM_BACKUP))
> +		return;
> +
>   	pm_bu = NULL;
>   
>   	for_each_compatible_node(node, NULL, "atmel,sama5d2-securam") {
> @@ -571,10 +584,14 @@ static void __init at91_pm_init(void (*pm_idle)(void))
>   
>   	at91_pm_sram_init();
>   
> -	if (at91_suspend_sram_fn)
> +	if (at91_suspend_sram_fn) {
>   		suspend_set_ops(&at91_pm_ops);
> -	else
> +		pr_info("AT91: PM: standby: %s, suspend: %s\n",
> +			pm_modes[pm_data.standby_mode].pattern,
> +			pm_modes[pm_data.suspend_mode].pattern);
> +	} else {
>   		pr_info("AT91: PM not supported, due to no SRAM allocated\n");
> +	}
>   }
>   
>   void __init at91rm9200_pm_init(void)
> @@ -607,3 +624,28 @@ void __init sama5d2_pm_init(void)
>   	at91_pm_bu_sram_init();
>   	sama5_pm_init();
>   }
> +
> +static int __init at91_pm_modes_select(char *str)
> +{
> +	char *s;
> +	substring_t args[MAX_OPT_ARGS];
> +	int standby, suspend;
> +
> +	if (!str)
> +		return 0;
> +
> +	s = strsep(&str, ",");
> +	standby = match_token(s, pm_modes, args);
> +	if (standby < 0)
> +		return 0;
> +
> +	suspend = match_token(str, pm_modes, args);
> +	if (suspend < 0)
> +		return 0;
> +
> +	pm_data.standby_mode = standby;
> +	pm_data.suspend_mode = suspend;
> +
> +	return 0;
> +}
> +early_param("atmel.pm_modes", at91_pm_modes_select);
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index d9c6612ef62f..f95d31496f08 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -33,7 +33,8 @@ struct at91_pm_data {
>   	unsigned int mode;
>   	void __iomem *shdwc;
>   	void __iomem *sfrbu;
> -	unsigned int deepest_state;
> +	unsigned int standby_mode;
> +	unsigned int suspend_mode;
>   };
>   #endif
>   
Best Regards,
Wenyou Yang
