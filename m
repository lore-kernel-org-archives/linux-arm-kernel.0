From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 14 Jan 2013 13:52:59 -0800
Subject: [PATCH] clk: prima2: enable dt-binding clkdev mapping
In-Reply-To: <1355993491-21233-1-git-send-email-Barry.Song@csr.com>
References: <1355993491-21233-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20130114215259.23734.68185@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Barry Song (2012-12-20 00:51:31)
> From: Barry Song <Baohua.Song@csr.com>
> 
> this patche deletes hard code that registers clkdev by things like:
> clk_register_clkdev(clk, NULL, "b0030000.nand");
> clk_register_clkdev(clk, NULL, "b0040000.audio");
> clk_register_clkdev(clk, NULL, "b0080000.usp");
> prima2 clock controller becomes a clock provider and  every dt node
> just declares its clock sources by dt prop.
> 
> it also makes us easier to extend this driver to support both prima2
> and marco as marco has different address mapping with prima2.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Barry,

The changes to clk-prima2.c look OK to me.  Did you want me to take this
patch through clk-next?

Thanks,
Mike

> ---
>  .../devicetree/bindings/clock/prima2-clock.txt     |   73 +++++++
>  arch/arm/boot/dts/prima2.dtsi                      |   31 +++-
>  drivers/clk/clk-prima2.c                           |  205 ++++++++------------
>  3 files changed, 183 insertions(+), 126 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/prima2-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/prima2-clock.txt b/Documentation/devicetree/bindings/clock/prima2-clock.txt
> new file mode 100644
> index 0000000..5016979
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/prima2-clock.txt
> @@ -0,0 +1,73 @@
> +* Clock bindings for CSR SiRFprimaII
> +
> +Required properties:
> +- compatible: Should be "sirf,prima2-clkc"
> +- reg: Address and length of the register set
> +- interrupts: Should contain clock controller interrupt
> +- #clock-cells: Should be <1>
> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.  The following is a full list of prima2
> +clocks and IDs.
> +
> +       Clock                   ID
> +       ---------------------------
> +       rtc                     0
> +       osc                     1
> +       pll1                    2
> +       pll2                    3
> +       pll3                    4
> +       mem                     5
> +       sys                     6
> +       security                7
> +       dsp                     8
> +       gps                     9
> +       mf                      10
> +       io                      11
> +       cpu                     12
> +       uart0                   13
> +       uart1                   14
> +       uart2                   15
> +       tsc                     16
> +       i2c0                    17
> +       i2c1                    18
> +       spi0                    19
> +       spi1                    20
> +       pwmc                    21
> +       efuse                   22
> +       pulse                   23
> +       dmac0                   24
> +       dmac1                   25
> +       nand                    26
> +       audio                   27
> +       usp0                    28
> +       usp1                    29
> +       usp2                    30
> +       vip                     31
> +       gfx                     32
> +       mm                      33
> +       lcd                     34
> +       vpp                     35
> +       mmc01                   36
> +       mmc23                   37
> +       mmc45                   38
> +       usbpll                  39
> +       usb0                    40
> +       usb1                    41
> +
> +Examples:
> +
> +clks: clock-controller at 88000000 {
> +       compatible = "sirf,prima2-clkc";
> +       reg = <0x88000000 0x1000>;
> +       interrupts = <3>;
> +       #clock-cells = <1>;
> +};
> +
> +i2c0: i2c at b00e0000 {
> +       cell-index = <0>;
> +       compatible = "sirf,prima2-i2c";
> +       reg = <0xb00e0000 0x10000>;
> +       interrupts = <24>;
> +       clocks = <&clks 17>;
> +};
> diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
> index 055fca5..3329719 100644
> --- a/arch/arm/boot/dts/prima2.dtsi
> +++ b/arch/arm/boot/dts/prima2.dtsi
> @@ -58,10 +58,11 @@
>                         #size-cells = <1>;
>                         ranges = <0x88000000 0x88000000 0x40000>;
>  
> -                       clock-controller at 88000000 {
> +                       clks: clock-controller at 88000000 {
>                                 compatible = "sirf,prima2-clkc";
>                                 reg = <0x88000000 0x1000>;
>                                 interrupts = <3>;
> +                               #clock-cells = <1>;
>                         };
>  
>                         reset-controller at 88010000 {
> @@ -85,6 +86,7 @@
>                                 compatible = "sirf,prima2-memc";
>                                 reg = <0x90000000 0x10000>;
>                                 interrupts = <27>;
> +                               clocks = <&clks 5>;
>                         };
>                 };
>  
> @@ -104,6 +106,7 @@
>                                 compatible = "sirf,prima2-vpp";
>                                 reg = <0x90020000 0x10000>;
>                                 interrupts = <31>;
> +                               clocks = <&clks 35>;
>                         };
>                 };
>  
> @@ -117,6 +120,7 @@
>                                 compatible = "powervr,sgx531";
>                                 reg = <0x98000000 0x8000000>;
>                                 interrupts = <6>;
> +                               clocks = <&clks 32>;
>                         };
>                 };
>  
> @@ -130,6 +134,7 @@
>                                 compatible = "sirf,prima2-video-codec";
>                                 reg = <0xa0000000 0x8000000>;
>                                 interrupts = <5>;
> +                               clocks = <&clks 33>;
>                         };
>                 };
>  
> @@ -149,12 +154,14 @@
>                                 compatible = "sirf,prima2-gps";
>                                 reg = <0xa8010000 0x10000>;
>                                 interrupts = <7>;
> +                               clocks = <&clks 9>;
>                         };
>  
>                         dsp at a9000000 {
>                                 compatible = "sirf,prima2-dsp";
>                                 reg = <0xa9000000 0x1000000>;
>                                 interrupts = <8>;
> +                               clocks = <&clks 8>;
>                         };
>                 };
>  
> @@ -174,12 +181,14 @@
>                                 compatible = "sirf,prima2-nand";
>                                 reg = <0xb0030000 0x10000>;
>                                 interrupts = <41>;
> +                               clocks = <&clks 26>;
>                         };
>  
>                         audio at b0040000 {
>                                 compatible = "sirf,prima2-audio";
>                                 reg = <0xb0040000 0x10000>;
>                                 interrupts = <35>;
> +                               clocks = <&clks 27>;
>                         };
>  
>                         uart0: uart at b0050000 {
> @@ -187,6 +196,7 @@
>                                 compatible = "sirf,prima2-uart";
>                                 reg = <0xb0050000 0x10000>;
>                                 interrupts = <17>;
> +                               clocks = <&clks 13>;
>                         };
>  
>                         uart1: uart at b0060000 {
> @@ -194,6 +204,7 @@
>                                 compatible = "sirf,prima2-uart";
>                                 reg = <0xb0060000 0x10000>;
>                                 interrupts = <18>;
> +                               clocks = <&clks 14>;
>                         };
>  
>                         uart2: uart at b0070000 {
> @@ -201,6 +212,7 @@
>                                 compatible = "sirf,prima2-uart";
>                                 reg = <0xb0070000 0x10000>;
>                                 interrupts = <19>;
> +                               clocks = <&clks 15>;
>                         };
>  
>                         usp0: usp at b0080000 {
> @@ -208,6 +220,7 @@
>                                 compatible = "sirf,prima2-usp";
>                                 reg = <0xb0080000 0x10000>;
>                                 interrupts = <20>;
> +                               clocks = <&clks 28>;
>                         };
>  
>                         usp1: usp at b0090000 {
> @@ -215,6 +228,7 @@
>                                 compatible = "sirf,prima2-usp";
>                                 reg = <0xb0090000 0x10000>;
>                                 interrupts = <21>;
> +                               clocks = <&clks 29>;
>                         };
>  
>                         usp2: usp at b00a0000 {
> @@ -222,6 +236,7 @@
>                                 compatible = "sirf,prima2-usp";
>                                 reg = <0xb00a0000 0x10000>;
>                                 interrupts = <22>;
> +                               clocks = <&clks 30>;
>                         };
>  
>                         dmac0: dma-controller at b00b0000 {
> @@ -229,6 +244,7 @@
>                                 compatible = "sirf,prima2-dmac";
>                                 reg = <0xb00b0000 0x10000>;
>                                 interrupts = <12>;
> +                               clocks = <&clks 24>;
>                         };
>  
>                         dmac1: dma-controller at b0160000 {
> @@ -236,11 +252,13 @@
>                                 compatible = "sirf,prima2-dmac";
>                                 reg = <0xb0160000 0x10000>;
>                                 interrupts = <13>;
> +                               clocks = <&clks 25>;
>                         };
>  
>                         vip at b00C0000 {
>                                 compatible = "sirf,prima2-vip";
>                                 reg = <0xb00C0000 0x10000>;
> +                               clocks = <&clks 31>;
>                         };
>  
>                         spi0: spi at b00d0000 {
> @@ -248,6 +266,7 @@
>                                 compatible = "sirf,prima2-spi";
>                                 reg = <0xb00d0000 0x10000>;
>                                 interrupts = <15>;
> +                               clocks = <&clks 19>;
>                         };
>  
>                         spi1: spi at b0170000 {
> @@ -255,6 +274,7 @@
>                                 compatible = "sirf,prima2-spi";
>                                 reg = <0xb0170000 0x10000>;
>                                 interrupts = <16>;
> +                               clocks = <&clks 20>;
>                         };
>  
>                         i2c0: i2c at b00e0000 {
> @@ -262,6 +282,7 @@
>                                 compatible = "sirf,prima2-i2c";
>                                 reg = <0xb00e0000 0x10000>;
>                                 interrupts = <24>;
> +                               clocks = <&clks 17>;
>                         };
>  
>                         i2c1: i2c at b00f0000 {
> @@ -269,12 +290,14 @@
>                                 compatible = "sirf,prima2-i2c";
>                                 reg = <0xb00f0000 0x10000>;
>                                 interrupts = <25>;
> +                               clocks = <&clks 18>;
>                         };
>  
>                         tsc at b0110000 {
>                                 compatible = "sirf,prima2-tsc";
>                                 reg = <0xb0110000 0x10000>;
>                                 interrupts = <33>;
> +                               clocks = <&clks 16>;
>                         };
>  
>                         gpio: pinctrl at b0120000 {
> @@ -507,17 +530,20 @@
>                         pwm at b0130000 {
>                                 compatible = "sirf,prima2-pwm";
>                                 reg = <0xb0130000 0x10000>;
> +                               clocks = <&clks 21>;
>                         };
>  
>                         efusesys at b0140000 {
>                                 compatible = "sirf,prima2-efuse";
>                                 reg = <0xb0140000 0x10000>;
> +                               clocks = <&clks 22>;
>                         };
>  
>                         pulsec at b0150000 {
>                                 compatible = "sirf,prima2-pulsec";
>                                 reg = <0xb0150000 0x10000>;
>                                 interrupts = <48>;
> +                               clocks = <&clks 23>;
>                         };
>  
>                         pci-iobg {
> @@ -616,12 +642,14 @@
>                                 compatible = "chipidea,ci13611a-prima2";
>                                 reg = <0xb8000000 0x10000>;
>                                 interrupts = <10>;
> +                               clocks = <&clks 40>;
>                         };
>  
>                         usb1: usb at b00f0000 {
>                                 compatible = "chipidea,ci13611a-prima2";
>                                 reg = <0xb8010000 0x10000>;
>                                 interrupts = <11>;
> +                               clocks = <&clks 41>;
>                         };
>  
>                         sata at b00f0000 {
> @@ -634,6 +662,7 @@
>                                 compatible = "sirf,prima2-security";
>                                 reg = <0xb8030000 0x10000>;
>                                 interrupts = <42>;
> +                               clocks = <&clks 7>;
>                         };
>                 };
>         };
> diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/clk-prima2.c
> index a203ecc..f8e9d0c 100644
> --- a/drivers/clk/clk-prima2.c
> +++ b/drivers/clk/clk-prima2.c
> @@ -1025,20 +1025,67 @@ static struct of_device_id rsc_ids[] = {
>         {},
>  };
>  
> +enum prima2_clk_index {
> +       /* 0    1     2      3      4      5      6       7         8      9 */
> +       rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
> +       mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
> +       spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
> +       usp2,   vip,   gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
> +       usb0,  usb1,  maxclk,
> +};
> +
> +static __initdata struct clk_hw* prima2_clk_hw_array[maxclk] = {
> +       NULL, /* dummy */
> +       NULL,
> +       &clk_pll1.hw,
> +       &clk_pll2.hw,
> +       &clk_pll3.hw,
> +       &clk_mem.hw,
> +       &clk_sys.hw,
> +       &clk_security.hw,
> +       &clk_dsp.hw,
> +       &clk_gps.hw,
> +       &clk_mf.hw,
> +       &clk_io.hw,
> +       &clk_cpu.hw,
> +       &clk_uart0.hw,
> +       &clk_uart1.hw,
> +       &clk_uart2.hw,
> +       &clk_tsc.hw,
> +       &clk_i2c0.hw,
> +       &clk_i2c1.hw,
> +       &clk_spi0.hw,
> +       &clk_spi1.hw,
> +       &clk_pwmc.hw,
> +       &clk_efuse.hw,
> +       &clk_pulse.hw,
> +       &clk_dmac0.hw,
> +       &clk_dmac1.hw,
> +       &clk_nand.hw,
> +       &clk_audio.hw,
> +       &clk_usp0.hw,
> +       &clk_usp1.hw,
> +       &clk_usp2.hw,
> +       &clk_vip.hw,
> +       &clk_gfx.hw,
> +       &clk_mm.hw,
> +       &clk_lcd.hw,
> +       &clk_vpp.hw,
> +       &clk_mmc01.hw,
> +       &clk_mmc23.hw,
> +       &clk_mmc45.hw,
> +       &usb_pll_clk_hw,
> +       &clk_usb0.hw,
> +       &clk_usb1.hw,
> +};
> +
> +static struct clk *prima2_clks[maxclk];
> +static struct clk_onecell_data clk_data;
> +
>  void __init sirfsoc_of_clk_init(void)
>  {
> -       struct clk *clk;
>         struct device_node *np;
> -
> -       np = of_find_matching_node(NULL, clkc_ids);
> -       if (!np)
> -               panic("unable to find compatible clkc node in dtb\n");
> -
> -       sirfsoc_clk_vbase = of_iomap(np, 0);
> -       if (!sirfsoc_clk_vbase)
> -               panic("unable to map clkc registers\n");
> -
> -       of_node_put(np);
> +       int i;
>  
>         np = of_find_matching_node(NULL, rsc_ids);
>         if (!np)
> @@ -1050,122 +1097,30 @@ void __init sirfsoc_of_clk_init(void)
>  
>         of_node_put(np);
>  
> +       np = of_find_matching_node(NULL, clkc_ids);
> +       if (!np)
> +               return;
> +
> +       sirfsoc_clk_vbase = of_iomap(np, 0);
> +       if (!sirfsoc_clk_vbase)
> +               panic("unable to map clkc registers\n");
>  
>         /* These are always available (RTC and 26MHz OSC)*/
> -       clk = clk_register_fixed_rate(NULL, "rtc", NULL,
> +       prima2_clks[rtc] = clk_register_fixed_rate(NULL, "rtc", NULL,
>                 CLK_IS_ROOT, 32768);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register_fixed_rate(NULL, "osc", NULL,
> +       prima2_clks[osc]= clk_register_fixed_rate(NULL, "osc", NULL,
>                 CLK_IS_ROOT, 26000000);
> -       BUG_ON(IS_ERR(clk));
> -
> -       clk = clk_register(NULL, &clk_pll1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_pll2.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_pll3.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_mem.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_sys.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_security.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b8030000.security");
> -       clk = clk_register(NULL, &clk_dsp.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_gps.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "a8010000.gps");
> -       clk = clk_register(NULL, &clk_mf.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_io.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "io");
> -       clk = clk_register(NULL, &clk_cpu.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "cpu");
> -       clk = clk_register(NULL, &clk_uart0.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0050000.uart");
> -       clk = clk_register(NULL, &clk_uart1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0060000.uart");
> -       clk = clk_register(NULL, &clk_uart2.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0070000.uart");
> -       clk = clk_register(NULL, &clk_tsc.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0110000.tsc");
> -       clk = clk_register(NULL, &clk_i2c0.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00e0000.i2c");
> -       clk = clk_register(NULL, &clk_i2c1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00f0000.i2c");
> -       clk = clk_register(NULL, &clk_spi0.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00d0000.spi");
> -       clk = clk_register(NULL, &clk_spi1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0170000.spi");
> -       clk = clk_register(NULL, &clk_pwmc.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0130000.pwm");
> -       clk = clk_register(NULL, &clk_efuse.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0140000.efusesys");
> -       clk = clk_register(NULL, &clk_pulse.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0150000.pulsec");
> -       clk = clk_register(NULL, &clk_dmac0.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00b0000.dma-controller");
> -       clk = clk_register(NULL, &clk_dmac1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0160000.dma-controller");
> -       clk = clk_register(NULL, &clk_nand.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0030000.nand");
> -       clk = clk_register(NULL, &clk_audio.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0040000.audio");
> -       clk = clk_register(NULL, &clk_usp0.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0080000.usp");
> -       clk = clk_register(NULL, &clk_usp1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b0090000.usp");
> -       clk = clk_register(NULL, &clk_usp2.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00a0000.usp");
> -       clk = clk_register(NULL, &clk_vip.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00c0000.vip");
> -       clk = clk_register(NULL, &clk_gfx.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "98000000.graphics");
> -       clk = clk_register(NULL, &clk_mm.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "a0000000.multimedia");
> -       clk = clk_register(NULL, &clk_lcd.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "90010000.display");
> -       clk = clk_register(NULL, &clk_vpp.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "90020000.vpp");
> -       clk = clk_register(NULL, &clk_mmc01.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_mmc23.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_mmc45.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &usb_pll_clk_hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk = clk_register(NULL, &clk_usb0.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00e0000.usb");
> -       clk = clk_register(NULL, &clk_usb1.hw);
> -       BUG_ON(IS_ERR(clk));
> -       clk_register_clkdev(clk, NULL, "b00f0000.usb");
> +
> +       for (i = pll1; i < maxclk; i++) {
> +               prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
> +               BUG_ON(!prima2_clks[i]);
> +       }
> +       clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
> +       clk_register_clkdev(prima2_clks[io],  NULL, "io");
> +       clk_register_clkdev(prima2_clks[mem],  NULL, "mem");
> +
> +       clk_data.clks = prima2_clks;
> +       clk_data.clk_num = maxclk;
> +
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  }
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
