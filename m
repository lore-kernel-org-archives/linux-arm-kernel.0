From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 19 Jan 2018 19:50:07 +0100 (CET)
Subject: [PATCH v3 3/4] gpio: raspberrypi-exp: Driver for RPi3 GPIO
 expander via mailbox service
In-Reply-To: <1a2829a6cb5edc951f9d8f322882916ab9cea67c.1516105893.git.baruch@tkos.co.il>
References: <cover.1516105893.git.baruch@tkos.co.il>
 <1a2829a6cb5edc951f9d8f322882916ab9cea67c.1516105893.git.baruch@tkos.co.il>
Message-ID: <2094453455.55619.1516387807214@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 16. Januar 2018 um 13:45 geschrieben:
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
> v3:
>   * Tweak Kconfig driver prompt
>   * Make GPIO_RASPBERRYPI_EXP tristate
>   * Make COMPILE_TEST independent of RASPBERRYPI_FIRMWARE
>   * Remove redundant DMA header
>   * Use less code lines for dev_err()
>   * Check rpi_exp_gpio_get_polarity() return value
>   * Remove redundant platform_set_drvdata() call
> 
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
>  drivers/gpio/gpio-raspberrypi-exp.c | 253 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 drivers/gpio/gpio-raspberrypi-exp.c
> 
> ...
> +
> +static int rpi_exp_gpio_probe(struct platform_device *pdev)
> +{
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
> +	return devm_gpiochip_add_data(dev, &rpi_gpio->gc, rpi_gpio);
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

i assume you got the kbuild test robot mail about this. So please remove this and you can add my 

Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

> +		.of_match_table	= of_match_ptr(rpi_exp_gpio_ids),
> +	},
> +	.probe	= rpi_exp_gpio_probe,
> +};
> +module_platform_driver(rpi_exp_gpio_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.org>");
> +MODULE_DESCRIPTION("Raspberry Pi 3 expander GPIO driver");
> +MODULE_ALIAS("platform:rpi-exp-gpio");
> -- 
> 2.15.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
