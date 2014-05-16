From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 May 2014 01:57:35 +0200
Subject: [PATCH v4 5/8] clk: exynos: use cpu-clock provider type to
 represent arm clock.
In-Reply-To: <1400029876-5830-6-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
 <1400029876-5830-6-git-send-email-thomas.ab@samsung.com>
Message-ID: <5376A5EF.90104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 14.05.2014 03:11, Thomas Abraham wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type and the independent
> clock blocks that made up the arm clock can be removed.
> 
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c      |   25 +++++++++----------------
>  drivers/clk/samsung/clk-exynos5250.c   |   12 ++++++------
>  include/dt-bindings/clock/exynos5250.h |    1 +
>  3 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index b4f9672..7e3bb16c 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -471,7 +471,6 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
>  	MUX(0, "mout_fimd1", group1_p4210, E4210_SRC_LCD1, 0, 4),
>  	MUX(0, "mout_mipi1", group1_p4210, E4210_SRC_LCD1, 12, 4),
>  	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_CPU, 8, 1),
> -	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4210, SRC_CPU, 16, 1),
>  	MUX(CLK_SCLK_VPLL, "sclk_vpll", sclk_vpll_p4210, SRC_TOP0, 8, 1),
>  	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4210, SRC_CAM, 0, 4),
>  	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4210, SRC_CAM, 4, 4),
> @@ -530,7 +529,6 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>  	MUX(0, "mout_jpeg", mout_jpeg_p, E4X12_SRC_CAM1, 8, 1),
>  	MUX(CLK_SCLK_MPLL, "sclk_mpll", mout_mpll_p, SRC_DMC, 12, 1),
>  	MUX(CLK_SCLK_VPLL, "sclk_vpll", mout_vpll_p, SRC_TOP0, 8, 1),
> -	MUX(CLK_MOUT_CORE, "mout_core", mout_core_p4x12, SRC_CPU, 16, 1),
>  	MUX(CLK_MOUT_FIMC0, "mout_fimc0", group1_p4x12, SRC_CAM, 0, 4),
>  	MUX(CLK_MOUT_FIMC1, "mout_fimc1", group1_p4x12, SRC_CAM, 4, 4),
>  	MUX(CLK_MOUT_FIMC2, "mout_fimc2", group1_p4x12, SRC_CAM, 8, 4),
> @@ -572,8 +570,6 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
>  
>  /* list of divider clocks supported in all exynos4 soc's */
>  static struct samsung_div_clock exynos4_div_clks[] __initdata = {
> -	DIV(0, "div_core", "mout_core", DIV_CPU0, 0, 3),
> -	DIV(0, "div_core2", "div_core", DIV_CPU0, 28, 3),

Please don't remove these clocks, as they will be necessary to define
proper hierarchy CMU_CPU clock output block. In particular, access to
following clocks will be required:

div_corem0
div_corem1
div_cores
div_atb
div_periph
div_pclk_dbg
div_hpm

They might be implemented using normal dividers, but with
CLK_DIVIDER_READ_ONLY [1] and CLK_GET_RATE_NOCACHE flags.

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/322977/focus=322978

This also means keeping mout_core clock defined, but with
CLK_MUX_READ_ONLY flag it should be fine.

>  	DIV(0, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
>  	DIV(0, "div_fimc1", "mout_fimc1", DIV_CAM, 4, 4),
>  	DIV(0, "div_fimc2", "mout_fimc2", DIV_CAM, 8, 4),
> @@ -619,8 +615,8 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
>  	DIV(0, "div_spi_pre2", "div_spi2", DIV_PERIL2, 8, 8),
>  	DIV(0, "div_audio1", "mout_audio1", DIV_PERIL4, 0, 4),
>  	DIV(0, "div_audio2", "mout_audio2", DIV_PERIL4, 16, 4),
> -	DIV(CLK_ARM_CLK, "arm_clk", "div_core2", DIV_CPU0, 28, 3),
> -	DIV(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
> +	DIV_F(CLK_SCLK_APLL, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3,
> +			CLK_GET_RATE_NOCACHE, 0),

Do you need CLK_GET_RATE_NOCACHE here? AFAIK whenever rate is changed on
APLL the clock core will recalculate rate of this clock.

>  	DIV_F(0, "div_mipi_pre0", "div_mipi0", DIV_LCD0, 20, 4,
>  			CLK_SET_RATE_PARENT, 0),
>  	DIV_F(0, "div_mmc_pre0", "div_mmc0", DIV_FSYS1, 8, 8,
> @@ -1003,12 +999,6 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
>  		0),
>  };
>  
> -static struct samsung_clock_alias exynos4_aliases[] __initdata = {
> -	ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
> -	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
> -	ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
> -};
> -
>  static struct samsung_clock_alias exynos4210_aliases[] __initdata = {
>  	ALIAS(CLK_SCLK_MPLL, NULL, "mout_mpll"),
>  };
> @@ -1241,6 +1231,9 @@ static void __init exynos4_clk_init(struct device_node *np,
>  			ARRAY_SIZE(exynos4210_gate_clks));
>  		samsung_clk_register_alias(exynos4210_aliases,
>  			ARRAY_SIZE(exynos4210_aliases));
> +		exynos_register_arm_clock(CLK_ARM_CLK, mout_core_p4210,
> +			ARRAY_SIZE(mout_core_p4210), reg_base, np, NULL,
> +			&samsung_clk_lock);
>  	} else {
>  		samsung_clk_register_mux(exynos4x12_mux_clks,
>  			ARRAY_SIZE(exynos4x12_mux_clks));
> @@ -1250,11 +1243,11 @@ static void __init exynos4_clk_init(struct device_node *np,
>  			ARRAY_SIZE(exynos4x12_gate_clks));
>  		samsung_clk_register_alias(exynos4x12_aliases,
>  			ARRAY_SIZE(exynos4x12_aliases));
> +		exynos_register_arm_clock(CLK_ARM_CLK, mout_core_p4x12,
> +			ARRAY_SIZE(mout_core_p4x12), reg_base, np, NULL,
> +			&samsung_clk_lock);
>  	}
>  
> -	samsung_clk_register_alias(exynos4_aliases,
> -			ARRAY_SIZE(exynos4_aliases));
> -
>  	exynos4_clk_sleep_init();
>  
>  	pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
> @@ -1262,7 +1255,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>  		exynos4_soc == EXYNOS4210 ? "Exynos4210" : "Exynos4x12",
>  		_get_rate("sclk_apll"),	_get_rate("sclk_mpll"),
>  		_get_rate("sclk_epll"), _get_rate("sclk_vpll"),
> -		_get_rate("arm_clk"));
> +		_get_rate("armclk"));

I'd prefer name of this clock to be not changed to not cause conflicts
with other patches.

Similar comments apply to clk-exynos5250.

Best regards,
Tomasz
