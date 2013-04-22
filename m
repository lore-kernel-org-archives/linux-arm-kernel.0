From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 22 Apr 2013 15:01:16 -0700
Subject: [PATCH 3/4] ARM: nomadik: convert all clocks except timer to dt
In-Reply-To: <1366466974-16115-1-git-send-email-linus.walleij@linaro.org>
References: <1366466974-16115-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130422220116.17530.44985@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2013-04-20 07:09:34)
> This moves all Nomadik clocks except the one used for the
> timer/clocksource over to the device tree.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

For the clk-nomadik.c part:

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  .../devicetree/bindings/arm/ste-nomadik.txt        |  5 ++
>  arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 54 ++++++++++++++++++++++
>  arch/arm/mach-nomadik/cpu-8815.c                   | 20 +-------
>  drivers/clk/clk-nomadik.c                          | 26 +++--------
>  4 files changed, 68 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ste-nomadik.txt b/Documentation/devicetree/bindings/arm/ste-nomadik.txt
> index 19bca04..6256ec3 100644
> --- a/Documentation/devicetree/bindings/arm/ste-nomadik.txt
> +++ b/Documentation/devicetree/bindings/arm/ste-nomadik.txt
> @@ -3,6 +3,11 @@ ST-Ericsson Nomadik Device Tree Bindings
>  For various board the "board" node may contain specific properties
>  that pertain to this particular board, such as board-specific GPIOs.
>  
> +Required root node property: src
> +- Nomadik System and reset controller used for basic chip control, clock
> +  and reset line control.
> +- compatible: must be "stericsson,nomadik,src"
> +
>  Boards with the Nomadik SoC include:
>  
>  S8815 "MiniKit" manufactured by Calao Systems:
> diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
> index 4a4aab3..f0df948 100644
> --- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
> +++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
> @@ -45,6 +45,7 @@
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 gpio-bank = <0>;
> +               clocks = <&pclk>;
>         };
>  
>         gpio1: gpio at 101e5000 {
> @@ -57,6 +58,7 @@
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 gpio-bank = <1>;
> +               clocks = <&pclk>;
>         };
>  
>         gpio2: gpio at 101e6000 {
> @@ -69,6 +71,7 @@
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 gpio-bank = <2>;
> +               clocks = <&pclk>;
>         };
>  
>         gpio3: gpio at 101e7000 {
> @@ -81,12 +84,50 @@
>                 gpio-controller;
>                 #gpio-cells = <2>;
>                 gpio-bank = <3>;
> +               clocks = <&pclk>;
>         };
>  
>         pinctrl {
>                 compatible = "stericsson,nmk-pinctrl-stn8815";
>         };
>  
> +       src: src at 101e0000 {
> +               compatible = "stericsson,nomadik-src";
> +               reg = <0x101e0000 0x1000>;
> +               clocks {
> +                       /*
> +                        * Dummy clock for primecells
> +                        */
> +                       pclk: pclk at 0 {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <2400000>;
> +                       };
> +                       /*
> +                        * The 2.4 MHz TIMCLK reference clock is active at
> +                        * boot time, this is actually the MXTALCLK @19.2 MHz
> +                        * divided by 8. This clock is used by the timers and
> +                        * watchdog. See page 105 ff.
> +                        */
> +                       timclk: timclk at 2.4M {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <2400000>;
> +                       };
> +                       /*
> +                        * At boot time, PLL2 is set to generate a set of
> +                        * fixed clocks, one of them is CLK48, the 48 MHz
> +                        * clock, routed to the UART, MMC/SD, I2C, IrDA,
> +                        * USB and SSP blocks.
> +                        */
> +                       clk48: clk48 at 48M {
> +                               #clock-cells = <0>;
> +                               compatible = "fixed-clock";
> +                               clock-frequency = <48000000>;
> +                       };
> +               };
> +       };
> +
>         /* A NAND flash of 128 MiB */
>         fsmc: flash at 40000000 {
>                 compatible = "stericsson,fsmc-nand";
> @@ -97,6 +138,7 @@
>                         <0x41000000 0x2000>,    /* NAND Base ADDR */
>                         <0x40800000 0x2000>;    /* NAND Base CMD */
>                 reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
> +               clocks = <&pclk>;
>                 status = "okay";
>  
>                 partition at 0 {
> @@ -211,6 +253,8 @@
>                         reg = <0x101fd000 0x1000>;
>                         interrupt-parent = <&vica>;
>                         interrupts = <12>;
> +                       clocks = <&clk48>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
>                 };
>  
>                 uart1: uart at 101fb000 {
> @@ -218,6 +262,8 @@
>                         reg = <0x101fb000 0x1000>;
>                         interrupt-parent = <&vica>;
>                         interrupts = <17>;
> +                       clocks = <&clk48>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
>                 };
>  
>                 uart2: uart at 101f2000 {
> @@ -225,17 +271,23 @@
>                         reg = <0x101f2000 0x1000>;
>                         interrupt-parent = <&vica>;
>                         interrupts = <28>;
> +                       clocks = <&clk48>, <&pclk>;
> +                       clock-names = "uartclk", "apb_pclk";
>                         status = "disabled";
>                 };
>  
>                 rng: rng at 101b0000 {
>                         compatible = "arm,primecell";
>                         reg = <0x101b0000 0x1000>;
> +                       clocks = <&clk48>, <&pclk>;
> +                       clock-names = "rng", "apb_pclk";
>                 };
>  
>                 rtc: rtc at 101e8000 {
>                         compatible = "arm,pl031", "arm,primecell";
>                         reg = <0x101e8000 0x1000>;
> +                       clocks = <&pclk>;
> +                       clock-names = "apb_pclk";
>                         interrupt-parent = <&vica>;
>                         interrupts = <10>;
>                 };
> @@ -243,6 +295,8 @@
>                 mmcsd: sdi at 101f6000 {
>                         compatible = "arm,pl18x", "arm,primecell";
>                         reg = <0x101f6000 0x1000>;
> +                       clocks = <&clk48>, <&pclk>;
> +                       clock-names = "mclk", "apb_pclk";
>                         interrupt-parent = <&vica>;
>                         interrupts = <22>;
>                         max-frequency = <48000000>;
> diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
> index 59f6ff5..0e2c5e0 100644
> --- a/arch/arm/mach-nomadik/cpu-8815.c
> +++ b/arch/arm/mach-nomadik/cpu-8815.c
> @@ -280,28 +280,12 @@ device_initcall(cpu8815_mmcsd_init);
>  
>  /* These are mostly to get the right device names for the clock lookups */
>  static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
> -       OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO0_BASE,
> -               "gpio.0", NULL),
> -       OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO1_BASE,
> -               "gpio.1", NULL),
> -       OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO2_BASE,
> -               "gpio.2", NULL),
> -       OF_DEV_AUXDATA("st,nomadik-gpio", NOMADIK_GPIO3_BASE,
> -               "gpio.3", NULL),
>         OF_DEV_AUXDATA("stericsson,nmk-pinctrl-stn8815", 0,
>                 "pinctrl-stn8815", NULL),
> -       OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART0_BASE,
> -               "uart0", NULL),
> -       OF_DEV_AUXDATA("arm,primecell", NOMADIK_UART1_BASE,
> -               "uart1", NULL),
> -       OF_DEV_AUXDATA("arm,primecell", NOMADIK_RNG_BASE,
> -               "rng", NULL),
> -       OF_DEV_AUXDATA("arm,primecell", NOMADIK_RTC_BASE,
> -               "rtc-pl031", NULL),
>         OF_DEV_AUXDATA("stericsson,fsmc-nand", NOMADIK_FSMC_BASE,
> -               "fsmc-nand", &cpu8815_nand_data),
> +               NULL, &cpu8815_nand_data),
>         OF_DEV_AUXDATA("arm,primecell", NOMADIK_SDI_BASE,
> -               "mmci", &mmcsd_plat_data),
> +               NULL, &mmcsd_plat_data),
>         { /* sentinel */ },
>  };
>  
> diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> index 6b4c70f..19f197c 100644
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -3,24 +3,24 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/clk-provider.h>
> +#include <linux/of.h>
>  
>  /*
>   * The Nomadik clock tree is described in the STN8815A12 DB V4.2
>   * reference manual for the chip, page 94 ff.
>   */
>  
> +static const __initconst struct of_device_id cpu8815_clk_match[] = {
> +       { .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
> +       { /* sentinel */ }
> +};
> +
>  void __init nomadik_clk_init(void)
>  {
>         struct clk *clk;
>  
>         clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
>         clk_register_clkdev(clk, "apb_pclk", NULL);
> -       clk_register_clkdev(clk, NULL, "gpio.0");
> -       clk_register_clkdev(clk, NULL, "gpio.1");
> -       clk_register_clkdev(clk, NULL, "gpio.2");
> -       clk_register_clkdev(clk, NULL, "gpio.3");
> -       clk_register_clkdev(clk, NULL, "rng");
> -       clk_register_clkdev(clk, NULL, "fsmc-nand");
>  
>         /*
>          * The 2.4 MHz TIMCLK reference clock is active at boot time, this is
> @@ -32,17 +32,5 @@ void __init nomadik_clk_init(void)
>         clk_register_clkdev(clk, NULL, "mtu0");
>         clk_register_clkdev(clk, NULL, "mtu1");
>  
> -       /*
> -        * At boot time, PLL2 is set to generate a set of fixed clocks,
> -        * one of them is CLK48, the 48 MHz clock, routed to the UART, MMC/SD
> -        * I2C, IrDA, USB and SSP blocks.
> -        */
> -       clk = clk_register_fixed_rate(NULL, "CLK48", NULL, CLK_IS_ROOT,
> -                                     48000000);
> -       clk_register_clkdev(clk, NULL, "uart0");
> -       clk_register_clkdev(clk, NULL, "uart1");
> -       clk_register_clkdev(clk, NULL, "mmci");
> -       clk_register_clkdev(clk, NULL, "ssp");
> -       clk_register_clkdev(clk, NULL, "nmk-i2c.0");
> -       clk_register_clkdev(clk, NULL, "nmk-i2c.1");
> +       of_clk_init(cpu8815_clk_match);
>  }
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
