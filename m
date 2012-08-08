From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 09 Aug 2012 11:06:26 +1200
Subject: Platform data from devicetree
Message-ID: <1344467186.6707.6.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quick question regarding platform_devices created from devicetree.

At the moment, we do a of_match_device() against vt8500_gpio_dt_ids[] to
get an of_device_id that contains the .data field to pass into the
driver.

Given that pdev is created from a match against vt8500_gpio_dt_ids[] as
well, why does pdev->dev.of_node.data == NULL? Is this data not
populated into this field? What data can be passed into this field?

Regards

Tony Prisk


Example code below:

static struct of_device_id vt8500_gpio_dt_ids[] = {
	{ .compatible = "via,vt8500-gpio", .data = &vt8500_data, },
	{ .compatible = "wm,wm8505-gpio", .data = &wm8505_data, },
	{ .compatible = "wm,wm8650-gpio", .data = &wm8650_data, },
	{ /* Sentinel */ },
};

static int __devinit vt8500_gpio_probe(struct platform_device *pdev)
{
	void __iomem *gpio_base;
	struct device_node *np;
	const struct of_device_id *of_id =
			of_match_device(vt8500_gpio_dt_ids, &pdev->dev);

	if (!of_id) {
		dev_err(&pdev->dev, "Failed to find gpio controller\n");
		return -ENODEV;
	}

	np = pdev->dev.of_node;
	...
}

static struct platform_driver vt8500_gpio_driver = {
	.probe		= vt8500_gpio_probe,
	.driver		= {
		.name	= "vt8500-gpio",
		.owner	= THIS_MODULE,
		.of_match_table = vt8500_gpio_dt_ids,
	},
};
