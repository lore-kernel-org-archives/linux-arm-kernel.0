From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 09:47:07 +0100
Subject: [PATCH] ARM i.MX6: Fix ethernet PLL clocks
In-Reply-To: <20121122084228.GF24693@S2100-06.ap.freescale.net>
References: <1353505652-28200-1-git-send-email-s.hauer@pengutronix.de>
 <20121122084228.GF24693@S2100-06.ap.freescale.net>
Message-ID: <20121122084707.GA10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 04:42:31PM +0800, Shawn Guo wrote:
> On Wed, Nov 21, 2012 at 02:47:32PM +0100, Sascha Hauer wrote:
> > In current code the ethernet PLL (according to code pll8, according to datasheet
> > pll6)
> 
> Yes, just checked the latest RM, it gets renumbered so.

So do we want to keep current code or change it according to the
datasheet?

> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index 3ec242f..95f8ea5 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -153,7 +153,7 @@ enum mx6q_clks {
> >  	usdhc4, vdo_axi, vpu_axi, cko1, pll1_sys, pll2_bus, pll3_usb_otg,
> >  	pll4_audio, pll5_video, pll6_mlb, pll7_usb_host, pll8_enet, ssi1_ipg,
> >  	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
> > -	clk_max
> > +	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, clk_max
> 
> The clk_max was put on a separate line on purpose, so that you can add
> new ones with + lines only.

Ok, will fix.

> 
> >  };
> >  
> >  static struct clk *clk[clk_max];
> > @@ -163,6 +163,13 @@ static enum mx6q_clks const clks_init_on[] __initconst = {
> >  	mmdc_ch0_axi, rom,
> >  };
> >  
> > +static struct clk_div_table clk_enet_ref_table[] = {
> > +	{ .val = 0, .div = 20, },
> > +	{ .val = 1, .div = 10, },
> > +	{ .val = 2, .div = 5, },
> > +	{ .val = 3, .div = 4, },
> > +};
> > +
> >  int __init mx6q_clocks_init(void)
> >  {
> >  	struct device_node *np;
> > @@ -202,6 +209,15 @@ int __init mx6q_clocks_init(void)
> >  	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 6);
> >  	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 6);
> >  
> > +	clk[sata_ref] = imx_clk_gate("sata_ref", "pll8_enet", base + 0x20, 20);
> > +	clk[pcie_ref] = imx_clk_gate("pcie_ref", "pll8_enet", base + 0x20, 19);
> 
> Offset 0x20 for PLL_ENET?

Indeed, that's wrong. It turned out that my sata disk only worked
because the enet pll had the enable bits for the sata clock in the
gate mask. Will fix that.

> 
> > +	clk[sata_ref_100m] = imx_clk_fixed_factor("sata_ref_100m", "sata_ref", 1, 5);
> > +	clk[pcie_ref_125m] = imx_clk_fixed_factor("pcie_ref_100m", "pcie_ref", 1, 4);
> 
> s/pcie_ref_100m/pcie_ref_125m

ok.

> 
> Also, don't we generally have divider/factor be parent of gate, do we?

Will change.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
