From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Sat, 27 Jun 2015 22:25:05 +0200
Subject: [PATCH v3 4/4] power: Add an axp20x-usb-power driver
In-Reply-To: <558E3488.9070501@samsung.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-4-git-send-email-hdegoede@redhat.com>
 <558E3488.9070501@samsung.com>
Message-ID: <20150627222505.1a312c78@uranus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Jun 2015 14:28:40 Krzysztof Kozlowski wrote:
> W dniu 26.06.2015 o 19:59, Hans de Goede pisze:
> > This adds a driver for the usb power_supply bits of the axp20x PMICs.
> > 
> > I initially started writing my own driver, before coming aware of
> > Bruno Pr?mont's excellent earlier RFC with a driver for this.
> > 
> > My driver was lacking CURRENT_MAX and VOLTAGE_MIN support Bruno's
> > drvier has, so I've copied the code for those from his driver.
> > 
> > Note that the AC-power-supply and battery charger bits will need separate
> > drivers. Each one needs its own devictree child-node so that other
> > devicetree nodes can reference the right power-supply, and thus each one
> > will get its own mfd-cell / platform_device and platform-driver.
> > 
> > Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Bruno Pr?mont <bonbons@linux-vserver.org>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v2:
> > -Split out the dt-bindings documentation into a separate patch
> > -Renamed axp20x_read_16bit to axp20x_read_variable_width
> > -Use better local variable names inside axp20x_read_variable_width
> > Changes in v3:
> > -Add Bruno's S-o-b
> 
> Hi,
> 
> Two minor comments below, the driver itself looks good.
> 
> 
> > ---
> >  drivers/power/Kconfig            |   7 ++
> >  drivers/power/Makefile           |   1 +
> >  drivers/power/axp20x_usb_power.c | 243 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h       |  24 ++++
> >  4 files changed, 275 insertions(+)
> >  create mode 100644 drivers/power/axp20x_usb_power.c
> > 
> > diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> > index 4091fb0..1fee60c 100644
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -439,6 +439,13 @@ config BATTERY_RT5033
> >  	  The fuelgauge calculates and determines the battery state of charge
> >  	  according to battery open circuit voltage.
> >  
> > +config AXP20X_POWER
> > +	tristate "AXP20x power supply driver"
> > +	depends on MFD_AXP20X
> > +	help
> > +	  This driver provides support for the power supply features of
> > +	  AXP20x PMIC.
> > +
> >  source "drivers/power/reset/Kconfig"
> >  
> >  endif # POWER_SUPPLY
> > diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> > index b7b0181..ae0f27d 100644
> > --- a/drivers/power/Makefile
> > +++ b/drivers/power/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
> >  
> >  obj-$(CONFIG_PDA_POWER)		+= pda_power.o
> >  obj-$(CONFIG_APM_POWER)		+= apm_power.o
> > +obj-$(CONFIG_AXP20X_POWER)	+= axp20x_usb_power.o
> >  obj-$(CONFIG_MAX8925_POWER)	+= max8925_power.o
> >  obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
> >  obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
> > diff --git a/drivers/power/axp20x_usb_power.c b/drivers/power/axp20x_usb_power.c
> > new file mode 100644
> > index 0000000..09f388e
> > --- /dev/null
> > +++ b/drivers/power/axp20x_usb_power.c
> > @@ -0,0 +1,243 @@
> > +/*
> > + * AXP20x PMIC USB power supply status driver
> > + *
> > + * Copyright (C) 2015 Hans de Goede <hdegoede@redhat.com>
> > + * Copyright (C) 2014 Bruno Pr?mont <bonbons@linux-vserver.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under  the terms of the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/axp20x.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define DRVNAME "axp20x-usb-power-supply"
> > +
> > +#define AXP20X_PWR_STATUS_VBUS_PRESENT	BIT(5)
> > +#define AXP20X_PWR_STATUS_VBUS_USED	BIT(4)
> > +
> > +#define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
> > +
> > +#define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
> > +#define AXP20X_VBUS_CLIMIT_MASK		3
> > +#define AXP20X_VBUC_CLIMIT_900mA	0
> > +#define AXP20X_VBUC_CLIMIT_500mA	1
> > +#define AXP20X_VBUC_CLIMIT_100mA	2
> > +#define AXP20X_VBUC_CLIMIT_NONE		3
> > +
> > +#define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
> > +#define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
> > +
> > +#define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
> > +
> > +struct axp20x_usb_power {
> > +	struct regmap *regmap;
> > +	struct power_supply *supply;
> > +};
> > +
> > +static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
> > +{
> > +	struct axp20x_usb_power *power = devid;
> > +
> > +	power_supply_changed(power->supply);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int axp20x_usb_power_get_property(struct power_supply *psy,
> > +	enum power_supply_property psp, union power_supply_propval *val)
> > +{
> > +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> > +	unsigned int input, v;
> > +	int r;
> 
> Here and in probe function - it is strictly personal but I don't like
> the 'r' variable. I got used to 'err' or 'ret' which are more
> descriptive to me. 'r' may look like 'resource' for example.

'ret' might work but doesn't it imply return value for this function
instead of return value from a called function?

> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > +		r = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
> > +		if (r)
> > +			return r;
> > +
> > +		val->intval = AXP20X_VBUS_VHOLD_uV(v);
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +		r = axp20x_read_variable_width(power->regmap,
> > +					       AXP20X_VBUS_V_ADC_H, 12);
> > +		if (r < 0)
> > +			return r;
> > +
> > +		val->intval = r * 1700; /* 1 step = 1.7 mV */
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +		r = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
> > +		if (r)
> > +			return r;
> > +
> > +		switch (v & AXP20X_VBUS_CLIMIT_MASK) {
> > +		case AXP20X_VBUC_CLIMIT_100mA:
> > +			val->intval = 100000;
> > +			break;
> > +		case AXP20X_VBUC_CLIMIT_500mA:
> > +			val->intval = 500000;
> > +			break;
> > +		case AXP20X_VBUC_CLIMIT_900mA:
> > +			val->intval = 900000;
> > +			break;
> > +		case AXP20X_VBUC_CLIMIT_NONE:
> > +			val->intval = -1;
> > +			break;
> > +		}
> > +		return 0;
> > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +		r = axp20x_read_variable_width(power->regmap,
> > +					       AXP20X_VBUS_I_ADC_H, 12);
> > +		if (r < 0)
> > +			return r;
> > +
> > +		val->intval = r * 375; /* 1 step = 0.375 mA */
> > +		return 0;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	/* All the properties below need the input-status reg value */
> > +	r = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
> > +	if (r)
> > +		return r;
> > +
> > +	switch (psp) {
> > +	case POWER_SUPPLY_PROP_HEALTH:
> > +		if (!(input & AXP20X_PWR_STATUS_VBUS_PRESENT)) {
> > +			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
> > +			break;
> > +		}
> > +
> > +		r = regmap_read(power->regmap, AXP20X_USB_OTG_STATUS, &v);
> > +		if (r)
> > +			return r;
> > +
> > +		if (!(v & AXP20X_USB_STATUS_VBUS_VALID)) {
> > +			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> > +			break;
> > +		}
> > +
> > +		val->intval = POWER_SUPPLY_HEALTH_GOOD;
> > +		break;
> > +	case POWER_SUPPLY_PROP_PRESENT:
> > +		val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
> > +		break;
> > +	case POWER_SUPPLY_PROP_ONLINE:
> > +		val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_USED);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static enum power_supply_property axp20x_usb_power_properties[] = {
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_MAX,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +};
> > +
> > +static const struct power_supply_desc axp20x_usb_power_desc = {
> > +	.name = "axp20x-usb",
> > +	.type = POWER_SUPPLY_TYPE_USB,
> > +	.properties = axp20x_usb_power_properties,
> > +	.num_properties = ARRAY_SIZE(axp20x_usb_power_properties),
> > +	.get_property = axp20x_usb_power_get_property,
> > +};
> > +
> > +static int axp20x_usb_power_probe(struct platform_device *pdev)
> > +{
> > +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> > +	struct power_supply_config psy_cfg = {};
> > +	struct axp20x_usb_power *power;
> > +	static const char * const irq_names[] = { "VBUS_PLUGIN",
> > +		"VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID" };
> > +	int i, irq, r;
> > +
> > +	if (!of_device_is_available(pdev->dev.of_node))
> > +		return -ENODEV;
> > +
> > +	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> > +	if (!power)
> > +		return -ENOMEM;
> > +
> > +	power->regmap = axp20x->regmap;
> > +
> > +	/* Enable vbus valid checking */
> > +	r = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
> > +		    AXP20X_VBUS_MON_VBUS_VALID, AXP20X_VBUS_MON_VBUS_VALID);
> > +	if (r)
> > +		return r;
> > +
> > +	/* Enable vbus voltage and current measurement */
> > +	r = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> > +			AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT,
> > +			AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT);
> > +	if (r)
> > +		return r;
> > +
> > +	psy_cfg.of_node = pdev->dev.of_node;
> > +	psy_cfg.drv_data = power;
> > +
> > +	power->supply = devm_power_supply_register(&pdev->dev,
> > +					&axp20x_usb_power_desc, &psy_cfg);
> > +	if (IS_ERR(power->supply))
> > +		return PTR_ERR(power->supply);
> > +
> > +	/* Request irqs after registering, as irqs may trigger immediately */
> > +	for (i = 0; i < ARRAY_SIZE(irq_names); i++) {
> > +		irq = platform_get_irq_byname(pdev, irq_names[i]);
> > +		if (irq < 0) {
> > +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> > +				 irq_names[i], irq);
> > +			continue;
> > +		}
> > +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> > +		r = devm_request_any_context_irq(&pdev->dev, irq,
> > +				axp20x_usb_power_irq, 0, DRVNAME, power);
> > +		if (r < 0)
> > +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> > +				 irq_names[i], r);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id axp20x_usb_power_match[] = {
> > +	{ .compatible = "x-powers,axp202-usb-power-supply" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
> > +
> > +static struct platform_driver axp20x_usb_power_driver = {
> > +	.probe = axp20x_usb_power_probe,
> > +	.driver = {
> > +		.name = DRVNAME,
> > +		.of_match_table = axp20x_usb_power_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(axp20x_usb_power_driver);
> > +
> > +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> > +MODULE_DESCRIPTION("AXP20x PMIC USB power supply status driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > index 6d8b39a..8ec996e 100644
> > --- a/include/linux/mfd/axp20x.h
> > +++ b/include/linux/mfd/axp20x.h
> > @@ -11,6 +11,8 @@
> >  #ifndef __LINUX_MFD_AXP20X_H
> >  #define __LINUX_MFD_AXP20X_H
> >  
> > +#include <linux/regmap.h>
> > +
> >  enum {
> >  	AXP202_ID = 0,
> >  	AXP209_ID,
> > @@ -372,4 +374,26 @@ struct axp288_extcon_pdata {
> >  	struct gpio_desc *gpio_mux_cntl;
> >  };
> >  
> > +/* generic helper function for reading 9-16 bit wide regs */
> > +static inline int axp20x_read_variable_width(struct regmap *regmap,
> > +	unsigned int reg, unsigned int width)
> > +{
> > +	unsigned int reg_val, result;
> > +	int err;
> > +
> > +	err = regmap_read(regmap, reg, &reg_val);
> > +	if (err)
> > +		return err;
> > +
> > +	result = reg_val << (width - 8);
> > +
> > +	err = regmap_read(regmap, reg + 1, &reg_val);
> > +	if (err)
> > +		return err;
> > +
> > +	result |= reg_val;
> > +
> > +	return result;
> > +}
> > +
> >  #endif /* __LINUX_MFD_AXP20X_H */
> 
> Is this static inline function used outside of
> drivers/power/axp20x_usb_power.c? Looks like it isn't, but maybe you
> have a plan for it? If not, then it shouldn't be in header file.

See comments for first iteration of this patch:
| | This is only used twice and only in one file.
| |
| | Do you know of any other uses of this call that will be upstreamed
| | shortly?  
| 
| Yes I plan to write drivers for the other 3 power_supply class
| cells (ac-power, battery-charger, rtc-bat-charger) in the axp209,
| and most of those need the same helper which I why I put it here.  

> Best regards,
> Krzysztof

Best regards,
Bruno
