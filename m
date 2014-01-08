From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Jan 2014 12:36:45 -0800
Subject: [PATCH v2 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <1389198608-24339-2-git-send-email-hdegoede@redhat.com>
References: <1389198608-24339-1-git-send-email-hdegoede@redhat.com>
 <1389198608-24339-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGVrzcbsvm1MLj0U=jSZRRsorz6XLEoNTv4vhseL4Oq06FDz=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2014/1/8 Hans de Goede <hdegoede@redhat.com>:
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
>  .../devicetree/bindings/usb/platform-ohci.txt      |  25 ++++
>  drivers/usb/host/ohci-platform.c                   | 148 ++++++++++++++++++---
>  2 files changed, 153 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/platform-ohci.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/platform-ohci.txt b/Documentation/devicetree/bindings/usb/platform-ohci.txt
> new file mode 100644
> index 0000000..44bfa57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/platform-ohci.txt

ohci-mmio might be a better name than platform maybe?

[snip]

> +static int ohci_platform_power_on(struct platform_device *dev)
> +{
> +       struct usb_hcd *hcd = platform_get_drvdata(dev);
> +       struct ohci_platform_priv *priv =
> +               (struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
> +       int clk, ret;
> +
> +       for (clk = 0; priv->clks[clk] && clk < OHCI_MAX_CLKS; clk++) {
> +               ret = clk_prepare_enable(priv->clks[clk]);
> +               if (ret)
> +                       goto err_disable_clks;
> +       }

Do we really need to cap this to OHCI_MAX_CLKS, the next driver which
has 4 clocks will have to bump this, so maybe a linked-list would be
best?

> +
> +       if (priv->phy) {
> +               ret = phy_init(priv->phy);
> +               if (ret)
> +                       goto err_disable_clks;
> +
> +               ret = phy_power_on(priv->phy);
> +               if (ret)
> +                       goto err_exit_phy;
> +       }

Although I do value the idea of having DT probing for ohci-platform,
ehci-platform et al, I am not sure if this really belongs in the
generic OHCI platform driver, or if we should rather have small glue
drivers which register the ohci-platform driver and which provides all
the platform-specific power_on, power_off, suspend callbacks to the
ohci platform driver? Such glue driver would be the one which gets
probed based off a specific compatible string a

At first glance it does look like this covers 80% of the existing OHCI
drivers out there, so this is good. We might also want to support
clock pointers provided via platform_data so we can remove ohci-at91,
ohci-ep93xx, ohci-spear and friends in the future.

ohci-ppc-of could also probably be removed once we add quirks and
endian properties parsing to ohci-platform?

> +
> +       return 0;
> +
> +err_exit_phy:
> +       phy_exit(priv->phy);
> +err_disable_clks:
> +       while (--clk >= 0)
> +               clk_disable_unprepare(priv->clks[clk]);
> +
> +       return ret;
> +}
> +
> +static void ohci_platform_power_off(struct platform_device *dev)
> +{
> +       struct usb_hcd *hcd = platform_get_drvdata(dev);
> +       struct ohci_platform_priv *priv =
> +               (struct ohci_platform_priv *)hcd_to_ohci(hcd)->priv;
> +       int clk;
> +
> +       if (priv->phy) {
> +               phy_power_off(priv->phy);
> +               phy_exit(priv->phy);
> +       }
> +
> +       for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
> +               if (priv->clks[clk])
> +                       clk_disable_unprepare(priv->clks[clk]);
> +}
> +
>  static struct hc_driver __read_mostly ohci_platform_hc_driver;
>
>  static const struct ohci_driver_overrides platform_overrides __initconst = {
> -       .product_desc = "Generic Platform OHCI controller",
> -       .reset =        ohci_platform_reset,
> +       .product_desc =         "Generic Platform OHCI controller",
> +       .reset =                ohci_platform_reset,
> +       .extra_priv_size =      sizeof(struct ohci_platform_priv),
> +};
> +
> +static struct usb_ohci_pdata ohci_platform_defaults = {
> +       .power_on =             ohci_platform_power_on,
> +       .power_suspend =        ohci_platform_power_off,
> +       .power_off =            ohci_platform_power_off,
>  };
>
>  static int ohci_platform_probe(struct platform_device *dev)
> @@ -60,12 +128,24 @@ static int ohci_platform_probe(struct platform_device *dev)
>         struct usb_hcd *hcd;
>         struct resource *res_mem;
>         struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
> -       int irq;
> -       int err = -ENOMEM;
> +       int clk, irq, err;
> +       char name[8];
>
> +       /*
> +        * Use reasonable defaults so platforms don't have to provide these
> +        * with DT probing on ARM.
> +        */
>         if (!pdata) {
> -               WARN_ON(1);
> -               return -ENODEV;
> +               pdata = dev->dev.platform_data = &ohci_platform_defaults;
> +               /*
> +                * Right now device-tree probed devices don't get dma_mask set.
> +                * Since shared usb code relies on it, set it here for now.
> +                * Once we have dma capability bindings this can go away.
> +                */
> +               err = dma_coerce_mask_and_coherent(&dev->dev,
> +                                                  DMA_BIT_MASK(32));
> +               if (err)
> +                       return err;
>         }
>
>         if (usb_disabled())
> @@ -83,17 +163,40 @@ static int ohci_platform_probe(struct platform_device *dev)
>                 return -ENXIO;
>         }
>
> +       hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
> +                       dev_name(&dev->dev));
> +       if (!hcd)
> +               return -ENOMEM;
> +
> +       if (pdata == &ohci_platform_defaults) {
> +               struct ohci_platform_priv *priv = (struct ohci_platform_priv *)
> +                                                 hcd_to_ohci(hcd)->priv;
> +
> +               priv->phy = devm_phy_get(&dev->dev, "phy0");

Does this work with a more than one OHCI controller which could
possibly have a dedicated PHY?

> +               if (IS_ERR(priv->phy)) {
> +                       err = PTR_ERR(priv->phy);
> +                       if (err == -EPROBE_DEFER)
> +                               goto err_put_hcd;
> +                       priv->phy = NULL;
> +               }
