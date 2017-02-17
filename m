From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Fri, 17 Feb 2017 22:54:56 +0100
Subject: [PATCH v3 3/4] leds: Add LED support for MT6323 PMIC
In-Reply-To: <1487311560-26684-4-git-send-email-sean.wang@mediatek.com>
References: <1487311560-26684-1-git-send-email-sean.wang@mediatek.com>
 <1487311560-26684-4-git-send-email-sean.wang@mediatek.com>
Message-ID: <e8b595f7-8b9d-96a9-8a91-6f4922672b5d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

Thanks for the updated patch. I have one more comment below.

On 02/17/2017 07:05 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MT6323 PMIC is a multi-function device that includes
> LED function. It allows attaching up to 4 LEDs which
> can either be on, off or dimmed and/or blinked with
> the controller.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/leds/Kconfig       |   8 +
>  drivers/leds/Makefile      |   1 +
>  drivers/leds/leds-mt6323.c | 470 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 479 insertions(+)
>  create mode 100644 drivers/leds/leds-mt6323.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index c621cbb..30095fc 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -117,6 +117,14 @@ config LEDS_MIKROTIK_RB532
>  	  This option enables support for the so called "User LED" of
>  	  Mikrotik's Routerboard 532.
>  
> +config LEDS_MT6323
> +	tristate "LED Support for Mediatek MT6323 PMIC"
> +	depends on LEDS_CLASS
> +	depends on MFD_MT6397
> +	help
> +	  This option enables support for on-chip LED drivers found on
> +	  Mediatek MT6323 PMIC.
> +
>  config LEDS_S3C24XX
>  	tristate "LED Support for Samsung S3C24XX GPIO LEDs"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 6b82737..4feb332 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_LEDS_IS31FL32XX)		+= leds-is31fl32xx.o
>  obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
>  obj-$(CONFIG_LEDS_MLXCPLD)		+= leds-mlxcpld.o
>  obj-$(CONFIG_LEDS_NIC78BX)		+= leds-nic78bx.o
> +obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
>  
>  # LED SPI Drivers
>  obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
> diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
> new file mode 100644
> index 0000000..f431b1d
> --- /dev/null
> +++ b/drivers/leds/leds-mt6323.c
> @@ -0,0 +1,470 @@
> +/*
> + * LED driver for Mediatek MT6323 PMIC
> + *
> + * Copyright (C) 2017 Sean Wang <sean.wang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/mt6323/registers.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * Register field for MT6323_TOP_CKPDN0 to enable
> + * 32K clock common for LED device.
> + */
> +#define MT6323_RG_DRV_32K_CK_PDN	BIT(11)
> +#define MT6323_RG_DRV_32K_CK_PDN_MASK	BIT(11)
> +
> +/*
> + * Register field for MT6323_TOP_CKPDN2 to enable
> + * individual clock for LED device.
> + */
> +#define MT6323_RG_ISINK_CK_PDN(i)	BIT(i)
> +#define MT6323_RG_ISINK_CK_PDN_MASK(i)	BIT(i)
> +
> +/*
> + * Register field for MT6323_TOP_CKCON1 to select
> + * clock source.
> + */
> +#define MT6323_RG_ISINK_CK_SEL_MASK(i)	(BIT(10) << (i))
> +
> +/*
> + * Register for MT6323_ISINK_CON0 to setup the
> + * duty cycle of the blink.
> + */
> +#define MT6323_ISINK_CON0(i)		(MT6323_ISINK0_CON0 + 0x8 * (i))
> +#define MT6323_ISINK_DIM_DUTY_MASK	(0x1f << 8)
> +#define MT6323_ISINK_DIM_DUTY(i)	(((i) << 8) & \
> +					MT6323_ISINK_DIM_DUTY_MASK)
> +
> +/* Register to setup the period of the blink. */
> +#define MT6323_ISINK_CON1(i)		(MT6323_ISINK0_CON1 + 0x8 * (i))
> +#define MT6323_ISINK_DIM_FSEL_MASK	(0xffff)
> +#define MT6323_ISINK_DIM_FSEL(i)	((i) & MT6323_ISINK_DIM_FSEL_MASK)
> +
> +/* Register to control the brightness. */
> +#define MT6323_ISINK_CON2(i)		(MT6323_ISINK0_CON2 + 0x8 * (i))
> +#define MT6323_ISINK_CH_STEP_SHIFT	12
> +#define MT6323_ISINK_CH_STEP_MASK	(0x7 << 12)
> +#define MT6323_ISINK_CH_STEP(i)		(((i) << 12) & \
> +					MT6323_ISINK_CH_STEP_MASK)
> +#define MT6323_ISINK_SFSTR0_TC_MASK	(0x3 << 1)
> +#define MT6323_ISINK_SFSTR0_TC(i)	(((i) << 1) & \
> +					MT6323_ISINK_SFSTR0_TC_MASK)
> +#define MT6323_ISINK_SFSTR0_EN_MASK	BIT(0)
> +#define MT6323_ISINK_SFSTR0_EN		BIT(0)
> +
> +/* Register to LED channel enablement. */
> +#define MT6323_ISINK_CH_EN_MASK(i)	BIT(i)
> +#define MT6323_ISINK_CH_EN(i)		BIT(i)
> +
> +#define MT6323_MAX_PERIOD		      10000
> +#define MT6323_MAX_LEDS			  4
> +#define MT6323_MAX_BRIGHTNESS		  6
> +#define MT6323_UNIT_DUTY		       3125
> +
> +struct mt6323_leds;
> +
> +/**
> + * struct mt6323_led - state container for the LED device
> + * @id:			the identifier in MT6323 LED device
> + * @parent:		the pointer to MT6323 LED controller
> + * @cdev:		LED class device for this LED device
> + * @current_brightness: current state of the LED device
> + */
> +struct mt6323_led {
> +	int			id;
> +	struct mt6323_leds	*parent;
> +	struct led_classdev	cdev;
> +	u8			current_brightness;
> +};
> +
> +/**
> + * struct mt6323_leds -	state container for holding LED controller
> + *			of the driver
> + * @dev:		the device pointer
> + * @hw:			the underlying hardware providing shared
> + *			bus for the register operations
> + * @led_num:		how much the LED device the controller could control
> + * @lock:		the lock among process context
> + * @led:		the array that contains the state of individual
> + *			LED device
> + */
> +struct mt6323_leds {
> +	struct device		*dev;
> +	struct mt6397_chip	*hw;
> +	u8			led_num;
> +	/* protect among process context */
> +	struct mutex		lock;
> +	struct mt6323_led	led[MT6323_MAX_LEDS];
> +};
> +
> +static int mt6323_led_hw_off(struct led_classdev *cdev)
> +{
> +	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
> +	struct mt6323_leds *leds = led->parent;
> +	struct regmap *regmap = leds->hw->regmap;
> +	unsigned int status;
> +	int ret;
> +
> +	status = MT6323_ISINK_CH_EN(led->id);
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_EN_CTRL,
> +				 MT6323_ISINK_CH_EN_MASK(led->id), ~status);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(100, 300);
> +	ret = regmap_update_bits(regmap, MT6323_TOP_CKPDN2,
> +				 MT6323_RG_ISINK_CK_PDN_MASK(led->id),
> +				 MT6323_RG_ISINK_CK_PDN(led->id));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mt6323_get_led_hw_brightness(struct led_classdev *cdev)
> +{
> +	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
> +	struct mt6323_leds *leds = led->parent;
> +	struct regmap *regmap = leds->hw->regmap;
> +	unsigned int status;
> +	int ret;
> +
> +	ret = regmap_read(regmap, MT6323_TOP_CKPDN2, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (status & MT6323_RG_ISINK_CK_PDN_MASK(led->id))
> +		return 0;
> +
> +	ret = regmap_read(regmap, MT6323_ISINK_EN_CTRL, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(status & MT6323_ISINK_CH_EN(led->id)))
> +		return 0;
> +
> +	ret = regmap_read(regmap, MT6323_ISINK_CON2(led->id), &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	return  ((status & MT6323_ISINK_CH_STEP_MASK)
> +		  >> MT6323_ISINK_CH_STEP_SHIFT) + 1;
> +}
> +
> +static int mt6323_led_hw_on(struct led_classdev *cdev)
> +{
> +	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
> +	struct mt6323_leds *leds = led->parent;
> +	struct regmap *regmap = leds->hw->regmap;
> +	unsigned int status;
> +	int ret;
> +
> +	/*
> +	 * Setup required clock source, enable the corresponding
> +	 * clock and channel and let work with continuous blink as
> +	 * the default.
> +	 */
> +	ret = regmap_update_bits(regmap, MT6323_TOP_CKCON1,
> +				 MT6323_RG_ISINK_CK_SEL_MASK(led->id), 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	status = MT6323_RG_ISINK_CK_PDN(led->id);
> +	ret = regmap_update_bits(regmap, MT6323_TOP_CKPDN2,
> +				 MT6323_RG_ISINK_CK_PDN_MASK(led->id),
> +				 ~status);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(100, 300);
> +
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_EN_CTRL,
> +				 MT6323_ISINK_CH_EN_MASK(led->id),
> +				 MT6323_ISINK_CH_EN(led->id));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_CON2(led->id),
> +				 MT6323_ISINK_CH_STEP_MASK,
> +				 MT6323_ISINK_CH_STEP(1));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_CON0(led->id),
> +				 MT6323_ISINK_DIM_DUTY_MASK,
> +				 MT6323_ISINK_DIM_DUTY(31));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_CON1(led->id),
> +				 MT6323_ISINK_DIM_FSEL_MASK,
> +				 MT6323_ISINK_DIM_FSEL(1000));
> +	if (ret < 0)
> +		return ret;
> +
> +	led->current_brightness = 1;
> +
> +	return 0;
> +}
> +
> +static int mt6323_led_set_blink(struct led_classdev *cdev,
> +				unsigned long *delay_on,
> +				unsigned long *delay_off)
> +{
> +	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
> +	struct mt6323_leds *leds = led->parent;
> +	struct regmap *regmap = leds->hw->regmap;
> +	u16 period;
> +	u8 duty_cycle, duty_hw;
> +	int ret;
> +
> +	/*
> +	 * Units are in ms, if over the hardware able
> +	 * to support, fallback into software blink.
> +	 */
> +	if (*delay_on + *delay_off > MT6323_MAX_PERIOD)
> +		return -EINVAL;
> +
> +	/*
> +	 * LED subsystem requires a default user
> +	 * friendly blink pattern for the LED so using
> +	 * 1Hz duty cycle 50% here if without specific
> +	 * value delay_on and delay off being assigned.
> +	 */
> +	if (*delay_on == 0 && *delay_off == 0) {
> +		*delay_on = 500;
> +		*delay_off = 500;
> +	}
> +
> +	period = *delay_on + *delay_off;
> +
> +	/*
> +	 * duty_cycle is the percentage of period during
> +	 * which the led is ON.
> +	 */
> +	duty_cycle = 100 * (*delay_on) / period;
> +
> +	mutex_lock(&leds->lock);
> +
> +	if (!led->current_brightness) {
> +		ret = mt6323_led_hw_on(cdev);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	duty_hw = DIV_ROUND_CLOSEST(duty_cycle * 1000, MT6323_UNIT_DUTY);
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_CON0(led->id),
> +				 MT6323_ISINK_DIM_DUTY_MASK,
> +				 MT6323_ISINK_DIM_DUTY(duty_hw));
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = regmap_update_bits(regmap, MT6323_ISINK_CON1(led->id),
> +				 MT6323_ISINK_DIM_FSEL_MASK,
> +				 MT6323_ISINK_DIM_FSEL(period - 1));
> +out:
> +	mutex_unlock(&leds->lock);
> +
> +	return ret;
> +}
> +
> +static int mt6323_led_set_brightness(struct led_classdev *cdev,
> +				     enum led_brightness brightness)
> +{
> +	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
> +	struct mt6323_leds *leds = led->parent;
> +	struct regmap *regmap = leds->hw->regmap;
> +	int ret;
> +
> +	mutex_lock(&leds->lock);
> +
> +	if (!led->current_brightness && brightness) {
> +		ret = mt6323_led_hw_on(cdev);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	if (brightness) {
> +		/*
> +		 * Setup current output for the corresponding
> +		 * brightness level.
> +		 */
> +		ret = regmap_update_bits(regmap, MT6323_ISINK_CON2(led->id),
> +					 MT6323_ISINK_CH_STEP_MASK,
> +					 MT6323_ISINK_CH_STEP(brightness - 1));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = regmap_update_bits(regmap, MT6323_ISINK_CON2(led->id),
> +					 MT6323_ISINK_SFSTR0_TC_MASK |
> +					 MT6323_ISINK_SFSTR0_EN_MASK,
> +					 MT6323_ISINK_SFSTR0_TC(2) |
> +					 MT6323_ISINK_SFSTR0_EN);
> +		if (ret < 0)
> +			goto out;
> +	} else {
> +		ret = mt6323_led_hw_off(cdev);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	led->current_brightness = brightness;
> +out:
> +	mutex_unlock(&leds->lock);
> +
> +	return ret;
> +}
> +
> +static int mt6323_led_set_dt_default(struct led_classdev *cdev,
> +				     struct device_node *np)
> +{
> +	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
> +	const char *state;
> +	int ret;
> +
> +	led->cdev.name = of_get_property(np, "label", NULL) ? : np->name;
> +	led->cdev.default_trigger = of_get_property(np,
> +						    "linux,default-trigger",
> +						    NULL);
> +
> +	state = of_get_property(np, "default-state", NULL);
> +	if (state) {
> +		if (!strcmp(state, "keep")) {
> +			ret = mt6323_get_led_hw_brightness(cdev);
> +			if (ret < 0)
> +				return ret;
> +			led->current_brightness = ret;
> +		} else if (!strcmp(state, "on")) {
> +			mt6323_led_set_brightness(cdev, 1);
> +		} else  {
> +			mt6323_led_set_brightness(cdev, 0);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt6323_led_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *child;
> +	struct mt6397_chip *hw = dev_get_drvdata(pdev->dev.parent);
> +	struct mt6323_leds *leds;
> +	int ret, i = 0, count;
> +	unsigned int status;
> +
> +	count = of_get_child_count(np);
> +	if (!count)
> +		return -ENODEV;
> +
> +	count = (count <= MT6323_MAX_LEDS) ? count : MT6323_MAX_LEDS;
> +
> +	leds = devm_kzalloc(dev, sizeof(struct mt6323_leds) +
> +			    sizeof(struct mt6323_led) * count,
> +			    GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, leds);
> +	leds->dev = dev;
> +
> +	/*
> +	 * leds->hw points to the underlying bus for the register
> +	 * controlled.
> +	 */
> +	leds->hw = hw;
> +	mutex_init(&leds->lock);
> +	leds->led_num = count;
> +
> +	status = MT6323_RG_DRV_32K_CK_PDN;
> +	ret = regmap_update_bits(leds->hw->regmap, MT6323_TOP_CKPDN0,
> +				 MT6323_RG_DRV_32K_CK_PDN_MASK, ~status);
> +	if (ret < 0) {
> +		dev_err(leds->dev,
> +			"Failed to update MT6323_TOP_CKPDN0 Register\n");
> +		return ret;
> +	}
> +
> +	for_each_available_child_of_node(np, child) {

You're limiting the count of LEDs above, but here you're parsing all
available child nodes, which can result in accessing unallocated memory.

> +		leds->led[i].cdev.max_brightness = MT6323_MAX_BRIGHTNESS;
> +		leds->led[i].cdev.brightness_set_blocking =
> +					mt6323_led_set_brightness;
> +		leds->led[i].cdev.blink_set = mt6323_led_set_blink;
> +		leds->led[i].id = i;
> +		leds->led[i].parent = leds;
> +
> +		ret = mt6323_led_set_dt_default(&leds->led[i].cdev, child);
> +		if (ret < 0) {
> +			dev_err(leds->dev,
> +				"Failed to LED set default from devicetree\n");
> +			return ret;
> +		}
> +
> +		ret = devm_led_classdev_register(dev, &leds->led[i].cdev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register LED: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		leds->led[i].cdev.dev->of_node = child;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mt6323_led_remove(struct platform_device *pdev)
> +{
> +	struct mt6323_leds *leds = platform_get_drvdata(pdev);
> +	int i;
> +
> +	/* Turn the LEDs off on driver removal. */
> +	for (i = 0 ; i < leds->led_num ; i++)
> +		mt6323_led_hw_off(&leds->led[i].cdev);
> +
> +	regmap_update_bits(leds->hw->regmap, MT6323_TOP_CKPDN0,
> +			   MT6323_RG_DRV_32K_CK_PDN_MASK,
> +			   MT6323_RG_DRV_32K_CK_PDN);
> +
> +	mutex_destroy(&leds->lock);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt6323_led_dt_match[] = {
> +	{ .compatible = "mediatek,mt6323-led" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_led_dt_match);
> +
> +static struct platform_driver mt6323_led_driver = {
> +	.probe		= mt6323_led_probe,
> +	.remove		= mt6323_led_remove,
> +	.driver		= {
> +		.name	= "mt6323-led",
> +		.of_match_table = mt6323_led_dt_match,
> +	},
> +};
> +
> +module_platform_driver(mt6323_led_driver);
> +
> +MODULE_DESCRIPTION("LED driver for Mediatek MT6323 PMIC");
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_LICENSE("GPL");
> 

-- 
Best regards,
Jacek Anaszewski
