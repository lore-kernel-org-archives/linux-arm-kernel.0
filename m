From: dtor@chromium.org (Dmitry Torokhov)
Date: Mon, 9 Feb 2015 11:20:13 -0800
Subject: [PATCH v8 2/4] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <1423070463-24483-3-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423070463-24483-1-git-send-email-rjui@broadcom.com>
 <1423070463-24483-3-git-send-email-rjui@broadcom.com>
Message-ID: <20150209191951.GA15709@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ray,

On Wed, Feb 04, 2015 at 09:21:01AM -0800, Ray Jui wrote:
> +static int cygnus_gpio_pinmux_add_range(struct cygnus_gpio *chip)
> +{
> +	struct device_node *node = chip->dev->of_node;
> +	struct device_node *pinmux_node;
> +	struct platform_device *pinmux_pdev;
> +	struct gpio_chip *gc = &chip->gc;
> +	int i, ret;
> +
> +	/* parse DT to find the phandle to the pinmux controller */
> +	pinmux_node = of_parse_phandle(node, "pinmux", 0);
> +	if (!pinmux_node)
> +		return -ENODEV;
> +
> +	pinmux_pdev = of_find_device_by_node(pinmux_node);
> +	if (!pinmux_pdev) {
> +		dev_err(chip->dev, "failed to get pinmux device\n");
> +		return -EINVAL;
> +	}
> +
> +	/* now need to create the mapping between local GPIO and PINMUX pins */
> +	for (i = 0; i < ARRAY_SIZE(cygnus_gpio_pintable); i++) {
> +		ret = gpiochip_add_pin_range(gc, dev_name(&pinmux_pdev->dev),
> +					     cygnus_gpio_pintable[i].offset,
> +					     cygnus_gpio_pintable[i].pin_base,
> +					     cygnus_gpio_pintable[i].num_pins);
> +		if (ret) {
> +			dev_err(chip->dev, "unable to add GPIO pin range\n");
> +			goto err_put_device;
> +		}
> +	}
> +
> +	chip->pinmux_is_supported = true;
> +
> +	/* no need for pinmux_pdev device reference anymore */
> +	put_device(&pinmux_pdev->dev);

Sorry I did not notice it before, but of_parse_phandle() takes reference
to the returned device node, so you need to "put" it here and in error
path as well. Actually you can do:

	int ret = 0;

	pinmux_node = of_parse_phandle(node, "pinmux", 0);
	if (!pinmux_node)
		return -ENODEV;

	pinmux_pdev = of_find_device_by_node(pinmux_node);
	/* We do not longer need pinmux node */
	of_node_put(pinmux_node);

	if (!pinmux_dev)
		....

	for (..) {
		...
		if (ret) {
			dev_err(...);
			break;
		}
	}

	chip->pinmux_is_supported = (ret == 0);
	put_device(..);
	return ret;
}

This way you free resources in the same path.

...

> +
> +static struct platform_driver cygnus_gpio_driver = {
> +	.driver = {
> +		.name = "cygnus-gpio",
> +		.of_match_table = cygnus_gpio_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = cygnus_gpio_probe,
> +};
> +
> +static int __init cygnus_gpio_init(void)
> +{
> +	return platform_driver_probe(&cygnus_gpio_driver, cygnus_gpio_probe);

When I asked you to add ".suppress_bind_attrs = true" I missed the fact
that you were using platform_driver_probe() which already does this
internally. However platform_driver_probe() can't handle deferred
probing, which may or may not be OK. Is there a chance that any of the
resources needed by the driver return -EPROBE_DEFER? If not then it is
safe to continue using platform_driver_probe() and you can drop
suppress_bind_attrs assignment, otherwise it may be better to switch to
platform_driver_register().

Thanks.

-- 
Dmitry
