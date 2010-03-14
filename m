From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 14 Mar 2010 11:29:02 +0200
Subject: [PATCH 1/5] [ARM] pxa/cm-x300.c: add battery charger support
In-Reply-To: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
References: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <4B9CAC5E.1020709@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Any update on this?

On 03/09/10 11:43, Igor Grinberg wrote:
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-pxa/cm-x300.c |   57 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 56 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index d37cfa1..0e538d8 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -30,6 +30,8 @@
>  #include <linux/i2c/pca953x.h>
>  
>  #include <linux/mfd/da903x.h>
> +#include <linux/power_supply.h>
> +#include <linux/apm-emulation.h>
>  
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_gpio.h>
> @@ -584,12 +586,65 @@ static void __init cm_x300_init_rtc(void)
>  static inline void cm_x300_init_rtc(void) {}
>  #endif
>  
> +/* Battery */
> +struct power_supply_info cm_x300_psy_info = {
> +	.name = "battery",
> +	.technology = POWER_SUPPLY_TECHNOLOGY_LIPO,
> +	.voltage_max_design = 4200000,
> +	.voltage_min_design = 3000000,
> +	.use_for_apm = 1,
> +};
> +
> +static void cm_x300_battery_low(void)
> +{
> +#if defined(CONFIG_APM_EMULATION)
> +	apm_queue_event(APM_LOW_BATTERY);
> +#endif
> +}
> +
> +static void cm_x300_battery_critical(void)
> +{
> +#if defined(CONFIG_APM_EMULATION)
> +	apm_queue_event(APM_CRITICAL_SUSPEND);
> +#endif
> +}
> +
> +struct da9030_battery_info cm_x300_battery_info = {
> +	.battery_info = &cm_x300_psy_info,
> +
> +	.charge_milliamp = 1000,
> +	.charge_millivolt = 4200,
> +
> +	.vbat_low = 3600,
> +	.vbat_crit = 3400,
> +	.vbat_charge_start = 4100,
> +	.vbat_charge_stop = 4200,
> +	.vbat_charge_restart = 4000,
> +
> +	.vcharge_min = 3200,
> +	.vcharge_max = 5500,
> +
> +	.tbat_low = 197,
> +	.tbat_high = 78,
> +	.tbat_restart = 100,
> +
> +	.batmon_interval = 0,
> +
> +	.battery_low = cm_x300_battery_low,
> +	.battery_critical = cm_x300_battery_critical,
> +};
> +
>  /* DA9030 */
>  struct da903x_subdev_info cm_x300_da9030_subdevs[] = {
>  	{
>  		.name = "da903x-backlight",
>  		.id = DA9030_ID_WLED,
> -	}
> +	},
> +	{
> +		.name = "da903x-battery",
> +		.id = DA9030_ID_BAT,
> +		.platform_data = &cm_x300_battery_info,
> +	},
>  };
>  
>  static struct da903x_platform_data cm_x300_da9030_info = {
>   
