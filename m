From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Aug 2015 09:17:57 +0100
Subject: [PATCH v1 RFC] This patch repairs HTC Magician machine (PXA27x)
 support
In-Reply-To: <55CBCDED.8010409@tul.cz>
References: <55CBCDED.8010409@tul.cz>
Message-ID: <20150813081757.GA8782@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Aug 2015, Petr Cvek wrote:

> Fixing original code: Problems to successful boot due to the bad LCD
> power sequence (wrongly configured GPIO).
> 
> Add/fix platform data and helper function for various hardware
> (touchscreen, audio, USB device, ...).
> 
> Add new discovered GPIOs and fix names by GPIO context.
> 
> Add new LEDs driver.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/Kconfig                 |    1 +
>  arch/arm/mach-pxa/include/mach/magician.h |   21 +-
>  arch/arm/mach-pxa/magician.c              | 1148 +++++++++++++++++++++++------
>  drivers/leds/Kconfig                      |    9 +
>  drivers/leds/Makefile                     |    1 +
>  drivers/leds/leds-pasic3.c                |  192 +++++
>  drivers/mfd/htc-pasic3.c                  |  115 ++-
>  include/linux/mfd/htc-pasic3.h            |   69 +-
>  8 files changed, 1293 insertions(+), 263 deletions(-)
>  create mode 100644 drivers/leds/leds-pasic3.c

I'm pretty sure there aren't strong enough dependence to warrant all
of this code being shoved into a single patch.  Please do what you can
to break it up into simple, manageable pieces which will make the
review and maintenance (patch acceptance) process easier.

[...]

> diff --git a/drivers/leds/leds-pasic3.c b/drivers/leds/leds-pasic3.c
> new file mode 100644
> index 0000000..ecb0557
> --- /dev/null
> +++ b/drivers/leds/leds-pasic3.c
> @@ -0,0 +1,192 @@
> +/*
> + * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not Compaq ASIC3)
> + *
> + * Copyright (c) 2015 Petr Cvek <petr.cvek@tul.cz>
> + *
> + * Based on leds-asic3.c driver
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +
> +#include <linux/mfd/htc-pasic3.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +
> +/*
> + * 1 tick is around 62-63 ms, blinking settings (on+off):
> + *	Min: 1+1 ticks ~125ms
> + *	Max: 127+127 ticks ~15?875ms
> + * Sometimes takes time to change after write (counter overflow?)
> + */
> +
> +#define MS_TO_CLK(ms)	DIV_ROUND_CLOSEST(((ms)*1024), 64000)
> +#define CLK_TO_MS(clk)	(((clk)*64000)/1024)
> +#define MAX_CLK		254		/* 127 + 127 (2x 7 bit reg) */
> +#define MAX_MS		CLK_TO_MS(MAX_CLK)
> +
> +static void brightness_set(struct led_classdev *cdev,
> +	enum led_brightness value)
> +{
> +	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);

This device should have no idea it's part of an MFD.

Just fetch platform data in the normal way.

> +	struct pasic3_led *led;
> +	struct device *dev;
> +	u8 val;
> +
> +	if (!cell->platform_data) {
> +		pr_err("No platform data\n");
> +		return;
> +	}
> +
> +	led = cell->platform_data;
> +	dev = pdev->dev.parent;
> +
> +	if (value == LED_OFF) {
> +		val = pasic3_read_register(dev, PASIC3_CH_CONTROL);
> +		pasic3_write_register(dev, PASIC3_CH_CONTROL,
> +			val & ~(led->bit_blink_en | led->bit_force_on));
> +
> +		val = pasic3_read_register(dev, PASIC3_MASK_A);
> +		pasic3_write_register(dev, PASIC3_MASK_A, val & ~led->bit_mask);
> +	} else {
> +		val = pasic3_read_register(dev, PASIC3_CH_CONTROL);
> +		pasic3_write_register(dev, PASIC3_CH_CONTROL,
> +			val | led->bit_force_on);
> +	}
> +}
> +
> +static int blink_set(struct led_classdev *cdev,
> +	unsigned long *delay_on,
> +	unsigned long *delay_off)
> +{
> +	struct platform_device *pdev = to_platform_device(cdev->dev->parent);
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);

As above.

> +	struct device *dev;
> +	struct pasic3_led *led;
> +	u32 on, off;
> +	u8 val;
> +
> +	if (!cell->platform_data) {
> +		pr_err("No platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (*delay_on > MAX_MS || *delay_off > MAX_MS)
> +		return -EINVAL;
> +
> +	if (*delay_on == 0 && *delay_off == 0) {
> +		/* If both are zero then a sensible default should be chosen */
> +		on = MS_TO_CLK(500);
> +		off = MS_TO_CLK(500);
> +	} else {
> +		on = MS_TO_CLK(*delay_on);
> +		off = MS_TO_CLK(*delay_off);
> +		if ((on + off) > MAX_CLK)
> +			return -EINVAL;
> +		/* Minimal value must be 1 */
> +		on = on ? on : 1;
> +		off = off ? off : 1;
> +	}
> +
> +	led = cell->platform_data;
> +	dev = pdev->dev.parent;
> +
> +	pasic3_write_register(dev, led->reg_delay_on, on);
> +	pasic3_write_register(dev, led->reg_delay_off, off);
> +
> +	val = pasic3_read_register(dev, PASIC3_CH_CONTROL);
> +	pasic3_write_register(dev, PASIC3_CH_CONTROL, val | led->bit_blink_en);
> +
> +	*delay_on = CLK_TO_MS(on);
> +	*delay_off = CLK_TO_MS(off);
> +
> +	return 0;
> +}
> +
> +static int pasic3_led_probe(struct platform_device *pdev)
> +{
> +	struct pasic3_led *led = dev_get_platdata(&pdev->dev);
> +	int ret;
> +
> +	ret = mfd_cell_enable(pdev);
> +	if (ret < 0)
> +		return ret;

That is not what .enable is for, please don't use it.

> +	led->cdev.flags = LED_CORE_SUSPENDRESUME;
> +	led->cdev.brightness_set = brightness_set;
> +	led->cdev.blink_set = blink_set;
> +
> +	ret = led_classdev_register(&pdev->dev, &led->cdev);
> +	if (ret < 0)
> +		goto out;
> +
> +	return 0;
> +
> +out:
> +	(void) mfd_cell_disable(pdev);
> +	return ret;
> +}
> +
> +static int pasic3_led_remove(struct platform_device *pdev)
> +{
> +	struct pasic3_led *led = dev_get_platdata(&pdev->dev);
> +
> +	led_classdev_unregister(&led->cdev);
> +
> +	return mfd_cell_disable(pdev);

Likewise.

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int pasic3_led_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
> +	int ret;
> +
> +	ret = 0;
> +	if (cell->suspend)
> +		ret = (*cell->suspend)(pdev);
> +
> +	return ret;
> +}
> +
> +static int pasic3_led_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
> +	int ret;
> +
> +	ret = 0;
> +	if (cell->resume)
> +		ret = (*cell->resume)(pdev);

Err, no.  Move the cell->resume() code into here.

> +	return ret;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(pasic3_led_pm_ops, pasic3_led_suspend,
> +	pasic3_led_resume);
> +
> +static struct platform_driver pasic3_led_driver = {
> +	.probe		= pasic3_led_probe,
> +	.remove		= pasic3_led_remove,
> +	.driver		= {
> +		.name	= "leds-pasic3",
> +		.pm	= &pasic3_led_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(pasic3_led_driver);
> +
> +MODULE_AUTHOR("Petr Cvek <petr.cvek@tul.cz>");
> +MODULE_DESCRIPTION("HTC Magician PASIC3 LED driver");
> +MODULE_LICENSE("GPL");

v2

> +MODULE_ALIAS("platform:leds-pasic3");
> diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
> index e88d4f6..3df3f0a 100644
> --- a/drivers/mfd/htc-pasic3.c
> +++ b/drivers/mfd/htc-pasic3.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
>   *
> + * LED support:
> + * Copyright (C) 2015 Petr Cvek <petr.cvek@tul.cz>
> + *

You don't need to break up the copyright statements.  Remove the "LED
support" line and the blank line above it.

>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; version 2 of the License.
> @@ -65,8 +68,76 @@ EXPORT_SYMBOL(pasic3_read_register); /* for leds-pasic3 */
>   * LEDs
>   */
>  
> -static struct mfd_cell led_cell __initdata = {
> -	.name = "leds-pasic3",
> +
> +static int pasic3_leds_enable(struct platform_device *pdev)
> +{
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
> +	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct pasic3_led *led;
> +
> +	led = cell->platform_data;
> +	pdata = led->pdata;
> +
> +	gpio_set_value(pdata->power_gpio, 1);
> +
> +	return 0;
> +}

You need to re-think this function (you're doing some pretty wacky
stuff in there) and move it into the LED driver.

> +static int pasic3_leds_disable(struct platform_device *pdev)
> +{
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
> +	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct pasic3_led *led;
> +
> +	led = cell->platform_data;
> +	pdata = led->pdata;
> +
> +	gpio_set_value(pdata->power_gpio, 0);
> +
> +	return 0;
> +}

And this one.

> +static int pasic3_leds_suspend(struct platform_device *pdev)
> +{
> +	const struct mfd_cell *cell = mfd_get_cell(pdev);
> +	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct pasic3_led *led;
> +
> +	led = cell->platform_data;
> +	pdata = led->pdata;
> +
> +	gpio_set_value(pdata->power_gpio, 0);
> +
> +	return 0;
> +}

And this one.

> +#define PASIC3_NUM_LEDS 3
> +
> +static struct mfd_cell pasic3_cell_leds[PASIC3_NUM_LEDS] = {
> +	[0] = {
> +		.name		= "leds-pasic3",
> +		.id			= 0,
> +		.enable		= pasic3_leds_enable,
> +		.disable	= pasic3_leds_disable,
> +		.suspend	= pasic3_leds_suspend,
> +		.resume		= pasic3_leds_enable,
> +	},
> +	[1] = {
> +		.name		= "leds-pasic3",
> +		.id			= 1,
> +		.enable		= pasic3_leds_enable,
> +		.disable	= pasic3_leds_disable,
> +		.suspend	= pasic3_leds_suspend,
> +		.resume		= pasic3_leds_enable,
> +	},
> +	[2] = {
> +		.name		= "leds-pasic3",
> +		.id			= 2,
> +		.enable		= pasic3_leds_enable,
> +		.disable	= pasic3_leds_disable,
> +		.suspend	= pasic3_leds_suspend,
> +		.resume		= pasic3_leds_enable,
> +	},
>  };

Why do you need to explicitly set the .ids?

>  /*
> @@ -78,10 +149,10 @@ static int ds1wm_enable(struct platform_device *pdev)
>  	struct device *dev = pdev->dev.parent;
>  	int c;
>  
> -	c = pasic3_read_register(dev, 0x28);
> -	pasic3_write_register(dev, 0x28, c & 0x7f);
> +	c = pasic3_read_register(dev, PASIC3_GPIO);
> +	pasic3_write_register(dev, PASIC3_GPIO, c & ~DS1WM_nEN);

Not keen on camel case defines.

> -	dev_dbg(dev, "DS1WM OWM_EN low (active) %02x\n", c & 0x7f);
> +	dev_dbg(dev, "DS1WM OWM_EN low (active) %02x\n", c & ~DS1WM_nEN);
>  	return 0;
>  }
>  
> @@ -90,10 +161,10 @@ static int ds1wm_disable(struct platform_device *pdev)
>  	struct device *dev = pdev->dev.parent;
>  	int c;
>  
> -	c = pasic3_read_register(dev, 0x28);
> -	pasic3_write_register(dev, 0x28, c | 0x80);
> +	c = pasic3_read_register(dev, PASIC3_GPIO);
> +	pasic3_write_register(dev, PASIC3_GPIO, c | DS1WM_nEN);
>  
> -	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | 0x80);
> +	dev_dbg(dev, "DS1WM OWM_EN high (inactive) %02x\n", c | DS1WM_nEN);
>  	return 0;
>  }
>  
> @@ -172,13 +243,27 @@ static int __init pasic3_probe(struct platform_device *pdev)
>  			dev_warn(dev, "failed to register DS1WM\n");
>  	}
>  
> -	if (pdata && pdata->led_pdata) {
> -		led_cell.platform_data = pdata->led_pdata;
> -		led_cell.pdata_size = sizeof(struct pasic3_leds_machinfo);
> -		ret = mfd_add_devices(&pdev->dev, pdev->id, &led_cell, 1, r,
> -				      0, NULL);
> +	if (pdata && pdata->leds) {
> +		int i;
> +
> +		for (i = 0; i < PASIC3_NUM_LEDS; ++i) {
> +			pdata->leds[i].pdata = pdata;
> +			pasic3_cell_leds[i].platform_data = &pdata->leds[i];
> +			pasic3_cell_leds[i].pdata_size = sizeof(pdata->leds[i]);
> +		}

Where is the platform data passed in from?

> +		ret = mfd_add_devices(&pdev->dev, 0,

Are you sure you don't want the this to be automatically done for you?

See: include/linux/platform_device.h

> +			pasic3_cell_leds, PASIC3_NUM_LEDS, NULL, 0, NULL);
> +
>  		if (ret < 0)
>  			dev_warn(dev, "failed to register LED device\n");
> +
> +		if (pdata->power_gpio) {
> +			ret = gpio_request(pdata->power_gpio,
> +				"Red-Blue LED Power");
> +			if (ret < 0)
> +				dev_warn(dev, "failed to request power GPIO\n");

Why are you doing this in here?  Doesn't this belong in the LED driver?

> +		}
> +
>  	}
>  
>  	return 0;
> @@ -187,10 +272,14 @@ static int __init pasic3_probe(struct platform_device *pdev)
>  static int pasic3_remove(struct platform_device *pdev)
>  {
>  	struct pasic3_data *asic = platform_get_drvdata(pdev);
> +	struct pasic3_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct resource *r;
>  
>  	mfd_remove_devices(&pdev->dev);
>  
> +	if (pdata->power_gpio)
> +		gpio_free(pdata->power_gpio);
> +

Move somewhere else.

>  	iounmap(asic->mapping);
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(r->start, resource_size(r));
> diff --git a/include/linux/mfd/htc-pasic3.h b/include/linux/mfd/htc-pasic3.h
> index 3d3ed67..e8e4cd2 100644
> --- a/include/linux/mfd/htc-pasic3.h
> +++ b/include/linux/mfd/htc-pasic3.h
> @@ -18,36 +18,65 @@
>  extern void pasic3_write_register(struct device *dev, u32 reg, u8 val);
>  extern u8 pasic3_read_register(struct device *dev, u32 reg);
>  
> -/*
> - * mask for registers 0x20,0x21,0x22
> - */
> -#define PASIC3_MASK_LED0 0x04
> -#define PASIC3_MASK_LED1 0x08
> -#define PASIC3_MASK_LED2 0x40
> +#define PASIC3_CH0_DELAY_ON		0x00
> +#define PASIC3_CH0_DELAY_OFF	0x01
> +#define PASIC3_CH1_DELAY_ON		0x02
> +#define PASIC3_CH1_DELAY_OFF	0x03
> +#define PASIC3_CH2_DELAY_ON		0x04
> +#define PASIC3_CH2_DELAY_OFF	0x05
> +#define PASIC3_DELAY_MASK		0x7f
> +
> +#define PASIC3_CH_CONTROL		0x06
> +#define		R06_CH0_EN			(1<<0)
> +#define		R06_CH1_EN			(1<<1)
> +#define		R06_CH2_EN			(1<<2)
> +#define		R06_CH0_FORCE_ON	(1<<3)
> +#define		R06_CH1_FORCE_ON	(1<<4)
> +#define		R06_CH2_FORCE_ON	(1<<5)

Use BIT().

>  /*
> - * bits in register 0x06
> + * pwm_ch0_out | force_on | (bit0 & bit1 & bit2)
> + * pwm_ch1_out | force_on | (bit0 & bit1 & bit2)
> + * pwm_ch2_out | force_on | (bit2?bit0:(bit0 & ! bit1))
>   */
> -#define PASIC3_BIT2_LED0 0x08
> -#define PASIC3_BIT2_LED1 0x10
> -#define PASIC3_BIT2_LED2 0x20
> +
> +#define PASIC3_MASK_A	0x20
> +#define PASIC3_MASK_B	0x21
> +#define PASIC3_MASK_C	0x22
> +#define  MASK_CH0	(1<<2)
> +#define  MASK_CH1	(1<<3)
> +#define  MASK_CH2	(1<<6)

As above and for all other "1 <<" logic.

> +#define  PASIC3_GPIO	0x28
> +
> +#define	DS1WM_nEN	(1<<7)
> +#define  PASIC3_SYS	0x2a
> +/* NORMAL_RST, CAM_PWR_RST and UNKNOWN will autoclear, set STATUS */
> +#define  NORMAL_RST		(1<<0)
> +#define  CAM_PWR_RST	(1<<1)
> +#define  UNKNOWN		(1<<2)
> +#define  STATUS_NORMAL_RST	(1<<4)
> +#define  STATUS_CAM_PWR_RST	(1<<5)
> +#define  STATUS_UNKNOWN		(1<<6)
> +
> +#define PASIC3_RST_EN		0x2c
> +#define  EN_NORMAL_RST	0x40
> +#define  EN_DOOR_RST	0x42
>  
>  struct pasic3_led {
> -	struct led_classdev         led;
> -	unsigned int                hw_num;
> -	unsigned int                bit2;
> -	unsigned int                mask;
> -	struct pasic3_leds_machinfo *pdata;
> +	struct led_classdev		cdev;
> +	unsigned int	hw_num;
> +	unsigned char	bit_blink_en;
> +	unsigned char	bit_force_on;
> +	unsigned char	bit_mask;
> +	unsigned char	reg_delay_on;
> +	unsigned char	reg_delay_off;

Are you sure these shouldn't be bools?

> +	struct pasic3_platform_data *pdata;
>  };
>  
> -struct pasic3_leds_machinfo {
> +struct pasic3_platform_data {
>  	unsigned int      num_leds;
>  	unsigned int      power_gpio;
>  	struct pasic3_led *leds;
> -};
> -
> -struct pasic3_platform_data {
> -	struct pasic3_leds_machinfo *led_pdata;
>  	unsigned int                 clock_rate;
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
