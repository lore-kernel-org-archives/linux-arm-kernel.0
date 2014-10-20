From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon, 20 Oct 2014 15:18:27 +0530
Subject: [PATCH 3/7] clk: samsung: exynos7: add clocks for RTC block
In-Reply-To: <1413562315-12283-4-git-send-email-a.kesavan@samsung.com>
References: <1413562315-12283-1-git-send-email-a.kesavan@samsung.com>
 <1413562315-12283-4-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAFp+6iG4Wv6cn6p2sxX1bMJjfkeDrZa_zKjeR7+iWqwN-TkX=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,


On Fri, Oct 17, 2014 at 9:41 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
>
> Add clock support for the RTC block in Exynos7.
>
> Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  .../devicetree/bindings/clock/exynos7-clock.txt    |    1 +
>  drivers/clk/samsung/clk-exynos7.c                  |   54 ++++++++++++++++++++
>  include/dt-bindings/clock/exynos7-clk.h            |   17 +++---
>  3 files changed, 66 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> index 4c69b66..aff6fd2 100644
> --- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> @@ -28,6 +28,7 @@ Required Properties for Clock Controller:
>         - "samsung,exynos7-clock-topc"
>         - "samsung,exynos7-clock-top0"
>         - "samsung,exynos7-clock-top1"
> +       - "samsung,exynos7-clock-ccore"

just a nit.
you need to mention the clock sources for this block too, like it's
there for every other block in this Documentation ?

>         - "samsung,exynos7-clock-peric0"
>         - "samsung,exynos7-clock-peric1"
>         - "samsung,exynos7-clock-peris"
> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
> index f5e43fa..3a30f43 100644
> --- a/drivers/clk/samsung/clk-exynos7.c
> +++ b/drivers/clk/samsung/clk-exynos7.c
> @@ -29,7 +29,9 @@
>  #define AUD_PLL_CON0           0x0140
>  #define MUX_SEL_TOPC0          0x0200
>  #define MUX_SEL_TOPC1          0x0204
> +#define MUX_SEL_TOPC2          0x0208
>  #define MUX_SEL_TOPC3          0x020C
> +#define DIV_TOPC0              0x0600
>  #define DIV_TOPC1              0x0604
>  #define DIV_TOPC3              0x060C
>
> @@ -78,7 +80,9 @@ static unsigned long topc_clk_regs[] __initdata = {
>         AUD_PLL_CON0,
>         MUX_SEL_TOPC0,
>         MUX_SEL_TOPC1,
> +       MUX_SEL_TOPC2,
>         MUX_SEL_TOPC3,
> +       DIV_TOPC0,
>         DIV_TOPC1,
>         DIV_TOPC3,
>  };
> @@ -101,10 +105,15 @@ static struct samsung_mux_clock topc_mux_clks[] __initdata = {
>         MUX(0, "mout_sclk_bus0_pll_out", mout_sclk_bus0_pll_out_p,
>                 MUX_SEL_TOPC1, 16, 1),
>
> +       MUX(0, "mout_aclk_ccore_133", mout_topc_group2, MUX_SEL_TOPC2, 4, 2),
> +
>         MUX(0, "mout_aclk_peris_66", mout_topc_group2, MUX_SEL_TOPC3, 24, 2),
>  };
>
>  static struct samsung_div_clock topc_div_clks[] __initdata = {
> +       DIV(DOUT_ACLK_CCORE_133, "dout_aclk_ccore_133", "mout_aclk_ccore_133",
> +               DIV_TOPC0, 4, 4),
> +
>         DIV(DOUT_ACLK_PERIS, "dout_aclk_peris_66", "mout_aclk_peris_66",
>                 DIV_TOPC1, 24, 4),
>
> @@ -393,6 +402,51 @@ static void __init exynos7_clk_top1_init(struct device_node *np)
>  CLK_OF_DECLARE(exynos7_clk_top1, "samsung,exynos7-clock-top1",
>         exynos7_clk_top1_init);
>
> +/* Register Offset definitions for CMU_CCORE (0x105B0000) */
> +#define MUX_SEL_CCORE                  0x0200
> +#define DIV_CCORE                      0x0600
> +#define ENABLE_ACLK_CCORE0             0x0800
> +#define ENABLE_ACLK_CCORE1             0x0804
> +#define ENABLE_PCLK_CCORE              0x0900
> +
> +/*
> + * List of parent clocks for Muxes in CMU_CCORE
> + */
> +PNAME(mout_aclk_ccore_133_p)   = { "fin_pll", "dout_aclk_ccore_133" };
> +
> +static unsigned long ccore_clk_regs[] __initdata = {
> +       MUX_SEL_CCORE,
> +       ENABLE_PCLK_CCORE,
> +};
> +
> +static struct samsung_mux_clock ccore_mux_clks[] __initdata = {
> +       MUX(0, "mout_aclk_ccore_133_user", mout_aclk_ccore_133_p,
> +               MUX_SEL_CCORE, 1, 1),
> +};
> +
> +static struct samsung_gate_clock ccore_gate_clks[] __initdata = {
> +       GATE(PCLK_RTC, "pclk_rtc", "mout_aclk_ccore_133_user",
> +               ENABLE_PCLK_CCORE, 8, 0, 0),
> +};
> +
> +static struct samsung_cmu_info ccore_cmu_info __initdata = {
> +       .mux_clks               = ccore_mux_clks,
> +       .nr_mux_clks            = ARRAY_SIZE(ccore_mux_clks),
> +       .gate_clks              = ccore_gate_clks,
> +       .nr_gate_clks           = ARRAY_SIZE(ccore_gate_clks),
> +       .nr_clk_ids             = CCORE_NR_CLK,
> +       .clk_regs               = ccore_clk_regs,
> +       .nr_clk_regs            = ARRAY_SIZE(ccore_clk_regs),
> +};
> +
> +static void __init exynos7_clk_ccore_init(struct device_node *np)
> +{
> +       samsung_cmu_register_one(np, &ccore_cmu_info);
> +}
> +
> +CLK_OF_DECLARE(exynos7_clk_ccore, "samsung,exynos7-clock-ccore",
> +       exynos7_clk_ccore_init);
> +
>  /* Register Offset definitions for CMU_PERIC0 (0x13610000) */
>  #define MUX_SEL_PERIC0                 0x0200
>  #define ENABLE_PCLK_PERIC0             0x0900
> diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
> index ff63c4e..3227679 100644
> --- a/include/dt-bindings/clock/exynos7-clk.h
> +++ b/include/dt-bindings/clock/exynos7-clk.h
> @@ -11,12 +11,13 @@
>  #define _DT_BINDINGS_CLOCK_EXYNOS7_H
>
>  /* TOPC */
> -#define DOUT_ACLK_PERIS                        1
> -#define DOUT_SCLK_BUS0_PLL             2
> -#define DOUT_SCLK_BUS1_PLL             3
> -#define DOUT_SCLK_CC_PLL               4
> -#define DOUT_SCLK_MFC_PLL              5
> -#define TOPC_NR_CLK                    6
> +#define DOUT_ACLK_CCORE_133            1
> +#define DOUT_ACLK_PERIS                        2
> +#define DOUT_SCLK_BUS0_PLL             3
> +#define DOUT_SCLK_BUS1_PLL             4
> +#define DOUT_SCLK_CC_PLL               5
> +#define DOUT_SCLK_MFC_PLL              6
> +#define TOPC_NR_CLK                    7
>
>  /* TOP0 */
>  #define DOUT_ACLK_PERIC1               1
> @@ -38,6 +39,10 @@
>  #define CLK_SCLK_MMC0                  8
>  #define TOP1_NR_CLK                    9
>
> +/* CCORE */
> +#define PCLK_RTC                       1
> +#define CCORE_NR_CLK                   2
> +
>  /* PERIC0 */
>  #define PCLK_UART0                     1
>  #define SCLK_UART0                     2
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
