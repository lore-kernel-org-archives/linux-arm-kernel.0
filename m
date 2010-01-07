From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 7 Jan 2010 20:51:17 +0100
Subject: [PATCH v2 08/09] input: enable touch on 88pm860x
In-Reply-To: <771cded00912092006o2fd46687v8aa9d2aa1404cb59@mail.gmail.com>
References: <771cded00912090517l5665e02fj35e90d02932e545a@mail.gmail.com>
	<20091210032149.GH10138@core.coreip.homeip.net>
	<200912091957.26793.dmitry.torokhov@gmail.com>
	<771cded00912092006o2fd46687v8aa9d2aa1404cb59@mail.gmail.com>
Message-ID: <20100107195116.GD11239@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Wed, Dec 09, 2009 at 11:06:36PM -0500, Haojian Zhuang wrote:
> 
> Update it :)
Does this patch look ok to you ? Can I add your SOB ?

Cheers,
Samuel.

 
> Haojian

> From c065aad6b765d25342ade3851b7d58a330d74589 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 8 Dec 2009 13:34:16 -0500
> Subject: [PATCH] input: enable touch on 88pm860x
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/input/touchscreen/88pm860x-ts.c |  241 +++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/Kconfig       |   12 ++
>  drivers/input/touchscreen/Makefile      |    1 +
>  include/linux/mfd/88pm860x.h            |    1 +
>  4 files changed, 255 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/88pm860x-ts.c
> 
> diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
> new file mode 100644
> index 0000000..56254d2
> --- /dev/null
> +++ b/drivers/input/touchscreen/88pm860x-ts.c
> @@ -0,0 +1,241 @@
> +/*
> + * Touchscreen driver for Marvell 88PM860x
> + *
> + * Copyright (C) 2009 Marvell International Ltd.
> + * 	Haojian Zhuang <haojian.zhuang@marvell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/mfd/88pm860x.h>
> +
> +#define MEAS_LEN		(8)
> +#define ACCURATE_BIT		(12)
> +
> +/* touch register */
> +#define MEAS_EN3		(0x52)
> +
> +#define MEAS_TSIX_1		(0x8D)
> +#define MEAS_TSIX_2		(0x8E)
> +#define MEAS_TSIY_1		(0x8F)
> +#define MEAS_TSIY_2		(0x90)
> +#define MEAS_TSIZ1_1		(0x91)
> +#define MEAS_TSIZ1_2		(0x92)
> +#define MEAS_TSIZ2_1		(0x93)
> +#define MEAS_TSIZ2_2		(0x94)
> +
> +/* bit definitions of touch */
> +#define MEAS_PD_EN		(1 << 3)
> +#define MEAS_TSIX_EN		(1 << 4)
> +#define MEAS_TSIY_EN		(1 << 5)
> +#define MEAS_TSIZ1_EN		(1 << 6)
> +#define MEAS_TSIZ2_EN		(1 << 7)
> +
> +struct pm860x_touch {
> +	struct input_dev *idev;
> +	struct i2c_client *i2c;
> +	struct pm860x_chip *chip;
> +	int irq;
> +	int res_x;		/* resistor of Xplate */
> +};
> +
> +static irqreturn_t pm860x_touch_handler(int irq, void *data)
> +{
> +	struct pm860x_touch *touch = data;
> +	struct pm860x_chip *chip = touch->chip;
> +	unsigned char buf[MEAS_LEN];
> +	int x, y, pen_down;
> +	int z1, z2, rt = 0;
> +	int ret;
> +
> +	pm860x_mask_irq(chip, irq);
> +	ret = pm860x_bulk_read(touch->i2c, MEAS_TSIX_1, MEAS_LEN, buf);
> +	if (ret < 0)
> +		goto out;
> +
> +	pen_down = buf[1] & (1 << 6);
> +	x = ((buf[0] & 0xFF) << 4) | (buf[1] & 0x0F);
> +	y = ((buf[2] & 0xFF) << 4) | (buf[3] & 0x0F);
> +	z1 = ((buf[4] & 0xFF) << 4) | (buf[5] & 0x0F);
> +	z2 = ((buf[6] & 0xFF) << 4) | (buf[7] & 0x0F);
> +
> +	if (pen_down) {
> +		if ((x != 0) && (z1 != 0) && (touch->res_x != 0)) {
> +			rt = z2 / z1 - 1;
> +			rt = (rt * touch->res_x * x) >> ACCURATE_BIT;
> +			dev_dbg(chip->dev, "z1:%d, z2:%d, rt:%d\n",
> +				z1, z2, rt);
> +		}
> +		input_report_abs(touch->idev, ABS_X, x);
> +		input_report_abs(touch->idev, ABS_Y, y);
> +		input_report_abs(touch->idev, ABS_PRESSURE, rt);
> +		input_report_key(touch->idev, BTN_TOUCH, 1);
> +		dev_dbg(chip->dev, "pen down at [%d, %d].\n", x, y);
> +	} else {
> +		input_report_abs(touch->idev, ABS_PRESSURE, 0);
> +		input_report_key(touch->idev, BTN_TOUCH, 0);
> +		dev_dbg(chip->dev, "pen release\n");
> +	}
> +	input_sync(touch->idev);
> +	pm860x_unmask_irq(chip, irq);
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static int pm860x_touch_open(struct input_dev *dev)
> +{
> +	struct pm860x_touch *touch = input_get_drvdata(dev);
> +	struct pm860x_chip *chip = touch->chip;
> +	int data, ret;
> +
> +	data = MEAS_PD_EN | MEAS_TSIX_EN | MEAS_TSIY_EN
> +		| MEAS_TSIZ1_EN | MEAS_TSIZ2_EN;
> +	ret = pm860x_set_bits(touch->i2c, MEAS_EN3, data, data);
> +	if (ret < 0)
> +		goto out;
> +	pm860x_unmask_irq(chip, touch->irq);
> +	return 0;
> +out:
> +	return ret;
> +}
> +
> +static void pm860x_touch_close(struct input_dev *dev)
> +{
> +	struct pm860x_touch *touch = input_get_drvdata(dev);
> +	struct pm860x_chip *chip = touch->chip;
> +	int data;
> +
> +	data = MEAS_PD_EN | MEAS_TSIX_EN | MEAS_TSIY_EN
> +		| MEAS_TSIZ1_EN | MEAS_TSIZ2_EN;
> +	pm860x_set_bits(touch->i2c, MEAS_EN3, data, 0);
> +	pm860x_mask_irq(chip, touch->irq);
> +}
> +
> +static int __devinit pm860x_touch_probe(struct platform_device *pdev)
> +{
> +	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct pm860x_platform_data *pm860x_pdata =		\
> +				pdev->dev.parent->platform_data;
> +	struct pm860x_touch_pdata *pdata = NULL;
> +	struct pm860x_touch *touch;
> +	int irq, ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ resource!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pm860x_pdata) {
> +		dev_err(&pdev->dev, "platform data is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	pdata = pm860x_pdata->touch;
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "touchscreen data is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	touch = kzalloc(sizeof(struct pm860x_touch), GFP_KERNEL);
> +	if (touch == NULL)
> +		return -ENOMEM;
> +	dev_set_drvdata(&pdev->dev, touch);
> +
> +	touch->idev = input_allocate_device();
> +	if (touch->idev == NULL) {
> +		dev_err(&pdev->dev, "Failed to allocate input device!\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	touch->idev->name = "88pm860x-touch";
> +	touch->idev->phys = "88pm860x/input0";
> +	touch->idev->id.bustype = BUS_I2C;
> +	touch->idev->dev.parent = &pdev->dev;
> +	touch->idev->open = pm860x_touch_open;
> +	touch->idev->close = pm860x_touch_close;
> +	touch->chip = chip;
> +	touch->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
> +	touch->irq = irq;
> +	touch->res_x = pdata->res_x;
> +	input_set_drvdata(touch->idev, touch);
> +
> +	ret = pm860x_request_irq(chip, irq, pm860x_touch_handler, touch);
> +	if (ret < 0)
> +		goto out_irq;
> +
> +	__set_bit(EV_ABS, touch->idev->evbit);
> +	__set_bit(ABS_X, touch->idev->absbit);
> +	__set_bit(ABS_Y, touch->idev->absbit);
> +	__set_bit(ABS_PRESSURE, touch->idev->absbit);
> +	__set_bit(EV_SYN, touch->idev->evbit);
> +	__set_bit(EV_KEY, touch->idev->evbit);
> +	__set_bit(BTN_TOUCH, touch->idev->keybit);
> +
> +	input_set_abs_params(touch->idev, ABS_X, 0, 1 << ACCURATE_BIT, 0, 0);
> +	input_set_abs_params(touch->idev, ABS_Y, 0, 1 << ACCURATE_BIT, 0, 0);
> +	input_set_abs_params(touch->idev, ABS_PRESSURE, 0, 1 << ACCURATE_BIT,
> +				0, 0);
> +
> +	ret = input_register_device(touch->idev);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to register touch!\n");
> +		goto out_rg;
> +	}
> +
> +	platform_set_drvdata(pdev, touch);
> +	return 0;
> +out_rg:
> +	pm860x_free_irq(chip, irq);
> +out_irq:
> +	input_free_device(touch->idev);
> +out:
> +	kfree(touch);
> +	return ret;
> +}
> +
> +static int __devexit pm860x_touch_remove(struct platform_device *pdev)
> +{
> +	struct pm860x_touch *touch = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(touch->idev);
> +	pm860x_free_irq(touch->chip, touch->irq);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(touch);
> +	return 0;
> +}
> +
> +static struct platform_driver pm860x_touch_driver = {
> +	.driver	= {
> +		.name	= "88pm860x-touch",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe	= pm860x_touch_probe,
> +	.remove	= __devexit_p(pm860x_touch_remove),
> +};
> +
> +static int __init pm860x_touch_init(void)
> +{
> +	return platform_driver_register(&pm860x_touch_driver);
> +}
> +module_init(pm860x_touch_init);
> +
> +static void __exit pm860x_touch_exit(void)
> +{
> +	platform_driver_unregister(&pm860x_touch_driver);
> +}
> +module_exit(pm860x_touch_exit);
> +
> +MODULE_DESCRIPTION("Touchscreen driver for Marvell Semiconductor 88PM860x");
> +MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:88pm860x-touch");
> +
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 8cc453c..df8cbb7 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -11,6 +11,18 @@ menuconfig INPUT_TOUCHSCREEN
>  
>  if INPUT_TOUCHSCREEN
>  
> +config TOUCHSCREEN_88PM860X
> +	tristate "Marvell 88PM860x touchscreen"
> +	depends on MFD_88PM860X
> +	help
> +	  Say Y here if you have a 88PM860x PMIC and want to enable
> +	  support for the built-in touchscreen.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called 88pm860x-ts.
> +
>  config TOUCHSCREEN_ADS7846
>  	tristate "ADS7846/TSC2046 and ADS7843 based touchscreens"
>  	depends on SPI_MASTER
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 15fa62c..b278a1f 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -6,6 +6,7 @@
>  
>  wm97xx-ts-y := wm97xx-core.o
>  
> +obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
>  obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
>  obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
> diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
> index 5d7cd5a..87e41da 100644
> --- a/include/linux/mfd/88pm860x.h
> +++ b/include/linux/mfd/88pm860x.h
> @@ -341,6 +341,7 @@ struct pm860x_touch_pdata {
>  	int		tsi_prebias;	/* time, slot */
>  	int		pen_prebias;	/* time, slot */
>  	int		pen_prechg;	/* time, slot */
> +	int		res_x;		/* resistor of Xplate */
>  	unsigned long	flags;
>  };
>  
> -- 
> 1.5.6.5
> 


-- 
Intel Open Source Technology Centre
http://oss.intel.com/
