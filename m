From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 11 Jan 2014 21:37:40 +1300
Subject: [PATCH v4 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1389393980-21183-2-git-send-email-hdegoede@redhat.com>
References: <1389393980-21183-1-git-send-email-hdegoede@redhat.com>
 <1389393980-21183-2-git-send-email-hdegoede@redhat.com>
Message-ID: <52D102D4.4090302@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/14 11:46, Hans de Goede wrote:
> Add support for ohci-platform instantiation from devicetree, including
> optionally getting clks and a phy from devicetree, and enabling / disabling
> those on power_on / off.
>
> This should allow using ohci-platform from devicetree in various cases.
> Specifically after this commit it can be used for the ohci controller found
> on Allwinner sunxi SoCs.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   .../devicetree/bindings/usb/mmio-ohci.txt          |  22 +++
>   drivers/usb/host/ohci-platform.c                   | 164 ++++++++++++++++++---
>   2 files changed, 162 insertions(+), 24 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/usb/mmio-ohci.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/mmio-ohci.txt b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
> new file mode 100644
> index 0000000..9c776ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
> @@ -0,0 +1,22 @@
> +Generic MMIO OHCI controller
> +
> +Required properties:
> +- compatible : "mmio-ohci"
> +- reg : ohci controller register range (address and length)
> +- interrupts : ohci controller interrupt
> +
> +Optional properties:
> +- clocks : a list of phandle + clock specifier pairs
> +- phys : phandle + phy specifier pair
> +- phy-names : "usb"
> +
> +Example:
> +
> +	ohci0: ohci at 0x01c14400 {
> +		compatible = "mmio-ohci";
> +		reg = <0x01c14400 0x100>;
> +		interrupts = <64>;
> +		clocks = <&usb_clk 6>, <&ahb_gates 2>;
> +		phys = <&usbphy 1>;
> +		phy-names = "usb";
> +	};
>
> ... <snip> ....
>
> @@ -83,17 +156,40 @@ static int ohci_platform_probe(struct platform_device *dev)
>   		return -ENXIO;
>   	}
>   
> +	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
> +			dev_name(&dev->dev));
> +	if (!hcd)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(dev, hcd);
> +	dev->dev.platform_data = pdata;
> +	priv = hcd_to_ohci_priv(hcd);
> +
> +	if (pdata == &ohci_platform_defaults && dev->dev.of_node) {
> +		priv->phy = devm_phy_get(&dev->dev, "usb");
> +		if (IS_ERR(priv->phy)) {
> +			err = PTR_ERR(priv->phy);
> +			if (err == -EPROBE_DEFER)
> +				goto err_put_hcd;
> +			priv->phy = NULL;
> +		}
> +
> +		for (clk = 0; clk < OHCI_MAX_CLKS; clk++) {
> +			priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
> +			if (IS_ERR(priv->clks[clk])) {
> +				err = PTR_ERR(priv->clks[clk]);
> +				if (err == -EPROBE_DEFER)
> +					goto err_put_clks;
> +				priv->clks[clk] = NULL;
> +				break;
> +			}
> +		}
> +	}
>

Given that you have limited the clock parsing to OHCI_MAX_CLKS, there 
should be some kind of warning/error message if the DT contains more 
than OHCI_MAX_CLKS - otherwise you have silent failures when the clocks 
aren't configured.

There is also no note in the binding to indicate this limitation and you 
shouldn't expect people writing DT files to go digging through the 
source to check for this.

Regards
Tony P
