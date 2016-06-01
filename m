From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 02 Jun 2016 01:35:44 +0200
Subject: [PATCH 1/6] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <CAD=FV=V1qX_YTTygsz=v+p6BdG8VZcu8np2nDvm1NiJHDnf==g@mail.gmail.com>
References: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
 <1464328939-8073-2-git-send-email-zyw@rock-chips.com>
 <CAD=FV=V1qX_YTTygsz=v+p6BdG8VZcu8np2nDvm1NiJHDnf==g@mail.gmail.com>
Message-ID: <4995389.1NeJsSFJWj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris, Doug,

Am Dienstag, 31. Mai 2016, 14:35:39 schrieb Doug Anderson:
> > diff --git a/drivers/phy/phy-rockchip-typec.c
> > b/drivers/phy/phy-rockchip-typec.c new file mode 100644
> > index 0000000..6609cfb
> > --- /dev/null
> > +++ b/drivers/phy/phy-rockchip-typec.c
> > @@ -0,0 +1,823 @@

[...]

> > +#define ADDR_ADJ                       2

what purpose does this ADDR_ADJ serve.
It is only used in the big block of defines below, but nowhere else in the 
driver and even the naming does not improve readability as it isn't very 
descriptive. So you could just as well just use "foo << 2" instead of ADDR_ADJ


> > +#define CMN_SSM_BANDGAP                        (0x21 << ADDR_ADJ)
> > +#define CMN_SSM_BIAS                   (0x22 << ADDR_ADJ)
> > +#define CMN_PLLSM0_PLLEN               (0x29 << ADDR_ADJ)
> > +#define CMN_PLLSM0_PLLPRE              (0x2a << ADDR_ADJ)
> > +#define CMN_PLLSM0_PLLVREF             (0x2b << ADDR_ADJ)

[...]

> > +static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy,
> > +                         unsigned int num_lanes)
> > +{
> > +       unsigned int i;()?
> > +
> > +       writel(0x830, tcphy->base + PMA_CMN_CTRL1);
> > +       for (i = 0; i < num_lanes; i++) {
> > +               writel(0x90, tcphy->base + XCVR_DIAG_LANE_FCM_EN_MGN(i));
> > +               writel(0x960, tcphy->base + TX_RCVDET_EN_TMR(i));
> > +               writel(0x30, tcphy->base + TX_RCVDET_ST_TMR(i));
> 
> Would it be too much to ask to get more details about all these magic
> values?

Magic values are generally not well liked and I guess you will probably see a 
request for nicely named constants some more ;-)
Especially, as we also generally want to know that the code in questions 
actually wants to do.


> > +       }
> > +}
> > +
> > +static void tcphy_cfg_usb_pll(struct rockchip_typec_phy *tcphy)
> > +{
> > +       unsigned int rdata;
> > +
> > +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
> > +       writel(rdata & 0xfffc, tcphy->base + CMN_DIAG_HSCLK_SEL);
> > +       writel(0xf0, tcphy->base + CMN_PLL0_VCOCAL_INIT);
> > +       writel(0x18, tcphy->base + CMN_PLL0_VCOCAL_ITER);
> > +       writel(0xd0, tcphy->base + CMN_PLL0_INTDIV);
> > +       writel(0x4a4a, tcphy->base + CMN_PLL0_FRACDIV);
> > +       writel(0x34, tcphy->base + CMN_PLL0_HIGH_THR);
> > +       writel(0x1ee, tcphy->base + CMN_PLL0_SS_CTRL1);
> > +       writel(0x7f03, tcphy->base + CMN_PLL0_SS_CTRL2);
> > +       writel(0x20, tcphy->base + CMN_PLL0_DSM_DIAG);
> > +       writel(0, tcphy->base + CMN_DIAG_PLL0_OVRD);
> > +       writel(0, tcphy->base + CMN_DIAG_PLL0_FBH_OVRD);
> > +       writel(0, tcphy->base + CMN_DIAG_PLL0_FBL_OVRD);
> > +       writel(0x7, tcphy->base + CMN_DIAG_PLL0_V2I_TUNE);
> > +       writel(0x45, tcphy->base + CMN_DIAG_PLL0_CP_TUNE);
> > +       writel(0x8, tcphy->base + CMN_DIAG_PLL0_LF_PROG);

same here and even if these are some super-secret values, this code definitly 
needs some explanation what this is doing and what is the expected result.

Same for all the other blocks of magic values. Named constants preferred but 
at least comments on functionality required.

> > +}

[...]

> > +static int rockchip_typec_phy_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct rockchip_typec_phy *tcphy;
> > +       struct resource *res;
> > +       struct phy_provider *phy_provider;
> > +
> > +       tcphy = devm_kzalloc(dev, sizeof(*tcphy), GFP_KERNEL);
> > +       if (!tcphy)
> > +               return -ENOMEM;
> > +
> > +       tcphy->dev = dev;
> > +       platform_set_drvdata(pdev, tcphy);
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       tcphy->base = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(tcphy->base)) {
> > +               dev_err(dev, "failed to remap phy regs\n");
> > +               return PTR_ERR(tcphy->base);
> > +       }
> > +       tcphy->grf_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +                                                       "rockchip,grf");
> > +       if (IS_ERR(tcphy->grf_regs)) {
> > +               dev_err(dev, "%s: could not find grf dt node\n",
> > __func__);
> > +               return PTR_ERR(tcphy->grf_regs);
> > +       }
> > +
> > +       tcphy->clk_core = of_clk_get_by_name(dev->of_node, "tcpdcore");

this shouldn't be an of_clk_* function. Your clock is defined in the core 
device node, so please use a simple

	tcphy->clk_core = devm_clk_get(&pdev->dev, "tcpdcore");

especially as the code right now lacks a matching clk_put(). The of-variant is 
needed if you get your clock from subnodes, but not when it is defined in the 
core device node.


> > +       if (IS_ERR(tcphy->clk_core)) {
> > +               dev_err(dev, "%s: could not get uphy core clock\n",
> > __func__);
> nit: No real need for __func__.  That's useful to add in when you
> don't have a "dev" pointer and need a "pr_err" to show something that
> will help the user find the right line of code.
> 
> > +               tcphy->clk_core = NULL;
> 
> So is tcpdcore optional or required?  Bindings doc says "required" and
> the "dev_err" above implies required.  ...but then you don't return an
> error code.  That makes it optional.  ...but then you use it
> unconditional elsewhere in this file.  That makes it required.

clk_prepare and clk_enable work with NULL clks just fine (and even return 
sucessful).

> Summary: return an error here, don't just set to NULL.

But the summary is still correct. If the clock is defined as required, the 
driver should fail if it's missing.

> > +       }
> > +
> > +       tcphy->clk_ref = of_clk_get_by_name(dev->of_node, "tcpdphy_ref");
> > +       if (IS_ERR(tcphy->clk_core)) {
> > +               dev_err(dev, "%s: could not get uphy ref clock\n",
> > __func__); +               tcphy->clk_core = NULL;
> 
> "if" test and NULL assignment are for wrong variables.

and all the same remarks as for tcpdcore apply.


Heiko
