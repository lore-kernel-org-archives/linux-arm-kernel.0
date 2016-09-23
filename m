From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 23 Sep 2016 21:00:21 +0200 (CEST)
Subject: [PATCH 2/3] gpio: Add a driver for the Raspberry Pi's firmware
 GPIO calls.
In-Reply-To: <20160919161314.25858-2-eric@anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <20160919161314.25858-2-eric@anholt.net>
Message-ID: <420040015.81512.e9d48a65-997b-4986-a9d0-10632895df40.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 19. September 2016 um 18:13 geschrieben:
> 
> 
> This driver will be used for accessing the FXL6408 GPIO exander on the
> Pi3.  We can't drive it directly from Linux because the firmware is
> continuously polling one of the expander's lines to do its
> undervoltage detection.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> ...
> +
> +static int rpi_gpio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *fw_node;
> +	struct rpi_gpio *rpi;
> +	u32 ngpio;
> +	int ret;
> +
> +	rpi = devm_kzalloc(dev, sizeof *rpi, GFP_KERNEL);
> +	if (!rpi)
> +		return -ENOMEM;
> +	rpi->dev = dev;
> +
> +	fw_node = of_parse_phandle(np, "firmware", 0);

AFAIK fw_node must be freed with of_node_put() after usage

> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	rpi->firmware = rpi_firmware_get(fw_node);
> +	if (!rpi->firmware)
> +		return -EPROBE_DEFER;
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio)) {
> +		dev_err(dev, "Missing ngpios");
> +		return -ENOENT;
> +	}
> +	if (of_property_read_u32(pdev->dev.of_node,
> +				 "raspberrypi,firmware-gpio-offset",
> +				 &rpi->offset)) {
> +		dev_err(dev, "Missing raspberrypi,firmware-gpio-offset");
> +		return -ENOENT;
> +	}
> +
> +	rpi->gc.label = np->full_name;
> +	rpi->gc.owner = THIS_MODULE;
> +	rpi->gc.of_node = np;
> +	rpi->gc.ngpio = ngpio;
> +	rpi->gc.direction_input = rpi_gpio_dir_in;
> +	rpi->gc.direction_output = rpi_gpio_dir_out;
> +	rpi->gc.get = rpi_gpio_get;
> +	rpi->gc.set = rpi_gpio_set;
> +	rpi->gc.can_sleep = true;

i think it's better to assign rpi->gc.base explicit.

Stefan
