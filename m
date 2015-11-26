From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Nov 2015 12:22:59 +0800
Subject: [PATCH v3 1/2] phy-sun4i-usb: Use of_match_node to get model
 specific config data
In-Reply-To: <1448470202-3628-1-git-send-email-hdegoede@redhat.com>
References: <1448470202-3628-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v64XL=bptxoCwiVkf8u-EfckpuASS3Foo=Q3i4a_6CaJYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 12:50 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Use of_match_node instead of calling of_device_is_compatible a ton of
> times to get model specific config data.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> -New patch in v3 of this patch-set
> ---
>  drivers/phy/phy-sun4i-usb.c | 130 +++++++++++++++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index b12964b..1d8f85d 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -88,12 +88,22 @@
>  #define DEBOUNCE_TIME                  msecs_to_jiffies(50)
>  #define POLL_TIME                      msecs_to_jiffies(250)
>
> +enum sun4i_usb_phy_type {
> +       sun4i_a10_phy,
> +       sun8i_a33_phy,
> +};
> +
> +struct sun4i_usb_phy_cfg {
> +       int num_phys;
> +       u32 disc_thresh;
> +       enum sun4i_usb_phy_type type;
> +       bool dedicated_clocks;
> +};
> +
>  struct sun4i_usb_phy_data {
>         void __iomem *base;
> +       const struct sun4i_usb_phy_cfg *cfg;
>         struct mutex mutex;
> -       int num_phys;
> -       u32 disc_thresh;
> -       bool has_a33_phyctl;
>         struct sun4i_usb_phy {
>                 struct phy *phy;
>                 void __iomem *pmu;
> @@ -164,12 +174,15 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
>
>         mutex_lock(&phy_data->mutex);
>
> -       if (phy_data->has_a33_phyctl) {
> +       switch (phy_data->cfg->type) {
> +       case sun4i_a10_phy:
> +               phyctl = phy_data->base + REG_PHYCTL_A10;

Any reason why this offset isn't incorporated into phy_data?

> +               break;
> +       case sun8i_a33_phy:
>                 phyctl = phy_data->base + REG_PHYCTL_A33;
>                 /* A33 needs us to set phyctl to 0 explicitly */
>                 writel(0, phyctl);
> -       } else {
> -               phyctl = phy_data->base + REG_PHYCTL_A10;
> +               break;
>         }
>
>         for (i = 0; i < len; i++) {
> @@ -249,7 +262,8 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>         sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
>
>         /* Disconnect threshold adjustment */
> -       sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL, data->disc_thresh, 2);
> +       sun4i_usb_phy_write(phy, PHY_DISCON_TH_SEL,
> +                           data->cfg->disc_thresh, 2);
>
>         sun4i_usb_phy_passby(phy, 1);
>
> @@ -476,7 +490,7 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
>  {
>         struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
>
> -       if (args->args[0] >= data->num_phys)
> +       if (args->args[0] >= data->cfg->num_phys)
>                 return ERR_PTR(-ENODEV);
>
>         return data->phys[args->args[0]].phy;
> @@ -499,6 +513,59 @@ static int sun4i_usb_phy_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
> +       .num_phys = 3,
> +       .disc_thresh = 3,
> +       .type = sun4i_a10_phy,
> +       .dedicated_clocks = false,
> +};
> +
> +static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
> +       .num_phys = 2,
> +       .disc_thresh = 2,
> +       .type = sun4i_a10_phy,
> +       .dedicated_clocks = false,
> +};
> +
> +static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
> +       .num_phys = 3,
> +       .disc_thresh = 3,
> +       .type = sun4i_a10_phy,
> +       .dedicated_clocks = true,
> +};
> +
> +static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
> +       .num_phys = 3,
> +       .disc_thresh = 2,
> +       .type = sun4i_a10_phy,
> +       .dedicated_clocks = false,
> +};
> +
> +static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
> +       .num_phys = 2,
> +       .disc_thresh = 3,
> +       .type = sun4i_a10_phy,
> +       .dedicated_clocks = true,
> +};
> +
> +static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
> +       .num_phys = 2,
> +       .disc_thresh = 3,
> +       .type = sun8i_a33_phy,
> +       .dedicated_clocks = true,
> +};
> +
> +static const struct of_device_id sun4i_usb_phy_of_match[] = {
> +       { .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
> +       { .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
> +       { .compatible = "allwinner,sun6i-a31-usb-phy", .data = &sun6i_a31_cfg },
> +       { .compatible = "allwinner,sun7i-a20-usb-phy", .data = &sun7i_a20_cfg },
> +       { .compatible = "allwinner,sun8i-a23-usb-phy", .data = &sun8i_a23_cfg },
> +       { .compatible = "allwinner,sun8i-a33-usb-phy", .data = &sun8i_a33_cfg },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> +
>  static const unsigned int sun4i_usb_phy0_cable[] = {
>         EXTCON_USB,
>         EXTCON_USB_HOST,
> @@ -511,10 +578,16 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         struct phy_provider *phy_provider;
> -       bool dedicated_clocks;
> +       const struct of_device_id *match;
>         struct resource *res;
>         int i, ret;
>
> +       match = of_match_node(sun4i_usb_phy_of_match, dev->of_node);

You can use of_device_get_match_data() for slightly less code. This
will also let you keep the of_device_id table where it was, at the
bottom.

> +       if (!match) {

I'm working on something similar in the axp20x driver. Is there any
case of_match_node or of_device_get_match_data can fail?


Regards
ChenYu

> +               dev_err(dev, "of_match_node() failed\n");
> +               return -EINVAL;
> +       }
> +
>         data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>         if (!data)
>                 return -ENOMEM;
> @@ -522,29 +595,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>         mutex_init(&data->mutex);
>         INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
>         dev_set_drvdata(dev, data);
> -
> -       if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy") ||
> -           of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy") ||
> -           of_device_is_compatible(np, "allwinner,sun8i-a33-usb-phy"))
> -               data->num_phys = 2;
> -       else
> -               data->num_phys = 3;
> -
> -       if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy") ||
> -           of_device_is_compatible(np, "allwinner,sun7i-a20-usb-phy"))
> -               data->disc_thresh = 2;
> -       else
> -               data->disc_thresh = 3;
> -
> -       if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy") ||
> -           of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy") ||
> -           of_device_is_compatible(np, "allwinner,sun8i-a33-usb-phy"))
> -               dedicated_clocks = true;
> -       else
> -               dedicated_clocks = false;
> -
> -       if (of_device_is_compatible(np, "allwinner,sun8i-a33-usb-phy"))
> -               data->has_a33_phyctl = true;
> +       data->cfg = match->data;
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
>         data->base = devm_ioremap_resource(dev, res);
> @@ -590,7 +641,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       for (i = 0; i < data->num_phys; i++) {
> +       for (i = 0; i < data->cfg->num_phys; i++) {
>                 struct sun4i_usb_phy *phy = data->phys + i;
>                 char name[16];
>
> @@ -602,7 +653,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>                         phy->vbus = NULL;
>                 }
>
> -               if (dedicated_clocks)
> +               if (data->cfg->dedicated_clocks)
>                         snprintf(name, sizeof(name), "usb%d_phy", i);
>                 else
>                         strlcpy(name, "usb_phy", sizeof(name));
> @@ -689,17 +740,6 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id sun4i_usb_phy_of_match[] = {
> -       { .compatible = "allwinner,sun4i-a10-usb-phy" },
> -       { .compatible = "allwinner,sun5i-a13-usb-phy" },
> -       { .compatible = "allwinner,sun6i-a31-usb-phy" },
> -       { .compatible = "allwinner,sun7i-a20-usb-phy" },
> -       { .compatible = "allwinner,sun8i-a23-usb-phy" },
> -       { .compatible = "allwinner,sun8i-a33-usb-phy" },
> -       { },
> -};
> -MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> -
>  static struct platform_driver sun4i_usb_phy_driver = {
>         .probe  = sun4i_usb_phy_probe,
>         .remove = sun4i_usb_phy_remove,
> --
> 2.5.0
>
