From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 20 Apr 2018 06:57:44 +0000
Subject: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
In-Reply-To: <20180419145725.GX25429@dragon>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <20180419145725.GX25429@dragon>
Message-ID: <AM3PR04MB131538D8AC69E95D1CB48E80F5B40@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, April 19, 2018 10:57 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> robh+dt at kernel.org; mark.rutland at arm.com; linux at armlinux.org.uk;
> mturquette at baylibre.com; sboyd at kernel.org; S.j. Wang
> <shengjiu.wang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-clk at vger.kernel.org
> Subject: Re: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
> 
> On Mon, Mar 19, 2018 at 10:30:44AM +0800, Anson Huang wrote:
> > i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> > And this lvds2, along with lvds1, can be used to provide external
> > clock source to the internal pll, such as pll4_audio and pll5_video.
> >
> > This patch mainly adds the lvds2 to the clock tree and fix its
> > relationship with pll accordingly.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx6sx.c             | 8 ++++++--
> >  include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx6sx.c
> > b/drivers/clk/imx/clk-imx6sx.c index e6d389e..478ad0d 100644
> > --- a/drivers/clk/imx/clk-imx6sx.c
> > +++ b/drivers/clk/imx/clk-imx6sx.c
> > @@ -80,7 +80,7 @@ static const char *lvds_sels[]	= {
> >  	"arm", "pll1_sys", "dummy", "dummy", "dummy", "dummy", "dummy",
> "pll5_video_div",
> >  	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
> > }; -static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in", };
> > +static const char *pll_bypass_src_sels[] = { "osc", "lvds1_in",
> > +"lvds2_in", "dummy", };
> >  static const char *pll1_bypass_sels[] = { "pll1", "pll1_bypass_src",
> > };  static const char *pll2_bypass_sels[] = { "pll2",
> > "pll2_bypass_src", };  static const char *pll3_bypass_sels[] = {
> > "pll3", "pll3_bypass_src", }; @@ -158,8 +158,9 @@ static void __init
> imx6sx_clocks_init(struct device_node *ccm_node)
> >  	clks[IMX6SX_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node, "ipp_di0");
> >  	clks[IMX6SX_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node, "ipp_di1");
> >
> > -	/* Clock source from external clock via CLK1 PAD */
> > +	/* Clock source from external clock via CLK1/2 PAD */
> >  	clks[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clock("anaclk1", 0);
> > +	clks[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clock("anaclk2", 0);
> 
> It seems to me that anaclk clocks are similar to ipp_di, and could be handled in
> the same way as ipp_di clocks.  If that's the case, I would suggest we do the
> following.
> 
> 1. Kill clocks container node by dropping 'reg' property and naming
>    clock nodes uniquely.  This is not strictly related to what we try
>    to do here, but just to address DT maintainers' concern on 'clocks'
>    container node.
> 
> 	clk_ckil: clock-ckil {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <32768>;
> 		clock-output-names = "ckil";
> 	};
> 
> 	clk_osc: clock-osc {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <24000000>;
> 		clock-output-names = "osc";
> 	};
> 
> 	clk_ipp_di0: clock-ipp-di0 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "ipp_di0";
> 	};
> 
> 	clk_ipp_di1: clock-ipp-di1 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "ipp_di1";
> 	};
> 
> 	clks: ccm at 20c4000 {
> 		compatible = "fsl,imx6sx-ccm";
> 		reg = <0x020c4000 0x4000>;
> 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> 		#clock-cells = <1>;
> 		clocks = <&clk_ckil>, <&clk_osc>, <&clk_ipp_di0>, <&clk_ipp_di1>;
> 		clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
> 	};
> 
> 2. Patch clock driver to have anaclk1 and anaclk2 handled in the same
>    way as ipp_di clocks.
> 
> 	clks[IMX6SX_CLK_ANACLK1] = of_clk_get_by_name(ccm_node, "anaclk1");
> 	clks[IMX6SX_CLK_ANACLK2] = of_clk_get_by_name(ccm_node, "anaclk2");
> 
> 3. Add anaclk1 and anaclk2 with clock-frequency being 0 by default, just
>    like ipp_di clocks.
> 
> 	clk_anaclk1: clock-anaclk1 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "anaclk1";
> 	};
> 
> 	clk_anaclk2: clock-anaclk2 {
> 		compatible = "fixed-clock";
> 		#clock-cells = <0>;
> 		clock-frequency = <0>;
> 		clock-output-names = "anaclk2";
> 	};
> 
> 	clks: ccm at 20c4000 {
> 		compatible = "fsl,imx6sx-ccm";
> 		reg = <0x020c4000 0x4000>;
> 		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> 		#clock-cells = <1>;
> 		clocks = <&clk_ckil>, <&clk_osc>,
> 			 <&clk_ipp_di0>, <&clk_ipp_di1>,
> 			 <&clk_anaclk1>, <&clk_anaclk2>;
> 		clock-names = "ckil", "osc",
> 			      "ipp_di0", "ipp_di1",
> 			      "anaclk1", "anaclk2";
> 	};
> 
> 4. Overwrite anaclk2 clock-frequency in imx6sx-sabreauto.dts.
> 
> &clk_anaclk2 {
> 	clock-frequency = <24576000>;
> };
> 
> Please test and let me know whether it works or not.  Thanks.
> 
> Shawn

It is working, see below clk tree dump, I will send a V3 patch, thanks.

Anson. 


root at imx6qpdlsolox:~# cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect
   clock                          count    count    count        rate   accuracy   phase
----------------------------------------------------------------------------------------
 dummy                                3        3        0           0          0 0
    cko1_sel                          0        0        0           0          0 0
       cko1_podf                      0        0        0           0          0 0
          cko1                        0        0        0           0          0 0
             cko                      0        0        0           0          0 0
    usbphy2_gate                      1        1        0           0          0 0
    usbphy1_gate                      1        1        0           0          0 0
 anaclk2                              0        0        0    24576000          0 0
    lvds2_in                          0        0        0    24576000          0 0
 anaclk1                              0        0        0           0          0 0
    lvds1_in                          0        0        0           0          0 0
 ipp_di1                              0        0        0           0          0 0
 ipp_di0                              0        0        0           0          0 0
 osc                                  6        6        0    24000000          0 0

> 
> >
> >  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
> >  	base = of_iomap(np, 0);
> > @@ -228,7 +229,9 @@ static void __init imx6sx_clocks_init(struct
> device_node *ccm_node)
> >  	clks[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_gate("pcie_ref_125m",
> > "pcie_ref", base + 0xe0, 19);
> >
> >  	clks[IMX6SX_CLK_LVDS1_OUT] = imx_clk_gate_exclusive("lvds1_out",
> > "lvds1_sel", base + 0x160, 10, BIT(12));
> > +	clks[IMX6SX_CLK_LVDS2_OUT] = imx_clk_gate_exclusive("lvds2_out",
> > +"lvds2_sel", base + 0x160, 11, BIT(13));
> >  	clks[IMX6SX_CLK_LVDS1_IN]  = imx_clk_gate_exclusive("lvds1_in",
> "anaclk1",   base + 0x160, 12, BIT(10));
> > +	clks[IMX6SX_CLK_LVDS2_IN]  = imx_clk_gate_exclusive("lvds2_in",
> "anaclk2",   base + 0x160, 13, BIT(11));
> >
> >  	clks[IMX6SX_CLK_ENET_REF] = clk_register_divider_table(NULL,
> "enet_ref", "pll6_enet", 0,
> >  			base + 0xe0, 0, 2, 0, clk_enet_ref_table, @@ -270,6 +273,7 @@
> > static void __init imx6sx_clocks_init(struct device_node *ccm_node)
> >
> >  	/*                                                name
> reg           shift   width   parent_names       num_parents */
> >  	clks[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_mux("lvds1_sel",
> base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
> > +	clks[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_mux("lvds2_sel",
> base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
> >
> >  	np = ccm_node;
> >  	base = of_iomap(np, 0);
> > diff --git a/include/dt-bindings/clock/imx6sx-clock.h
> > b/include/dt-bindings/clock/imx6sx-clock.h
> > index 36f0324..cd2d6c5 100644
> > --- a/include/dt-bindings/clock/imx6sx-clock.h
> > +++ b/include/dt-bindings/clock/imx6sx-clock.h
> > @@ -275,6 +275,10 @@
> >  #define IMX6SX_PLL6_BYPASS		262
> >  #define IMX6SX_PLL7_BYPASS		263
> >  #define IMX6SX_CLK_SPDIF_GCLK		264
> > -#define IMX6SX_CLK_CLK_END		265
> > +#define IMX6SX_CLK_LVDS2_SEL		265
> > +#define IMX6SX_CLK_LVDS2_OUT		266
> > +#define IMX6SX_CLK_LVDS2_IN		267
> > +#define IMX6SX_CLK_ANACLK2		268
> > +#define IMX6SX_CLK_CLK_END		269
> >
> >  #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-clk"
> > in the body of a message to majordomo at vger.kernel.org More majordomo
> > info at
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger
> > .kernel.org%2Fmajordomo-info.html&data=02%7C01%7CAnson.Huang%40nx
> p.com
> > %7Cfaec2b0e3f024446b4b908d5a605f71c%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635
> > %7C0%7C0%7C636597466911971203&sdata=YXDSFv3JbKb26ncEJmpf0kUUp1
> DdVY6Fmc
> > utQZW1%2FM8%3D&reserved=0
