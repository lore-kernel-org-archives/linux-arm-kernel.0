From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 30 May 2013 12:00:12 -0700
Subject: [PATCH 3/6] clk: move the U300 fixed and fixed-factor to DT
In-Reply-To: <1369330288-14856-4-git-send-email-linus.walleij@stericsson.com>
References: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
 <1369330288-14856-4-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130530190012.4470.50181@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2013-05-23 10:31:25)
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This converts the fixed and fixed-factor clocks in the U300
> platform to register themselves from the device tree.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Mike, seeking an ACK on this to take the series through
> ARM SoC.

I'm happy to see another conversion to of_clk_init.

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  arch/arm/boot/dts/ste-u300.dts | 44 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk-u300.c         | 33 +++++++++++++------------------
>  2 files changed, 57 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
> index 0530095..c51a8c7 100644
> --- a/arch/arm/boot/dts/ste-u300.dts
> +++ b/arch/arm/boot/dts/ste-u300.dts
> @@ -33,6 +33,49 @@
>         syscon: syscon at c0011000 {
>                 compatible = "stericsson,u300-syscon";
>                 reg = <0xc0011000 0x1000>;
> +               clk32: app_32_clk at 32k {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <32768>;
> +               };
> +               pll13: pll13 at 13M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <13000000>;
> +               };
> +               pll208: pll208 at 208M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <208000000>;
> +               };
> +               app208: app_208_clk at 208M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <1>;
> +                       clock-mult = <1>;
> +                       clocks = <&pll208>;
> +               };
> +               app104: app_104_clk at 104M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <2>;
> +                       clock-mult = <1>;
> +                       clocks = <&pll208>;
> +               };
> +               app52: app_52_clk at 52M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <4>;
> +                       clock-mult = <1>;
> +                       clocks = <&pll208>;
> +               };
> +               app26: app_26_clk at 26M {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-factor-clock";
> +                       clock-div = <2>;
> +                       clock-mult = <1>;
> +                       clocks = <&app52>;
> +               };
>         };
>  
>         timer: timer at c0014000 {
> @@ -65,6 +108,7 @@
>                 reg = <0xc0012000 0x1000>;
>                 interrupt-parent = <&vicb>;
>                 interrupts = <3>;
> +               clocks = <&clk32>;
>         };
>  
>         rtc: rtc at c0017000 {
> diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
> index a41e42e..bebd6c9 100644
> --- a/drivers/clk/clk-u300.c
> +++ b/drivers/clk/clk-u300.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/clk-provider.h>
>  #include <linux/spinlock.h>
> +#include <linux/of.h>
>  
>  /* APP side SYSCON registers */
>  /* CLK Control Register 16bit (R/W) */
> @@ -931,6 +932,17 @@ mclk_clk_register(struct device *dev, const char *name,
>         return clk;
>  }
>  
> +static const __initconst struct of_device_id u300_clk_match[] = {
> +       {
> +               .compatible = "fixed-clock",
> +               .data = of_fixed_clk_setup,
> +       },
> +       {
> +               .compatible = "fixed-factor-clock",
> +               .data = of_fixed_factor_clk_setup,
> +       },
> +};
> +
>  void __init u300_clk_init(void __iomem *base)
>  {
>         u16 val;
> @@ -951,26 +963,7 @@ void __init u300_clk_init(void __iomem *base)
>         val |= U300_SYSCON_PMCR_PWR_MGNT_ENABLE;
>         writew(val, syscon_vbase + U300_SYSCON_PMCR);
>  
> -       /* These are always available (RTC and PLL13) */
> -       clk = clk_register_fixed_rate(NULL, "app_32_clk", NULL,
> -                                     CLK_IS_ROOT, 32768);
> -       /* The watchdog sits directly on the 32 kHz clock */
> -       clk_register_clkdev(clk, NULL, "coh901327_wdog");
> -       clk = clk_register_fixed_rate(NULL, "pll13", NULL,
> -                                     CLK_IS_ROOT, 13000000);
> -
> -       /* These derive from PLL208 */
> -       clk = clk_register_fixed_rate(NULL, "pll208", NULL,
> -                                     CLK_IS_ROOT, 208000000);
> -       clk = clk_register_fixed_factor(NULL, "app_208_clk", "pll208",
> -                                       0, 1, 1);
> -       clk = clk_register_fixed_factor(NULL, "app_104_clk", "pll208",
> -                                       0, 1, 2);
> -       clk = clk_register_fixed_factor(NULL, "app_52_clk", "pll208",
> -                                       0, 1, 4);
> -       /* The 52 MHz is divided down to 26 MHz */
> -       clk = clk_register_fixed_factor(NULL, "app_26_clk", "app_52_clk",
> -                                       0, 1, 2);
> +       of_clk_init(u300_clk_match);
>  
>         /* Directly on the AMBA interconnect */
>         clk = syscon_clk_register(NULL, "cpu_clk", "app_208_clk", 0, true,
> -- 
> 1.7.11.3
