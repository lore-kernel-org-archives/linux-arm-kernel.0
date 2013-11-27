From: george.cherian@ti.com (George Cherian)
Date: Wed, 27 Nov 2013 14:49:54 +0530
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
 <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
Message-ID: <5295B93A.3040400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 1:46 AM, WingMan Kwok wrote:
> Add Keystone platform specific glue layer to support
> USB3 Host mode.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>   drivers/usb/dwc3/Kconfig         |    7 +
>   drivers/usb/dwc3/Makefile        |    1 +
>   drivers/usb/dwc3/dwc3-keystone.c |  272 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 280 insertions(+)
>   create mode 100644 drivers/usb/dwc3/dwc3-keystone.c

<snip>
> +	error = of_platform_populate(node, NULL, NULL, dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to create dwc3 core\n");
> +		goto err_core;
> +	}
> +
> +	return 0;
> +
> +err_core:
> +	kdwc3_disable_irqs(kdwc);
> +err_irq:
> +	kdwc3_disable(kdwc);
> +
> +	return error;
> +}
> +
> +static int kdwc3_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
> +
> +	if (kdwc) {
> +		kdwc3_disable_irqs(kdwc);
> +		kdwc3_disable(kdwc);
> +		platform_set_drvdata(pdev, NULL);
> +	}
> +	return 0;
> +}
> +

You need to unregister the child nodes in remove.
Also why can't the dwc3-omap driver be reused, Felipe??
I believe the TI wrapper for Keystone is similar to that of AM437x or 
OMAP5.
> +static const struct of_device_id kdwc3_of_match[] = {
> +	{ .compatible = "ti,keystone-dwc3", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, kdwc3_of_match);
> +
> +static struct platform_driver kdwc3_driver = {
> +	.probe		= kdwc3_probe,
> +	.remove		= kdwc3_remove,
> +	.driver		= {
> +		.name	= "keystone-dwc3",
> +		.owner	        = THIS_MODULE,
> +		.of_match_table	= kdwc3_of_match,
> +	},
> +};
> +
> +module_platform_driver(kdwc3_driver);
> +
> +MODULE_ALIAS("platform:keystone-dwc3");
> +MODULE_AUTHOR("WingMan Kwok <w-kwok2@ti.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("DesignWare USB3 KEYSTONE Glue Layer");


-- 
-George
