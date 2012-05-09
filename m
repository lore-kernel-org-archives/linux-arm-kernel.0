From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 May 2012 20:45:32 +0900
Subject: [PATCH 07/20] ARM: EXYNOS: Add pre-divider and fout mux clocks for
 bpll and mpll
In-Reply-To: <1335813270-13083-8-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-8-git-send-email-thomas.abraham@linaro.org>
Message-ID: <019601cd2dd9$3da83780$b8f8a680$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> From: Kisoo Yu <ksoo.yu@samsung.com>
> 
> The fout clock of BPLL and MPLL have a selectable source in rev1 of
> EXYNOS5. The clock options are a fixed divided by 2 clock and the
> output of the PLL itself. Add support for these new clock instances.
> 
> Signed-off-by: Kisoo Yu <ksoo.yu@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> [kgene.kim at samsung.com: temporary apply this because I
> don't want to add pll stuff in each clock not commonly]

As I commented, I won't apply this because pll stuff should be added in
common file such as plat-s5p/clock.c even though the plat-s5p files moved
into plat-samsung.

> Temporary-Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

No. I didn't sign on this in my topic branch.

> ---
>  arch/arm/mach-exynos/clock-exynos5.c           |   73
> +++++++++++++++++++++++-
>  arch/arm/mach-exynos/include/mach/regs-clock.h |    2 +
>  arch/arm/plat-s5p/clock.c                      |   11 ----
>  3 files changed, 74 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-
> exynos/clock-exynos5.c
> index 846741e..7c0f810 100644
> --- a/arch/arm/mach-exynos/clock-exynos5.c
> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> @@ -145,6 +145,39 @@ static struct clksrc_clk exynos5_clk_sclk_apll = {
>  	.reg_div = { .reg = EXYNOS5_CLKDIV_CPU0, .shift = 24, .size = 3 },
>  };
> 
> +static struct clk clk_fout_bpll_div2 = {
> +	.name	= "fout_bpll_div2",
> +};
> +
> +static struct clk *exynos5_clkset_mout_bpll_fout_list[] = {
> +	[0] = &clk_fout_bpll_div2,
> +	[1] = &clk_fout_bpll,
> +};
> +
> +static struct clksrc_sources exynos5_clkset_mout_bpll_fout = {
> +	.sources	= exynos5_clkset_mout_bpll_fout_list,
> +	.nr_sources	= ARRAY_SIZE(exynos5_clkset_mout_bpll_fout_list),
> +};
> +
> +static struct clksrc_clk exynos5_clk_mout_bpll_fout = {
> +	.clk	= {
> +		.name		= "mout_bpll_fout",
> +	},
> +	.sources = &exynos5_clkset_mout_bpll_fout,
> +	.reg_src = { .reg = EXYNOS5_PLL_DIV2_SEL, .shift = 0, .size = 1 },
> +};
> +
> +/* Possible clock sources for BPLL Mux */
> +static struct clk *clk_src_bpll_list[] = {
> +	[0] = &clk_fin_bpll,
> +	[1] = &exynos5_clk_mout_bpll_fout.clk,
> +};
> +
> +struct clksrc_sources clk_src_bpll = {
> +	.sources	= clk_src_bpll_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_bpll_list),
> +};
> +
>  static struct clksrc_clk exynos5_clk_mout_bpll = {
>  	.clk	= {
>  		.name		= "mout_bpll",
> @@ -187,11 +220,43 @@ static struct clksrc_clk exynos5_clk_mout_epll = {
>  	.reg_src = { .reg = EXYNOS5_CLKSRC_TOP2, .shift = 12, .size = 1 },
>  };
> 
> +static struct clk clk_fout_mpll_div2 = {
> +	.name	= "fout_mpll_div2",
> +};
> +
> +static struct clk *exynos5_clkset_mout_mpll_fout_list[] = {
> +	[0] = &clk_fout_mpll_div2,
> +	[1] = &clk_fout_mpll,
> +};
> +
> +static struct clksrc_sources exynos5_clkset_mout_mpll_fout = {
> +	.sources	= exynos5_clkset_mout_mpll_fout_list,
> +	.nr_sources	= ARRAY_SIZE(exynos5_clkset_mout_mpll_fout_list),
> +};
> +
> +static struct clksrc_clk exynos5_clk_mout_mpll_fout = {
> +	.clk	= {
> +		.name		= "mout_mpll_fout",
> +	},
> +	.sources = &exynos5_clkset_mout_mpll_fout,
> +	.reg_src = { .reg = EXYNOS5_PLL_DIV2_SEL, .shift = 4, .size = 1 },
> +};
> +
> +static struct clk *exynos5_clk_src_mpll_list[] = {
> +	[0] = &clk_fin_mpll,
> +	[1] = &exynos5_clk_mout_mpll_fout.clk,
> +};
> +
> +struct clksrc_sources exynos5_clk_src_mpll = {
> +	.sources	= exynos5_clk_src_mpll_list,
> +	.nr_sources	= ARRAY_SIZE(exynos5_clk_src_mpll_list),
> +};
> +
>  struct clksrc_clk exynos5_clk_mout_mpll = {
>  	.clk = {
>  		.name		= "mout_mpll",
>  	},
> -	.sources = &clk_src_mpll,
> +	.sources = &exynos5_clk_src_mpll,
>  	.reg_src = { .reg = EXYNOS5_CLKSRC_CORE1, .shift = 8, .size = 1 },
>  };
> 
> @@ -946,10 +1011,12 @@ static struct clksrc_clk *exynos5_sysclks[] = {
>  	&exynos5_clk_mout_apll,
>  	&exynos5_clk_sclk_apll,
>  	&exynos5_clk_mout_bpll,
> +	&exynos5_clk_mout_bpll_fout,
>  	&exynos5_clk_mout_bpll_user,
>  	&exynos5_clk_mout_cpll,
>  	&exynos5_clk_mout_epll,
>  	&exynos5_clk_mout_mpll,
> +	&exynos5_clk_mout_mpll_fout,
>  	&exynos5_clk_mout_mpll_user,
>  	&exynos5_clk_vpllsrc,
>  	&exynos5_clk_sclk_vpll,
> @@ -1013,6 +1080,8 @@ static struct clk *exynos5_clks[] __initdata = {
>  	&exynos5_clk_sclk_hdmi27m,
>  	&exynos5_clk_sclk_hdmiphy,
>  	&clk_fout_bpll,
> +	&clk_fout_bpll_div2,
> +	&clk_fout_mpll_div2,
>  	&clk_fout_cpll,
>  	&exynos5_clk_armclk,
>  };
> @@ -1178,8 +1247,10 @@ void __init_or_cpufreq exynos5_setup_clocks(void)
> 
>  	clk_fout_apll.ops = &exynos5_fout_apll_ops;
>  	clk_fout_bpll.rate = bpll;
> +	clk_fout_bpll_div2.rate = bpll >> 1;
>  	clk_fout_cpll.rate = cpll;
>  	clk_fout_mpll.rate = mpll;
> +	clk_fout_mpll_div2.rate = mpll >> 1;
>  	clk_fout_epll.rate = epll;
>  	clk_fout_vpll.rate = vpll;
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h
> b/arch/arm/mach-exynos/include/mach/regs-clock.h
> index d9578a5..130034d 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-clock.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
> @@ -313,6 +313,8 @@
>  #define EXYNOS5_CLKGATE_IP_PERIS		EXYNOS_CLKREG(0x10960)
>  #define EXYNOS5_CLKGATE_BLOCK
EXYNOS_CLKREG(0x10980)
> 
> +#define EXYNOS5_PLL_DIV2_SEL			EXYNOS_CLKREG(0x20A24)
> +
>  #define EXYNOS5_BPLL_CON0			EXYNOS_CLKREG(0x20110)
>  #define EXYNOS5_CLKSRC_CDREX			EXYNOS_CLKREG(0x20200)
>  #define EXYNOS5_CLKDIV_CDREX			EXYNOS_CLKREG(0x20500)
> diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
> index f68a9bb..bea0907 100644
> --- a/arch/arm/plat-s5p/clock.c
> +++ b/arch/arm/plat-s5p/clock.c
> @@ -115,17 +115,6 @@ struct clksrc_sources clk_src_apll = {
>  	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
>  };
> 
> -/* Possible clock sources for BPLL Mux */
> -static struct clk *clk_src_bpll_list[] = {
> -	[0] = &clk_fin_bpll,
> -	[1] = &clk_fout_bpll,
> -};
> -
> -struct clksrc_sources clk_src_bpll = {
> -	.sources	= clk_src_bpll_list,
> -	.nr_sources	= ARRAY_SIZE(clk_src_bpll_list),
> -};
> -
>  /* Possible clock sources for CPLL Mux */
>  static struct clk *clk_src_cpll_list[] = {
>  	[0] = &clk_fin_cpll,
> --
> 1.7.5.4
