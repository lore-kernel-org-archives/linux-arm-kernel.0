From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 14:57:21 -0700
Subject: [PATCH v3 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1361273732-23357-9-git-send-email-p.zabel@pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
 <1361273732-23357-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <5123F541.4020407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 04:35 AM, Philipp Zabel wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.

> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.txt b/Documentation/devicetree/bindings/reset/gpio-reset.txt

> +Required properties:

> +- reset-delays: List of delays in ms. The corresponding gpio reset line is
> +                asserted for this duration to reset.

mS are quite long. Would it make sense for this property to be uS instead?

> diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c

> +static int gpio_reset_probe(struct platform_device *pdev)

> +	if (of_find_property(np, "reset-delays", NULL)) {
> +		delays = devm_kzalloc(&pdev->dev, sizeof(u32) *
> +				drvdata->nr_gpios, GFP_KERNEL);
> +		if (delays == NULL)
> +			return -ENOMEM;

It'd be nice if there were something like of_property_read_u32_index()
so you could read each value one-by-one in the loop later on, rather
than dynamically allocating this temporarily.

> +		ret = of_property_read_u32_array(np, "reset-delays", delays,
> +				drvdata->nr_gpios);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < drvdata->nr_gpios; i++) {
> +		drvdata->gpios[i].gpio = of_get_named_gpio_flags(np,
> +				"reset-gpios", i, &flags);
> +		if (drvdata->gpios[i].gpio < 0) {
> +			dev_err(&pdev->dev, "invalid gpio for reset %d\n", i);

It's not an error if the value is -EPROBE_DEFERRED; you might want to
explicitly check for that case and not print anything?

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

That raises the question: What is the initial reset state expected to
be? Some devices might want to stay in reset until their driver
explicitly removes the reset signal.

We could handle that by adding another (optional) property indicating
the initial reset state of each GPIO; default to initially not-in-reset
unless that property exists and specifies initially-in-reset.

> +		ret = devm_gpio_request_one(&pdev->dev, drvdata->gpios[i].gpio,
> +				drvdata->gpios[i].flags, NULL);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to request gpio %d for reset %d\n",
> +					drvdata->gpios[i].gpio, i);
> +			return ret;
> +		}

Perhaps first loop to look up all the GPIOs and initialize data
structures, then loop to request the GPIOs? That'd prevent lots of HW
programming and de-programming for the GPIOs near the start of the list,
in the case where some later GPIO causes -EPROBE_DEFERRED, and so this
probe() function keeps getting executed over and over.

> +		if (delays != NULL)
> +			drvdata->gpios[i].delay_ms = delays[i];
> +		else
> +			drvdata->gpios[i].delay_ms = -1; /* .reset returns -ENOSYS */

(here is where of_property_read_u32_index() might be handy)

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

You might want to add a few things like MODULE_AUTHOR,
MODULE_DESCRIPTION,  MODULE_LICENSE,
MODULE_DEVICE_TABLE(of, gpio_reset_dt_ids), perhaps MODULE_ALIAS for the
platform device too.
