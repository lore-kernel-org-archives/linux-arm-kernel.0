From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 29 Aug 2014 18:33:31 +0800
Subject: [RFC PATCH 1/2] ARM: imx: add BYPASS support for PLL clocks
In-Reply-To: <20140829093236.GA503@audiosh1>
References: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
 <1409067313-32063-2-git-send-email-shawn.guo@freescale.com>
 <20140828084420.GG28777@dragon> <20140829014947.GA2741@audiosh1>
 <20140829025349.GH28777@dragon> <20140829033344.GA2910@audiosh1>
 <20140829084125.GB3135@dragon> <20140829093236.GA503@audiosh1>
Message-ID: <20140829103328.GA13258@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 05:32:40PM +0800, Shengjiu Wang wrote:
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index 6692115b0138..9fe4169c79dd 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -268,8 +268,18 @@
> >                                 };
> > 
> >                                 esai: esai at 02024000 {
> > +                                       compatible = "fsl,imx6q-esai", "fsl,imx35-esai";
> >                                         reg = <0x02024000 0x4000>;
> >                                         interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
> > +                                       clocks = <&clks IMX6QDL_CLK_ESAI_IPG>,
> > +                                                <&clks IMX6QDL_CLK_ESAI_EXTAL>,
> > +                                                <&clks IMX6QDL_CLK_ESAI_IPG>;
> > +                                       clock-names = "core", "extal", "fsys";
> > +                                       dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
> > +                                       dma-names = "rx", "tx";
> > +                                       fsl,fifo-depth = <128>;
> > +                                       fsl,esai-synchronous;
> we alway don't set fsl,fifo-depth and fsl,esai-synchronous, just use the
> default value in driver.

Okay.  The change here is just to get ESAI driver probed, so that the
assigned-clocks in ESAI node can be handled.  I suppose you will send me
a patch to get ESAI node ready for working.

> > +                                       status = "disabled";
> >                                 };
> > 
> >                                 ssi1: ssi at 02028000 {
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > index 009abd69385d..1084394197ad 100644
> > --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> > @@ -17,6 +17,14 @@
> >                 reg = <0x10000000 0x80000000>;
> >         };
> > 
> > +       clocks {
> > +               anaclk2 { /* on-board 24.576MHz audio oscillator */
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <24576000>;
> > +               };
> > +       };
> > +
> >         leds {
> >                 compatible = "gpio-leds";
> >                 pinctrl-names = "default";
> > @@ -45,6 +53,17 @@
> >         };
> >  };
> > 
> > +&clks {
> > +       assigned-clocks = <&clks IMX6QDL_PLL4_BYPASS_SRC>,
> > +                         <&clks IMX6QDL_PLL4_BYPASS>,
> > +                         <&clks IMX6QDL_CLK_ESAI_SEL>,
> > +                         <&clks IMX6QDL_CLK_PLL4_POST_DIV>;
> > +       assigned-clock-parents = <&clks IMX6QDL_CLK_LVDS2_IN>,
> > +                                <&clks IMX6QDL_PLL4_BYPASS_SRC>,
> > +                                <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
> > +       assigned-clock-rates = <0>, <0>, <0>, <24576000>;
> > +};
> > +
> >  &ecspi1 {
> >         fsl,spi-num-chipselects = <1>;
> >         cs-gpios = <&gpio3 19 0>;
> > @@ -61,6 +80,12 @@
> >         };
> >  };
> > 
> > +&esai {
> > +       assigned-clocks = <&clks IMX6QDL_CLK_ESAI_EXTAL>;
> > +       assigned-clock-rates = <24576000>;
> > +       status = "okay";
> > +};
> > +
> 
> Can we move the clocks for &esai to &clks ? I just think that will look better.
> Anyway, this is just my view. you can do it follow the formal principle.

The general principle is that clocks used by multiple clients like bus
clock and pll are configured in &clk node, and leaf clocks only used by
particular client device should be configured in that device node.

Shawn
