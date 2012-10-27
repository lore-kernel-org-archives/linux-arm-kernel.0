From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 27 Oct 2012 17:07:20 +0200
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <1351146654-9110-2-git-send-email-rajanikanth.hv@stericsson.com>
References: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1351146654-9110-2-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <508BF8A8.9090206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 08:30 AM, Rajanikanth H.V wrote:
> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> 
> - This patch adds device tree support for fuelgauge driver
> - optimize bm devices platform_data usage and of_probe(...)
>   Note: of_probe() routine for battery managed devices is made
>   common across all bm drivers.
> - test status:
>   - interrupt numbers assigned differs between legacy and FDT mode.
> 
> Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
[...]
> diff --git a/Documentation/devicetree/bindings/power_supply/ab8500/fg.txt b/Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
> new file mode 100644
> index 0000000..28eaf35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
> @@ -0,0 +1,58 @@
> +=== AB8500 Fuel Gauge Driver ===
> +
> +AB8500 is a mixed signal multimedia and power management
> +device comprising: power and energy-management-module,
> +wall-charger, usb-charger, audio codec, general purpose adc,
> +tvout, clock management and sim card interface.
> +
> +Fuelgauge support is part of energy-management-modules, other
> +components of this module are:
> +main-charger, usb-combo-charger and battery-temperature-monitoring.
> +
> +The properties below describes the node for fuelgauge driver.
> +
> +Required Properties:
> +- compatible = This shall be: "stericsson,ab8500-fg"
> +- battery = Shall be battery specific information
> +	Example:
> +	ab8500_fg {
> +		compatible = "stericsson,ab8500-fg";
> +		battery	   = <&ab8500_battery>;
> +	};
> +
> +dependent node:
> +	ab8500_battery: ab8500_battery {
> +	};
> +	This node will provide information on 'thermistor interface' and
> +	'battery technology type' used.
> +
> +Properties of this node are:
> +thermistor-on-batctrl:
> +	A boolean value indicating thermistor interface	to battery
> +
> +	Note:
> +	'btemp' and 'batctrl' are the pins interfaced for battery temperature
> +	measurement, 'btemp' signal is used when NTC(negative temperature
> +	coefficient) resister is interfaced external to battery whereas
> +	'batctrl' pin is used when NTC resister is internal to battery.
> +
> +	Example:
> +	ab8500_battery: ab8500_battery {
> +		thermistor-on-batctrl;
> +	};
> +	indiactes: NTC resister is internal to battery, 'batctrl' is used

s/indiactes/indicates

[...]
> +int __devinit
> +bmdevs_of_probe(struct device *dev,
> +		struct device_node *np,
> +		struct abx500_bm_data **battery)
> +{
> +	struct	abx500_battery_type *btype;
> +	struct  device_node *np_bat_supply;
> +	struct	abx500_bm_data *bat;
> +	const char *bat_tech;
> +	int i, thermistor;
> +
> +	*battery = &ab8500_bm_data;
> +
> +	/* get phandle to 'battery-info' node */
> +	np_bat_supply = of_parse_phandle(np, "battery", 0);
> +	if (!np_bat_supply) {
> +		dev_err(dev, "missing property battery\n");
> +		return -EINVAL;
> +	}
> +	if (of_property_read_bool(np_bat_supply,
> +			"thermistor-on-batctrl"))
> +		thermistor = NTC_INTERNAL;
> +	else
> +		thermistor = NTC_EXTERNAL;
> +
> +	bat = *battery;
> +	if (thermistor == NTC_EXTERNAL) {
> +		bat->n_btypes  = 4;
> +		bat->bat_type  = bat_type_ext_thermistor;
> +		bat->adc_therm = ABx500_ADC_THERM_BATTEMP;
> +	}
> +	bat_tech = of_get_property(np_bat_supply,
> +			"stericsson,battery-type", NULL);
> +	if (!bat_tech)
> +		dev_warn(dev, "missing property battery-name/type\n");
> +
> +	if (strncmp(bat_tech, "LION", 4) == 0) {

What if bat_tech is NULL?

[...]
> diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
> index bf02225..e117920 100644
> --- a/drivers/power/ab8500_fg.c
> +++ b/drivers/power/ab8500_fg.c
> @@ -22,15 +22,16 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/kobject.h>
> -#include <linux/mfd/abx500/ab8500.h>
> -#include <linux/mfd/abx500.h>
>  #include <linux/slab.h>
> -#include <linux/mfd/abx500/ab8500-bm.h>
>  #include <linux/delay.h>
> -#include <linux/mfd/abx500/ab8500-gpadc.h>
> -#include <linux/mfd/abx500.h>
>  #include <linux/time.h>
> +#include <linux/of.h>
>  #include <linux/completion.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/abx500.h>
> +#include <linux/mfd/abx500/ab8500.h>
> +#include <linux/mfd/abx500/ab8500-bm.h>
> +#include <linux/mfd/abx500/ab8500-gpadc.h>
>  
>  #define MILLI_TO_MICRO			1000
>  #define FG_LSB_IN_MA			1627
> @@ -212,7 +213,6 @@ struct ab8500_fg {
>  	struct ab8500_fg_avg_cap avg_cap;
>  	struct ab8500 *parent;
>  	struct ab8500_gpadc *gpadc;
> -	struct abx500_fg_platform_data *pdata;

pdata should be removed from the description of the struct members as well.

--
Francesco
