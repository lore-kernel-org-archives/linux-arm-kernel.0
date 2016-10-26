From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Oct 2016 10:27:20 +0100
Subject: [PATCH 1/1] power: axp20x_ac: Add support for ac power-supply on
 axp20x and axp22x pmics
In-Reply-To: <1474129243-10873-1-git-send-email-lyu@micile.com>
References: <1474129243-10873-1-git-send-email-lyu@micile.com>
Message-ID: <20161026092720.GN8574@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Sep 2016, Lawrence Yu wrote:

> Add support for monitoring of ac power supply input.  axp22x is the same
> as axp20x except it can not monitor voltage or current, only presence of
> power.
> 
> This is mainly a copy of the existing axp20x_usb_power driver modified to
> use the ac power supply registers instead of the usb registers.
> 
> axp20x tested on a generic A20 tablet.
> axp22x tested on an a33 ga10h-v1.1 tablet.
> 
> Signed-off-by: Lawrence Yu <lyu@micile.com>
> ---
>  .../bindings/power_supply/axp20x_ac_power.txt      |  35 ++++
>  arch/arm/boot/dts/axp209.dtsi                      |   5 +
>  arch/arm/boot/dts/axp22x.dtsi                      |   5 +
>  drivers/mfd/axp20x.c                               |  11 ++
>  drivers/power/Makefile                             |   1 +
>  drivers/power/axp20x_ac_power.c                    | 219 +++++++++++++++++++++

Please split this patch up per-subsystem.

>  6 files changed, 276 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
>  create mode 100644 drivers/power/axp20x_ac_power.c
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
> new file mode 100644
> index 0000000..d751cdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
> @@ -0,0 +1,35 @@
> +AXP20x AC power supply
> +
> +Required Properties:
> +-compatible: One of: "x-powers,axp202-ac-power-supply"
> +                     "x-powers,axp221-ac-power-supply"
> +
> +This node is a subnode of the axp20x PMIC.
> +
> +Example:
> +
> +axp209: pmic at 34 {
> +	compatible = "x-powers,axp209";
> +	reg = <0x34>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {
> +		x-powers,dcdc-freq = <1500>;
> +
> +		vdd_cpu: dcdc2 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-name = "vdd-cpu";
> +		};
> +
> +		...
> +	};
> +
> +	ac-power-supply: ac-power-supply {
> +		compatible = "x-powers,axp202-ac-power-supply";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 675bb0f..54e23c6 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -97,6 +97,11 @@
>  		};
>  	};
>  
> +	ac_power_supply: ac_power_supply {
> +		compatible = "x-powers,axp202-ac-power-supply";
> +		status = "disabled";
> +	};
> +
>  	usb_power_supply: usb_power_supply {
>  		compatible = "x-powers,axp202-usb-power-supply";
>  		status = "disabled";
> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
> index 458b668..cdd5d4f 100644
> --- a/arch/arm/boot/dts/axp22x.dtsi
> +++ b/arch/arm/boot/dts/axp22x.dtsi
> @@ -148,6 +148,11 @@
>  		};
>  	};
>  
> +	ac_power_supply: ac_power_supply {
> +		compatible = "x-powers,axp221-ac-power-supply";
> +		status = "disabled";
> +	};
> +
>  	usb_power_supply: usb_power_supply {
>  		compatible = "x-powers,axp221-usb-power-supply";
>  		status = "disabled";
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index ba130be..450d1a0 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -162,6 +162,12 @@ static struct resource axp20x_ac_power_supply_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
>  };
>  
> +static struct resource axp22x_ac_power_supply_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
> +};
> +
>  static struct resource axp20x_pek_resources[] = {
>  	{
>  		.name	= "PEK_DBR",
> @@ -595,6 +601,11 @@ static struct mfd_cell axp22x_cells[] = {
>  	}, {
>  		.name			= "axp20x-regulator",
>  	}, {
> +		.name		= "axp20x-ac-power-supply",
> +		.of_compatible	= "x-powers,axp221-ac-power-supply",
> +		.num_resources	= ARRAY_SIZE(axp22x_ac_power_supply_resources),
> +		.resources	= axp22x_ac_power_supply_resources,
> +	}, {
>  		.name		= "axp20x-usb-power-supply",
>  		.of_compatible	= "x-powers,axp221-usb-power-supply",
>  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index e46b75d..295ec0f 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
>  
>  obj-$(CONFIG_PDA_POWER)		+= pda_power.o
>  obj-$(CONFIG_APM_POWER)		+= apm_power.o
> +obj-$(CONFIG_AXP20X_POWER)	+= axp20x_ac_power.o
>  obj-$(CONFIG_AXP20X_POWER)	+= axp20x_usb_power.o
>  obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
>  obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
> diff --git a/drivers/power/axp20x_ac_power.c b/drivers/power/axp20x_ac_power.c
> new file mode 100644
> index 0000000..13bb093
> --- /dev/null
> +++ b/drivers/power/axp20x_ac_power.c
> @@ -0,0 +1,219 @@
> +/*
> + * AXP20x PMIC AC power supply status driver
> + *
> + * Copyright (C) 2015 Hans de Goede <hdegoede@redhat.com>
> + * Copyright (C) 2014 Bruno Pr?mont <bonbons@linux-vserver.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under  the terms of the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/axp20x.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define DRVNAME "axp20x-ac-power-supply"
> +
> +#define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
> +#define AXP20X_PWR_STATUS_ACIN_USED	BIT(6)
> +#define AXP20X_ADC_EN1_ACIN_CURR	BIT(4)
> +#define AXP20X_ADC_EN1_ACIN_VOLT	BIT(5)
> +
> +struct axp20x_ac_power {
> +	struct device_node *np;
> +	struct regmap *regmap;
> +	struct power_supply *supply;
> +};
> +
> +static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
> +{
> +	struct axp20x_ac_power *power = devid;
> +
> +	power_supply_changed(power->supply);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int axp20x_ac_power_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
> +	unsigned int input;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret = axp20x_read_variable_width(power->regmap,
> +					 AXP20X_ACIN_V_ADC_H, 12);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret * 1700; /* 1 step = 1.7 mV */
> +		return 0;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret = axp20x_read_variable_width(power->regmap,
> +						 AXP20X_ACIN_I_ADC_H, 12);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret * 625; /* 1 step = 0.375 mA */
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	/* All the properties below need the input-status reg value */
> +	ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = !!(input & AXP20X_PWR_STATUS_ACIN_PRESENT);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = !!(input & AXP20X_PWR_STATUS_ACIN_USED);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property axp20x_ac_power_properties[] = {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static enum power_supply_property axp22x_ac_power_properties[] = {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static const struct power_supply_desc axp20x_ac_power_desc = {
> +	.name = "axp20x-ac",
> +	.type = POWER_SUPPLY_TYPE_MAINS,
> +	.properties = axp20x_ac_power_properties,
> +	.num_properties = ARRAY_SIZE(axp20x_ac_power_properties),
> +	.get_property = axp20x_ac_power_get_property,
> +};
> +
> +static const struct power_supply_desc axp22x_ac_power_desc = {
> +	.name = "axp20x-ac",
> +	.type = POWER_SUPPLY_TYPE_MAINS,
> +	.properties = axp22x_ac_power_properties,
> +	.num_properties = ARRAY_SIZE(axp22x_ac_power_properties),
> +	.get_property = axp20x_ac_power_get_property,
> +};
> +
> +static int axp20x_ac_power_probe(struct platform_device *pdev)
> +{
> +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg = {};
> +	struct axp20x_ac_power *power;
> +	static const char * const axp20x_irq_names[] = {
> +		"ACIN_PLUGIN", "ACIN_REMOVAL", NULL };
> +	static const char * const axp22x_irq_names[] = {
> +		"ACIN_PLUGIN", "ACIN_REMOVAL", NULL };
> +	static const char * const *irq_names;
> +	const struct power_supply_desc *ac_power_desc;
> +	int i, irq, ret;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	if (!axp20x) {
> +		dev_err(&pdev->dev, "Parent drvdata not set\n");
> +		return -EINVAL;
> +	}
> +
> +	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +	if (!power)
> +		return -ENOMEM;
> +
> +	power->np = pdev->dev.of_node;
> +	power->regmap = axp20x->regmap;
> +
> +	if (of_device_is_compatible(power->np,
> +			"x-powers,axp202-ac-power-supply")) {
> +
> +		/* Enable acin voltage and current measurement */
> +		ret = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> +			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT,
> +			AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOLT);
> +		if (ret)
> +			return ret;
> +
> +		ac_power_desc = &axp20x_ac_power_desc;
> +		irq_names = axp20x_irq_names;
> +	} else if (of_device_is_compatible(power->np,
> +			"x-powers,axp221-ac-power-supply")) {
> +		ac_power_desc = &axp22x_ac_power_desc;
> +		irq_names = axp22x_irq_names;
> +	} else {
> +		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> +			axp20x->variant);
> +		return -EINVAL;
> +	}
> +
> +	psy_cfg.of_node = pdev->dev.of_node;
> +	psy_cfg.drv_data = power;
> +
> +	power->supply = devm_power_supply_register(&pdev->dev, ac_power_desc,
> +						   &psy_cfg);
> +	if (IS_ERR(power->supply))
> +		return PTR_ERR(power->supply);
> +
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i = 0; irq_names[i]; i++) {
> +		irq = platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +		ret = devm_request_any_context_irq(&pdev->dev, irq,
> +				axp20x_ac_power_irq, 0, DRVNAME, power);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id axp20x_ac_power_match[] = {
> +	{ .compatible = "x-powers,axp202-ac-power-supply" },
> +	{ .compatible = "x-powers,axp221-ac-power-supply" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> +
> +static struct platform_driver axp20x_ac_power_driver = {
> +	.probe = axp20x_ac_power_probe,
> +	.driver = {
> +		.name = DRVNAME,
> +		.of_match_table = axp20x_ac_power_match,
> +	},
> +};
> +
> +module_platform_driver(axp20x_ac_power_driver);
> +
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("AXP20x PMIC AC power supply status driver");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
