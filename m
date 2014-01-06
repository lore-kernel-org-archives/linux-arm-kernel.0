From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Jan 2014 08:16:02 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
References: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
Message-ID: <201401060816.02998.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014, Hans de Goede wrote:
> +Required properties:
> + - compatible: Should be "platform-ohci"
> + - reg: Address range of the ohci registers.
> + - interrupts: Should contain the ohci interrupt.
> +
> +Optional properties:
> + - clocks: array of clocks
> + - clock-names: clock names "ahb" and/or "ohci"
> + - phys: phy
> + - phy-names: "usb_phy"

Maybe just "usb"? It obviously is a phy, so that part of the name
is a bit redundant. Actually, the "usb" part of the name also seems
redundant. Is it possible to make it an anonymous phy reference
without a phy-names property as we often do for clocks?

> +static int ohci_platform_power_on(struct platform_device *dev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(dev);
> +	struct ohci_platform_priv *priv =
> +		(struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
> +	int ret;
> +
> +	if (!IS_ERR(priv->ohci_clk)) {
> +		ret = clk_prepare_enable(priv->ohci_clk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!IS_ERR(priv->ahb_clk)) {
> +		ret = clk_prepare_enable(priv->ahb_clk);
> +		if (ret)
> +			goto err_disable_ohci_clk;
> +	}
> +
> +	if (!IS_ERR(priv->phy)) {
> +		ret = phy_init(priv->phy);
> +		if (ret)
> +			goto err_disable_ahb_clk;
> +
> +		ret = phy_power_on(priv->phy);
> +		if (ret)
> +			goto err_exit_phy;
> +	}

Style-wise, I think I'd prefer not storing error values in the
ohci_platform_priv struct, but rather using NULL pointers for
when the clocks or phy references are unused.

> @@ -83,17 +171,30 @@ static int ohci_platform_probe(struct platform_device *dev)
>  		return -ENXIO;
>  	}
>  
> +	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
> +			dev_name(&dev->dev));
> +	if (!hcd)
> +		return -ENOMEM;
> +
> +	if (pdata == &ohci_platform_defaults) {
> +		struct ohci_platform_priv *priv = (struct ohci_platform_priv *)
> +						  hcd_to_ohci(hcd)->priv;
> +
> +		priv->phy = devm_phy_get(&dev->dev, "usb_phy");
> +		if (IS_ERR(priv->phy) && PTR_ERR(priv->phy) == -EPROBE_DEFER) {
> +			err = -EPROBE_DEFER;
> +			goto err_put_hcd;
> +		}
> +
> +		priv->ohci_clk = devm_clk_get(&dev->dev, "ohci");
> +		priv->ahb_clk = devm_clk_get(&dev->dev, "ahb");
> +	}

I think you have to check the clocks for -EPROBE_DEFER as well here, not
just the PHY. Otherwise you don't know the difference between "no clock
provided", "error getting the clock reference" and "clock controller not
initialized yet, try again".

> @@ -178,6 +277,12 @@ static int ohci_platform_resume(struct device *dev)
>  #define ohci_platform_resume	NULL
>  #endif /* CONFIG_PM */
>  
> +static const struct of_device_id ohci_platform_ids[] = {
> +	{ .compatible = "platform-ohci", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ohci_platform_ids);

I never liked the "platform-*" naming for compatible properties, the
name of the driver is just based on a linux implementation detail
(the platform bus), which could change. How about just calling the
generic one "ohci" or "usb-ohci"?

	Arnd
