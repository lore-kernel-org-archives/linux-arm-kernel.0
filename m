From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Jun 2013 13:28:34 +0200
Subject: [PATCH 1/3] usb: chipidea: add CSR SiRFSoC ci13xxx usb driver
In-Reply-To: <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
 <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <11238795.iUF0RmU8ZP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013 11:25:36 Barry Song wrote:
> From: Rong Wang <Rong.Wang@csr.com>
> 
> CSR SiRF SoCs licensed chipidea ci13xxx USB IP, this patch
> makes the chipidea drivers support CSR SiRF SoCS.
> 
> It also changes the Kconfig, only compile MSM and IMX if related
> drivers are enabled. Otherwise, we always need to enable all
> clients of chipidea drivers.

Can't you use the same driver as for imx and make it more generic?
I don't actually see anything in here that is really specific to SiRF
and most of the code is the same as for imx.

If there are bits that are truly SiRF specific, at least that can
be a much smaller part I think.

> +#define RSC_USB_UART_SHARE	0x0
> +#define USB1_MODE_SEL		BIT(2)
> +#define pdev_to_phy(pdev)	((struct usb_phy *)platform_get_drvdata(pdev))
> +
> +static int sirfsoc_vbus_gpio;

What do you need static data for? This seems like a bad idea because it
makes it impossible to support multiple such devices.

> +struct ci13xxx_sirf_data {
> +	struct platform_device	*ci_pdev;
> +	struct clk		*clk;
> +};
> +
> +static inline int ci13xxx_sirf_drive_vbus(int value)
> +{
> +	return gpio_direction_output(sirfsoc_vbus_gpio, value ? 0 : 1);
> +}
> +
> +static void ci13xxx_sirf_notify_event(struct ci13xxx *ci, unsigned event)
> +{
> +	switch (event) {
> +	case CI13XXX_CONTROLLER_RESET_EVENT:
> +		ci13xxx_sirf_drive_vbus(1);
> +		break;
> +	case CI13XXX_CONTROLLER_STOPPED_EVENT:
> +		ci13xxx_sirf_drive_vbus(0);
> +		break;
> +	default:
> +		dev_info(ci->dev, "Unknown Event\n");
> +		break;
> +	}
> +}
> +
> +static struct ci13xxx_platform_data ci13xxx_sirf_platdata = {
> +	.name			= "ci13xxx_sirf",
> +	.flags			= CI13XXX_DISABLE_STREAMING,
> +	.capoffset		= DEF_CAPOFFSET,
> +	.notify_event		= ci13xxx_sirf_notify_event,
> +};
> +
> +static struct of_device_id rsc_ids[] = {
> +	{ .compatible = "sirf,prima2-rsc", },
> +	{ /* sentinel */ }
> +};

This is the reset controller, right? You already use the reset API
below, why do you need to open-code the gpio

> +static int ci13xxx_sirf_probe(struct platform_device *pdev)
> +{
> +	struct platform_device *plat_ci, *phy_pdev;
> +	struct device_node *rsc_np, *phy_np;
> +	struct ci13xxx_sirf_data *data;
> +	struct usb_phy *phy;
> +	void __iomem *rsc_vbase;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		dev_err(&pdev->dev, "Failed to allocate ci13xxx_sirf_data!\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* 1. set usb controller clock */
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		dev_err(&pdev->dev,
> +			"Failed to get clock, err=%ld\n", PTR_ERR(data->clk));
> +		return PTR_ERR(data->clk);
> +	}
> +	ret = clk_prepare_enable(data->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Failed to prepare or enable clock, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* 2. software reset */
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		dev_info(&pdev->dev,
> +			"Failed to reset device, err=%d\n", ret);
> +
> +	/* 3. vbus configuration */
> +	sirfsoc_vbus_gpio = of_get_named_gpio(pdev->dev.of_node,
> +							"vbus-gpios", 0);
> +	if (sirfsoc_vbus_gpio < 0) {
> +		dev_err(&pdev->dev, "Can't get vbus gpio from DT\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	ret = gpio_request(sirfsoc_vbus_gpio, "ci13xxx_sirf");
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get gpio control\n");
> +		goto err;
> +	}
> +

This seems totally generic so far, better put it into a common file.

> +	/* 4. rsc control */
> +	rsc_np = of_find_matching_node(NULL, rsc_ids);
> +	if (!rsc_np) {
> +		dev_err(&pdev->dev, "Failed to get rsc device node\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	rsc_vbase = of_iomap(rsc_np, 0);
> +	if (!rsc_vbase) {
> +		dev_err(&pdev->dev, "Failed to iomap rsc memory\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	writel(readl(rsc_vbase + RSC_USB_UART_SHARE) | USB1_MODE_SEL,
> +					rsc_vbase + RSC_USB_UART_SHARE);

And this seems out of place.

> +	/* 6. get phy for controller */
> +	phy_np = of_parse_phandle(pdev->dev.of_node, "sirf,ci13xxx-usbphy", 0);
> +	if (!phy_np) {
> +		dev_err(&pdev->dev, "Failed to get phy device node\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}

I think "sirf,ci13xxx-usbphy" is a particularly bad identifier for the
phy here. Please have a look at the generic phy binding that is being
proposed.

> +static const struct of_device_id ci13xxx_sirf_dt_ids[] = {
> +	{ .compatible = "sirf,ci13xxx-usbcontroller", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ci13xxx_sirf_dt_ids);

Please take the 'xxx' strings out of the 'compatible' string and use
the specific device you are doing this for. If there are multiple
ones, you can either list all of them or ensure they are all marked
as compatible with the original design.

	Arnd
