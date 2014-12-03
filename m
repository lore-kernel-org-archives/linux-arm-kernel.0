From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 3 Dec 2014 14:13:54 +0200
Subject: [PATCH v3 1/3] video: omapdss: Add opa362 driver
In-Reply-To: <1417352867-7436-2-git-send-email-marek@goldelico.com>
References: <1417352867-7436-1-git-send-email-marek@goldelico.com>
 <1417352867-7436-2-git-send-email-marek@goldelico.com>
Message-ID: <547EFE82.7020701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/11/14 15:07, Marek Belisko wrote:

> +#include <video/omap-panel-data.h>

This should not be needed, as the driver is DT only.

> +static int opa362_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct panel_drv_data *ddata;
> +	struct omap_dss_device *dssdev, *in;
> +	struct gpio_desc *gpio;
> +	int r;
> +
> +	dev_dbg(&pdev->dev, "probe\n");
> +
> +	if (node == NULL) {
> +		dev_err(&pdev->dev, "Unable to find device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	gpio = devm_gpiod_get(&pdev->dev, "enable");
> +	if (IS_ERR(gpio)) {
> +		if (PTR_ERR(gpio) != -ENOENT)
> +			return PTR_ERR(gpio);
> +	} else {
> +		gpiod_direction_output(gpio, 0);
> +	}
> +
> +	ddata->enable_gpio = gpio;

The 'gpio' may be non-null here, if PTR_ERR(gpio) == -ENOENT. You should
set 'gpio' to NULL in the IS_ERR(gpio) path, as you later check the gpio
for NULL.

> +static struct platform_driver opa362_driver = {
> +	.probe	= opa362_probe,
> +	.remove	= __exit_p(opa362_remove),
> +	.driver	= {
> +		.name	= "amplifier-opa362",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = opa362_of_match,
> +	},

Here you should add:

.suppress_bind_attrs = true,

so that the device/driver cannot be unbound via sysfs, as that's not
supported at the moment.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/e1859bb9/attachment.sig>
