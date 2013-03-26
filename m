From: Milo.Kim@ti.com (Kim, Milo)
Date: Tue, 26 Mar 2013 02:55:00 +0000
Subject: [PATCH v10 09/12] leds: Add support for Palmas LEDs
In-Reply-To: <1363964122-19201-10-git-send-email-ian@slimlogic.co.uk>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
 <1363964122-19201-10-git-send-email-ian@slimlogic.co.uk>
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E495A6@DQHE02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

> The Palmas familly of chips has LED support. This is not always muxed
> to output pins so depending on the setting of the mux this driver
> will create the appropriate LED class devices.
> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>

Please see my comments below.

> ---
>  drivers/leds/Kconfig       |    9 +
>  drivers/leds/Makefile      |    1 +
>  drivers/leds/leds-palmas.c |  561
> ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/palmas.h |   80 +++++++
>  4 files changed, 651 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/leds/leds-palmas.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index d44806d..249027e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -479,6 +479,15 @@ config LEDS_BLINKM
>  	  This option enables support for the BlinkM RGB LED connected
>  	  through I2C. Say Y to enable support for the BlinkM LED.
> 
> +config LEDS_PALMAS
> +	bool "LED support for the Palmas family of PMICs"
> +	depends on LEDS_CLASS
> +	depends on MFD_PALMAS
> +	help
> +	  This option enables the driver for LED1 & LED2 pins on Palmas
> PMIC
> +	  if these pins are enabled in the mux configuration. The driver
> support
> +	  ON/OFF and blinking with hardware control.
> +

LEDS_CLASS can be built as module, but LEDS_PALAMS is boolean type.
Undefined LED functions symbol errors can happen.
Therefore, dependency should be LED_CLASS=y.

>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
> 
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index ac28977..3acb116 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_RENESAS_TPU)		+= leds-
> renesas-tpu.o
>  obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>  obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
>  obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
> +obj-$(CONFIG_LEDS_PALMAS)		+= leds-palmas.o
> 
>  # LED SPI Drivers
>  obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
> diff --git a/drivers/leds/leds-palmas.c b/drivers/leds/leds-palmas.c
> new file mode 100644
> index 0000000..e9da4d1
> --- /dev/null
> +++ b/drivers/leds/leds-palmas.c
> @@ -0,0 +1,561 @@
> +/*
> + * Driver for LED part of Palmas PMIC Chips
> + *
> + * Copyright 2011-2013 Texas Instruments Inc.
> + *
> + * Author: Graeme Gregory <gg@slimlogic.co.uk>
> + * Author: Ian Lartey <ian@slimlogic.co.uk>
> + *
> + *  This program is free software; you can redistribute it and/or
> modify it
> + *  under  the terms of the GNU General  Public License as published
> by the
> + *  Free Software Foundation;  either version 2 of the License, or (at
> your
> + *  option) any later version.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/palmas.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct palmas_leds_data;
> +
> +enum palmas_led_on_time {
> +	LED_ON_62_5MS = 0x00,
> +	LED_ON_125MS = 0x01,
> +	LED_ON_250MS = 0x02,
> +	LED_ON_500MS = 0x03,
> +};
> +
> +enum palmas_led_period {
> +	LED_PERIOD_OFF = 0x00,
> +	LED_PERIOD_125MS = 0x01,
> +	LED_PERIOD_250MS = 0x02,
> +	LED_PERIOD_500MS = 0x03,
> +	LED_PERIOD_1000MS = 0x04,
> +	LED_PERIOD_2000MS = 0x05,
> +	LED_PERIOD_4000MS = 0x06,
> +	LED_PERIOD_8000MS = 0x07,
> +};
> +
> +struct palmas_led {
> +	struct led_classdev cdev;
> +	struct palmas_leds_data *leds_data;
> +	int led_no;
> +	struct work_struct work;
> +	struct mutex mutex;
> +
> +	spinlock_t value_lock;
> +
> +	int blink;
> +	enum palmas_led_on_time on_time;
> +	enum palmas_led_period period;
> +	enum led_brightness brightness;
> +};
> +
> +struct palmas_leds_data {
> +	struct device *dev;
> +	struct led_classdev cdev;
> +	struct palmas *palmas;
> +
> +	struct palmas_led *palmas_led;
> +	int no_leds;
> +};
> +
> +#define to_palmas_led(led_cdev) \
> +	container_of(led_cdev, struct palmas_led, cdev)
> +
> +static char *palmas_led_names[] = {
> +	"palmas:led1",
> +	"palmas:led2",
> +	"palmas:led3",
> +	"palmas:led4",
> +};
> +
> +struct palmas_led_info {
> +	int mask;
> +	int shift;
> +};
> +
> +struct palmas_led_info led_period_info[] = {
> +	{
> +		PALMAS_LED_PERIOD_CTRL_LED_1_PERIOD_MASK,
> +		PALMAS_LED_PERIOD_CTRL_LED_1_PERIOD_SHIFT,
> +	},
> +	{
> +		PALMAS_LED_PERIOD_CTRL_LED_2_PERIOD_MASK,
> +		PALMAS_LED_PERIOD_CTRL_LED_2_PERIOD_SHIFT,
> +	},
> +	{
> +		PALMAS_LED_PERIOD2_CTRL_LED_3_PERIOD_MASK,
> +		PALMAS_LED_PERIOD2_CTRL_LED_3_PERIOD_SHIFT,
> +	},
> +	{
> +		PALMAS_LED_PERIOD2_CTRL_CHRG_LED_PERIOD_MASK,
> +		PALMAS_LED_PERIOD2_CTRL_CHRG_LED_PERIOD_SHIFT,
> +	},
> +};
> +
> +struct palmas_led_info led_time_info[] = {
> +	{
> +		PALMAS_LED_CTRL_LED_1_ON_TIME_MASK,
> +		PALMAS_LED_CTRL_LED_1_ON_TIME_SHIFT,
> +	},
> +	{
> +		PALMAS_LED_CTRL_LED_2_ON_TIME_MASK,
> +		PALMAS_LED_CTRL_LED_2_ON_TIME_SHIFT,
> +	},
> +	{
> +		PALMAS_LED_CTRL2_LED_3_ON_TIME_MASK,
> +		PALMAS_LED_CTRL2_LED_3_ON_TIME_SHIFT,
> +	},
> +	{
> +		PALMAS_LED_CTRL2_CHRG_LED_ON_TIME_MASK,
> +		PALMAS_LED_CTRL2_CHRG_LED_ON_TIME_SHIFT,
> +	},
> +};
> +
> +static int palmas_led_read(struct palmas_leds_data *leds, unsigned int
> reg,
> +		unsigned int *dest)
> +{
> +	return palmas_read(leds->palmas, PALMAS_LED_BASE, reg, dest);
> +}
> +
> +static int palmas_led_write(struct palmas_leds_data *leds, unsigned
> int reg,
> +		unsigned int value)
> +{
> +	return palmas_write(leds->palmas, PALMAS_LED_BASE, reg, value);
> +}
> +
> +static int palmas_led_update_bits(struct palmas_leds_data *leds,
> +		unsigned int reg, unsigned int mask, unsigned int value)
> +{
> +	return palmas_update_bits(leds->palmas, PALMAS_LED_BASE,
> +			reg, mask, value);
> +}
> +
> +static void palmas_get_crtl_and_period(struct palmas_led *led,

It looks typo, _crtl_ -> _ctrl_.

> +static int palmas_leds_probe(struct platform_device *pdev)
> +{
> +	struct palmas *palmas = dev_get_drvdata(pdev->dev.parent);
> +	struct palmas_leds_platform_data *pdata = pdev->dev.platform_data;
> +	struct palmas_leds_data *leds_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int ret, i;
> +	int offset = 0;
> +
> +	if (!palmas->led_muxed && !is_palmas_charger(palmas->product_id))
> {
> +		dev_err(&pdev->dev, "there are no LEDs muxed\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Palmas charger requires platform data */
> +	if (is_palmas_charger(palmas->product_id) && node && !pdata) {
> +
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		ret = palmas_dt_to_pdata(&pdev->dev, node, pdata);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (is_palmas_charger(palmas->product_id) && !pdata)
> +		return -EINVAL;
> +
> +	leds_data = devm_kzalloc(&pdev->dev, sizeof(*leds_data),
> GFP_KERNEL);
> +	if (!leds_data)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, leds_data);
> +
> +	leds_data->palmas = palmas;
> +
> +	switch (palmas->led_muxed) {
> +	case PALMAS_LED1_MUXED | PALMAS_LED2_MUXED:
> +		leds_data->no_leds = 2;
> +		break;
> +	case PALMAS_LED1_MUXED:
> +	case PALMAS_LED2_MUXED:
> +		leds_data->no_leds = 1;
> +		break;
> +	default:
> +		leds_data->no_leds = 0;
> +		break;
> +	}
> +
> +	if (is_palmas_charger(palmas->product_id)) {
> +		if (pdata->chrg_led_mode)
> +			leds_data->no_leds += 2;
> +		else
> +			leds_data->no_leds++;
> +	}
> +
> +	if (leds_data->no_leds == 0)
> +		leds_data->palmas_led = NULL;
> +	else
> +		leds_data = devm_kzalloc(&pdev->dev,
> +				leds_data->no_leds * sizeof(*leds_data),
> +				GFP_KERNEL);

Mem alloc, should it be 'leds_data->palmas_led' instead of 'leds_data'?
Additionaly, size should be leds_data->no_leds * sizeof(*palmas_led) as well.

> +
> +	/* Initialise LED1 */
> +	if (palmas->led_muxed & PALMAS_LED1_MUXED) {
> +		palmas_init_led(leds_data, offset, 1);
> +		offset++;
> +	}
> +
> +	/* Initialise LED2 */
> +	if (palmas->led_muxed & PALMAS_LED2_MUXED) {
> +		palmas_init_led(leds_data, offset, 2);
> +		offset++;
> +	}
> +
> +	if (is_palmas_charger(palmas->product_id)) {
> +		palmas_init_led(leds_data, offset, 3);
> +		offset++;
> +
> +		if (pdata->chrg_led_mode) {
> +			palmas_led_update_bits(leds_data,
> PALMAS_CHRG_LED_CTRL,
> +					PALMAS_CHRG_LED_CTRL_CHRG_LED_MODE,
> +					PALMAS_CHRG_LED_CTRL_CHRG_LED_MODE);
> +
> +			palmas_init_led(leds_data, offset, 4);
> +		}
> +	}
> +
> +	for (i = 0; i < leds_data->no_leds; i++) {
> +		ret = led_classdev_register(leds_data->dev,
> +				&leds_data->palmas_led[i].cdev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"Failed to register LED no: %d err: %d\n",
> +				i, ret);
> +			goto err_led;
> +		}
> +	}
> +
> +	if (!is_palmas_charger(palmas->product_id))
> +		return 0;
> +
> +	/* Set the LED current registers if set in platform data */
> +	if (pdata->led1_current)
> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL1,
> +				PALMAS_LED_CURRENT_CTRL1_LED_1_CURRENT_MASK,
> +				pdata->led1_current);

For better readability, mask and shifted values are recommended even if
the shift is 0. These shift bits are already defined in a header.

> +
> +	if (pdata->led2_current)
> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL1,
> +				PALMAS_LED_CURRENT_CTRL1_LED_2_CURRENT_MASK,
> +				pdata->led2_current <<
> +				PALMAS_LED_CURRENT_CTRL1_LED_2_CURRENT_SHIFT);
> +
> +	if (pdata->led3_current)
> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL2,
> +				PALMAS_LED_CURRENT_CTRL2_LED_3_CURRENT_MASK,
> +				pdata->led3_current);
> +
> +	if (pdata->led3_current)
> +		palmas_led_update_bits(leds_data, PALMAS_LED_CURRENT_CTRL2,
> +				PALMAS_LED_CURRENT_CTRL2_LED_3_CURRENT_MASK,
> +				pdata->led3_current);

Updating 'led3_current' is a duplicate. Please remove it.
Shift bit operation also is needed.

> +
> +	if (pdata->led4_current)
> +		palmas_led_update_bits(leds_data, PALMAS_CHRG_LED_CTRL,
> +				PALMAS_CHRG_LED_CTRL_CHRG_LED_CURRENT_MASK,
> +				pdata->led4_current <<
> +				PALMAS_CHRG_LED_CTRL_CHRG_LED_CURRENT_SHIFT);
> +
> +	if (pdata->chrg_led_vbat_low)
> +		palmas_led_update_bits(leds_data, PALMAS_CHRG_LED_CTRL,
> +				PALMAS_CHRG_LED_CTRL_CHRG_LOWBAT_BLK_DIS,
> +				PALMAS_CHRG_LED_CTRL_CHRG_LOWBAT_BLK_DIS);
> +
> +	return 0;
> +
> +err_led:
> +	for (i = 0; i < leds_data->no_leds; i++)
> +		led_classdev_unregister(&leds_data->palmas_led[i].cdev);
> +	return ret;
> +}
> +
> +static int palmas_leds_remove(struct platform_device *pdev)
> +{
> +	struct palmas_leds_data *leds_data = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < leds_data->no_leds; i++)
> +		led_classdev_unregister(&leds_data->palmas_led[i].cdev);
> +	if (i)
> +		kfree(leds_data->palmas_led);
> +	kfree(leds_data);

Kfree()s are not required because both were allocated by devm_kzalloc()s.

> +
> +	return 0;
> +}
> +
> +static struct of_device_id of_palmas_match_tbl[] = {
> +	{ .compatible = "ti,palmas-leds", },
> +	{ .compatible = "ti,twl6035-leds", },
> +	{ .compatible = "ti,twl6036-leds", },
> +	{ .compatible = "ti,twl6037-leds", },
> +	{ .compatible = "ti,tps65913-leds", },
> +	{ .compatible = "ti,tps65914-leds", },
> +	{ .compatible = "ti,tps80036-leds", },
> +	{ /* end */ }
> +};
> +
> +static struct platform_driver palmas_leds_driver = {
> +	.driver = {
> +		.name = "palmas-leds",
> +		.of_match_table = of_palmas_match_tbl,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = palmas_leds_probe,
> +	.remove = palmas_leds_remove,
> +};
> +
> +module_platform_driver(palmas_leds_driver);
> +
> +MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
> +MODULE_DESCRIPTION("Palmas LED driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:palmas-leds");
> +MODULE_DEVICE_TABLE(of, of_palmas_match_tbl);
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index d8c303b..73186c8 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -232,6 +232,36 @@ struct palmas_clk_platform_data {
>  	int clk32kgaudio_mode_sleep;
>  };
> 
> +enum palmas_led_current {
> +	PALMAS_ILED_0mA = 0,		/*  0    mA */
> +	PALMAS_ILED_0m25A,		/*  0.25 mA */
> +	PALMAS_ILED_0m5A,		/*  0.5  mA */
> +	PALMAS_ILED_1m0A,		/*  1.0  mA */
> +	PALMAS_ILED_2m5A,		/*  2.5  mA */
> +	PALMAS_ILED_5m0A,		/*  5.0  mA */
> +	PALMAS_ILED_10m0A,		/* 10.0  mA */
> +	PALMAS_ILED_0m0A,		/*  0    mA */
> +};

It's a trivial comment - why don't you use micro unit such like 250uA, 500uA?

> +
> +#define is_palmas_led_current_ok(a) (((a) == PALMAS_ILED_0mA) || \
> +		((a) == PALMAS_ILED_0m25A) || \
> +		((a) == PALMAS_ILED_0m5A) || \
> +		((a) == PALMAS_ILED_1m0A) || \
> +		((a) == PALMAS_ILED_2m5A) || \
> +		((a) == PALMAS_ILED_5m0A) || \
> +		((a) == PALMAS_ILED_10m0A) || \
> +		((a) == PALMAS_ILED_0m0A))
> +
> +struct palmas_leds_platform_data {
> +	int led1_current;
> +	int led2_current;
> +	int led3_current;
> +	int led4_current;

Please define enum palmas_led_current type for ledN_current instead of integer.

> +
> +	int chrg_led_mode;
> +	int chrg_led_vbat_low;
> +};
> +
>  struct palmas_platform_data {
>  	int irq_flags;
>  	int gpio_base;
> @@ -1856,6 +1886,12 @@ enum usb_irq_events {
>  #define PALMAS_LED_CTRL						0x1
>  #define PALMAS_PWM_CTRL1					0x2
>  #define PALMAS_PWM_CTRL2					0x3
> +#define PALMAS_LED_PERIOD2_CTRL					0x4
> +#define PALMAS_LED_CTRL2					0x5
> +#define PALMAS_LED_CURRENT_CTRL1				0x6
> +#define PALMAS_LED_CURRENT_CTRL2				0x7
> +#define PALMAS_CHRG_LED_CTRL					0x8
> +#define PALMAS_LED_EN						0x9
> 
>  /* Bit definitions for LED_PERIOD_CTRL */
>  #define PALMAS_LED_PERIOD_CTRL_LED_2_PERIOD_MASK		0x38
> @@ -1883,6 +1919,50 @@ enum usb_irq_events {
>  #define PALMAS_PWM_CTRL2_PWM_DUTY_SEL_MASK			0xff
>  #define PALMAS_PWM_CTRL2_PWM_DUTY_SEL_SHIFT			0
> 
> +/* Bit definitions for LED_PERIOD2_CTRL */
> +#define PALMAS_LED_PERIOD2_CTRL_CHRG_LED_PERIOD_MASK		0x38
> +#define PALMAS_LED_PERIOD2_CTRL_CHRG_LED_PERIOD_SHIFT		3
> +#define PALMAS_LED_PERIOD2_CTRL_LED_3_PERIOD_MASK		0x07
> +#define PALMAS_LED_PERIOD2_CTRL_LED_3_PERIOD_SHIFT		0
> +
> +/* Bit definitions for LED_CTRL2 */
> +#define PALMAS_LED_CTRL2_CHRG_LED_SEQ				0x20
> +#define PALMAS_LED_CTRL2_CHRG_LED_SEQ_SHIFT			5
> +#define PALMAS_LED_CTRL2_LED_3_SEQ				0x10
> +#define PALMAS_LED_CTRL2_LED_3_SEQ_SHIFT			4
> +#define PALMAS_LED_CTRL2_CHRG_LED_ON_TIME_MASK			0x0c
> +#define PALMAS_LED_CTRL2_CHRG_LED_ON_TIME_SHIFT			2
> +#define PALMAS_LED_CTRL2_LED_3_ON_TIME_MASK			0x03
> +#define PALMAS_LED_CTRL2_LED_3_ON_TIME_SHIFT			0
> +
> +/* Bit definitions for LED_CURRENT_CTRL1 */
> +#define PALMAS_LED_CURRENT_CTRL1_LED_2_CURRENT_MASK		0x38
> +#define PALMAS_LED_CURRENT_CTRL1_LED_2_CURRENT_SHIFT		3
> +#define PALMAS_LED_CURRENT_CTRL1_LED_1_CURRENT_MASK		0x07
> +#define PALMAS_LED_CURRENT_CTRL1_LED_1_CURRENT_SHIFT		0
> +
> +/* Bit definitions for LED_CURRENT_CTRL2 */
> +#define PALMAS_LED_CURRENT_CTRL2_LED_3_CURRENT_MASK		0x07
> +#define PALMAS_LED_CURRENT_CTRL2_LED_3_CURRENT_SHIFT		0
> +
> +/* Bit definitions for CHRG_LED_CTRL */
> +#define PALMAS_CHRG_LED_CTRL_CHRG_LED_CURRENT_MASK		0x38
> +#define PALMAS_CHRG_LED_CTRL_CHRG_LED_CURRENT_SHIFT		3
> +#define PALMAS_CHRG_LED_CTRL_CHRG_LOWBAT_BLK_DIS		0x02
> +#define PALMAS_CHRG_LED_CTRL_CHRG_LOWBAT_BLK_DIS_SHIFT		1
> +#define PALMAS_CHRG_LED_CTRL_CHRG_LED_MODE			0x01
> +#define PALMAS_CHRG_LED_CTRL_CHRG_LED_MODE_SHIFT		0
> +
> +/* Bit definitions for LED_EN */
> +#define PALMAS_LED_EN_CHRG_LED_EN				0x08
> +#define PALMAS_LED_EN_CHRG_LED_EN_SHIFT				3
> +#define PALMAS_LED_EN_LED_3_EN					0x04
> +#define PALMAS_LED_EN_LED_3_EN_SHIFT				2
> +#define PALMAS_LED_EN_LED_2_EN					0x02
> +#define PALMAS_LED_EN_LED_2_EN_SHIFT				1
> +#define PALMAS_LED_EN_LED_1_EN					0x01
> +#define PALMAS_LED_EN_LED_1_EN_SHIFT				0
> +
>  /* Registers for function INTERRUPT */
>  #define PALMAS_INT1_STATUS					0x0
>  #define PALMAS_INT1_MASK					0x1
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
