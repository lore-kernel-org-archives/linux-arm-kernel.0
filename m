From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jan 2014 19:07:16 +0100
Subject: [PATCH v3 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
References: <1389290226-6971-1-git-send-email-hdegoede@redhat.com>
 <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
Message-ID: <4432391.5QkdBVBQQi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014 18:57:05 Hans de Goede wrote:
> +       if (pdata == &ohci_platform_defaults && dev->dev.of_node) {
> +               priv->phy = devm_phy_get(&dev->dev, "usb");
> +               if (IS_ERR(priv->phy)) {
> +                       err = PTR_ERR(priv->phy);
> +                       if (err == -EPROBE_DEFER)
> +                               goto err_put_hcd;
> +                       priv->phy = NULL;
> +               }
> +
> +               for (clk = 0; clk < OHCI_MAX_CLKS; clk++) {
> +                       priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
> +                       if (IS_ERR(priv->clks[clk])) {
> +                               err = PTR_ERR(priv->clks[clk]);
> +                               if (err == -EPROBE_DEFER)
> +                                       goto err_put_clks;
> +                               priv->clks[clk] = NULL;
> +                               break;
> +                       }
> +               }
> +       }

Ah, very nice! This way it will actually work to replace a number
of older drivers that require a specific clock name.

I still think we should change the phy subsystem to allow the
same, that would make it more consistent here, and avoid the
need for coming up with a number of bogus phy names for random
drivers that can only ever have one phy.

	Arnd
