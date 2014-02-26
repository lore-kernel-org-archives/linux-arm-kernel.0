From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Feb 2014 23:12:04 +0800
Subject: [linux-sunxi] [PATCH v3 1/4] ARM: sunxi: Add driver for sunxi usb
 phy
In-Reply-To: <1393157352-21104-2-git-send-email-hdegoede@redhat.com>
References: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
 <1393157352-21104-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v64Gg6QKn4KRXQ2uGR_rFb1mFD1fgzN_6MJDnLuv_JYf6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 23, 2014 at 8:09 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The Allwinner A1x / A2x SoCs have 2 or 3 usb phys which are all accessed
> through a single set of registers. Besides this there are also some other
> phy related bits which need poking, which are per phy, but shared between the
> ohci and ehci controllers, so these are also controlled from this new phy
> driver.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  26 ++
>  drivers/phy/Kconfig                                |  11 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-sun4i-usb.c                        | 329 +++++++++++++++++++++
>  4 files changed, 367 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>  create mode 100644 drivers/phy/phy-sun4i-usb.c
>
[..]
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> new file mode 100644
> index 0000000..31c4611
> --- /dev/null
> +++ b/drivers/phy/phy-sun4i-usb.c
[..]
> +static int sun4i_usb_phy_probe(struct platform_device *pdev)
> +{
> +       struct sun4i_usb_phy_data *data;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       void __iomem *pmu = NULL;
> +       struct phy_provider *phy_provider;
> +       struct reset_control *reset;
> +       struct regulator *vbus;
> +       struct resource *res;
> +       struct phy *phy;
> +       char name[16];
> +       int i;
> +
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       mutex_init(&data->mutex);
> +
> +       if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy"))
> +               data->num_phys = 2;
> +       else
> +               data->num_phys = 3;
> +
> +       if (of_device_is_compatible(np, "allwinner,sun4i-a10-usb-phy"))
> +               data->disc_thresh = 3;
> +       else
> +               data->disc_thresh = 2;
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
> +       data->base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(data->base))
> +               return PTR_ERR(data->base);
> +
> +       data->clk = devm_clk_get(dev, "usb_phy");
> +       if (IS_ERR(data->clk)) {
> +               dev_err(dev, "could not get usb_phy clock\n");
> +               return PTR_ERR(data->clk);
> +       }
> +
> +       /* Skip 0, 0 is the phy for otg which is not yet supported. */
> +       for (i = 1; i < data->num_phys; i++) {
> +               snprintf(name, sizeof(name), "usb%d_vbus", i);
> +               vbus = devm_regulator_get_optional(dev, name);
> +               if (IS_ERR(vbus)) {
> +                       if (PTR_ERR(vbus) == -EPROBE_DEFER)
> +                               return -EPROBE_DEFER;
> +                       vbus = NULL;
> +               }
> +
> +               snprintf(name, sizeof(name), "usb%d_reset", i);
> +               reset = devm_reset_control_get(dev, name);
> +               if (IS_ERR(reset)) {

I got around to rebasing my musb tree. I see you fixed the reset
control error path. You got one.

> +                       dev_err(dev, "failed to get reset %s\n", name);
> +                       return PTR_ERR(phy);

But you missed one here. And phy is uninitialized until later,
so this will break big time.


Cheers
ChenYu

> +               }
> +
> +               if (i) { /* No pmu for usbc0 */
> +                       snprintf(name, sizeof(name), "pmu%d", i);
> +                       res = platform_get_resource_byname(pdev,
> +                                                       IORESOURCE_MEM, name);
> +                       pmu = devm_ioremap_resource(dev, res);
> +                       if (IS_ERR(pmu))
> +                               return PTR_ERR(pmu);
> +               }
> +
> +               phy = devm_phy_create(dev, &sun4i_usb_phy_ops, NULL);
> +               if (IS_ERR(phy)) {
> +                       dev_err(dev, "failed to create PHY %d\n", i);
> +                       return PTR_ERR(phy);
> +               }
> +
> +               data->phys[i].phy = phy;
> +               data->phys[i].pmu = pmu;
> +               data->phys[i].vbus = vbus;
> +               data->phys[i].reset = reset;
> +               data->phys[i].index = i;
> +               phy_set_drvdata(phy, &data->phys[i]);
> +       }
> +
> +       dev_set_drvdata(dev, data);
> +       phy_provider = devm_of_phy_provider_register(dev, sun4i_usb_phy_xlate);
> +       if (IS_ERR(phy_provider))
> +               return PTR_ERR(phy_provider);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sun4i_usb_phy_of_match[] = {
> +       { .compatible = "allwinner,sun4i-a10-usb-phy" },
> +       { .compatible = "allwinner,sun5i-a13-usb-phy" },
> +       { .compatible = "allwinner,sun7i-a20-usb-phy" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> +
> +static struct platform_driver sun4i_usb_phy_driver = {
> +       .probe  = sun4i_usb_phy_probe,
> +       .driver = {
> +               .of_match_table = sun4i_usb_phy_of_match,
> +               .name  = "sun4i-usb-phy",
> +               .owner = THIS_MODULE,
> +       }
> +};
> +module_platform_driver(sun4i_usb_phy_driver);
> +
> +MODULE_DESCRIPTION("Allwinner sun4i USB phy driver");
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/groups/opt_out.
