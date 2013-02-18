From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Feb 2013 10:22:24 +0800
Subject: [PATCH v2 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1360776872-18584-9-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
 <1360776872-18584-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130218022222.GH6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 06:34:32PM +0100, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

You must have something to mention in the commit log when you add
such a new reset controller.

> ---
>  drivers/reset/Kconfig      |   13 +++
>  drivers/reset/Makefile     |    1 +
>  drivers/reset/gpio-reset.c |  188 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 drivers/reset/gpio-reset.c

...

> +static int gpio_reset_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct gpio_reset_data *drvdata;
> +	enum of_gpio_flags flags;
> +	u32 *delays = NULL;
> +	int ret;
> +	int i;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (drvdata == NULL)
> +		return -ENOMEM;
> +
> +	drvdata->nr_gpios = of_gpio_named_count(np, "gpios");

I would suggest to name the property reset-gpios.

All the properties and compatible used in the driver should be
documented in the binding doc.

Shawn

> +	if (drvdata->nr_gpios < 1)
> +		return -EINVAL;
> +
> +	drvdata->gpios = devm_kzalloc(&pdev->dev, sizeof(struct gpio_reset) *
> +			drvdata->nr_gpios, GFP_KERNEL);
> +	if (drvdata->gpios == NULL)
> +		return -ENOMEM;
> +
> +	if (of_find_property(np, "reset-delays", NULL)) {
> +		delays = devm_kzalloc(&pdev->dev, sizeof(u32) *
> +				drvdata->nr_gpios, GFP_KERNEL);
> +		if (delays == NULL)
> +			return -ENOMEM;
> +
> +		ret = of_property_read_u32_array(np, "reset-delays", delays,
> +				drvdata->nr_gpios);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < drvdata->nr_gpios; i++) {
> +		drvdata->gpios[i].gpio = of_get_named_gpio_flags(np, "gpios",
> +				i, &flags);
> +		if (drvdata->gpios[i].gpio < 0) {
> +			dev_err(&pdev->dev, "invalid gpio for reset %d\n", i);
> +			return drvdata->gpios[i].gpio;
> +		}
> +
> +		/*
> +		 * The flags are also used to remember whether a given GPIO
> +		 * reset is active-low.
> +		 */
> +		if (flags & OF_GPIO_ACTIVE_LOW)
> +			drvdata->gpios[i].flags = GPIOF_OUT_INIT_HIGH;
> +		else
> +			drvdata->gpios[i].flags = GPIOF_OUT_INIT_LOW;
> +
> +		ret = devm_gpio_request_one(&pdev->dev, drvdata->gpios[i].gpio,
> +				drvdata->gpios[i].flags, NULL);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to request gpio %d for reset %d\n",
> +					drvdata->gpios[i].gpio, i);
> +			return ret;
> +		}
> +
> +		if (delays != NULL)
> +			drvdata->gpios[i].delay_ms = delays[i];
> +		else
> +			drvdata->gpios[i].delay_ms = -1; /* .reset returns -ENOSYS */
> +	}
> +
> +	devm_kfree(&pdev->dev, delays);
> +
> +	drvdata->rcdev.of_node = np;
> +	drvdata->rcdev.ops = &gpio_reset_ops;
> +	reset_controller_register(&drvdata->rcdev);
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	return 0;
> +}
> +
> +static int gpio_reset_remove(struct platform_device *pdev)
> +{
> +	struct gpio_reset_data *drvdata = platform_get_drvdata(pdev);
> +
> +	reset_controller_unregister(&drvdata->rcdev);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id gpio_reset_dt_ids[] = {
> +	{ .compatible = "gpio-reset" },
> +	{ }
> +};
> +
> +static struct platform_driver gpio_reset_driver = {
> +	.probe = gpio_reset_probe,
> +	.remove = gpio_reset_remove,
> +	.driver = {
> +		.name = "gpio-reset",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(gpio_reset_dt_ids),
> +	},
> +};
> +
> +module_platform_driver(gpio_reset_driver);
> -- 
> 1.7.10.4
> 
