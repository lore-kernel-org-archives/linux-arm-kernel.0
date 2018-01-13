From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 Jan 2018 11:33:15 +0100 (CET)
Subject: [PATCH v2 3/4] gpio: raspberrypi-exp: Driver for RPi3 GPIO
 expander via mailbox service
In-Reply-To: <35b07d1aae959c357d671f5530311320d0f10cc8.1515698418.git.baruch@tkos.co.il>
References: <cover.1515698418.git.baruch@tkos.co.il>
 <35b07d1aae959c357d671f5530311320d0f10cc8.1515698418.git.baruch@tkos.co.il>
Message-ID: <1313448378.43279.1515839595810@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 11. Januar 2018 um 20:44 geschrieben:
> 
> 
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> 
> Pi3 and Compute Module 3 have a GPIO expander that the
> VPU communicates with.
> There is a mailbox service that now allows control of this
> expander, so add a kernel driver that can make use of it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
>   * Rename driver to gpio-raspberrypi-exp
>   * Populate the gpiochip parent device pointer
>   * Use macro for the mailbox base GPIO number
>   * Drop linux/gpio.h and GPIOF_DIR_*
>   * Check and print firmware error value
>   * Use devm_gpiochip_add_data(); drop .remove
>   * A few more minor tweaks
> ---
>  drivers/gpio/Kconfig                |   9 ++
>  drivers/gpio/Makefile               |   1 +
>  drivers/gpio/gpio-raspberrypi-exp.c | 258 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/gpio/gpio-raspberrypi-exp.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d6a8e851ad13..8df901c75bef 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -128,6 +128,15 @@ config GPIO_AXP209
>  	help
>  	  Say yes to enable GPIO support for the AXP209 PMIC
>  
> +config GPIO_RASPBERRYPI_EXP
> +	bool "RaspberryPi 3 Exp GPIO"

How about "RaspberryPi 3 GPIO Expander" ?

Why not tristate? On arm64 it's preferred to have a kernel module.


> +	default RASPBERRYPI_FIRMWARE
> +	depends on OF_GPIO && RASPBERRYPI_FIRMWARE && \
> +		(ARCH_BCM2835 || COMPILE_TEST)

Since this is default on RASPBERRYPI_FIRMWARE, we could remove it from the dependencies.

> +	help
> +	  Turn on GPIO support for the expander on Raspberry Pi 3 boards, using
> +	  the firmware mailbox to communicate with VideoCore on BCM283x chips.
> +
>  config GPIO_BCM_KONA
>  	bool "Broadcom Kona GPIO"
>  	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 4bc24febb889..71021b0e71da 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
>  obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
>  obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
>  obj-$(CONFIG_GPIO_AXP209)	+= gpio-axp209.o
> +obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
>  obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
>  obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
> diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
> new file mode 100644
> index 000000000000..95b1957a69fa
> --- /dev/null
> +++ b/drivers/gpio/gpio-raspberrypi-exp.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Raspberry Pi 3 expander GPIO driver
> + *
> + *  Uses the firmware mailbox service to communicate with the
> + *  GPIO expander on the VPU.
> + *
> + *  Copyright (C) 2017 Raspberry Pi Trading Ltd.

2018?

> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>

I can't see any DMA handling, so please remove it.

> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define MODULE_NAME "raspberrypi-exp-gpio"
> +#define NUM_GPIO 8
> +
> +#define RPI_EXP_GPIO_BASE	128
> +
> +#define RPI_EXP_GPIO_DIR_IN	0
> +#define RPI_EXP_GPIO_DIR_OUT	1
> +
> +struct rpi_exp_gpio {
> +	struct gpio_chip gc;
> +	struct rpi_firmware *fw;
> +};
> +
> +/* VC4 firmware mailbox interface data structures */
> +
> +struct gpio_set_config {
> +	u32 gpio;
> +	u32 direction;
> +	u32 polarity;
> +	u32 term_en;
> +	u32 term_pull_up;
> +	u32 state;
> +};
> +
> +struct gpio_get_config {
> +	u32 gpio;
> +	u32 direction;
> +	u32 polarity;
> +	u32 term_en;
> +	u32 term_pull_up;
> +};
> +
> +struct gpio_get_set_state {
> +	u32 gpio;
> +	u32 state;
> +};
> +
> +static int rpi_exp_gpio_get_polarity(struct gpio_chip *gc, unsigned int off)
> +{
> +	struct rpi_exp_gpio *gpio;
> +	struct gpio_get_config get;
> +	int ret;
> +
> +	gpio = gpiochip_get_data(gc);
> +
> +	get.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_CONFIG,
> +				    &get, sizeof(get));
> +	if (ret || get.gpio != 0) {
> +		dev_err(gc->parent,
> +			"Failed to get GPIO %u config (%d %x)\n", off, ret,
> +			get.gpio);

Can't we change this to fit in 2 lines?

> +		return ret ? ret : -EIO;
> +	}
> +	return get.polarity;
> +}
> +
> +static int rpi_exp_gpio_dir_in(struct gpio_chip *gc, unsigned int off)
> +{
> +	struct rpi_exp_gpio *gpio;
> +	struct gpio_set_config set_in;
> +	int ret;
> +
> +	gpio = gpiochip_get_data(gc);
> +
> +	set_in.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
> +	set_in.direction = RPI_EXP_GPIO_DIR_IN;
> +	set_in.polarity = rpi_exp_gpio_get_polarity(gc, off);

This could fail, so please check the return code.

> +					/* Retain existing setting */
> +	set_in.term_en = 0;		/* termination disabled */
> +	set_in.term_pull_up = 0;	/* n/a as termination disabled */
> +	set_in.state = 0;		/* n/a as configured as an input */
> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_SET_GPIO_CONFIG,
> +				    &set_in, sizeof(set_in));
> +	if (ret || set_in.gpio != 0) {
> +		dev_err(gc->parent,
> +			"Failed to set GPIO %u to input (%d %x)\n",
> +			off, ret, set_in.gpio);

see above

> +		return ret ? ret : -EIO;
> +	}
> +	return 0;
> +}
> +
> +static int rpi_exp_gpio_dir_out(struct gpio_chip *gc, unsigned int off, int val)
> +{
> +	struct rpi_exp_gpio *gpio;
> +	struct gpio_set_config set_out;
> +	int ret;
> +
> +	gpio = gpiochip_get_data(gc);
> +
> +	set_out.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
> +	set_out.direction = RPI_EXP_GPIO_DIR_OUT;
> +	set_out.polarity = rpi_exp_gpio_get_polarity(gc, off);

This could also fail.

> +					/* Retain existing setting */
> +	set_out.term_en = 0;		/* n/a as an output */
> +	set_out.term_pull_up = 0;	/* n/a as termination disabled */
> +	set_out.state = val;		/* Output state */
> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_SET_GPIO_CONFIG,
> +				    &set_out, sizeof(set_out));
> +	if (ret || set_out.gpio != 0) {
> +		dev_err(gc->parent,
> +			"Failed to set GPIO %u to output (%d %x)\n", off, ret,
> +			set_out.gpio);
> +		return ret ? ret : -EIO;
> +	}
> +	return 0;
> +}
> +
> +static int rpi_exp_gpio_get_direction(struct gpio_chip *gc, unsigned int off)
> +{
> +	struct rpi_exp_gpio *gpio;
> +	struct gpio_get_config get;
> +	int ret;
> +
> +	gpio = gpiochip_get_data(gc);
> +
> +	get.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_CONFIG,
> +				    &get, sizeof(get));
> +	if (ret || get.gpio != 0) {
> +		dev_err(gc->parent,
> +			"Failed to get GPIO %u config (%d %x)\n", off, ret,
> +			get.gpio);
> +		return ret ? ret : -EIO;
> +	}
> +	return !get.direction;
> +}
> +
> +static int rpi_exp_gpio_get(struct gpio_chip *gc, unsigned int off)
> +{
> +	struct rpi_exp_gpio *gpio;
> +	struct gpio_get_set_state get;
> +	int ret;
> +
> +	gpio = gpiochip_get_data(gc);
> +
> +	get.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
> +	get.state = 0;		/* storage for returned value */
> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_STATE,
> +					 &get, sizeof(get));
> +	if (ret || get.gpio != 0) {
> +		dev_err(gc->parent,
> +			"Failed to get GPIO %u state (%d %x)\n", off, ret,
> +			get.gpio);
> +		return ret ? ret : -EIO;
> +	}
> +	return !!get.state;
> +}
> +
> +static void rpi_exp_gpio_set(struct gpio_chip *gc, unsigned int off, int val)
> +{
> +	struct rpi_exp_gpio *gpio;
> +	struct gpio_get_set_state set;
> +	int ret;
> +
> +	gpio = gpiochip_get_data(gc);
> +
> +	set.gpio = off + RPI_EXP_GPIO_BASE;	/* GPIO to update */
> +	set.state = val;	/* Output state */
> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_SET_GPIO_STATE,
> +					 &set, sizeof(set));
> +	if (ret || set.gpio != 0)
> +		dev_err(gc->parent,
> +			"Failed to set GPIO %u state (%d %x)\n", off, ret,
> +			set.gpio);
> +}
> +
> +static int rpi_exp_gpio_probe(struct platform_device *pdev)
> +{
> +	int err = 0;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *fw_node;
> +	struct rpi_firmware *fw;
> +	struct rpi_exp_gpio *rpi_gpio;
> +
> +	fw_node = of_parse_phandle(np, "firmware", 0);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	fw = rpi_firmware_get(fw_node);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	rpi_gpio = devm_kzalloc(dev, sizeof(*rpi_gpio), GFP_KERNEL);
> +	if (!rpi_gpio)
> +		return -ENOMEM;
> +
> +	rpi_gpio->fw = fw;
> +	rpi_gpio->gc.parent = dev;
> +	rpi_gpio->gc.label = MODULE_NAME;
> +	rpi_gpio->gc.owner = THIS_MODULE;
> +	rpi_gpio->gc.of_node = np;
> +	rpi_gpio->gc.base = -1;
> +	rpi_gpio->gc.ngpio = NUM_GPIO;
> +
> +	rpi_gpio->gc.direction_input = rpi_exp_gpio_dir_in;
> +	rpi_gpio->gc.direction_output = rpi_exp_gpio_dir_out;
> +	rpi_gpio->gc.get_direction = rpi_exp_gpio_get_direction;
> +	rpi_gpio->gc.get = rpi_exp_gpio_get;
> +	rpi_gpio->gc.set = rpi_exp_gpio_set;
> +	rpi_gpio->gc.can_sleep = true;
> +
> +	err = devm_gpiochip_add_data(dev, &rpi_gpio->gc, rpi_gpio);
> +	if (err)
> +		return err;
> +
> +	platform_set_drvdata(pdev, rpi_gpio);

Since we use devm_gpiochip_add_data, we can drop this.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rpi_exp_gpio_ids[] = {
> +	{ .compatible = "raspberrypi,firmware-gpio" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rpi_exp_gpio_ids);
> +
> +static struct platform_driver rpi_exp_gpio_driver = {
> +	.driver	= {
> +		.name		= MODULE_NAME,
> +		.owner		= THIS_MODULE,

Please drop this, too.

Thanks
Stefan
