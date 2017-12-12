From: plaes@plaes.org (Priit Laes)
Date: Tue, 12 Dec 2017 17:26:35 +0000
Subject: [linux-sunxi] [PATCH v2 3/6] ARM: sun4i: Convert to CCU
In-Reply-To: <CAOi56cUjqjcZRz6VSwUWcrW=4RQyqyZHtm1vuM3HT2ypdPJ78g@mail.gmail.com>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
 <4357a69da97f46a324eec4c766f4bc9d9e7733ff.1490545262.git-series.plaes@plaes.org>
 <CAOi56cUjqjcZRz6VSwUWcrW=4RQyqyZHtm1vuM3HT2ypdPJ78g@mail.gmail.com>
Message-ID: <20171212172635.2utwz3koyo5iwglt@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 02:22:30PM -0800, Kevin Hilman wrote:
> On Sun, Mar 26, 2017 at 10:20 AM, Priit Laes <plaes@plaes.org> wrote:
> > Convert sun4i-a10.dtsi to new CCU driver.
> >
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> 
> I finally got around to bisecting a mainline boot failure on
> sun4i-a10-cubieboard that's been happening for quite a while.  Based
> on on kernelci.org, it showed up sometime during the v4.15 merge
> window[1].  It bisected down to this commit (in mainline as commit
> 41193869f2bdb585ce09bfdd16d9482aadd560ad).
> 
> When it fails, there is no output on the serial console, so I don't
> know exactly how it's failing, just that it no longer boots.

We tried out latest 4.15 with various compilers and it works:
- gcc version 7.1.1 20170622 (Red Hat Cross 7.1.1-3) (GCC) - A10 Gemei G9 tablet
- gcc 7.2.0-debian - A10 Cubieboard

> 
> Kevin
> 
> [1] https://kernelci.org/boot/id/5a2e10cd59b51430a9afa173/
> 
> > ---
> >  arch/arm/boot/dts/sun4i-a10.dtsi | 636 ++++----------------------------
> >  1 file changed, 82 insertions(+), 554 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> > index ba20b48..0d8320a 100644
> > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > @@ -45,7 +45,8 @@
> >
> >  #include <dt-bindings/thermal/thermal.h>
> >
> > -#include <dt-bindings/clock/sun4i-a10-pll2.h>
> > +#include <dt-bindings/clock/sunxi-a10-a20-ccu.h>
> > +#include <dt-bindings/reset/sunxi-a10-a20-ccu.h>
> >  #include <dt-bindings/dma/sun4i-a10.h>
> >  #include <dt-bindings/pinctrl/sun4i-a10.h>
> >
> > @@ -65,9 +66,9 @@
> >                         compatible = "allwinner,simple-framebuffer",
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_be0-lcd0-hdmi";
> > -                       clocks = <&ahb_gates 36>, <&ahb_gates 43>,
> > -                                <&ahb_gates 44>, <&de_be0_clk>,
> > -                                <&tcon0_ch1_clk>, <&dram_gates 26>;
> > +                       clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI1>,
> > +                                <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_DE_BE0>,
> > +                                <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_DE_BE0>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -75,10 +76,11 @@
> >                         compatible = "allwinner,simple-framebuffer",
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
> > -                       clocks = <&ahb_gates 36>, <&ahb_gates 43>,
> > -                                <&ahb_gates 44>, <&ahb_gates 46>,
> > -                                <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch1_clk>,
> > -                                <&dram_gates 25>, <&dram_gates 26>;
> > +                       clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI1>,
> > +                                <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
> > +                                <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
> > +                                <&ccu CLK_TCON0_CH1>,
> > +                                <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -86,9 +88,10 @@
> >                         compatible = "allwinner,simple-framebuffer",
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_fe0-de_be0-lcd0";
> > -                       clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&ahb_gates 46>,
> > -                                <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
> > -                                <&dram_gates 25>, <&dram_gates 26>;
> > +                       clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_DE_BE0>,
> > +                                <&ccu CLK_AHB_DE_FE0>, <&ccu CLK_DE_BE0>,
> > +                                <&ccu CLK_DE_FE0>, <&ccu CLK_TCON0_CH1>,
> > +                                <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -96,11 +99,11 @@
> >                         compatible = "allwinner,simple-framebuffer",
> >                                      "simple-framebuffer";
> >                         allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
> > -                       clocks = <&ahb_gates 34>, <&ahb_gates 36>,
> > -                                <&ahb_gates 44>, <&ahb_gates 46>,
> > -                                <&de_be0_clk>, <&de_fe0_clk>,
> > -                                <&tcon0_ch1_clk>, <&dram_gates 5>,
> > -                                <&dram_gates 25>, <&dram_gates 26>;
> > +                       clocks = <&ccu CLK_AHB_TVE0>, <&ccu CLK_AHB_LCD0>,
> > +                                <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_AHB_DE_FE0>,
> > +                                <&ccu CLK_DE_BE0>, <&ccu CLK_DE_FE0>,
> > +                                <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_TVE0>,
> > +                                <&ccu CLK_DRAM_DE_FE0>, <&ccu CLK_DRAM_DE_BE0>;
> >                         status = "disabled";
> >                 };
> >         };
> > @@ -112,7 +115,7 @@
> >                         device_type = "cpu";
> >                         compatible = "arm,cortex-a8";
> >                         reg = <0x0>;
> > -                       clocks = <&cpu>;
> > +                       clocks = <&ccu CLK_CPU>;
> >                         clock-latency = <244144>; /* 8 32k periods */
> >                         operating-points = <
> >                                 /* kHz    uV */
> > @@ -168,18 +171,6 @@
> >                 #size-cells = <1>;
> >                 ranges;
> >
> > -               /*
> > -                * This is a dummy clock, to be used as placeholder on
> > -                * other mux clocks when a specific parent clock is not
> > -                * yet implemented. It should be dropped when the driver
> > -                * is complete.
> > -                */
> > -               dummy: dummy {
> > -                       #clock-cells = <0>;
> > -                       compatible = "fixed-clock";
> > -                       clock-frequency = <0>;
> > -               };
> > -
> >                 osc24M: clk at 01c20050 {
> >                         #clock-cells = <0>;
> >                         compatible = "allwinner,sun4i-a10-osc-clk";
> > @@ -188,487 +179,12 @@
> >                         clock-output-names = "osc24M";
> >                 };
> >
> > -               osc3M: osc3M_clk {
> > -                       compatible = "fixed-factor-clock";
> > -                       #clock-cells = <0>;
> > -                       clock-div = <8>;
> > -                       clock-mult = <1>;
> > -                       clocks = <&osc24M>;
> > -                       clock-output-names = "osc3M";
> > -               };
> > -
> >                 osc32k: clk at 0 {
> >                         #clock-cells = <0>;
> >                         compatible = "fixed-clock";
> >                         clock-frequency = <32768>;
> >                         clock-output-names = "osc32k";
> >                 };
> > -
> > -               pll1: clk at 01c20000 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-pll1-clk";
> > -                       reg = <0x01c20000 0x4>;
> > -                       clocks = <&osc24M>;
> > -                       clock-output-names = "pll1";
> > -               };
> > -
> > -               pll2: clk at 01c20008 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-pll2-clk";
> > -                       reg = <0x01c20008 0x8>;
> > -                       clocks = <&osc24M>;
> > -                       clock-output-names = "pll2-1x", "pll2-2x",
> > -                                            "pll2-4x", "pll2-8x";
> > -               };
> > -
> > -               pll3: clk at 01c20010 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-pll3-clk";
> > -                       reg = <0x01c20010 0x4>;
> > -                       clocks = <&osc3M>;
> > -                       clock-output-names = "pll3";
> > -               };
> > -
> > -               pll3x2: pll3x2_clk {
> > -                       compatible = "fixed-factor-clock";
> > -                       #clock-cells = <0>;
> > -                       clock-div = <1>;
> > -                       clock-mult = <2>;
> > -                       clocks = <&pll3>;
> > -                       clock-output-names = "pll3-2x";
> > -               };
> > -
> > -               pll4: clk at 01c20018 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-pll1-clk";
> > -                       reg = <0x01c20018 0x4>;
> > -                       clocks = <&osc24M>;
> > -                       clock-output-names = "pll4";
> > -               };
> > -
> > -               pll5: clk at 01c20020 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-pll5-clk";
> > -                       reg = <0x01c20020 0x4>;
> > -                       clocks = <&osc24M>;
> > -                       clock-output-names = "pll5_ddr", "pll5_other";
> > -               };
> > -
> > -               pll6: clk at 01c20028 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-pll6-clk";
> > -                       reg = <0x01c20028 0x4>;
> > -                       clocks = <&osc24M>;
> > -                       clock-output-names = "pll6_sata", "pll6_other", "pll6";
> > -               };
> > -
> > -               pll7: clk at 01c20030 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-pll3-clk";
> > -                       reg = <0x01c20030 0x4>;
> > -                       clocks = <&osc3M>;
> > -                       clock-output-names = "pll7";
> > -               };
> > -
> > -               pll7x2: pll7x2_clk {
> > -                       compatible = "fixed-factor-clock";
> > -                       #clock-cells = <0>;
> > -                       clock-div = <1>;
> > -                       clock-mult = <2>;
> > -                       clocks = <&pll7>;
> > -                       clock-output-names = "pll7-2x";
> > -               };
> > -
> > -               /* dummy is 200M */
> > -               cpu: cpu at 01c20054 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-cpu-clk";
> > -                       reg = <0x01c20054 0x4>;
> > -                       clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
> > -                       clock-output-names = "cpu";
> > -               };
> > -
> > -               axi: axi at 01c20054 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-axi-clk";
> > -                       reg = <0x01c20054 0x4>;
> > -                       clocks = <&cpu>;
> > -                       clock-output-names = "axi";
> > -               };
> > -
> > -               axi_gates: clk at 01c2005c {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-axi-gates-clk";
> > -                       reg = <0x01c2005c 0x4>;
> > -                       clocks = <&axi>;
> > -                       clock-indices = <0>;
> > -                       clock-output-names = "axi_dram";
> > -               };
> > -
> > -               ahb: ahb at 01c20054 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-ahb-clk";
> > -                       reg = <0x01c20054 0x4>;
> > -                       clocks = <&axi>;
> > -                       clock-output-names = "ahb";
> > -               };
> > -
> > -               ahb_gates: clk at 01c20060 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-ahb-gates-clk";
> > -                       reg = <0x01c20060 0x8>;
> > -                       clocks = <&ahb>;
> > -                       clock-indices = <0>, <1>,
> > -                                       <2>, <3>,
> > -                                       <4>, <5>, <6>,
> > -                                       <7>, <8>, <9>,
> > -                                       <10>, <11>, <12>,
> > -                                       <13>, <14>, <16>,
> > -                                       <17>, <18>, <20>,
> > -                                       <21>, <22>, <23>,
> > -                                       <24>, <25>, <26>,
> > -                                       <32>, <33>, <34>,
> > -                                       <35>, <36>, <37>,
> > -                                       <40>, <41>, <43>,
> > -                                       <44>, <45>,
> > -                                       <46>, <47>,
> > -                                       <50>, <52>;
> > -                       clock-output-names = "ahb_usb0", "ahb_ehci0",
> > -                                            "ahb_ohci0", "ahb_ehci1",
> > -                                            "ahb_ohci1", "ahb_ss", "ahb_dma",
> > -                                            "ahb_bist", "ahb_mmc0", "ahb_mmc1",
> > -                                            "ahb_mmc2", "ahb_mmc3", "ahb_ms",
> > -                                            "ahb_nand", "ahb_sdram", "ahb_ace",
> > -                                            "ahb_emac", "ahb_ts", "ahb_spi0",
> > -                                            "ahb_spi1", "ahb_spi2", "ahb_spi3",
> > -                                            "ahb_pata", "ahb_sata", "ahb_gps",
> > -                                            "ahb_ve", "ahb_tvd", "ahb_tve0",
> > -                                            "ahb_tve1", "ahb_lcd0", "ahb_lcd1",
> > -                                            "ahb_csi0", "ahb_csi1", "ahb_hdmi",
> > -                                            "ahb_de_be0", "ahb_de_be1",
> > -                                            "ahb_de_fe0", "ahb_de_fe1",
> > -                                            "ahb_mp", "ahb_mali400";
> > -               };
> > -
> > -               apb0: apb0 at 01c20054 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-apb0-clk";
> > -                       reg = <0x01c20054 0x4>;
> > -                       clocks = <&ahb>;
> > -                       clock-output-names = "apb0";
> > -               };
> > -
> > -               apb0_gates: clk at 01c20068 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-apb0-gates-clk";
> > -                       reg = <0x01c20068 0x4>;
> > -                       clocks = <&apb0>;
> > -                       clock-indices = <0>, <1>,
> > -                                       <2>, <3>,
> > -                                       <5>, <6>,
> > -                                       <7>, <10>;
> > -                       clock-output-names = "apb0_codec", "apb0_spdif",
> > -                                            "apb0_ac97", "apb0_iis",
> > -                                            "apb0_pio", "apb0_ir0",
> > -                                            "apb0_ir1", "apb0_keypad";
> > -               };
> > -
> > -               apb1: clk at 01c20058 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-apb1-clk";
> > -                       reg = <0x01c20058 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
> > -                       clock-output-names = "apb1";
> > -               };
> > -
> > -               apb1_gates: clk at 01c2006c {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-apb1-gates-clk";
> > -                       reg = <0x01c2006c 0x4>;
> > -                       clocks = <&apb1>;
> > -                       clock-indices = <0>, <1>,
> > -                                       <2>, <4>,
> > -                                       <5>, <6>,
> > -                                       <7>, <16>,
> > -                                       <17>, <18>,
> > -                                       <19>, <20>,
> > -                                       <21>, <22>,
> > -                                       <23>;
> > -                       clock-output-names = "apb1_i2c0", "apb1_i2c1",
> > -                                            "apb1_i2c2", "apb1_can",
> > -                                            "apb1_scr", "apb1_ps20",
> > -                                            "apb1_ps21", "apb1_uart0",
> > -                                            "apb1_uart1", "apb1_uart2",
> > -                                            "apb1_uart3", "apb1_uart4",
> > -                                            "apb1_uart5", "apb1_uart6",
> > -                                            "apb1_uart7";
> > -               };
> > -
> > -               nand_clk: clk at 01c20080 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c20080 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "nand";
> > -               };
> > -
> > -               ms_clk: clk at 01c20084 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c20084 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "ms";
> > -               };
> > -
> > -               mmc0_clk: clk at 01c20088 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > -                       reg = <0x01c20088 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "mmc0",
> > -                                            "mmc0_output",
> > -                                            "mmc0_sample";
> > -               };
> > -
> > -               mmc1_clk: clk at 01c2008c {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > -                       reg = <0x01c2008c 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "mmc1",
> > -                                            "mmc1_output",
> > -                                            "mmc1_sample";
> > -               };
> > -
> > -               mmc2_clk: clk at 01c20090 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > -                       reg = <0x01c20090 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "mmc2",
> > -                                            "mmc2_output",
> > -                                            "mmc2_sample";
> > -               };
> > -
> > -               mmc3_clk: clk at 01c20094 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > -                       reg = <0x01c20094 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "mmc3",
> > -                                            "mmc3_output",
> > -                                            "mmc3_sample";
> > -               };
> > -
> > -               ts_clk: clk at 01c20098 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c20098 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "ts";
> > -               };
> > -
> > -               ss_clk: clk at 01c2009c {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c2009c 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "ss";
> > -               };
> > -
> > -               spi0_clk: clk at 01c200a0 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200a0 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "spi0";
> > -               };
> > -
> > -               spi1_clk: clk at 01c200a4 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200a4 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "spi1";
> > -               };
> > -
> > -               spi2_clk: clk at 01c200a8 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200a8 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "spi2";
> > -               };
> > -
> > -               pata_clk: clk at 01c200ac {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200ac 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "pata";
> > -               };
> > -
> > -               ir0_clk: clk at 01c200b0 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200b0 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "ir0";
> > -               };
> > -
> > -               ir1_clk: clk at 01c200b4 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200b4 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "ir1";
> > -               };
> > -
> > -               spdif_clk: clk at 01c200c0 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod1-clk";
> > -                       reg = <0x01c200c0 0x4>;
> > -                       clocks = <&pll2 SUN4I_A10_PLL2_8X>,
> > -                                <&pll2 SUN4I_A10_PLL2_4X>,
> > -                                <&pll2 SUN4I_A10_PLL2_2X>,
> > -                                <&pll2 SUN4I_A10_PLL2_1X>;
> > -                       clock-output-names = "spdif";
> > -               };
> > -
> > -               usb_clk: clk at 01c200cc {
> > -                       #clock-cells = <1>;
> > -                       #reset-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-usb-clk";
> > -                       reg = <0x01c200cc 0x4>;
> > -                       clocks = <&pll6 1>;
> > -                       clock-output-names = "usb_ohci0", "usb_ohci1",
> > -                                            "usb_phy";
> > -               };
> > -
> > -               spi3_clk: clk at 01c200d4 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-mod0-clk";
> > -                       reg = <0x01c200d4 0x4>;
> > -                       clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
> > -                       clock-output-names = "spi3";
> > -               };
> > -
> > -               dram_gates: clk at 01c20100 {
> > -                       #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-dram-gates-clk";
> > -                       reg = <0x01c20100 0x4>;
> > -                       clocks = <&pll5 0>;
> > -                       clock-indices = <0>,
> > -                                       <1>, <2>,
> > -                                       <3>,
> > -                                       <4>,
> > -                                       <5>, <6>,
> > -                                       <15>,
> > -                                       <24>, <25>,
> > -                                       <26>, <27>,
> > -                                       <28>, <29>;
> > -                       clock-output-names = "dram_ve",
> > -                                            "dram_csi0", "dram_csi1",
> > -                                            "dram_ts",
> > -                                            "dram_tvd",
> > -                                            "dram_tve0", "dram_tve1",
> > -                                            "dram_output",
> > -                                            "dram_de_fe1", "dram_de_fe0",
> > -                                            "dram_de_be0", "dram_de_be1",
> > -                                            "dram_de_mp", "dram_ace";
> > -               };
> > -
> > -               de_be0_clk: clk at 01c20104 {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-display-clk";
> > -                       reg = <0x01c20104 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll5 1>;
> > -                       clock-output-names = "de-be0";
> > -               };
> > -
> > -               de_be1_clk: clk at 01c20108 {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-display-clk";
> > -                       reg = <0x01c20108 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll5 1>;
> > -                       clock-output-names = "de-be1";
> > -               };
> > -
> > -               de_fe0_clk: clk at 01c2010c {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-display-clk";
> > -                       reg = <0x01c2010c 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll5 1>;
> > -                       clock-output-names = "de-fe0";
> > -               };
> > -
> > -               de_fe1_clk: clk at 01c20110 {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-display-clk";
> > -                       reg = <0x01c20110 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll5 1>;
> > -                       clock-output-names = "de-fe1";
> > -               };
> > -
> > -
> > -               tcon0_ch0_clk: clk at 01c20118 {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
> > -                       reg = <0x01c20118 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > -                       clock-output-names = "tcon0-ch0-sclk";
> > -
> > -               };
> > -
> > -               tcon1_ch0_clk: clk at 01c2011c {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> > -                       reg = <0x01c2011c 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > -                       clock-output-names = "tcon1-ch0-sclk";
> > -
> > -               };
> > -
> > -               tcon0_ch1_clk: clk at 01c2012c {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
> > -                       reg = <0x01c2012c 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > -                       clock-output-names = "tcon0-ch1-sclk";
> > -
> > -               };
> > -
> > -               tcon1_ch1_clk: clk at 01c20130 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
> > -                       reg = <0x01c20130 0x4>;
> > -                       clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
> > -                       clock-output-names = "tcon1-ch1-sclk";
> > -
> > -               };
> > -
> > -               ve_clk: clk at 01c2013c {
> > -                       #clock-cells = <0>;
> > -                       #reset-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-ve-clk";
> > -                       reg = <0x01c2013c 0x4>;
> > -                       clocks = <&pll4>;
> > -                       clock-output-names = "ve";
> > -               };
> > -
> > -               codec_clk: clk at 01c20140 {
> > -                       #clock-cells = <0>;
> > -                       compatible = "allwinner,sun4i-a10-codec-clk";
> > -                       reg = <0x01c20140 0x4>;
> > -                       clocks = <&pll2 SUN4I_A10_PLL2_1X>;
> > -                       clock-output-names = "codec";
> > -               };
> >         };
> >
> >         soc at 01c00000 {
> > @@ -717,7 +233,7 @@
> >                         compatible = "allwinner,sun4i-a10-dma";
> >                         reg = <0x01c02000 0x1000>;
> >                         interrupts = <27>;
> > -                       clocks = <&ahb_gates 6>;
> > +                       clocks = <&ccu CLK_AHB_DMA>;
> >                         #dma-cells = <2>;
> >                 };
> >
> > @@ -725,7 +241,7 @@
> >                         compatible = "allwinner,sun4i-a10-nand";
> >                         reg = <0x01c03000 0x1000>;
> >                         interrupts = <37>;
> > -                       clocks = <&ahb_gates 13>, <&nand_clk>;
> > +                       clocks = <&ccu CLK_AHB_NAND>, <&ccu CLK_NAND>;
> >                         clock-names = "ahb", "mod";
> >                         dmas = <&dma SUN4I_DMA_DEDICATED 3>;
> >                         dma-names = "rxtx";
> > @@ -738,7 +254,7 @@
> >                         compatible = "allwinner,sun4i-a10-spi";
> >                         reg = <0x01c05000 0x1000>;
> >                         interrupts = <10>;
> > -                       clocks = <&ahb_gates 20>, <&spi0_clk>;
> > +                       clocks = <&ccu CLK_AHB_SPI0>, <&ccu CLK_SPI0>;
> >                         clock-names = "ahb", "mod";
> >                         dmas = <&dma SUN4I_DMA_DEDICATED 27>,
> >                                <&dma SUN4I_DMA_DEDICATED 26>;
> > @@ -752,7 +268,7 @@
> >                         compatible = "allwinner,sun4i-a10-spi";
> >                         reg = <0x01c06000 0x1000>;
> >                         interrupts = <11>;
> > -                       clocks = <&ahb_gates 21>, <&spi1_clk>;
> > +                       clocks = <&ccu CLK_AHB_SPI1>, <&ccu CLK_SPI1>;
> >                         clock-names = "ahb", "mod";
> >                         dmas = <&dma SUN4I_DMA_DEDICATED 9>,
> >                                <&dma SUN4I_DMA_DEDICATED 8>;
> > @@ -766,7 +282,7 @@
> >                         compatible = "allwinner,sun4i-a10-emac";
> >                         reg = <0x01c0b000 0x1000>;
> >                         interrupts = <55>;
> > -                       clocks = <&ahb_gates 17>;
> > +                       clocks = <&ccu CLK_AHB_EMAC>;
> >                         allwinner,sram = <&emac_sram 1>;
> >                         status = "disabled";
> >                 };
> > @@ -782,10 +298,10 @@
> >                 mmc0: mmc at 01c0f000 {
> >                         compatible = "allwinner,sun4i-a10-mmc";
> >                         reg = <0x01c0f000 0x1000>;
> > -                       clocks = <&ahb_gates 8>,
> > -                                <&mmc0_clk 0>,
> > -                                <&mmc0_clk 1>,
> > -                                <&mmc0_clk 2>;
> > +                       clocks = <&ccu CLK_AHB_MMC0>,
> > +                                <&ccu CLK_MMC0>,
> > +                                <&ccu CLK_MMC0_OUTPUT>,
> > +                                <&ccu CLK_MMC0_SAMPLE>;
> >                         clock-names = "ahb",
> >                                       "mmc",
> >                                       "output",
> > @@ -799,10 +315,10 @@
> >                 mmc1: mmc at 01c10000 {
> >                         compatible = "allwinner,sun4i-a10-mmc";
> >                         reg = <0x01c10000 0x1000>;
> > -                       clocks = <&ahb_gates 9>,
> > -                                <&mmc1_clk 0>,
> > -                                <&mmc1_clk 1>,
> > -                                <&mmc1_clk 2>;
> > +                       clocks = <&ccu CLK_AHB_MMC1>,
> > +                                <&ccu CLK_MMC1>,
> > +                                <&ccu CLK_MMC1_OUTPUT>,
> > +                                <&ccu CLK_MMC1_SAMPLE>;
> >                         clock-names = "ahb",
> >                                       "mmc",
> >                                       "output",
> > @@ -816,10 +332,10 @@
> >                 mmc2: mmc at 01c11000 {
> >                         compatible = "allwinner,sun4i-a10-mmc";
> >                         reg = <0x01c11000 0x1000>;
> > -                       clocks = <&ahb_gates 10>,
> > -                                <&mmc2_clk 0>,
> > -                                <&mmc2_clk 1>,
> > -                                <&mmc2_clk 2>;
> > +                       clocks = <&ccu CLK_AHB_MMC2>,
> > +                                <&ccu CLK_MMC2>,
> > +                                <&ccu CLK_MMC2_OUTPUT>,
> > +                                <&ccu CLK_MMC2_SAMPLE>;
> >                         clock-names = "ahb",
> >                                       "mmc",
> >                                       "output",
> > @@ -833,10 +349,10 @@
> >                 mmc3: mmc at 01c12000 {
> >                         compatible = "allwinner,sun4i-a10-mmc";
> >                         reg = <0x01c12000 0x1000>;
> > -                       clocks = <&ahb_gates 11>,
> > -                                <&mmc3_clk 0>,
> > -                                <&mmc3_clk 1>,
> > -                                <&mmc3_clk 2>;
> > +                       clocks = <&ccu CLK_AHB_MMC3>,
> > +                                <&ccu CLK_MMC3>,
> > +                                <&ccu CLK_MMC3_OUTPUT>,
> > +                                <&ccu CLK_MMC3_SAMPLE>;
> >                         clock-names = "ahb",
> >                                       "mmc",
> >                                       "output",
> > @@ -850,7 +366,7 @@
> >                 usb_otg: usb at 01c13000 {
> >                         compatible = "allwinner,sun4i-a10-musb";
> >                         reg = <0x01c13000 0x0400>;
> > -                       clocks = <&ahb_gates 0>;
> > +                       clocks = <&ccu CLK_AHB_OTG>;
> >                         interrupts = <38>;
> >                         interrupt-names = "mc";
> >                         phys = <&usbphy 0>;
> > @@ -865,9 +381,11 @@
> >                         compatible = "allwinner,sun4i-a10-usb-phy";
> >                         reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
> >                         reg-names = "phy_ctrl", "pmu1", "pmu2";
> > -                       clocks = <&usb_clk 8>;
> > +                       clocks = <&ccu CLK_USB_PHY>;
> >                         clock-names = "usb_phy";
> > -                       resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
> > +                       resets = <&ccu RST_USB_PHY0>,
> > +                                <&ccu RST_USB_PHY1>,
> > +                                <&ccu RST_USB_PHY2>;
> >                         reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
> >                         status = "disabled";
> >                 };
> > @@ -876,7 +394,7 @@
> >                         compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
> >                         reg = <0x01c14000 0x100>;
> >                         interrupts = <39>;
> > -                       clocks = <&ahb_gates 1>;
> > +                       clocks = <&ccu CLK_AHB_EHCI0>;
> >                         phys = <&usbphy 1>;
> >                         phy-names = "usb";
> >                         status = "disabled";
> > @@ -886,7 +404,7 @@
> >                         compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
> >                         reg = <0x01c14400 0x100>;
> >                         interrupts = <64>;
> > -                       clocks = <&usb_clk 6>, <&ahb_gates 2>;
> > +                       clocks = <&ccu CLK_USB_OHCI0>, <&ccu CLK_AHB_OHCI0>;
> >                         phys = <&usbphy 1>;
> >                         phy-names = "usb";
> >                         status = "disabled";
> > @@ -896,7 +414,7 @@
> >                         compatible = "allwinner,sun4i-a10-crypto";
> >                         reg = <0x01c15000 0x1000>;
> >                         interrupts = <86>;
> > -                       clocks = <&ahb_gates 5>, <&ss_clk>;
> > +                       clocks = <&ccu CLK_AHB_SS>, <&ccu CLK_SS>;
> >                         clock-names = "ahb", "mod";
> >                 };
> >
> > @@ -904,7 +422,7 @@
> >                         compatible = "allwinner,sun4i-a10-spi";
> >                         reg = <0x01c17000 0x1000>;
> >                         interrupts = <12>;
> > -                       clocks = <&ahb_gates 22>, <&spi2_clk>;
> > +                       clocks = <&ccu CLK_AHB_SPI2>, <&ccu CLK_SPI2>;
> >                         clock-names = "ahb", "mod";
> >                         dmas = <&dma SUN4I_DMA_DEDICATED 29>,
> >                                <&dma SUN4I_DMA_DEDICATED 28>;
> > @@ -918,7 +436,8 @@
> >                         compatible = "allwinner,sun4i-a10-ahci";
> >                         reg = <0x01c18000 0x1000>;
> >                         interrupts = <56>;
> > -                       clocks = <&pll6 0>, <&ahb_gates 25>;
> > +                       clocks = <&ccu CLK_PLL_PERIPH_SATA>,
> > +                                <&ccu CLK_AHB_SATA>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -926,7 +445,7 @@
> >                         compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
> >                         reg = <0x01c1c000 0x100>;
> >                         interrupts = <40>;
> > -                       clocks = <&ahb_gates 3>;
> > +                       clocks = <&ccu CLK_AHB_EHCI1>;
> >                         phys = <&usbphy 2>;
> >                         phy-names = "usb";
> >                         status = "disabled";
> > @@ -936,7 +455,7 @@
> >                         compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
> >                         reg = <0x01c1c400 0x100>;
> >                         interrupts = <65>;
> > -                       clocks = <&usb_clk 7>, <&ahb_gates 4>;
> > +                       clocks = <&ccu CLK_USB_OHCI1>, <&ccu CLK_AHB_OHCI1>;
> >                         phys = <&usbphy 2>;
> >                         phy-names = "usb";
> >                         status = "disabled";
> > @@ -946,7 +465,7 @@
> >                         compatible = "allwinner,sun4i-a10-spi";
> >                         reg = <0x01c1f000 0x1000>;
> >                         interrupts = <50>;
> > -                       clocks = <&ahb_gates 23>, <&spi3_clk>;
> > +                       clocks = <&ccu CLK_AHB_SPI3>, <&ccu CLK_SPI3>;
> >                         clock-names = "ahb", "mod";
> >                         dmas = <&dma SUN4I_DMA_DEDICATED 31>,
> >                                <&dma SUN4I_DMA_DEDICATED 30>;
> > @@ -956,6 +475,15 @@
> >                         #size-cells = <0>;
> >                 };
> >
> > +               ccu: clock at 01c20000 {
> > +                       compatible = "allwinner,sun4i-a10-ccu";
> > +                       reg = <0x01c20000 0x400>;
> > +                       clocks = <&osc24M>, <&osc32k>;
> > +                       clock-names = "hosc", "losc";
> > +                       #clock-cells = <1>;
> > +                       #reset-cells = <1>;
> > +               };
> > +
> >                 intc: interrupt-controller at 01c20400 {
> >                         compatible = "allwinner,sun4i-a10-ic";
> >                         reg = <0x01c20400 0x400>;
> > @@ -967,7 +495,7 @@
> >                         compatible = "allwinner,sun4i-a10-pinctrl";
> >                         reg = <0x01c20800 0x400>;
> >                         interrupts = <28>;
> > -                       clocks = <&apb0_gates 5>, <&osc24M>, <&osc32k>;
> > +                       clocks = <&ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
> >                         clock-names = "apb", "hosc", "losc";
> >                         gpio-controller;
> >                         interrupt-controller;
> > @@ -1145,7 +673,7 @@
> >                         compatible = "allwinner,sun4i-a10-spdif";
> >                         reg = <0x01c21000 0x400>;
> >                         interrupts = <13>;
> > -                       clocks = <&apb0_gates 1>, <&spdif_clk>;
> > +                       clocks = <&ccu CLK_APB0_SPDIF>, <&ccu CLK_SPDIF>;
> >                         clock-names = "apb", "spdif";
> >                         dmas = <&dma SUN4I_DMA_NORMAL 2>,
> >                                <&dma SUN4I_DMA_NORMAL 2>;
> > @@ -1155,7 +683,7 @@
> >
> >                 ir0: ir at 01c21800 {
> >                         compatible = "allwinner,sun4i-a10-ir";
> > -                       clocks = <&apb0_gates 6>, <&ir0_clk>;
> > +                       clocks = <&ccu CLK_APB0_IR0>, <&ccu CLK_IR0>;
> >                         clock-names = "apb", "ir";
> >                         interrupts = <5>;
> >                         reg = <0x01c21800 0x40>;
> > @@ -1164,7 +692,7 @@
> >
> >                 ir1: ir at 01c21c00 {
> >                         compatible = "allwinner,sun4i-a10-ir";
> > -                       clocks = <&apb0_gates 7>, <&ir1_clk>;
> > +                       clocks = <&ccu CLK_APB0_IR1>, <&ccu CLK_IR1>;
> >                         clock-names = "apb", "ir";
> >                         interrupts = <6>;
> >                         reg = <0x01c21c00 0x40>;
> > @@ -1183,7 +711,7 @@
> >                         compatible = "allwinner,sun4i-a10-codec";
> >                         reg = <0x01c22c00 0x40>;
> >                         interrupts = <30>;
> > -                       clocks = <&apb0_gates 0>, <&codec_clk>;
> > +                       clocks = <&ccu CLK_APB0_CODEC>, <&ccu CLK_CODEC>;
> >                         clock-names = "apb", "codec";
> >                         dmas = <&dma SUN4I_DMA_NORMAL 19>,
> >                                <&dma SUN4I_DMA_NORMAL 19>;
> > @@ -1209,7 +737,7 @@
> >                         interrupts = <1>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 16>;
> > +                       clocks = <&ccu CLK_APB1_UART0>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1219,7 +747,7 @@
> >                         interrupts = <2>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 17>;
> > +                       clocks = <&ccu CLK_APB1_UART1>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1229,7 +757,7 @@
> >                         interrupts = <3>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 18>;
> > +                       clocks = <&ccu CLK_APB1_UART2>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1239,7 +767,7 @@
> >                         interrupts = <4>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 19>;
> > +                       clocks = <&ccu CLK_APB1_UART3>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1249,7 +777,7 @@
> >                         interrupts = <17>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 20>;
> > +                       clocks = <&ccu CLK_APB1_UART4>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1259,7 +787,7 @@
> >                         interrupts = <18>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 21>;
> > +                       clocks = <&ccu CLK_APB1_UART5>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1269,7 +797,7 @@
> >                         interrupts = <19>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 22>;
> > +                       clocks = <&ccu CLK_APB1_UART6>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1279,7 +807,7 @@
> >                         interrupts = <20>;
> >                         reg-shift = <2>;
> >                         reg-io-width = <4>;
> > -                       clocks = <&apb1_gates 23>;
> > +                       clocks = <&ccu CLK_APB1_UART7>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1287,7 +815,7 @@
> >                         compatible = "allwinner,sun4i-a10-i2c";
> >                         reg = <0x01c2ac00 0x400>;
> >                         interrupts = <7>;
> > -                       clocks = <&apb1_gates 0>;
> > +                       clocks = <&ccu CLK_APB1_I2C0>;
> >                         status = "disabled";
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> > @@ -1297,7 +825,7 @@
> >                         compatible = "allwinner,sun4i-a10-i2c";
> >                         reg = <0x01c2b000 0x400>;
> >                         interrupts = <8>;
> > -                       clocks = <&apb1_gates 1>;
> > +                       clocks = <&ccu CLK_APB1_I2C1>;
> >                         status = "disabled";
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> > @@ -1307,7 +835,7 @@
> >                         compatible = "allwinner,sun4i-a10-i2c";
> >                         reg = <0x01c2b400 0x400>;
> >                         interrupts = <9>;
> > -                       clocks = <&apb1_gates 2>;
> > +                       clocks = <&ccu CLK_APB1_I2C2>;
> >                         status = "disabled";
> >                         #address-cells = <1>;
> >                         #size-cells = <0>;
> > @@ -1317,7 +845,7 @@
> >                         compatible = "allwinner,sun4i-a10-ps2";
> >                         reg = <0x01c2a000 0x400>;
> >                         interrupts = <62>;
> > -                       clocks = <&apb1_gates 6>;
> > +                       clocks = <&ccu CLK_APB1_PS20>;
> >                         status = "disabled";
> >                 };
> >
> > @@ -1325,7 +853,7 @@
> >                         compatible = "allwinner,sun4i-a10-ps2";
> >                         reg = <0x01c2a400 0x400>;
> >                         interrupts = <63>;
> > -                       clocks = <&apb1_gates 7>;
> > +                       clocks = <&ccu CLK_APB1_PS21>;
> >                         status = "disabled";
> >                 };
> >         };
> > --
> > git-series 0.9.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.
