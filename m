From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 20 Jun 2016 15:59:19 +0800
Subject: [v2 PATCH 2/4] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <CAAFQd5BFC3wh4hYWiyyc2b8Pn5VM1jr3jZyD0MJJKCvejsjz1g@mail.gmail.com>
References: <1465810789-22303-1-git-send-email-zyw@rock-chips.com>
 <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
 <CAAFQd5BFC3wh4hYWiyyc2b8Pn5VM1jr3jZyD0MJJKCvejsjz1g@mail.gmail.com>
Message-ID: <5767A257.3000303@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz

Thanks for your comments.
I will modify all the the part of snip. Please find my reply in the 
following.

On 06/18/2016 12:06 AM, Tomasz Figa wrote:
> Hi Chris,
>
>
> [snip]
>
>> +struct phy_reg {
>> +       int value;
>> +       int addr;
>> +};
>> +
>> +struct phy_reg usb_pll_cfg[] = {
>> +       {0xf0,          CMN_PLL0_VCOCAL_INIT},
> CodingStyle: Please add spaces after opening and before closing braces.
>
>> +       {0x18,          CMN_PLL0_VCOCAL_ITER},
>> +       {0xd0,          CMN_PLL0_INTDIV},
>> +       {0x4a4a,        CMN_PLL0_FRACDIV},
>> +       {0x34,          CMN_PLL0_HIGH_THR},
>> +       {0x1ee,         CMN_PLL0_SS_CTRL1},
>> +       {0x7f03,        CMN_PLL0_SS_CTRL2},
>> +       {0x20,          CMN_PLL0_DSM_DIAG},
>> +       {0,             CMN_DIAG_PLL0_OVRD},
>> +       {0,             CMN_DIAG_PLL0_FBH_OVRD},
>> +       {0,             CMN_DIAG_PLL0_FBL_OVRD},
>> +       {0x7,           CMN_DIAG_PLL0_V2I_TUNE},
>> +       {0x45,          CMN_DIAG_PLL0_CP_TUNE},
>> +       {0x8,           CMN_DIAG_PLL0_LF_PROG},
> It would be generally much, much better if these magic numbers were
> dissected into particular bitfields and defined using macros, if
> possible... The same applies to all other magic numbers in this file.
This magic number is very hard to describe, it is a initialization 
sequence from vendor.
Their names are very close to the description.
 From spec of cdn type-c phy:
Iteration wait timer value
pll_fb_div_integer value: Value of the pll_fb_div_integer signal.
pll_fb_div_fractional: Value of the pll_fb_div_fractional signal.
pll_fb_div_high_theshold: Value of the pll_fb_div_high_threshold signal.
...

>> +};
>> +
>> +struct phy_reg dp_pll_cfg[] = {
> [snip]
>> +static void tcphy_cfg_usb_pll(struct rockchip_typec_phy *tcphy)
>> +{
>> +       u32 rdata;
>> +       u32 i;
>> +
>> +       /*
>> +        * Selects which PLL clock will be driven on the analog high speed
>> +        * clock 0: PLL 0 div 1.
>> +        */
>> +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
>> +       writel(rdata & 0xfffc, tcphy->base + CMN_DIAG_HSCLK_SEL);
> This mask looks suspiciously. Is clearing bits 31-16 and 1-0 what we
> want here? I'd advise for manipulating the value in separate line and
> then only calling writel() with the final value already in the
> variable.
Yes, the register valid length is 16 bits, but the they are stored with 
32bit.
readl will return 0 in higher 16bit + valid value in lower 16bit.
and writel will ignore the higher 16bit.


>
>> +
>> +       /* load the configuration of PLL0 */
>> +       for (i = 0; i < ARRAY_SIZE(usb_pll_cfg); i++)
>> +               writel(usb_pll_cfg[i].value, tcphy->base + usb_pll_cfg[i].addr);
>> +}
>> +
>> +static void tcphy_cfg_dp_pll(struct rockchip_typec_phy *tcphy)
>> +{
>> +       u32 rdata;
>> +       u32 i;
>> +
>> +       /* set the default mode to RBR */
>> +       writel(DP_PLL_CLOCK_ENABLE | DP_PLL_ENABLE | DP_PLL_DATA_RATE_RBR,
>> +              tcphy->base + DP_CLK_CTL);
> This looks (and is understandable) much better than magic numbers in
> other parts of this file!
>
>> +
>> +       /*
>> +        * Selects which PLL clock will be driven on the analog high speed
>> +        * clock 1: PLL 1 div 2.
>> +        */
>> +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
>> +       rdata = (rdata & 0xffcf) | 0x30;
> If the & operation here is used to clear a bitfield, please use the
> negative notation, e.g.
>
> rdata &= ~0x30;
> rdata |= 0x30;
>
> (By the way, the AND NOT and OR with the same value is what the code
> above does, which would make sense if the bitfield mask was defined by
> a macro, but doesn't make any sense with magic numbers.)
>
> It looks like the registers are 16-bit. Should they really be accessed
> with readl() and not readw()? If they are accessed with readl(), what
> is returned in most significant 16 bits and what should be written
> there?
I will use macro here at next version
>
>> +       writel(rdata, tcphy->base + CMN_DIAG_HSCLK_SEL);
>> +
>> +       /* load the configuration of PLL1 */
>> +       for (i = 0; i < ARRAY_SIZE(dp_pll_cfg); i++)
>> +               writel(dp_pll_cfg[i].value, tcphy->base + dp_pll_cfg[i].addr);
>> +}
> [snip]
>> +       }
>> +
>> +       ret = clk_prepare_enable(tcphy->clk_ref);
>> +       if (ret) {
>> +               dev_err(tcphy->dev, "Failed to prepare_enable ref clock\n");
>> +               goto clk_ref_failed;
>> +       }
> [snip]
>> +static void tcphy_phy_deinit(struct rockchip_typec_phy *tcphy)
>> +{
>> +       clk_disable_unprepare(tcphy->clk_core);
>> +       clk_disable_unprepare(tcphy->clk_ref);
>> +}
>> +
>> +static const struct phy_ops rockchip_tcphy_ops = {
>> +       .owner          = THIS_MODULE,
> Hmm, if there is no phy ops, how the phy consumer drivers request the
> PHY to do anything?
There is no consumer call this phy, the power on and power off are 
called by notification.
So I am going to delete this ops next version.
>> +};
>> +
>> +static int tcphy_pd_event(struct notifier_block *nb,
>> +                         unsigned long event, void *priv)
>> +{
> [snip]
>> +static int tcphy_get_param(struct device *dev,
>> +                          struct usb3phy_reg *reg,
>> +                          const char *name)
>> +{
>> +       int ret, buffer[3];
> Shouldn't buffer be u32[3]?
>
>> +
>> +       ret = of_property_read_u32_array(dev->of_node, name, buffer, 3);
>> +       if (ret) {
>> +               dev_err(dev, "Can not parse %s\n", name);
>> +               return ret;
>> +       }
> [snip]
>> diff --git a/include/linux/phy/phy-rockchip-typec.h b/include/linux/phy/phy-rockchip-typec.h
>> new file mode 100644
>> index 0000000..acdd8cb
>> --- /dev/null
>> +++ b/include/linux/phy/phy-rockchip-typec.h
>> @@ -0,0 +1,20 @@
>> +#ifndef PHY_ROCKCHIP_TYPEC_H_
>> +#define PHY_ROCKCHIP_TYPEC_H_
>> +
>> +#define PIN_MAP_A      BIT(0)
>> +#define PIN_MAP_B      BIT(1)
>> +#define PIN_MAP_C      BIT(2)
>> +#define PIN_MAP_D      BIT(3)
>> +#define PIN_MAP_E      BIT(4)
>> +#define PIN_MAP_F      BIT(5)
>> +
>> +#define SET_PIN_MAP(x) (((x) & 0xff) << 24)
>> +#define SET_FLIP(x)    (((x) & 0xff) << 16)
>> +#define SET_DFP(x)     (((x) & 0xff) << 8)
>> +#define SET_PLUGGED(x) ((x) & 0xff)
>> +#define GET_PIN_MAP(x) (((x) >> 24) & 0xff)
>> +#define GET_FLIP(x)    (((x) >> 16) & 0xff)
>> +#define GET_DFP(x)     (((x) >> 8) & 0xff)
>> +#define GET_PLUGGED(x) ((x) & 0xff)
> Who is the user of the definitions in this header?
The type-c phy, Dp controller and Power delivery are the user.
Power delivery set the state and send the notification
type-c phy and Dp contoller get the state.


> Best regards,
> Tomasz
>
>
>
