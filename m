From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 08 Feb 2013 22:35:35 +0000
Subject: [PATCH 3.9 1/3] misc: new driver for GPIO-connected 7-segment
 displays
In-Reply-To: <1357576928-29133-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357576928-29133-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130208223535.66AC53E2C27@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  7 Jan 2013 17:42:06 +0100, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> This patch adds a driver to control 7-segment displays connected over
> GPIOs through a BCD encoder. Typically, up to four GPIOs go into a BCD
> encoder, that drives the 7-segment display to display a numeric value
> between 0 and 2^ngpios-1.
> 
> Once this driver is enabled, it creates a 'value' field in the sysfs
> directory of the device, which allows to set the current value
> displayed by the 7-segment.
> 
> It has been successfully tested on the Marvell Armada 370 and Marvell
> Armada XP evaluation boards. Both of them have a 7-segment display
> that can be controlled using 3 GPIOs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/misc/gpio-7seg.txt         |   18 +++
>  drivers/misc/Kconfig                               |   13 ++
>  drivers/misc/Makefile                              |    1 +
>  drivers/misc/gpio-7seg.c                           |  168 ++++++++++++++++++++
>  4 files changed, 200 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/gpio-7seg.txt
>  create mode 100644 drivers/misc/gpio-7seg.c
> 
> diff --git a/Documentation/devicetree/bindings/misc/gpio-7seg.txt b/Documentation/devicetree/bindings/misc/gpio-7seg.txt
> new file mode 100644
> index 0000000..107d178
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/gpio-7seg.txt
> @@ -0,0 +1,18 @@
> +* 7-segment driver connected over GPIO through a BCD decoder
> +
> +Required properties:
> +- compatible: "generic,gpio-7seg"
> +- gpios: list of GPIOs to use to control the 7-segment display
> +
> +Optional properties:
> +- default-value: default value shown by the 7-segment display at boot
> +  time. If not defined, defaults to 0.
> +
> +Example:
> +
> +gpio-7seg at 0 {
> +	compatible = "generic,gpio-7seg";
> +	status = "okay";
> +	gpios = <&gpio1 27 0 &gpio1 28 0 &gpio1 29 0>;
> +	default-value = <5>;
> +};

Nice, I would use this. As an extension, I could also see wanting to
support directly attached LED displays; one GPIO per segment (but I'm
not suggesting you do that; I'm just thinking out loud).

However, rather than a completely seperate driver, can you piggyback on
the existing gpio-leds driver? It would The binding document should also be in
bindings/leds, and the driver in drivers/leds.

g.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b151b7c..19f9d22 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -93,6 +93,19 @@ config ATMEL_TCB_CLKSRC_BLOCK
>  	  TC can be used for other purposes, such as PWM generation and
>  	  interval timing.
>  
> +config GPIO_7SEG
> +	tristate "GPIO-connected 7-segment display driver"
> +	help
> +	  This option enables a driver to control 7-segment displays
> +	  connected over GPIOs through a BCD encoder. Typically, up to
> +	  four GPIOs go into a BCD encoder, that drives the 7-segment
> +	  display to display a numeric value between 0 and
> +	  2^ngpios-1.
> +
> +	  Once this driver is enabled, it creates a 'value' field in
> +	  the sysfs directory of the device, which allows to set the
> +	  current value displayed by the 7-segment.
> +
>  config IBM_ASM
>  	tristate "Device driver for IBM RSA service processor"
>  	depends on X86 && PCI && INPUT
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 2129377..b789358 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
>  obj-$(CONFIG_ATMEL_PWM)		+= atmel_pwm.o
>  obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
>  obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
> +obj-$(CONFIG_GPIO_7SEG)         += gpio-7seg.o
>  obj-$(CONFIG_BMP085)		+= bmp085.o
>  obj-$(CONFIG_BMP085_I2C)	+= bmp085-i2c.o
>  obj-$(CONFIG_BMP085_SPI)	+= bmp085-spi.o
> diff --git a/drivers/misc/gpio-7seg.c b/drivers/misc/gpio-7seg.c
> new file mode 100644
> index 0000000..8cc5113
> --- /dev/null
> +++ b/drivers/misc/gpio-7seg.c
> @@ -0,0 +1,168 @@
> +/*
> + * Simple driver to control a 7 segment display connected through a
> + * BCD decoder using GPIOs.
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +
> +struct gpio_7seg_dev {
> +	struct device_attribute dev_attr;
> +	int *gpios;
> +	int ngpios;
> +	int value;
> +	int maxvalue;
> +};
> +
> +static void gpio_7seg_display_val(struct gpio_7seg_dev *sdev,
> +				  int value)
> +{
> +	int i;
> +
> +	for (i = 0; i < sdev->ngpios; i++) {
> +		int bitval = (value & BIT(i)) ? 1 : 0;
> +		gpio_set_value_cansleep(sdev->gpios[i], bitval);
> +	}
> +}
> +
> +static ssize_t gpio_7seg_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct gpio_7seg_dev *sdev = dev_get_drvdata(dev);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", sdev->value);
> +}
> +
> +static ssize_t gpio_7seg_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct gpio_7seg_dev *sdev = dev_get_drvdata(dev);
> +	unsigned long value;
> +	char *end;
> +
> +	value = simple_strtoul(buf, &end, 0);
> +	if (end == buf)
> +		return -EINVAL;
> +
> +	if (value >= sdev->maxvalue)
> +		return -EINVAL;
> +
> +	gpio_7seg_display_val(sdev, value);
> +	sdev->value = value;
> +
> +	return count;
> +}
> +
> +static int gpio_7seg_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct gpio_7seg_dev *sdev;
> +	int ret, i;
> +
> +	/*
> +	 * We only support being probed through the device tree, for
> +	 * now
> +	 */
> +	if (!np)
> +		return -EINVAL;
> +
> +	sdev = devm_kzalloc(&pdev->dev, sizeof(struct gpio_7seg_dev),
> +			    GFP_KERNEL);
> +	if (!sdev)
> +		return -ENOMEM;
> +
> +	sdev->ngpios = of_gpio_count(np);
> +	if (!sdev->ngpios)
> +		return -EINVAL;
> +
> +	sdev->gpios = devm_kzalloc(&pdev->dev, sizeof(int) * sdev->ngpios,
> +				   GFP_KERNEL);
> +	if (!sdev->gpios)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < sdev->ngpios; i++) {
> +		sdev->gpios[i] = of_get_gpio(np, i);
> +		ret = gpio_request_one(sdev->gpios[i], GPIOF_DIR_OUT, NULL);
> +		if (ret) {
> +			/*
> +			 * Mark this GPIO as non-requested for the
> +			 * error handling code
> +			 */
> +			sdev->gpios[i] = ret;
> +			goto gpio_cleanup;
> +		}
> +	}
> +
> +	ret = of_property_read_u32(np, "default-value", &sdev->value);
> +	if (ret)
> +		sdev->value = 0;
> +
> +	sdev->maxvalue = 1 << sdev->ngpios;
> +
> +	sdev->dev_attr.attr.name = "value";
> +	sdev->dev_attr.attr.mode = S_IRUGO | S_IWUGO;
> +	sdev->dev_attr.show = gpio_7seg_show;
> +	sdev->dev_attr.store = gpio_7seg_store;
> +
> +	ret = device_create_file(&pdev->dev, &sdev->dev_attr);
> +	if (ret)
> +		goto gpio_cleanup;
> +
> +	gpio_7seg_display_val(sdev, sdev->value);
> +
> +	platform_set_drvdata(pdev, sdev);
> +	return 0;
> +
> +gpio_cleanup:
> +	for (i = 0; i < sdev->ngpios; i++)
> +		if (gpio_is_valid(sdev->gpios[i]))
> +			gpio_free(sdev->gpios[i]);
> +	return ret;
> +}
> +
> +static int gpio_7seg_remove(struct platform_device *pdev)
> +{
> +	struct gpio_7seg_dev *sdev;
> +	int i;
> +
> +	sdev = platform_get_drvdata(pdev);
> +
> +	device_remove_file(&pdev->dev, &sdev->dev_attr);
> +
> +	for (i = 0; i < sdev->ngpios; i++)
> +		if (gpio_is_valid(sdev->gpios[i]))
> +			gpio_free(sdev->gpios[i]);
> +	return 0;
> +}
> +
> +static const struct of_device_id gpio_7seg_of_match_table[] = {
> +	{ .compatible = "generic,gpio-7seg" },
> +	{},
> +};
> +
> +static struct platform_driver gpio_7seg_driver = {
> +	.probe  = gpio_7seg_probe,
> +	.remove = gpio_7seg_remove,
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name  = "gpio-7seg",
> +		.of_match_table = of_match_ptr(gpio_7seg_of_match_table),
> +	},
> +};
> +
> +module_platform_driver(gpio_7seg_driver);
> +
> +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
> +MODULE_DESCRIPTION("Simple GPIO-connected 7-segment display driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
