From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 16 Nov 2015 10:36:02 +0800
Subject: [linux-sunxi] [PATCH 1/5] clk: sunxi: Add support for the H3 usb
 phy clocks
In-Reply-To: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65x5z4Svn+PAmm1W6xZKxP0iFjCodeA0xbf0VLxx5qiWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 3:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> From: Reinder de Haan <patchesrdh@mveas.com>
>
> The H3 has a usb-phy clk register which is similar to that of earlier
> SoCs, but with support for a larger number of phys. So we can simply add
> a new set of clk-data and a new compatible and be done with it.
>
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-usb.c                       | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index d303dec..23e7bce 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -70,6 +70,7 @@ Required properties:
>         "allwinner,sun5i-a13-usb-clk" - for usb gates + resets on A13
>         "allwinner,sun6i-a31-usb-clk" - for usb gates + resets on A31
>         "allwinner,sun8i-a23-usb-clk" - for usb gates + resets on A23
> +       "allwinner,sun8i-h3-usb-clk" - for usb gates + resets on H3
>         "allwinner,sun9i-a80-usb-mod-clk" - for usb gates + resets on A80
>         "allwinner,sun9i-a80-usb-phy-clk" - for usb phy gates + resets on A80
>
> diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
> index 1a72cd6..67b8e38 100644
> --- a/drivers/clk/sunxi/clk-usb.c
> +++ b/drivers/clk/sunxi/clk-usb.c
> @@ -243,3 +243,15 @@ static void __init sun9i_a80_usb_phy_setup(struct device_node *node)
>         sunxi_usb_clk_setup(node, &sun9i_a80_usb_phy_data, &a80_usb_phy_lock);
>  }
>  CLK_OF_DECLARE(sun9i_a80_usb_phy, "allwinner,sun9i-a80-usb-phy-clk", sun9i_a80_usb_phy_setup);
> +
> +static const struct usb_clk_data sun8i_h3_usb_clk_data __initconst = {
> +       .clk_mask =  BIT(19) | BIT(18) | BIT(17) | BIT(16) |
> +                    BIT(11) | BIT(10) | BIT(9) | BIT(8),
> +       .reset_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
> +};
> +
> +static void __init sun8i_h3_usb_setup(struct device_node *node)
> +{
> +       sunxi_usb_clk_setup(node, &sun8i_h3_usb_clk_data, &sun4i_a10_usb_lock);
> +}
> +CLK_OF_DECLARE(sun8i_h3_usb, "allwinner,sun8i-h3-usb-clk", sun8i_h3_usb_setup);
> --
> 2.5.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
