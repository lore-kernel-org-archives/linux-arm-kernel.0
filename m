From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Thu, 01 Nov 2012 16:15:11 +0100
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <1351698033-8980-2-git-send-email-rajanikanth.hv@linaro.org>
References: <1351698033-8980-1-git-send-email-rajanikanth.hv@linaro.org>
 <1351698033-8980-2-git-send-email-rajanikanth.hv@linaro.org>
Message-ID: <509291FF.6090500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 04:40 PM, Rajanikanth H.V wrote:
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
> +int __devinit
> +bmdevs_of_probe(struct device *dev,
> +		struct device_node *np,
> +		struct abx500_bm_data **battery)
> +{
> +	struct	abx500_battery_type *btype;
> +	struct  device_node *np_bat_supply;
> +	struct	abx500_bm_data *bat;
> +	const char *btech;
> +	char bat_tech[8];
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
> +	btech = of_get_property(np_bat_supply,
> +		"stericsson,battery-type", NULL);
> +	if (!btech) {
> +		dev_warn(dev, "missing property battery-name/type\n");
> +		strcpy(bat_tech, "UNKNOWN");
> +	} else {
> +		strcpy(bat_tech, btech);
> +	}

I don't get the point of declaring the char array and copying the string
in it, when you could simply use just the pointer returned by
of_get_property().
Anyway, if the string property is longer than 8 characters, you are
writing past the size of the destination array.
