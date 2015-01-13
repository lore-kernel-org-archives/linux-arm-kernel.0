From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Tue, 13 Jan 2015 15:59:22 +0530
Subject: [PATCH 3/4] clk: samsung: exynos7: add clocks for audio block
In-Reply-To: <1418995427-7712-4-git-send-email-padma.v@samsung.com>
References: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
 <1418995427-7712-4-git-send-email-padma.v@samsung.com>
Message-ID: <CAFp+6iEJ48tbec7VqWYmdN-Zb-7zB+xUWaECd5EFZO1eMxEpVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padma,


On Fri, Dec 19, 2014 at 6:53 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Add required clk support for I2S,PCM amd SPDIF
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---

verified from Exynos7 datasheet. The patch looks good.
Reviewed-by: Vivek Gautam <gautam.vivek@samsung.com>

>  .../devicetree/bindings/clock/exynos7-clock.txt    |    6 +
>  drivers/clk/samsung/clk-exynos7.c                  |  144 +++++++++++++++++++-
>  include/dt-bindings/clock/exynos7-clk.h            |   24 +++-
>  3 files changed, 169 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/exynos7-clock.txt b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> index 6d3d5f8..3b439ed 100644
> --- a/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos7-clock.txt
> @@ -34,6 +34,7 @@ Required Properties for Clock Controller:
>         - "samsung,exynos7-clock-peris"
>         - "samsung,exynos7-clock-fsys0"
>         - "samsung,exynos7-clock-fsys1"
> +       - "samsung,exynos7-clock-aud"
>
>   - reg: physical base address of the controller and the length of
>         memory mapped region.
> @@ -53,6 +54,7 @@ Input clocks for top0 clock controller:
>         - dout_sclk_bus1_pll
>         - dout_sclk_cc_pll
>         - dout_sclk_mfc_pll
> +       - dout_sclk_aud_pll
>
>  Input clocks for top1 clock controller:
>         - fin_pll
> @@ -91,3 +93,7 @@ Input clocks for fsys1 clock controller:
>         - dout_aclk_fsys1_200
>         - dout_sclk_mmc0
>         - dout_sclk_mmc1
> +
> +Input clocks for aud clock controller:
> +       - fin_pll
> +       - fout_aud_pll
> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
> index cf5e50e..e4bc241 100644
> --- a/drivers/clk/samsung/clk-exynos7.c
> +++ b/drivers/clk/samsung/clk-exynos7.c
> @@ -45,6 +45,7 @@ static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
>  };
>
>  /* List of parent clocks for Muxes in CMU_TOPC */
> +PNAME(mout_aud_pll_ctrl_p)     = { "fin_pll", "fout_aud_pll" };
>  PNAME(mout_bus0_pll_ctrl_p)    = { "fin_pll", "fout_bus0_pll" };
>  PNAME(mout_bus1_pll_ctrl_p)    = { "fin_pll", "fout_bus1_pll" };
>  PNAME(mout_cc_pll_ctrl_p)      = { "fin_pll", "fout_cc_pll" };
> @@ -104,6 +105,7 @@ static struct samsung_mux_clock topc_mux_clks[] __initdata = {
>
>         MUX(0, "mout_sclk_bus0_pll_out", mout_sclk_bus0_pll_out_p,
>                 MUX_SEL_TOPC1, 16, 1),
> +       MUX(0, "mout_aud_pll_ctrl", mout_aud_pll_ctrl_p, MUX_SEL_TOPC1, 0, 1),
>
>         MUX(0, "mout_aclk_ccore_133", mout_topc_group2, MUX_SEL_TOPC2, 4, 2),
>
> @@ -125,6 +127,13 @@ static struct samsung_div_clock topc_div_clks[] __initdata = {
>                 DIV_TOPC3, 12, 3),
>         DIV(DOUT_SCLK_MFC_PLL, "dout_sclk_mfc_pll", "mout_mfc_pll_ctrl",
>                 DIV_TOPC3, 16, 3),
> +       DIV(DOUT_SCLK_AUD_PLL, "dout_sclk_aud_pll", "mout_aud_pll_ctrl",
> +               DIV_TOPC3, 28, 3),
> +};
> +
> +static struct samsung_pll_rate_table pll1460x_24mhz_tbl[] __initdata = {
> +       PLL_36XX_RATE(491520000, 20, 1, 0, 31457),
> +       {},
>  };
>
>  static struct samsung_pll_clock topc_pll_clks[] __initdata = {
> @@ -136,8 +145,8 @@ static struct samsung_pll_clock topc_pll_clks[] __initdata = {
>                 BUS1_DPLL_CON0, NULL),
>         PLL(pll_1452x, 0, "fout_mfc_pll", "fin_pll", MFC_PLL_LOCK,
>                 MFC_PLL_CON0, NULL),
> -       PLL(pll_1460x, 0, "fout_aud_pll", "fin_pll", AUD_PLL_LOCK,
> -               AUD_PLL_CON0, NULL),
> +       PLL(pll_1460x, FOUT_AUD_PLL, "fout_aud_pll", "fin_pll", AUD_PLL_LOCK,
> +               AUD_PLL_CON0, pll1460x_24mhz_tbl),
>  };
>
>  static struct samsung_cmu_info topc_cmu_info __initdata = {
> @@ -166,13 +175,16 @@ CLK_OF_DECLARE(exynos7_clk_topc, "samsung,exynos7-clock-topc",
>  #define MUX_SEL_TOP00                  0x0200
>  #define MUX_SEL_TOP01                  0x0204
>  #define MUX_SEL_TOP03                  0x020C
> +#define MUX_SEL_TOP0_PERIC0            0x0230
>  #define MUX_SEL_TOP0_PERIC1            0x0234
>  #define MUX_SEL_TOP0_PERIC2            0x0238
>  #define MUX_SEL_TOP0_PERIC3            0x023C
>  #define DIV_TOP03                      0x060C
> +#define DIV_TOP0_PERIC0                        0x0630
>  #define DIV_TOP0_PERIC1                        0x0634
>  #define DIV_TOP0_PERIC2                        0x0638
>  #define DIV_TOP0_PERIC3                        0x063C
> +#define ENABLE_SCLK_TOP0_PERIC0                0x0A30
>  #define ENABLE_SCLK_TOP0_PERIC1                0x0A34
>  #define ENABLE_SCLK_TOP0_PERIC2                0x0A38
>  #define ENABLE_SCLK_TOP0_PERIC3                0x0A3C
> @@ -182,6 +194,8 @@ PNAME(mout_bus0_pll_p)      = { "fin_pll", "dout_sclk_bus0_pll" };
>  PNAME(mout_bus1_pll_p) = { "fin_pll", "dout_sclk_bus1_pll" };
>  PNAME(mout_cc_pll_p)   = { "fin_pll", "dout_sclk_cc_pll" };
>  PNAME(mout_mfc_pll_p)  = { "fin_pll", "dout_sclk_mfc_pll" };
> +PNAME(mout_aud_pll_p)  = { "fin_pll", "dout_sclk_aud_pll" };
> +

nit: unnecessary additional line.

>
>  PNAME(mout_top0_half_bus0_pll_p) = {"mout_top0_bus0_pll",
>         "ffac_top0_bus0_pll_div2"};
> @@ -195,24 +209,34 @@ PNAME(mout_top0_half_mfc_pll_p) = {"mout_top0_mfc_pll",
>  PNAME(mout_top0_group1) = {"mout_top0_half_bus0_pll",
>         "mout_top0_half_bus1_pll", "mout_top0_half_cc_pll",
>         "mout_top0_half_mfc_pll"};
> +PNAME(mout_top0_group3) = {"ioclk_audiocdclk0",
> +       "ioclk_audiocdclk1", "ioclk_spdif_extclk",
> +       "mout_top0_aud_pll", "mout_top0_half_bus0_pll",
> +       "mout_top0_half_bus1_pll"};
> +PNAME(mout_top0_group4) = {"ioclk_audiocdclk1", "mout_top0_aud_pll",
> +       "mout_top0_half_bus0_pll", "mout_top0_half_bus1_pll"};
>
>  static unsigned long top0_clk_regs[] __initdata = {
>         MUX_SEL_TOP00,
>         MUX_SEL_TOP01,
>         MUX_SEL_TOP03,
> +       MUX_SEL_TOP0_PERIC0,
>         MUX_SEL_TOP0_PERIC1,
>         MUX_SEL_TOP0_PERIC2,
>         MUX_SEL_TOP0_PERIC3,
>         DIV_TOP03,
> +       DIV_TOP0_PERIC0,
>         DIV_TOP0_PERIC1,
>         DIV_TOP0_PERIC2,
>         DIV_TOP0_PERIC3,
> +       ENABLE_SCLK_TOP0_PERIC0,
>         ENABLE_SCLK_TOP0_PERIC1,
>         ENABLE_SCLK_TOP0_PERIC2,
>         ENABLE_SCLK_TOP0_PERIC3,
>  };
>
>  static struct samsung_mux_clock top0_mux_clks[] __initdata = {
> +       MUX(0, "mout_top0_aud_pll", mout_aud_pll_p, MUX_SEL_TOP00, 0, 1),
>         MUX(0, "mout_top0_mfc_pll", mout_mfc_pll_p, MUX_SEL_TOP00, 4, 1),
>         MUX(0, "mout_top0_cc_pll", mout_cc_pll_p, MUX_SEL_TOP00, 8, 1),
>         MUX(0, "mout_top0_bus1_pll", mout_bus1_pll_p, MUX_SEL_TOP00, 12, 1),
> @@ -230,6 +254,10 @@ static struct samsung_mux_clock top0_mux_clks[] __initdata = {
>         MUX(0, "mout_aclk_peric1_66", mout_top0_group1, MUX_SEL_TOP03, 12, 2),
>         MUX(0, "mout_aclk_peric0_66", mout_top0_group1, MUX_SEL_TOP03, 20, 2),
>
> +       MUX(0, "mout_sclk_spdif", mout_top0_group3, MUX_SEL_TOP0_PERIC0, 4, 3),
> +       MUX(0, "mout_sclk_pcm1", mout_top0_group4, MUX_SEL_TOP0_PERIC0, 8, 2),
> +       MUX(0, "mout_sclk_i2s1", mout_top0_group4, MUX_SEL_TOP0_PERIC0, 20, 2),
> +
>         MUX(0, "mout_sclk_spi1", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 8, 2),
>         MUX(0, "mout_sclk_spi0", mout_top0_group1, MUX_SEL_TOP0_PERIC1, 20, 2),
>
> @@ -248,6 +276,10 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
>         DIV(DOUT_ACLK_PERIC0, "dout_aclk_peric0_66", "mout_aclk_peric0_66",
>                 DIV_TOP03, 20, 6),
>
> +       DIV(0, "dout_sclk_spdif", "mout_sclk_spdif", DIV_TOP0_PERIC0, 4, 4),
> +       DIV(0, "dout_sclk_pcm1", "mout_sclk_pcm1", DIV_TOP0_PERIC0, 8, 12),
> +       DIV(0, "dout_sclk_i2s1", "mout_sclk_i2s1", DIV_TOP0_PERIC0, 20, 10),
> +
>         DIV(0, "dout_sclk_spi1", "mout_sclk_spi1", DIV_TOP0_PERIC1, 8, 12),
>         DIV(0, "dout_sclk_spi0", "mout_sclk_spi0", DIV_TOP0_PERIC1, 20, 12),
>
> @@ -262,6 +294,13 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
>  };
>
>  static struct samsung_gate_clock top0_gate_clks[] __initdata = {
> +       GATE(CLK_SCLK_SPDIF, "sclk_spdif", "dout_sclk_spdif",
> +               ENABLE_SCLK_TOP0_PERIC0, 4, CLK_SET_RATE_PARENT, 0),
> +       GATE(CLK_SCLK_PCM1, "sclk_pcm1", "dout_sclk_pcm1",
> +               ENABLE_SCLK_TOP0_PERIC0, 8, CLK_SET_RATE_PARENT, 0),
> +       GATE(CLK_SCLK_I2S1, "sclk_i2s1", "dout_sclk_i2s1",
> +               ENABLE_SCLK_TOP0_PERIC0, 20, CLK_SET_RATE_PARENT, 0),
> +
>         GATE(CLK_SCLK_SPI1, "sclk_spi1", "dout_sclk_spi1",
>                 ENABLE_SCLK_TOP0_PERIC1, 8, CLK_SET_RATE_PARENT, 0),
>         GATE(CLK_SCLK_SPI0, "sclk_spi0", "dout_sclk_spi0",
> @@ -631,6 +670,12 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
>                 ENABLE_PCLK_PERIC1, 15, 0, 0),
>         GATE(PCLK_SPI4, "pclk_spi4", "mout_aclk_peric1_66_user",
>                 ENABLE_PCLK_PERIC1, 16, 0, 0),
> +       GATE(PCLK_I2S1, "pclk_i2s1", "mout_aclk_peric1_66_user",
> +               ENABLE_PCLK_PERIC1, 17, CLK_SET_RATE_PARENT, 0),
> +       GATE(PCLK_PCM1, "pclk_pcm1", "mout_aclk_peric1_66_user",
> +               ENABLE_PCLK_PERIC1, 18, 0, 0),
> +       GATE(PCLK_SPDIF, "pclk_spdif", "mout_aclk_peric1_66_user",
> +               ENABLE_PCLK_PERIC1, 19, 0, 0),
>
>         GATE(SCLK_UART1, "sclk_uart1_user", "mout_sclk_uart1_user",
>                 ENABLE_SCLK_PERIC10, 9, 0, 0),
> @@ -648,6 +693,12 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
>                 ENABLE_SCLK_PERIC10, 15, CLK_SET_RATE_PARENT, 0),
>         GATE(SCLK_SPI4, "sclk_spi4_user", "mout_sclk_spi4_user",
>                 ENABLE_SCLK_PERIC10, 16, CLK_SET_RATE_PARENT, 0),
> +       GATE(SCLK_I2S1, "sclk_i2s1_user", "dout_sclk_i2s1",
> +               ENABLE_SCLK_PERIC10, 17, 0, 0),
> +       GATE(SCLK_PCM1, "sclk_pcm1_user", "dout_sclk_pcm1",
> +               ENABLE_SCLK_PERIC10, 18, 0, 0),
> +       GATE(SCLK_SPDIF, "sclk_spdif_user", "dout_sclk_spdif",
> +               ENABLE_SCLK_PERIC10, 19, 0, 0),
>  };
>
>  static struct samsung_cmu_info peric1_cmu_info __initdata = {
> @@ -882,3 +933,92 @@ static void __init exynos7_clk_fsys1_init(struct device_node *np)
>
>  CLK_OF_DECLARE(exynos7_clk_fsys1, "samsung,exynos7-clock-fsys1",
>         exynos7_clk_fsys1_init);
> +
> +/* Register Offset definitions for CMU_AUD (0x114C0000) */
> +#define        MUX_SEL_AUD                     0x0200
> +#define        DIV_AUD0                        0x0600
> +#define        DIV_AUD1                        0x0604
> +#define        ENABLE_ACLK_AUD                 0x0800
> +#define        ENABLE_PCLK_AUD                 0x0900
> +#define        ENABLE_SCLK_AUD                 0x0A00
> +
> +/*
> + * List of parent clocks for Muxes in CMU_AUD
> + */
> +PNAME(mout_aud_pll_user_p) = { "fin_pll", "fout_aud_pll" };
> +PNAME(mout_aud_group_p) = { "dout_aud_cdclk", "ioclk_audiocdclk0" };
> +
> +static unsigned long aud_clk_regs[] __initdata = {
> +       MUX_SEL_AUD,
> +       DIV_AUD0,
> +       DIV_AUD1,
> +       ENABLE_ACLK_AUD,
> +       ENABLE_PCLK_AUD,
> +       ENABLE_SCLK_AUD,
> +};
> +
> +static struct samsung_mux_clock aud_mux_clks[] __initdata = {
> +       MUX(0, "mout_sclk_i2s", mout_aud_group_p, MUX_SEL_AUD, 12, 1),
> +       MUX(0, "mout_sclk_pcm", mout_aud_group_p, MUX_SEL_AUD, 16, 1),
> +       MUX(0, "mout_aud_pll_user", mout_aud_pll_user_p, MUX_SEL_AUD, 20, 1),
> +};
> +
> +static struct samsung_div_clock aud_div_clks[] __initdata = {
> +       DIV(0, "dout_aud_ca5", "mout_aud_pll_user", DIV_AUD0, 0, 4),
> +       DIV(0, "dout_aclk_aud", "dout_aud_ca5", DIV_AUD0, 4, 4),
> +       DIV(0, "dout_aud_pclk_dbg", "dout_aud_ca5", DIV_AUD0, 8, 4),
> +
> +       DIV(0, "dout_sclk_i2s", "mout_sclk_i2s", DIV_AUD1, 0, 4),
> +       DIV(0, "dout_sclk_pcm", "mout_sclk_pcm", DIV_AUD1, 4, 8),
> +       DIV(0, "dout_sclk_uart", "dout_aud_cdclk", DIV_AUD1, 12, 4),
> +       DIV(0, "dout_sclk_slimbus", "dout_aud_cdclk", DIV_AUD1, 16, 5),
> +       DIV(0, "dout_aud_cdclk", "mout_aud_pll_user", DIV_AUD1, 24, 4),
> +};
> +
> +static struct samsung_gate_clock aud_gate_clks[] __initdata = {
> +       GATE(SCLK_PCM, "sclk_pcm", "dout_sclk_pcm",
> +                       ENABLE_SCLK_AUD, 27, CLK_SET_RATE_PARENT, 0),
> +       GATE(SCLK_I2S, "sclk_i2s", "dout_sclk_i2s",
> +                       ENABLE_SCLK_AUD, 28, CLK_SET_RATE_PARENT, 0),
> +       GATE(0, "sclk_uart", "dout_sclk_uart", ENABLE_SCLK_AUD, 29, 0, 0),
> +       GATE(0, "sclk_slimbus", "dout_sclk_slimbus",
> +                       ENABLE_SCLK_AUD, 30, 0, 0),
> +
> +       GATE(0, "pclk_dbg_aud", "dout_aud_pclk_dbg", ENABLE_PCLK_AUD, 19, 0, 0),
> +       GATE(0, "pclk_gpio_aud", "dout_aclk_aud", ENABLE_PCLK_AUD, 20, 0, 0),
> +       GATE(0, "pclk_wdt1", "dout_aclk_aud", ENABLE_PCLK_AUD, 22, 0, 0),
> +       GATE(0, "pclk_wdt0", "dout_aclk_aud", ENABLE_PCLK_AUD, 23, 0, 0),
> +       GATE(0, "pclk_slimbus", "dout_aclk_aud", ENABLE_PCLK_AUD, 24, 0, 0),
> +       GATE(0, "pclk_uart", "dout_aclk_aud", ENABLE_PCLK_AUD, 25, 0, 0),
> +       GATE(PCLK_PCM, "pclk_pcm", "dout_aclk_aud",
> +                       ENABLE_PCLK_AUD, 26, CLK_SET_RATE_PARENT, 0),
> +       GATE(PCLK_I2S, "pclk_i2s", "dout_aclk_aud",
> +                       ENABLE_PCLK_AUD, 27, CLK_SET_RATE_PARENT, 0),
> +       GATE(0, "pclk_timer", "dout_aclk_aud", ENABLE_PCLK_AUD, 28, 0, 0),
> +       GATE(0, "pclk_smmu_aud", "dout_aclk_aud", ENABLE_PCLK_AUD, 31, 0, 0),
> +
> +       GATE(0, "aclk_smmu_aud", "dout_aclk_aud", ENABLE_ACLK_AUD, 27, 0, 0),
> +       GATE(0, "aclk_acel_lh_async_si_top", "dout_aclk_aud",
> +                        ENABLE_ACLK_AUD, 28, 0, 0),
> +       GATE(ACLK_ADMA, "aclk_dmac", "dout_aclk_aud", ENABLE_ACLK_AUD, 31, 0, 0),
> +};
> +
> +static struct samsung_cmu_info aud_cmu_info __initdata = {
> +       .mux_clks               = aud_mux_clks,
> +       .nr_mux_clks            = ARRAY_SIZE(aud_mux_clks),
> +       .div_clks               = aud_div_clks,
> +       .nr_div_clks            = ARRAY_SIZE(aud_div_clks),
> +       .gate_clks              = aud_gate_clks,
> +       .nr_gate_clks           = ARRAY_SIZE(aud_gate_clks),
> +       .nr_clk_ids             = AUD_NR_CLK,
> +       .clk_regs               = aud_clk_regs,
> +       .nr_clk_regs            = ARRAY_SIZE(aud_clk_regs),
> +};
> +
> +static void __init exynos7_clk_aud_init(struct device_node *np)
> +{
> +       samsung_cmu_register_one(np, &aud_cmu_info);
> +}
> +
> +CLK_OF_DECLARE(exynos7_clk_aud, "samsung,exynos7-clock-aud",
> +               exynos7_clk_aud_init);
> diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
> index 3bba9ec..9e5a2d8 100644
> --- a/include/dt-bindings/clock/exynos7-clk.h
> +++ b/include/dt-bindings/clock/exynos7-clk.h
> @@ -17,7 +17,9 @@
>  #define DOUT_SCLK_CC_PLL               4
>  #define DOUT_SCLK_MFC_PLL              5
>  #define DOUT_ACLK_CCORE_133            6
> -#define TOPC_NR_CLK                    7
> +#define DOUT_SCLK_AUD_PLL              7
> +#define FOUT_AUD_PLL                   8
> +#define TOPC_NR_CLK                    9
>
>  /* TOP0 */
>  #define DOUT_ACLK_PERIC1               1
> @@ -32,7 +34,10 @@
>  #define CLK_SCLK_SPI3                  10
>  #define CLK_SCLK_SPI4                  11
>  #define CLK_SCLK_SPI5                  12
> -#define TOP0_NR_CLK                    13
> +#define CLK_SCLK_SPDIF                 13
> +#define CLK_SCLK_PCM1                  14
> +#define CLK_SCLK_I2S1                  15
> +#define TOP0_NR_CLK                    16
>
>  /* TOP1 */
>  #define DOUT_ACLK_FSYS1_200            1
> @@ -88,7 +93,13 @@
>  #define SCLK_SPI3                      21
>  #define SCLK_SPI4                      22
>  #define SCLK_SPI5                      23
> -#define PERIC1_NR_CLK                  24
> +#define PCLK_I2S1                      24
> +#define PCLK_PCM1                      25
> +#define PCLK_SPDIF                     26
> +#define SCLK_I2S1                      27
> +#define SCLK_PCM1                      28
> +#define SCLK_SPDIF                     29
> +#define PERIC1_NR_CLK                  30
>
>  /* PERIS */
>  #define PCLK_CHIPID                    1
> @@ -116,4 +127,11 @@
>  #define ACLK_MMC0                      2
>  #define FSYS1_NR_CLK                   3
>
> +/* AUD */
> +#define SCLK_I2S                       1
> +#define SCLK_PCM                       2
> +#define PCLK_I2S                       3
> +#define PCLK_PCM                       4
> +#define ACLK_ADMA                      5
> +#define AUD_NR_CLK                     6
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS7_H */
> --
> 1.7.4.4
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
