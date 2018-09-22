From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Sep 2018 23:55:35 +0800
Subject: [PATCH 21/27] drm/sun4i: Add support for H6 HDMI PHY
In-Reply-To: <20180902072643.4917-22-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-22-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66RqR3pGh+1_rnvMQ4LJaSkKmky9D36tdxQS7cyJb6GYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 3:28 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> H6 has Synopsys DWC HDMI 2.0 TX PHY.
>
> mpll settings were calculated from specifications of similar Synopsys
> HDMI PHY found in i.MX6. Other PHY settings were derived from BSP PHY
> driver code.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 137 +++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> index ee2bf61cd4d2..2f5499bd35ec 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -14,6 +14,122 @@
>   */
>  #define I2C_ADDR       0x69
>
> +static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] = {

How did you choose the pixel clock points for this table? The values
sort of match up with the BSP.

> +       {
> +               30666000, {
> +                       { 0x00b3, 0x0000 },
> +                       { 0x2153, 0x0000 },
> +                       { 0x40f3, 0x0000 },
> +               },
> +       },  {
> +               36800000, {
> +                       { 0x00b3, 0x0000 },
> +                       { 0x2153, 0x0000 },
> +                       { 0x40a2, 0x0001 },
> +               },
> +       },  {
> +               46000000, {
> +                       { 0x00b3, 0x0000 },
> +                       { 0x2142, 0x0001 },
> +                       { 0x40a2, 0x0001 },
> +               },
> +       },  {
> +               61333000, {
> +                       { 0x0072, 0x0001 },
> +                       { 0x2142, 0x0001 },
> +                       { 0x40a2, 0x0001 },
> +               },
> +       },  {
> +               73600000, {
> +                       { 0x0072, 0x0001 },
> +                       { 0x2142, 0x0001 },
> +                       { 0x4061, 0x0002 },
> +               },
> +       },  {
> +               92000000, {
> +                       { 0x0072, 0x0001 },
> +                       { 0x2145, 0x0002 },
> +                       { 0x4061, 0x0002 },
> +               },
> +       },  {
> +               122666000, {
> +                       { 0x0051, 0x0002 },
> +                       { 0x2145, 0x0002 },
> +                       { 0x4061, 0x0002 },
> +               },
> +       },  {
> +               147200000, {
> +                       { 0x0051, 0x0002 },
> +                       { 0x2145, 0x0002 },
> +                       { 0x4064, 0x0003 },
> +               },
> +       },  {
> +               184000000, {
> +                       { 0x0051, 0x0002 },
> +                       { 0x214c, 0x0003 },
> +                       { 0x4064, 0x0003 },
> +               },
> +       },  {
> +               226666000, {
> +                       { 0x0040, 0x0003 },
> +                       { 0x214c, 0x0003 },
> +                       { 0x4064, 0x0003 },
> +               },
> +       },  {
> +               272000000, {
> +                       { 0x0040, 0x0003 },
> +                       { 0x214c, 0x0003 },
> +                       { 0x5a64, 0x0003 },
> +               },
> +       },  {
> +               340000000, {
> +                       { 0x0040, 0x0003 },
> +                       { 0x3b4c, 0x0003 },
> +                       { 0x5a64, 0x0003 },
> +               },
> +       },  {
> +               600000000, {

594000000 is the proper clock rate.

> +                       { 0x1a40, 0x0003 },
> +                       { 0x3b4c, 0x0003 },
> +                       { 0x5a64, 0x0003 },
> +               },
> +       }, {
> +               ~0UL, {
> +                       { 0x0000, 0x0000 },
> +                       { 0x0000, 0x0000 },
> +                       { 0x0000, 0x0000 },
> +               },
> +       }
> +};
> +
> +static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] = {

The BSP sometimes uses different settings depending on the pixel repetition.
Any ideas about this? I assume it's because the TMDS clock changes as a
result of pixel repetition, as is the same with different bit depths.

> +       /* pixelclk    bpp8    bpp10   bpp12 */
> +       { 25175000,  { 0x0000, 0x0000, 0x0000 }, },
> +       { 27000000,  { 0x0012, 0x0000, 0x0000 }, },
> +       { 59400000,  { 0x0008, 0x0008, 0x0008 }, },
> +       { 72000000,  { 0x0008, 0x0008, 0x001b }, },
> +       { 74250000,  { 0x0013, 0x0013, 0x0013 }, },
> +       { 90000000,  { 0x0008, 0x001a, 0x001b }, },
> +       { 118800000, { 0x001b, 0x001a, 0x001b }, },
> +       { 144000000, { 0x001b, 0x001a, 0x0034 }, },
> +       { 180000000, { 0x001b, 0x0033, 0x0034 }, },
> +       { 216000000, { 0x0036, 0x0033, 0x0034 }, },
> +       { 237600000, { 0x0036, 0x0033, 0x001b }, },
> +       { 288000000, { 0x0036, 0x001b, 0x001b }, },
> +       { 297000000, { 0x0019, 0x001b, 0x0019 }, },
> +       { 330000000, { 0x0036, 0x001b, 0x001b }, },
> +       { 600000000, { 0x003f, 0x001b, 0x001b }, },
> +       { ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
> +};
> +
> +static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
> +       /*pixelclk   symbol   term   vlev*/

I see a slightly different setting for 27000000, and this frequency
below 74250000
only, and even different for all three bit depths (not listed here). So:

    { 25175000,  0x8009, 0x0004, 0x0232 },
    { 27000000,  0x8009, 0x0007, 0x02b0 },

And,

> +       { 74250000,  0x8009, 0x0004, 0x0232},
> +       { 148500000, 0x8029, 0x0004, 0x0273},

These two don't match what I see in the BSP. BTW, which table did you use?
phy301 or phy303? The code seems to indicate that model 301 is the one.

> +       { 600000000, 0x8039, 0x0004, 0x014a},

594000000 is the proper pixel clock you're after.

> +       { ~0UL,      0x0000, 0x0000, 0x0000}
> +};
> +
>  static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
>                                       struct sun8i_hdmi_phy *phy,
>                                       unsigned int clk_rate)
> @@ -290,6 +406,16 @@ static void sun8i_hdmi_phy_unlock(struct sun8i_hdmi_phy *phy)
>                      SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
>  }
>
> +static void sun50i_hdmi_phy_init_h6(struct sun8i_hdmi_phy *phy)
> +{
> +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
> +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
> +
> +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> +                          0xffff0000, 0x80c00000);
> +}
> +
>  static void sun8i_hdmi_phy_init_a83t(struct sun8i_hdmi_phy *phy)
>  {
>         sun8i_hdmi_phy_unlock(phy);
> @@ -423,6 +549,13 @@ static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
>         .phy_config = &sun8i_hdmi_phy_config_h3,
>  };
>
> +static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
> +       .cur_ctr  = sun50i_h6_cur_ctr,
> +       .mpll_cfg = sun50i_h6_mpll_cfg,
> +       .phy_cfg  = sun50i_h6_phy_config,
> +       .phy_init = &sun50i_hdmi_phy_init_h6,
> +};
> +
>  static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
>         .is_custom_phy = true,
>         .phy_init = &sun8i_hdmi_phy_init_a83t,
> @@ -443,6 +576,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
>                 .compatible = "allwinner,sun50i-a64-hdmi-phy",
>                 .data = &sun50i_a64_hdmi_phy,
>         },
> +       {
> +               .compatible = "allwinner,sun50i-h6-hdmi-phy",
> +               .data = &sun50i_h6_hdmi_phy,
> +       },

Version sort please.

Regards
ChenYu

>         {
>                 .compatible = "allwinner,sun8i-a83t-hdmi-phy",
>                 .data = &sun8i_a83t_hdmi_phy,
> --
> 2.18.0
>
On Sun, Sep 2, 2018 at 3:28 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> H6 has Synopsys DWC HDMI 2.0 TX PHY.
>
> mpll settings were calculated from specifications of similar Synopsys
> HDMI PHY found in i.MX6. Other PHY settings were derived from BSP PHY
> driver code.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 137 +++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> index ee2bf61cd4d2..2f5499bd35ec 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -14,6 +14,122 @@
>   */
>  #define I2C_ADDR       0x69
>
> +static const struct dw_hdmi_mpll_config sun50i_h6_mpll_cfg[] = {
> +       {
> +               30666000, {
> +                       { 0x00b3, 0x0000 },
> +                       { 0x2153, 0x0000 },
> +                       { 0x40f3, 0x0000 },
> +               },
> +       },  {
> +               36800000, {
> +                       { 0x00b3, 0x0000 },
> +                       { 0x2153, 0x0000 },
> +                       { 0x40a2, 0x0001 },
> +               },
> +       },  {
> +               46000000, {
> +                       { 0x00b3, 0x0000 },
> +                       { 0x2142, 0x0001 },
> +                       { 0x40a2, 0x0001 },
> +               },
> +       },  {
> +               61333000, {
> +                       { 0x0072, 0x0001 },
> +                       { 0x2142, 0x0001 },
> +                       { 0x40a2, 0x0001 },
> +               },
> +       },  {
> +               73600000, {
> +                       { 0x0072, 0x0001 },
> +                       { 0x2142, 0x0001 },
> +                       { 0x4061, 0x0002 },
> +               },
> +       },  {
> +               92000000, {
> +                       { 0x0072, 0x0001 },
> +                       { 0x2145, 0x0002 },
> +                       { 0x4061, 0x0002 },
> +               },
> +       },  {
> +               122666000, {
> +                       { 0x0051, 0x0002 },
> +                       { 0x2145, 0x0002 },
> +                       { 0x4061, 0x0002 },
> +               },
> +       },  {
> +               147200000, {
> +                       { 0x0051, 0x0002 },
> +                       { 0x2145, 0x0002 },
> +                       { 0x4064, 0x0003 },
> +               },
> +       },  {
> +               184000000, {
> +                       { 0x0051, 0x0002 },
> +                       { 0x214c, 0x0003 },
> +                       { 0x4064, 0x0003 },
> +               },
> +       },  {
> +               226666000, {
> +                       { 0x0040, 0x0003 },
> +                       { 0x214c, 0x0003 },
> +                       { 0x4064, 0x0003 },
> +               },
> +       },  {
> +               272000000, {
> +                       { 0x0040, 0x0003 },
> +                       { 0x214c, 0x0003 },
> +                       { 0x5a64, 0x0003 },
> +               },
> +       },  {
> +               340000000, {
> +                       { 0x0040, 0x0003 },
> +                       { 0x3b4c, 0x0003 },
> +                       { 0x5a64, 0x0003 },
> +               },
> +       },  {
> +               600000000, {
> +                       { 0x1a40, 0x0003 },
> +                       { 0x3b4c, 0x0003 },
> +                       { 0x5a64, 0x0003 },
> +               },
> +       }, {
> +               ~0UL, {
> +                       { 0x0000, 0x0000 },
> +                       { 0x0000, 0x0000 },
> +                       { 0x0000, 0x0000 },
> +               },
> +       }
> +};
> +
> +static const struct dw_hdmi_curr_ctrl sun50i_h6_cur_ctr[] = {
> +       /* pixelclk    bpp8    bpp10   bpp12 */
> +       { 25175000,  { 0x0000, 0x0000, 0x0000 }, },
> +       { 27000000,  { 0x0012, 0x0000, 0x0000 }, },
> +       { 59400000,  { 0x0008, 0x0008, 0x0008 }, },
> +       { 72000000,  { 0x0008, 0x0008, 0x001b }, },
> +       { 74250000,  { 0x0013, 0x0013, 0x0013 }, },
> +       { 90000000,  { 0x0008, 0x001a, 0x001b }, },
> +       { 118800000, { 0x001b, 0x001a, 0x001b }, },
> +       { 144000000, { 0x001b, 0x001a, 0x0034 }, },
> +       { 180000000, { 0x001b, 0x0033, 0x0034 }, },
> +       { 216000000, { 0x0036, 0x0033, 0x0034 }, },
> +       { 237600000, { 0x0036, 0x0033, 0x001b }, },
> +       { 288000000, { 0x0036, 0x001b, 0x001b }, },
> +       { 297000000, { 0x0019, 0x001b, 0x0019 }, },
> +       { 330000000, { 0x0036, 0x001b, 0x001b }, },
> +       { 600000000, { 0x003f, 0x001b, 0x001b }, },
> +       { ~0UL,      { 0x0000, 0x0000, 0x0000 }, }
> +};
> +
> +static const struct dw_hdmi_phy_config sun50i_h6_phy_config[] = {
> +       /*pixelclk   symbol   term   vlev*/
> +       { 74250000,  0x8009, 0x0004, 0x0232},
> +       { 148500000, 0x8029, 0x0004, 0x0273},
> +       { 600000000, 0x8039, 0x0004, 0x014a},
> +       { ~0UL,      0x0000, 0x0000, 0x0000}
> +};
> +
>  static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
>                                       struct sun8i_hdmi_phy *phy,
>                                       unsigned int clk_rate)
> @@ -290,6 +406,16 @@ static void sun8i_hdmi_phy_unlock(struct sun8i_hdmi_phy *phy)
>                      SUN8I_HDMI_PHY_UNSCRAMBLE_MAGIC);
>  }
>
> +static void sun50i_hdmi_phy_init_h6(struct sun8i_hdmi_phy *phy)
> +{
> +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
> +                          SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN);
> +
> +       regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
> +                          0xffff0000, 0x80c00000);
> +}
> +
>  static void sun8i_hdmi_phy_init_a83t(struct sun8i_hdmi_phy *phy)
>  {
>         sun8i_hdmi_phy_unlock(phy);
> @@ -423,6 +549,13 @@ static const struct sun8i_hdmi_phy_variant sun50i_a64_hdmi_phy = {
>         .phy_config = &sun8i_hdmi_phy_config_h3,
>  };
>
> +static const struct sun8i_hdmi_phy_variant sun50i_h6_hdmi_phy = {
> +       .cur_ctr  = sun50i_h6_cur_ctr,
> +       .mpll_cfg = sun50i_h6_mpll_cfg,
> +       .phy_cfg  = sun50i_h6_phy_config,
> +       .phy_init = &sun50i_hdmi_phy_init_h6,
> +};
> +
>  static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
>         .is_custom_phy = true,
>         .phy_init = &sun8i_hdmi_phy_init_a83t,
> @@ -443,6 +576,10 @@ static const struct of_device_id sun8i_hdmi_phy_of_table[] = {
>                 .compatible = "allwinner,sun50i-a64-hdmi-phy",
>                 .data = &sun50i_a64_hdmi_phy,
>         },
> +       {
> +               .compatible = "allwinner,sun50i-h6-hdmi-phy",
> +               .data = &sun50i_h6_hdmi_phy,
> +       },
>         {
>                 .compatible = "allwinner,sun8i-a83t-hdmi-phy",
>                 .data = &sun8i_a83t_hdmi_phy,
> --
> 2.18.0
>
