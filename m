From: tfiga@chromium.org (Tomasz Figa)
Date: Sat, 18 Jun 2016 01:06:47 +0900
Subject: [v2 PATCH 2/4] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
References: <1465810789-22303-1-git-send-email-zyw@rock-chips.com>
 <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
Message-ID: <CAAFQd5BFC3wh4hYWiyyc2b8Pn5VM1jr3jZyD0MJJKCvejsjz1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Mon, Jun 13, 2016 at 6:39 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> Type-C PHY is designed to support the USB3 and DP applications. The
> PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> HBR2 data rates.

Please see my comments inline.

[snip]

> diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
> new file mode 100644
> index 0000000..230e074
> --- /dev/null
> +++ b/drivers/phy/phy-rockchip-typec.c
> @@ -0,0 +1,952 @@
[snip]
> +
> +#define XCVR_PSM_RCTRL(n)              ((0x4001 | (n << 9)) << 2)

It's not very safe to not have parentheses around the macro argument
dereference. Please add to all macros, such as below:

#define XCVR_PSM_RCTRL(n)              ((0x4001 | ((n) << 9)) << 2)

> +#define XCVR_PSM_CAL_TMR(n)            ((0x4002 | (n << 9)) << 2)
> +#define XCVR_PSM_A0IN_TMR(n)           ((0x4003 | (n << 9)) << 2)
> +#define TX_TXCC_CAL_SCLR_MULT(n)       ((0x4047 | (n << 9)) << 2)
> +#define TX_TXCC_CPOST_MULT_00(n)       ((0x404c | (n << 9)) << 2)
> +#define TX_TXCC_CPOST_MULT_01(n)       ((0x404d | (n << 9)) << 2)
> +#define TX_TXCC_CPOST_MULT_10(n)       ((0x404e | (n << 9)) << 2)
> +#define TX_TXCC_CPOST_MULT_11(n)       ((0x404f | (n << 9)) << 2)
[snip]
> +#define PHY_MODE_SET_TIMEOUT           1000000
> +
> +#define        MODE_DISCONNECT                 0
> +#define        MODE_UFP_USB                    BIT(0)
> +#define        MODE_DFP_USB                    BIT(1)
> +#define        MODE_DFP_DP                     BIT(2)

CodingStyle: Why is there a tab between #define and name?

> +
> +struct usb3phy_reg {
> +       u32     offset;
> +       u32     enable_bit;
> +       u32     write_enable;

CodingStyle: I believe it's generally preferable to just use a single
space between type and name. Also applies to other structs in this
file.

> +};
> +
> +struct rockchip_usb3phy_port_cfg {
> +       struct usb3phy_reg      typec_conn_dir;
> +       struct usb3phy_reg      usb3tousb2_en;
[snip]
> +struct phy_reg {
> +       int value;
> +       int addr;
> +};
> +
> +struct phy_reg usb_pll_cfg[] = {
> +       {0xf0,          CMN_PLL0_VCOCAL_INIT},

CodingStyle: Please add spaces after opening and before closing braces.

> +       {0x18,          CMN_PLL0_VCOCAL_ITER},
> +       {0xd0,          CMN_PLL0_INTDIV},
> +       {0x4a4a,        CMN_PLL0_FRACDIV},
> +       {0x34,          CMN_PLL0_HIGH_THR},
> +       {0x1ee,         CMN_PLL0_SS_CTRL1},
> +       {0x7f03,        CMN_PLL0_SS_CTRL2},
> +       {0x20,          CMN_PLL0_DSM_DIAG},
> +       {0,             CMN_DIAG_PLL0_OVRD},
> +       {0,             CMN_DIAG_PLL0_FBH_OVRD},
> +       {0,             CMN_DIAG_PLL0_FBL_OVRD},
> +       {0x7,           CMN_DIAG_PLL0_V2I_TUNE},
> +       {0x45,          CMN_DIAG_PLL0_CP_TUNE},
> +       {0x8,           CMN_DIAG_PLL0_LF_PROG},

It would be generally much, much better if these magic numbers were
dissected into particular bitfields and defined using macros, if
possible... The same applies to all other magic numbers in this file.

> +};
> +
> +struct phy_reg dp_pll_cfg[] = {
[snip]
> +static void tcphy_cfg_usb_pll(struct rockchip_typec_phy *tcphy)
> +{
> +       u32 rdata;
> +       u32 i;
> +
> +       /*
> +        * Selects which PLL clock will be driven on the analog high speed
> +        * clock 0: PLL 0 div 1.
> +        */
> +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       writel(rdata & 0xfffc, tcphy->base + CMN_DIAG_HSCLK_SEL);

This mask looks suspiciously. Is clearing bits 31-16 and 1-0 what we
want here? I'd advise for manipulating the value in separate line and
then only calling writel() with the final value already in the
variable.

> +
> +       /* load the configuration of PLL0 */
> +       for (i = 0; i < ARRAY_SIZE(usb_pll_cfg); i++)
> +               writel(usb_pll_cfg[i].value, tcphy->base + usb_pll_cfg[i].addr);
> +}
> +
> +static void tcphy_cfg_dp_pll(struct rockchip_typec_phy *tcphy)
> +{
> +       u32 rdata;
> +       u32 i;
> +
> +       /* set the default mode to RBR */
> +       writel(DP_PLL_CLOCK_ENABLE | DP_PLL_ENABLE | DP_PLL_DATA_RATE_RBR,
> +              tcphy->base + DP_CLK_CTL);

This looks (and is understandable) much better than magic numbers in
other parts of this file!

> +
> +       /*
> +        * Selects which PLL clock will be driven on the analog high speed
> +        * clock 1: PLL 1 div 2.
> +        */
> +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       rdata = (rdata & 0xffcf) | 0x30;

If the & operation here is used to clear a bitfield, please use the
negative notation, e.g.

rdata &= ~0x30;
rdata |= 0x30;

(By the way, the AND NOT and OR with the same value is what the code
above does, which would make sense if the bitfield mask was defined by
a macro, but doesn't make any sense with magic numbers.)

It looks like the registers are 16-bit. Should they really be accessed
with readl() and not readw()? If they are accessed with readl(), what
is returned in most significant 16 bits and what should be written
there?

> +       writel(rdata, tcphy->base + CMN_DIAG_HSCLK_SEL);
> +
> +       /* load the configuration of PLL1 */
> +       for (i = 0; i < ARRAY_SIZE(dp_pll_cfg); i++)
> +               writel(dp_pll_cfg[i].value, tcphy->base + dp_pll_cfg[i].addr);
> +}
[snip]
> +static inline int property_enable(struct rockchip_typec_phy *tcphy,
> +                                 const struct usb3phy_reg *reg, bool en)
> +{
> +       int mask = 1 << reg->write_enable;
> +       int val = en << reg->enable_bit;

A signed int is not really a good data type to store register values
in. Please use a fixed size unsigned data type with size matching the
registers, e.g. u32 or u16.

> +
> +       return regmap_write(tcphy->grf_regs, reg->offset, val | mask);
> +}
[snip]
> +       /*
> +        * Controls auxda_polarity, which selects the polarity of the xcvr
> +        * 1'b1 : Reverses the polarity (If TYPEC, Pulls ups aux_p and pull
> +        * down aux_m)
> +        * 1'b0 : Normal polarity (if TYPE_C, pulls up aux_m and pulls down
> +        * aux_p)
> +        */
> +       if (tcphy->flip)
> +               writel(0xa078, tcphy->base + TX_ANA_CTRL_REG_1);
> +       else
> +               writel(0xb078, tcphy->base + TX_ANA_CTRL_REG_1);

nit: IMHO it would be a bit more readable if done like this:

val = 0xa078; // Or proper bitfield definitions ORed together...
if (!tcphy->flip)
    val |= BIT(12); // Or proper bitfield macro...
writel(val, tcphy->base + TX_ANA_CTRL_REG1);

> +
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_3);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_4);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_5);
[snip]
> +       ret = clk_set_rate(tcphy->clk_core, 50000000);
> +       if (ret) {
> +               dev_err(tcphy->dev, "set type-c phy core clk rate failed\n");
> +               goto clk_ref_failed;

CodingStyle: The convention is to name the labels after the clean-up
step that is done at them, e.g. err_clk_core.

> +       }
> +
> +       ret = clk_prepare_enable(tcphy->clk_ref);
> +       if (ret) {
> +               dev_err(tcphy->dev, "Failed to prepare_enable ref clock\n");
> +               goto clk_ref_failed;
> +       }
[snip]
> +static void tcphy_phy_deinit(struct rockchip_typec_phy *tcphy)
> +{
> +       clk_disable_unprepare(tcphy->clk_core);
> +       clk_disable_unprepare(tcphy->clk_ref);
> +}
> +
> +static const struct phy_ops rockchip_tcphy_ops = {
> +       .owner          = THIS_MODULE,

Hmm, if there is no phy ops, how the phy consumer drivers request the
PHY to do anything?

> +};
> +
> +static int tcphy_pd_event(struct notifier_block *nb,
> +                         unsigned long event, void *priv)
> +{
[snip]
> +static int tcphy_get_param(struct device *dev,
> +                          struct usb3phy_reg *reg,
> +                          const char *name)
> +{
> +       int ret, buffer[3];

Shouldn't buffer be u32[3]?

> +
> +       ret = of_property_read_u32_array(dev->of_node, name, buffer, 3);
> +       if (ret) {
> +               dev_err(dev, "Can not parse %s\n", name);
> +               return ret;
> +       }
[snip]
> diff --git a/include/linux/phy/phy-rockchip-typec.h b/include/linux/phy/phy-rockchip-typec.h
> new file mode 100644
> index 0000000..acdd8cb
> --- /dev/null
> +++ b/include/linux/phy/phy-rockchip-typec.h
> @@ -0,0 +1,20 @@
> +#ifndef PHY_ROCKCHIP_TYPEC_H_
> +#define PHY_ROCKCHIP_TYPEC_H_
> +
> +#define PIN_MAP_A      BIT(0)
> +#define PIN_MAP_B      BIT(1)
> +#define PIN_MAP_C      BIT(2)
> +#define PIN_MAP_D      BIT(3)
> +#define PIN_MAP_E      BIT(4)
> +#define PIN_MAP_F      BIT(5)
> +
> +#define SET_PIN_MAP(x) (((x) & 0xff) << 24)
> +#define SET_FLIP(x)    (((x) & 0xff) << 16)
> +#define SET_DFP(x)     (((x) & 0xff) << 8)
> +#define SET_PLUGGED(x) ((x) & 0xff)
> +#define GET_PIN_MAP(x) (((x) >> 24) & 0xff)
> +#define GET_FLIP(x)    (((x) >> 16) & 0xff)
> +#define GET_DFP(x)     (((x) >> 8) & 0xff)
> +#define GET_PLUGGED(x) ((x) & 0xff)

Who is the user of the definitions in this header?

Best regards,
Tomasz
