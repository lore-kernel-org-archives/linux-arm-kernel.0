From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 8 Jul 2016 17:04:58 +0800
Subject: [PATCH v2 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <20160707222114.1673-4-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-4-stephen.boyd@linaro.org>
Message-ID: <20160708090458.GB20485@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:20:54PM -0700, Stephen Boyd wrote:
> @@ -39,6 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
>  	struct ulpi *ulpi = to_ulpi_dev(dev);
>  	const struct ulpi_device_id *id;
>  
> +	/* Some ULPI devices don't have a product id so rely on OF match */
> +	if (ulpi->id.product == 0)
> +		return of_driver_match_device(dev, driver);
> +

How about using vendor id? It can't be 0, but pid may be 0.
See: http://www.linux-usb.org/usb.ids

> +static int ulpi_of_register(struct ulpi *ulpi)
> +{
> +	struct device_node *np = NULL, *child;
> +
> +	/* Find a ulpi bus underneath the parent or the parent of the parent */
> +	if (ulpi->dev.parent->of_node)
> +		np = of_find_node_by_name(ulpi->dev.parent->of_node, "ulpi");
> +	else if (ulpi->dev.parent->parent && ulpi->dev.parent->parent->of_node)
> +		np = of_find_node_by_name(ulpi->dev.parent->parent->of_node,
> +					  "ulpi");
> +	if (!np)
> +		return 0;
> +
> +	child = of_get_next_available_child(np, NULL);
> +	if (!child)
> +		return -EINVAL;

You may need to call of_node_put on parent (np), not on child node
below.

> +
> +	ulpi->dev.of_node = child;
> +
> +	return 0;
> +}
> +
> +static int ulpi_read_id(struct ulpi *ulpi)
>  {
>  	int ret;
>  
> @@ -174,14 +218,39 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  	ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
>  	ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
>  
> +	return 0;
> +}
> +

What does this API for? Why it still needs to be called after
vid/pid gets from firmware?

> +static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> +{
> +	int ret;
> +
>  	ulpi->dev.parent = dev;
>  	ulpi->dev.bus = &ulpi_bus;
>  	ulpi->dev.type = &ulpi_dev_type;
>  	dev_set_name(&ulpi->dev, "%s.ulpi", dev_name(dev));
>  
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		ret = ulpi_of_register(ulpi);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ACPI_COMPANION_SET(&ulpi->dev, ACPI_COMPANION(dev));
>  
> -	request_module("ulpi:v%04xp%04x", ulpi->id.vendor, ulpi->id.product);
> +	ret = device_property_read_u16(&ulpi->dev, "ulpi-vendor",
> +				       &ulpi->id.vendor);
> +	ret |= device_property_read_u16(&ulpi->dev, "ulpi-product",
> +					&ulpi->id.product);
> +	if (ret) {
> +		ret = ulpi_read_id(ulpi);
> +		if (ret)
> +			return ret;
> +	}
> +
[...]

>  void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
> +	of_node_put(ulpi->dev.of_node);

[...]

-- 

Best Regards,
Peter Chen
