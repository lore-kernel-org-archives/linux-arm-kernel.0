From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Fri, 29 Aug 2014 17:32:40 +0800
Subject: [RFC PATCH 1/2] ARM: imx: add BYPASS support for PLL clocks
In-Reply-To: <20140829084125.GB3135@dragon>
References: <1409067313-32063-1-git-send-email-shawn.guo@freescale.com>
 <1409067313-32063-2-git-send-email-shawn.guo@freescale.com>
 <20140828084420.GG28777@dragon> <20140829014947.GA2741@audiosh1>
 <20140829025349.GH28777@dragon> <20140829033344.GA2910@audiosh1>
 <20140829084125.GB3135@dragon>
Message-ID: <20140829093236.GA503@audiosh1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> On Fri, Aug 29, 2014 at 11:33:47AM +0800, Shengjiu Wang wrote:
> > Otherwise I still need to do some step in below to source the clock to ESAI.
> > 
> >         clk_set_parent(pll4_bypass_src, lvds2_in);
> >         clk_set_parent(pll4_bypass, pll4_bypass_src);
> >         clk_set_rate(pll4_audio_div, 24576000);
> >         clk_set_rate(esai_extal, 24576000);
> > 
> > I think it is what we can expect, right? if yes, the patch is ok for ESAI.
> 
> Yes, we still need to set up parent and rate specifically for
> sabreauto ESAI use case.
> 
> But these setup can be done in device tree now with commit 86be408bfbd8
> (clk: Support for clock parents and rates assigned from device tree).
> Here is change that I tested with.  (Not sure if the info in esai node
> is all correct)
> 
Great. Thanks.

> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 6692115b0138..9fe4169c79dd 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -268,8 +268,18 @@
>                                 };
> 
>                                 esai: esai at 02024000 {
> +                                       compatible = "fsl,imx6q-esai", "fsl,imx35-esai";
>                                         reg = <0x02024000 0x4000>;
>                                         interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clks IMX6QDL_CLK_ESAI_IPG>,
> +                                                <&clks IMX6QDL_CLK_ESAI_EXTAL>,
> +                                                <&clks IMX6QDL_CLK_ESAI_IPG>;
> +                                       clock-names = "core", "extal", "fsys";
> +                                       dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
> +                                       dma-names = "rx", "tx";
> +                                       fsl,fifo-depth = <128>;
> +                                       fsl,esai-synchronous;
we alway don't set fsl,fifo-depth and fsl,esai-synchronous, just use the
default value in driver.
> +                                       status = "disabled";
>                                 };
> 
>                                 ssi1: ssi at 02028000 {
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 009abd69385d..1084394197ad 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -17,6 +17,14 @@
>                 reg = <0x10000000 0x80000000>;
>         };
> 
> +       clocks {
> +               anaclk2 { /* on-board 24.576MHz audio oscillator */
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <24576000>;
> +               };
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>                 pinctrl-names = "default";
> @@ -45,6 +53,17 @@
>         };
>  };
> 
> +&clks {
> +       assigned-clocks = <&clks IMX6QDL_PLL4_BYPASS_SRC>,
> +                         <&clks IMX6QDL_PLL4_BYPASS>,
> +                         <&clks IMX6QDL_CLK_ESAI_SEL>,
> +                         <&clks IMX6QDL_CLK_PLL4_POST_DIV>;
> +       assigned-clock-parents = <&clks IMX6QDL_CLK_LVDS2_IN>,
> +                                <&clks IMX6QDL_PLL4_BYPASS_SRC>,
> +                                <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
> +       assigned-clock-rates = <0>, <0>, <0>, <24576000>;
> +};
> +
>  &ecspi1 {
>         fsl,spi-num-chipselects = <1>;
>         cs-gpios = <&gpio3 19 0>;
> @@ -61,6 +80,12 @@
>         };
>  };
> 
> +&esai {
> +       assigned-clocks = <&clks IMX6QDL_CLK_ESAI_EXTAL>;
> +       assigned-clock-rates = <24576000>;
> +       status = "okay";
> +};
> +

Can we move the clocks for &esai to &clks ? I just think that will look better.
Anyway, this is just my view. you can do it follow the formal principle.

>  &fec {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_enet>;
> 
> 
> With above dts changes, I can get the following clock setup for ESAI.
> 
>  anaclk2                                  0            0    24576000          0
>     lvds2_in                              0            0    24576000          0
>        pll4_bypass_src                    0            0    24576000          0
>           pll4_bypass                     0            0    24576000          0
>              pll4_audio                   0            0    24576000          0
>                 pll4_post_div             0            0    24576000          0
>                    pll4_audio_div           0            0    24576000          0
>                       esai_sel            0            0    24576000          0
>                          esai_pred           0            0    24576000          0
>                             esai_podf           0            0    24576000          0
>                                esai_extal           0            0    24576000          0
> 
> Shawn
