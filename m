From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:46:06 +0100
Subject: [PATCH v4 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <CAGb2v64NZMw0vNvVtepthUMox5TDy07gTBAWZqf8GAq6TrMpOg@mail.gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-6-git-send-email-jenskuske@gmail.com>
 <CAGb2v64NZMw0vNvVtepthUMox5TDy07gTBAWZqf8GAq6TrMpOg@mail.gmail.com>
Message-ID: <20151101094606.GQ6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 30, 2015 at 03:33:05PM +0800, Chen-Yu Tsai wrote:
> > +               pll6: clk at 01c20028 {
> > +                       #clock-cells = <1>;
> > +                       compatible = "allwinner,sun6i-a31-pll6-clk";
> > +                       reg = <0x01c20028 0x4>;
> > +                       clocks = <&osc24M>;
> > +                       clock-output-names = "pll6", "pll6x2", "pll6d2";
> 
> What's the extra "pll6d2"? If you have an extra output, it's not compatible with
> "allwinner,sun6i-a31-pll6-clk".

[...]

> > +
> > +               ahb2: ahb2_clk at 01c2005c {
> > +                       #clock-cells = <0>;
> > +                       compatible = "allwinner,sun8i-h3-ahb2-clk";
> > +                       reg = <0x01c2005c 0x4>;
> > +                       clocks = <&ahb1>, <&pll6 2>;
> 
> And this would be wrong if you don't update the pll6 compatible or driver.
> There's no output on n = 2.
> 
> You could also chain a fixed divider directly in the driver.

Or in the DT directly.

I'd really like to move away from the various fixed dividers output
that prevents to reuse the clock drivers when it's the only
difference, like what's done here.

> 
> > +                       clock-output-names = "ahb2";
> > +               };
> > +
> > +               apb1: apb1_clk at 01c20054 {
> > +                       #clock-cells = <0>;
> > +                       compatible = "allwinner,sun4i-a10-apb0-clk";
> > +                       reg = <0x01c20054 0x4>;
> > +                       clocks = <&ahb1>;
> > +                       clock-output-names = "apb1";
> > +               };
> > +
> > +               apb2: apb2_clk at 01c20058 {
> > +                       #clock-cells = <0>;
> > +                       compatible = "allwinner,sun4i-a10-apb1-clk";
> > +                       reg = <0x01c20058 0x4>;
> > +                       clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
> > +                       clock-output-names = "apb2";
> > +               };
> > +
> > +               bus_gates: clk at 01c20060 {
> > +                       #clock-cells = <1>;
> > +                       compatible = "allwinner,sun8i-h3-bus-gates-clk";
> > +                       reg = <0x01c20060 0x14>;
> > +                       clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
> > +                       clock-names = "ahb1", "ahb2", "apb1", "apb2";
> > +                       clock-indices = <5>, <6>, <8>,
> > +                                       <9>, <10>, <13>,
> > +                                       <14>, <17>, <18>,
> > +                                       <19>, <20>,
> > +                                       <21>, <23>,
> > +                                       <24>, <25>,
> > +                                       <26>, <27>,
> > +                                       <28>, <29>,
> > +                                       <30>, <31>, <32>,
> > +                                       <35>, <36>, <37>,
> > +                                       <40>, <41>, <43>,
> > +                                       <44>, <52>, <53>,
> > +                                       <54>, <64>,
> > +                                       <65>, <69>, <72>,
> > +                                       <76>, <77>, <78>,
> > +                                       <96>, <97>, <98>,
> > +                                       <112>, <113>,
> > +                                       <114>, <115>, <116>,
> > +                                       <128>, <135>;
> > +                       clock-output-names = "ahb1_ce", "ahb1_dma", "ahb1_mmc0",
> > +                                       "ahb1_mmc1", "ahb1_mmc2", "ahb1_nand",
> > +                                       "ahb1_sdram", "ahb2_gmac", "ahb1_ts",
> > +                                       "ahb1_hstimer", "ahb1_spi0",
> > +                                       "ahb1_spi1", "ahb1_otg",
> > +                                       "ahb1_otg_ehci0", "ahb1_ehic1",
> 
> ahb1_ehci1? Same for the following 3 lines.
> 
> > +                                       "ahb1_ehic2", "ahb1_ehic3",
> > +                                       "ahb1_otg_ohci0", "ahb2_ohic1",
> > +                                       "ahb2_ohic2", "ahb2_ohic3", "ahb1_ve",
> > +                                       "ahb1_lcd0", "ahb1_lcd1", "ahb1_deint",
> > +                                       "ahb1_csi", "ahb1_tve", "ahb1_hdmi",
> > +                                       "ahb1_de", "ahb1_gpu", "ahb1_msgbox",
> > +                                       "ahb1_spinlock", "apb1_codec",
> > +                                       "apb1_spdif", "apb1_pio", "apb1_ths",
> > +                                       "apb1_i2s0", "apb1_i2s1", "apb1_i2s2",
> > +                                       "apb2_i2c0", "apb2_i2c1", "apb2_i2c2",
> > +                                       "apb2_uart0", "apb2_uart1",
> > +                                       "apb2_uart2", "apb2_uart3", "apb2_scr",
> > +                                       "ahb1_ephy", "ahb1_dbg";
> 
> If it weren't for the last 2 clocks, we could cleanly split out apb1 and apb2
> gates. Having a separate AHB clock gate taking 2 addresses seems messy
> as well. :(
> 
> > +               };
> > +
> > +               mmc0_clk: clk at 01c20088 {
> > +                       #clock-cells = <1>;
> > +                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > +                       reg = <0x01c20088 0x4>;
> > +                       clocks = <&osc24M>, <&pll6 0>, <&pll8 0>;
> > +                       clock-output-names = "mmc0",
> > +                                            "mmc0_output",
> > +                                            "mmc0_sample";
> > +               };
> > +
> > +               mmc1_clk: clk at 01c2008c {
> > +                       #clock-cells = <1>;
> > +                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > +                       reg = <0x01c2008c 0x4>;
> > +                       clocks = <&osc24M>, <&pll6 0>, <&pll8 0>;
> > +                       clock-output-names = "mmc1",
> > +                                            "mmc1_output",
> > +                                            "mmc1_sample";
> > +               };
> > +
> > +               mmc2_clk: clk at 01c20090 {
> > +                       #clock-cells = <1>;
> > +                       compatible = "allwinner,sun4i-a10-mmc-clk";
> > +                       reg = <0x01c20090 0x4>;
> > +                       clocks = <&osc24M>, <&pll6 0>, <&pll8 0>;
> > +                       clock-output-names = "mmc2",
> > +                                            "mmc2_output",
> > +                                            "mmc2_sample";
> > +               };
> > +
> > +               mbus_clk: clk at 01c2015c {
> > +                       #clock-cells = <0>;
> > +                       compatible = "allwinner,sun8i-a23-mbus-clk";
> > +                       reg = <0x01c2015c 0x4>;
> > +                       clocks = <&osc24M>, <&pll6 1>, <&pll5>;
> > +                       clock-output-names = "mbus";
> > +               };
> > +       };
> > +
> > +       soc {
> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               dma: dma-controller at 01c02000 {
> > +                       compatible = "allwinner,sun8i-h3-dma";
> > +                       reg = <0x01c02000 0x1000>;
> > +                       interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&bus_gates 6>;
> > +                       resets = <&bus_rst 6>;
> > +                       #dma-cells = <1>;
> > +               };
> > +
> > +               mmc0: mmc at 01c0f000 {
> > +                       compatible = "allwinner,sun5i-a13-mmc";
> > +                       reg = <0x01c0f000 0x1000>;
> > +                       clocks = <&bus_gates 8>,
> > +                                <&mmc0_clk 0>,
> > +                                <&mmc0_clk 1>,
> > +                                <&mmc0_clk 2>;
> > +                       clock-names = "ahb",
> > +                                     "mmc",
> > +                                     "output",
> > +                                     "sample";
> > +                       resets = <&bus_rst 8>;
> > +                       reset-names = "ahb";
> > +                       interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +                       status = "disabled";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +               };
> > +
> > +               mmc1: mmc at 01c10000 {
> > +                       compatible = "allwinner,sun5i-a13-mmc";
> > +                       reg = <0x01c10000 0x1000>;
> > +                       clocks = <&bus_gates 9>,
> > +                                <&mmc1_clk 0>,
> > +                                <&mmc1_clk 1>,
> > +                                <&mmc1_clk 2>;
> > +                       clock-names = "ahb",
> > +                                     "mmc",
> > +                                     "output",
> > +                                     "sample";
> > +                       resets = <&bus_rst 9>;
> > +                       reset-names = "ahb";
> > +                       interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> > +                       status = "disabled";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +               };
> > +
> > +               mmc2: mmc at 01c11000 {
> > +                       compatible = "allwinner,sun5i-a13-mmc";
> > +                       reg = <0x01c11000 0x1000>;
> > +                       clocks = <&bus_gates 10>,
> > +                                <&mmc2_clk 0>,
> > +                                <&mmc2_clk 1>,
> > +                                <&mmc2_clk 2>;
> > +                       clock-names = "ahb",
> > +                                     "mmc",
> > +                                     "output",
> > +                                     "sample";
> > +                       resets = <&bus_rst 10>;
> > +                       reset-names = "ahb";
> > +                       interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> > +                       status = "disabled";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +               };
> > +
> > +               pio: pinctrl at 01c20800 {
> > +                       compatible = "allwinner,sun8i-h3-pinctrl";
> > +                       reg = <0x01c20800 0x400>;
> > +                       interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&bus_gates 69>;
> > +                       gpio-controller;
> > +                       #gpio-cells = <3>;
> > +                       interrupt-controller;
> > +                       #interrupt-cells = <2>;
> > +
> > +                       uart0_pins_a: uart0 at 0 {
> > +                               allwinner,pins = "PA4", "PA5";
> > +                               allwinner,function = "uart0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       mmc0_pins_a: mmc0 at 0 {
> > +                               allwinner,pins = "PF0", "PF1", "PF2", "PF3",
> > +                                                "PF4", "PF5";
> > +                               allwinner,function = "mmc0";
> > +                               allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +
> > +                       mmc0_cd_pin: mmc0_cd_pin at 0 {
> > +                               allwinner,pins = "PF6";
> > +                               allwinner,function = "gpio_in";
> > +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> > +                       };
> 
> This should be in the board DTS, unless this is the reference design,
> in which case you should name the label like "mmc0_cd_pin_reference_design".
> 
> > +
> > +                       mmc1_pins_a: mmc1 at 0 {
> > +                               allwinner,pins = "PG0", "PG1", "PG2", "PG3",
> > +                                                "PG4", "PG5";
> > +                               allwinner,function = "mmc1";
> > +                               allwinner,drive = <SUN4I_PINCTRL_30_MA>;
> > +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> > +                       };
> > +               };
> > +
> > +               bus_rst: reset at 01c202c0 {
> > +                       #reset-cells = <1>;
> > +                       compatible = "allwinner,sun8i-h3-bus-reset";
> > +                       reg = <0x01c202c0 0x1c>;
> > +               };
> > +
> > +               timer at 01c20c00 {
> > +                       compatible = "allwinner,sun4i-a10-timer";
> > +                       reg = <0x01c20c00 0xa0>;
> > +                       interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks = <&osc24M>;
> > +               };
> > +
> > +               wdt0: watchdog at 01c20ca0 {
> > +                       compatible = "allwinner,sun6i-a31-wdt";
> > +                       reg = <0x01c20ca0 0x20>;
> > +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +               };
> > +
> > +               uart0: serial at 01c28000 {
> > +                       compatible = "snps,dw-apb-uart";
> > +                       reg = <0x01c28000 0x400>;
> > +                       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > +                       reg-shift = <2>;
> > +                       reg-io-width = <4>;
> > +                       clocks = <&bus_gates 112>;
> > +                       resets = <&bus_rst 144>;
> 
> Aren't you handling the holes in the bus_rst driver? If so,
> isn't it supposed to align both bus_gates and bus_rst indexes?
> 
> Same for the other UARTs.

Not really, the last reset registers don't have the same organization
than the bus clocks :/

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/8c48e0ad/attachment.sig>
