From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 02 Dec 2013 15:09:03 +0100
Subject: [RFC PATCH] clk: samsung: add support for multiple clock providers
In-Reply-To: <1385963716-20045-1-git-send-email-rahul.sharma@samsung.com>
References: <1385963716-20045-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1874542.EOuUcEDkzz@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On Monday 02 of December 2013 11:25:16 Rahul Sharma wrote:
> Samsung CCF helper functions doesn't provide support to
> register multiple Clock Providers for a given SoC. Due to
> this limitation soc platforms are not able to use these
> helpers for registering multiple clock providers and forced
> to bypass this layer.

This might make sense indeed, but I don't see any use cases for it
at the moment. Do you have anything in particular in mind?

Also this is somehow ugly to require passing device_node to every function
even when DT is not used. Instead, I would make samsung_clk_init() return
the context pointer, which would be then passed to other functions. This
would also eliminate the need to add private infrastructure mapping nodes
into context pointers.

One more thing is the name of clk_provider_context struct. It sounds too
generic for a Samsung specific structure. IMHO samsung_clk_provider would
be much better.

Best regards,
Tomasz

> 
> This layer is modified accordingly to enable the support.
> 
> Clockfile for exynos4, exynos5250, exynos5420.c and
> exynos5440 are also modified as per changed helper functions.
> 
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
> This patch is based on the following series from
> Tomasz Figa <t.figa@samsung.com>:
> http://www.spinics.net/lists/arm-kernel/msg280223.html
> 
> It is rebased on clk-for-linus-3.13 branch in mike's tree.
> 
>  drivers/clk/samsung/clk-exynos4.c    |   42 ++++-----
>  drivers/clk/samsung/clk-exynos5250.c |   19 ++--
>  drivers/clk/samsung/clk-exynos5420.c |   17 ++--
>  drivers/clk/samsung/clk-exynos5440.c |   12 +--
>  drivers/clk/samsung/clk-pll.c        |   14 +--
>  drivers/clk/samsung/clk-s3c64xx.c    |   37 ++++----
>  drivers/clk/samsung/clk.c            |  163 ++++++++++++++++++++++++----------
>  drivers/clk/samsung/clk.h            |   26 +++---
>  8 files changed, 205 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index ca2a940..b226544 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -1093,7 +1093,7 @@ static unsigned long exynos4_get_xom(void)
>  	return xom;
>  }
>  
> -static void __init exynos4_clk_register_finpll(void)
> +static void __init exynos4_clk_register_finpll(struct device_node *np)
>  {
>  	struct samsung_fixed_rate_clock fclk;
>  	struct clk *clk;
> @@ -1116,7 +1116,7 @@ static void __init exynos4_clk_register_finpll(void)
>  	fclk.parent_name = NULL;
>  	fclk.flags = CLK_IS_ROOT;
>  	fclk.fixed_rate = finpll_f;
> -	samsung_clk_register_fixed_rate(&fclk, 1);
> +	samsung_clk_register_fixed_rate(np, &fclk, 1);
>  
>  }
>  
> @@ -1234,14 +1234,14 @@ static void __init exynos4_clk_init(struct device_node *np,
>  
>  	samsung_clk_init(np, reg_base, nr_clks);
>  
> -	samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
> +	samsung_clk_of_register_fixed_ext(np, exynos4_fixed_rate_ext_clks,
>  			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
>  			ext_clk_match);
>  
> -	exynos4_clk_register_finpll();
> +	exynos4_clk_register_finpll(np);
>  
>  	if (exynos4_soc == EXYNOS4210) {
> -		samsung_clk_register_mux(exynos4210_mux_early,
> +		samsung_clk_register_mux(np, exynos4210_mux_early,
>  					ARRAY_SIZE(exynos4210_mux_early));
>  
>  		if (_get_rate("fin_pll") == 24000000) {
> @@ -1255,7 +1255,7 @@ static void __init exynos4_clk_init(struct device_node *np,
>  			exynos4210_plls[vpll].rate_table =
>  							exynos4210_vpll_rates;
>  
> -		samsung_clk_register_pll(exynos4210_plls,
> +		samsung_clk_register_pll(np, exynos4210_plls,
>  					ARRAY_SIZE(exynos4210_plls), reg_base);
>  	} else {
>  		if (_get_rate("fin_pll") == 24000000) {
> @@ -1267,42 +1267,42 @@ static void __init exynos4_clk_init(struct device_node *np,
>  							exynos4x12_vpll_rates;
>  		}
>  
> -		samsung_clk_register_pll(exynos4x12_plls,
> +		samsung_clk_register_pll(np, exynos4x12_plls,
>  					ARRAY_SIZE(exynos4x12_plls), reg_base);
>  	}
>  
> -	samsung_clk_register_fixed_rate(exynos4_fixed_rate_clks,
> +	samsung_clk_register_fixed_rate(np, exynos4_fixed_rate_clks,
>  			ARRAY_SIZE(exynos4_fixed_rate_clks));
> -	samsung_clk_register_mux(exynos4_mux_clks,
> +	samsung_clk_register_mux(np, exynos4_mux_clks,
>  			ARRAY_SIZE(exynos4_mux_clks));
> -	samsung_clk_register_div(exynos4_div_clks,
> +	samsung_clk_register_div(np, exynos4_div_clks,
>  			ARRAY_SIZE(exynos4_div_clks));
> -	samsung_clk_register_gate(exynos4_gate_clks,
> +	samsung_clk_register_gate(np, exynos4_gate_clks,
>  			ARRAY_SIZE(exynos4_gate_clks));
>  
>  	if (exynos4_soc == EXYNOS4210) {
> -		samsung_clk_register_fixed_rate(exynos4210_fixed_rate_clks,
> +		samsung_clk_register_fixed_rate(np, exynos4210_fixed_rate_clks,
>  			ARRAY_SIZE(exynos4210_fixed_rate_clks));
> -		samsung_clk_register_mux(exynos4210_mux_clks,
> +		samsung_clk_register_mux(np, exynos4210_mux_clks,
>  			ARRAY_SIZE(exynos4210_mux_clks));
> -		samsung_clk_register_div(exynos4210_div_clks,
> +		samsung_clk_register_div(np, exynos4210_div_clks,
>  			ARRAY_SIZE(exynos4210_div_clks));
> -		samsung_clk_register_gate(exynos4210_gate_clks,
> +		samsung_clk_register_gate(np, exynos4210_gate_clks,
>  			ARRAY_SIZE(exynos4210_gate_clks));
> -		samsung_clk_register_alias(exynos4210_aliases,
> +		samsung_clk_register_alias(np, exynos4210_aliases,
>  			ARRAY_SIZE(exynos4210_aliases));
>  	} else {
> -		samsung_clk_register_mux(exynos4x12_mux_clks,
> +		samsung_clk_register_mux(np, exynos4x12_mux_clks,
>  			ARRAY_SIZE(exynos4x12_mux_clks));
> -		samsung_clk_register_div(exynos4x12_div_clks,
> +		samsung_clk_register_div(np, exynos4x12_div_clks,
>  			ARRAY_SIZE(exynos4x12_div_clks));
> -		samsung_clk_register_gate(exynos4x12_gate_clks,
> +		samsung_clk_register_gate(np, exynos4x12_gate_clks,
>  			ARRAY_SIZE(exynos4x12_gate_clks));
> -		samsung_clk_register_alias(exynos4x12_aliases,
> +		samsung_clk_register_alias(np, exynos4x12_aliases,
>  			ARRAY_SIZE(exynos4x12_aliases));
>  	}
>  
> -	samsung_clk_register_alias(exynos4_aliases,
> +	samsung_clk_register_alias(np, exynos4_aliases,
>  			ARRAY_SIZE(exynos4_aliases));
>  
>  	exynos4_clk_sleep_init();
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index 82f14e1..1785a3d 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -592,10 +592,10 @@ static void __init exynos5250_clk_init(struct device_node *np)
>  	}
>  
>  	samsung_clk_init(np, reg_base, nr_clks);
> -	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
> +	samsung_clk_of_register_fixed_ext(np, exynos5250_fixed_rate_ext_clks,
>  			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
>  			ext_clk_match);
> -	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
> +	samsung_clk_register_mux(np, exynos5250_pll_pmux_clks,
>  				ARRAY_SIZE(exynos5250_pll_pmux_clks));
>  
>  	if (_get_rate("fin_pll") == 24 * MHZ)
> @@ -604,17 +604,18 @@ static void __init exynos5250_clk_init(struct device_node *np)
>  	if (_get_rate("mout_vpllsrc") == 24 * MHZ)
>  		exynos5250_plls[vpll].rate_table =  vpll_24mhz_tbl;
>  
> -	samsung_clk_register_pll(exynos5250_plls, ARRAY_SIZE(exynos5250_plls),
> -					reg_base);
> -	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
> +	samsung_clk_register_pll(np, exynos5250_plls,
> +			ARRAY_SIZE(exynos5250_plls),
> +			reg_base);
> +	samsung_clk_register_fixed_rate(np, exynos5250_fixed_rate_clks,
>  			ARRAY_SIZE(exynos5250_fixed_rate_clks));
> -	samsung_clk_register_fixed_factor(exynos5250_fixed_factor_clks,
> +	samsung_clk_register_fixed_factor(np, exynos5250_fixed_factor_clks,
>  			ARRAY_SIZE(exynos5250_fixed_factor_clks));
> -	samsung_clk_register_mux(exynos5250_mux_clks,
> +	samsung_clk_register_mux(np, exynos5250_mux_clks,
>  			ARRAY_SIZE(exynos5250_mux_clks));
> -	samsung_clk_register_div(exynos5250_div_clks,
> +	samsung_clk_register_div(np, exynos5250_div_clks,
>  			ARRAY_SIZE(exynos5250_div_clks));
> -	samsung_clk_register_gate(exynos5250_gate_clks,
> +	samsung_clk_register_gate(np, exynos5250_gate_clks,
>  			ARRAY_SIZE(exynos5250_gate_clks));
>  
>  	exynos5250_clk_sleep_init();
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 9de5bfd..44327e3 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -817,20 +817,21 @@ static void __init exynos5420_clk_init(struct device_node *np)
>  	}
>  
>  	samsung_clk_init(np, reg_base, nr_clks);
> -	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
> +	samsung_clk_of_register_fixed_ext(np, exynos5420_fixed_rate_ext_clks,
>  			ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
>  			ext_clk_match);
> -	samsung_clk_register_pll(exynos5420_plls, ARRAY_SIZE(exynos5420_plls),
> -					reg_base);
> -	samsung_clk_register_fixed_rate(exynos5420_fixed_rate_clks,
> +	samsung_clk_register_pll(np, exynos5420_plls,
> +			ARRAY_SIZE(exynos5420_plls),
> +			reg_base);
> +	samsung_clk_register_fixed_rate(np, exynos5420_fixed_rate_clks,
>  			ARRAY_SIZE(exynos5420_fixed_rate_clks));
> -	samsung_clk_register_fixed_factor(exynos5420_fixed_factor_clks,
> +	samsung_clk_register_fixed_factor(np, exynos5420_fixed_factor_clks,
>  			ARRAY_SIZE(exynos5420_fixed_factor_clks));
> -	samsung_clk_register_mux(exynos5420_mux_clks,
> +	samsung_clk_register_mux(np, exynos5420_mux_clks,
>  			ARRAY_SIZE(exynos5420_mux_clks));
> -	samsung_clk_register_div(exynos5420_div_clks,
> +	samsung_clk_register_div(np, exynos5420_div_clks,
>  			ARRAY_SIZE(exynos5420_div_clks));
> -	samsung_clk_register_gate(exynos5420_gate_clks,
> +	samsung_clk_register_gate(np, exynos5420_gate_clks,
>  			ARRAY_SIZE(exynos5420_gate_clks));
>  
>  	exynos5420_clk_sleep_init();
> diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
> index e3e460a..ef90bb7 100644
> --- a/drivers/clk/samsung/clk-exynos5440.c
> +++ b/drivers/clk/samsung/clk-exynos5440.c
> @@ -115,21 +115,21 @@ static void __init exynos5440_clk_init(struct device_node *np)
>  	}
>  
>  	samsung_clk_init(np, reg_base, nr_clks);
> -	samsung_clk_of_register_fixed_ext(exynos5440_fixed_rate_ext_clks,
> +	samsung_clk_of_register_fixed_ext(np, exynos5440_fixed_rate_ext_clks,
>  		ARRAY_SIZE(exynos5440_fixed_rate_ext_clks), ext_clk_match);
>  
>  	samsung_clk_register_pll2550x("cplla", "xtal", reg_base + 0x1c, 0x10);
>  	samsung_clk_register_pll2550x("cpllb", "xtal", reg_base + 0x20, 0x10);
>  
> -	samsung_clk_register_fixed_rate(exynos5440_fixed_rate_clks,
> +	samsung_clk_register_fixed_rate(np, exynos5440_fixed_rate_clks,
>  			ARRAY_SIZE(exynos5440_fixed_rate_clks));
> -	samsung_clk_register_fixed_factor(exynos5440_fixed_factor_clks,
> +	samsung_clk_register_fixed_factor(np, exynos5440_fixed_factor_clks,
>  			ARRAY_SIZE(exynos5440_fixed_factor_clks));
> -	samsung_clk_register_mux(exynos5440_mux_clks,
> +	samsung_clk_register_mux(np, exynos5440_mux_clks,
>  			ARRAY_SIZE(exynos5440_mux_clks));
> -	samsung_clk_register_div(exynos5440_div_clks,
> +	samsung_clk_register_div(np, exynos5440_div_clks,
>  			ARRAY_SIZE(exynos5440_div_clks));
> -	samsung_clk_register_gate(exynos5440_gate_clks,
> +	samsung_clk_register_gate(np, exynos5440_gate_clks,
>  			ARRAY_SIZE(exynos5440_gate_clks));
>  
>  	pr_info("Exynos5440: arm_clk = %ldHz\n", _get_rate("arm_clk"));
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index 529e11d..5b4228e 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -710,8 +710,9 @@ struct clk * __init samsung_clk_register_pll2550x(const char *name,
>  	return clk;
>  }
>  
> -static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
> -						void __iomem *base)
> +static void __init _samsung_clk_register_pll(struct device_node *np,
> +				struct samsung_pll_clock *pll_clk,
> +				void __iomem *base)
>  {
>  	struct samsung_clk_pll *pll;
>  	struct clk *clk;
> @@ -804,7 +805,7 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
>  		return;
>  	}
>  
> -	samsung_clk_add_lookup(clk, pll_clk->id);
> +	samsung_clk_add_lookup(np, clk, pll_clk->id);
>  
>  	if (!pll_clk->alias)
>  		return;
> @@ -815,11 +816,12 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
>  			__func__, pll_clk->name, ret);
>  }
>  
> -void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
> -				unsigned int nr_pll, void __iomem *base)
> +void __init samsung_clk_register_pll(struct device_node *np,
> +			struct samsung_pll_clock *pll_list,
> +			unsigned int nr_pll, void __iomem *base)
>  {
>  	int cnt;
>  
>  	for (cnt = 0; cnt < nr_pll; cnt++)
> -		_samsung_clk_register_pll(&pll_list[cnt], base);
> +		_samsung_clk_register_pll(np, &pll_list[cnt], base);
>  }
> diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
> index a43cbde..b12050f 100644
> --- a/drivers/clk/samsung/clk-s3c64xx.c
> +++ b/drivers/clk/samsung/clk-s3c64xx.c
> @@ -442,12 +442,13 @@ static struct samsung_clock_alias s3c6410_clock_aliases[] = {
>  	ALIAS(MEM0_SROM, NULL, "srom"),
>  };
>  
> -static void __init s3c64xx_clk_register_fixed_ext(unsigned long fin_pll_f,
> -							unsigned long xusbxti_f)
> +static void __init s3c64xx_clk_register_fixed_ext(struct device_node *np,
> +					unsigned long fin_pll_f,
> +					unsigned long xusbxti_f)
>  {
>  	s3c64xx_fixed_rate_ext_clks[0].fixed_rate = fin_pll_f;
>  	s3c64xx_fixed_rate_ext_clks[1].fixed_rate = xusbxti_f;
> -	samsung_clk_register_fixed_rate(s3c64xx_fixed_rate_ext_clks,
> +	samsung_clk_register_fixed_rate(np, s3c64xx_fixed_rate_ext_clks,
>  				ARRAY_SIZE(s3c64xx_fixed_rate_ext_clks));
>  }
>  
> @@ -469,44 +470,44 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
>  
>  	/* Register external clocks. */
>  	if (!np)
> -		s3c64xx_clk_register_fixed_ext(xtal_f, xusbxti_f);
> +		s3c64xx_clk_register_fixed_ext(np, xtal_f, xusbxti_f);
>  
>  	/* Register PLLs. */
> -	samsung_clk_register_pll(s3c64xx_pll_clks,
> +	samsung_clk_register_pll(np, s3c64xx_pll_clks,
>  				ARRAY_SIZE(s3c64xx_pll_clks), reg_base);
>  
>  	/* Register common internal clocks. */
> -	samsung_clk_register_fixed_rate(s3c64xx_fixed_rate_clks,
> +	samsung_clk_register_fixed_rate(np, s3c64xx_fixed_rate_clks,
>  					ARRAY_SIZE(s3c64xx_fixed_rate_clks));
> -	samsung_clk_register_mux(s3c64xx_mux_clks,
> +	samsung_clk_register_mux(np, s3c64xx_mux_clks,
>  					ARRAY_SIZE(s3c64xx_mux_clks));
> -	samsung_clk_register_div(s3c64xx_div_clks,
> +	samsung_clk_register_div(np, s3c64xx_div_clks,
>  					ARRAY_SIZE(s3c64xx_div_clks));
> -	samsung_clk_register_gate(s3c64xx_gate_clks,
> +	samsung_clk_register_gate(np, s3c64xx_gate_clks,
>  					ARRAY_SIZE(s3c64xx_gate_clks));
>  
>  	/* Register SoC-specific clocks. */
>  	if (is_s3c6400) {
> -		samsung_clk_register_mux(s3c6400_mux_clks,
> +		samsung_clk_register_mux(np, s3c6400_mux_clks,
>  					ARRAY_SIZE(s3c6400_mux_clks));
> -		samsung_clk_register_div(s3c6400_div_clks,
> +		samsung_clk_register_div(np, s3c6400_div_clks,
>  					ARRAY_SIZE(s3c6400_div_clks));
> -		samsung_clk_register_gate(s3c6400_gate_clks,
> +		samsung_clk_register_gate(np, s3c6400_gate_clks,
>  					ARRAY_SIZE(s3c6400_gate_clks));
> -		samsung_clk_register_alias(s3c6400_clock_aliases,
> +		samsung_clk_register_alias(np, s3c6400_clock_aliases,
>  					ARRAY_SIZE(s3c6400_clock_aliases));
>  	} else {
> -		samsung_clk_register_mux(s3c6410_mux_clks,
> +		samsung_clk_register_mux(np, s3c6410_mux_clks,
>  					ARRAY_SIZE(s3c6410_mux_clks));
> -		samsung_clk_register_div(s3c6410_div_clks,
> +		samsung_clk_register_div(np, s3c6410_div_clks,
>  					ARRAY_SIZE(s3c6410_div_clks));
> -		samsung_clk_register_gate(s3c6410_gate_clks,
> +		samsung_clk_register_gate(np, s3c6410_gate_clks,
>  					ARRAY_SIZE(s3c6410_gate_clks));
> -		samsung_clk_register_alias(s3c6410_clock_aliases,
> +		samsung_clk_register_alias(np, s3c6410_clock_aliases,
>  					ARRAY_SIZE(s3c6410_clock_aliases));
>  	}
>  
> -	samsung_clk_register_alias(s3c64xx_clock_aliases,
> +	samsung_clk_register_alias(np, s3c64xx_clock_aliases,
>  					ARRAY_SIZE(s3c64xx_clock_aliases));
>  	s3c64xx_clk_sleep_init();
>  
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index 91bec3e..a6fad4f 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -15,11 +15,15 @@
>  #include "clk.h"
>  
>  static DEFINE_SPINLOCK(lock);
> -static struct clk **clk_table;
> -static void __iomem *reg_base;
> -#ifdef CONFIG_OF
> -static struct clk_onecell_data clk_data;
> -#endif
> +static LIST_HEAD(clk_provider_list);
> +
> +/* Context node which holds information about the clock provider. */
> +struct clk_provider_context {
> +	struct list_head node;
> +	struct device_node *of_node;
> +	void __iomem *reg_base;
> +	struct clk_onecell_data clk_data;
> +};
>  
>  void samsung_clk_save(void __iomem *base,
>  				    struct samsung_clk_reg_dump *rd,
> @@ -58,37 +62,77 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
>  void __init samsung_clk_init(struct device_node *np, void __iomem *base,
>  			     unsigned long nr_clks)
>  {
> -	reg_base = base;
> +	struct clk_provider_context *ctx;
> +	struct clk **clk_table;
> +	int ret;
> +
> +	if (!np)
> +		return;
> +
> +	ctx = kzalloc(sizeof(struct clk_provider_context), GFP_KERNEL);
> +	if (!ctx)
> +		panic("could not allocate clock provider context.\n");
>  
>  	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
>  	if (!clk_table)
>  		panic("could not allocate clock lookup table\n");
>  
> -	if (!np)
> -		return;
> +	ctx->of_node = np;
> +	ctx->reg_base = base;
> +	ctx->clk_data.clks = clk_table;
> +	ctx->clk_data.clk_num = nr_clks;
>  
> -#ifdef CONFIG_OF
> -	clk_data.clks = clk_table;
> -	clk_data.clk_num = nr_clks;
> -	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> -#endif
> +	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
> +			&ctx->clk_data);
> +	if (ret)
> +		panic("could not register clock provide\n");
> +
> +	list_add_tail(&ctx->node, &clk_provider_list);
> +}
> +
> +/* static helper function to extract the context from node pointer */
> +static struct clk_provider_context *_get_clock_provider(struct device_node *np)
> +{
> +	struct clk_provider_context *ctx;
> +
> +	list_for_each_entry(ctx, &clk_provider_list, node)
> +		if (ctx->of_node == np)
> +			return ctx;
> +	return NULL;
>  }
>  
>  /* add a clock instance to the clock lookup table used for dt based lookup */
> -void samsung_clk_add_lookup(struct clk *clk, unsigned int id)
> +void samsung_clk_add_lookup(struct device_node *np, struct clk *clk,
> +				unsigned int id)
>  {
> -	if (clk_table && id)
> -		clk_table[id] = clk;
> +	struct clk_provider_context *ctx;
> +
> +	ctx = _get_clock_provider(np);
> +	if (!ctx) {
> +		pr_err("invalid node pointer.\n");
> +		return;
> +	}
> +
> +	if (ctx->clk_data.clks && id)
> +		ctx->clk_data.clks[id] = clk;
>  }
>  
>  /* register a list of aliases */
> -void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
> -					unsigned int nr_clk)
> +void __init samsung_clk_register_alias(struct device_node *np,
> +				struct samsung_clock_alias *list,
> +				unsigned int nr_clk)
>  {
> +	struct clk_provider_context *ctx;
>  	struct clk *clk;
>  	unsigned int idx, ret;
>  
> -	if (!clk_table) {
> +	ctx = _get_clock_provider(np);
> +	if (!ctx) {
> +		pr_err("invalid node pointer.\n");
> +		return;
> +	}
> +
> +	if (!ctx->clk_data.clks) {
>  		pr_err("%s: clock table missing\n", __func__);
>  		return;
>  	}
> @@ -100,7 +144,7 @@ void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
>  			continue;
>  		}
>  
> -		clk = clk_table[list->id];
> +		clk = ctx->clk_data.clks[list->id];
>  		if (!clk) {
>  			pr_err("%s: failed to find clock %d\n", __func__,
>  				list->id);
> @@ -115,7 +159,7 @@ void __init samsung_clk_register_alias(struct samsung_clock_alias *list,
>  }
>  
>  /* register a list of fixed clocks */
> -void __init samsung_clk_register_fixed_rate(
> +void __init samsung_clk_register_fixed_rate(struct device_node *np,
>  		struct samsung_fixed_rate_clock *list, unsigned int nr_clk)
>  {
>  	struct clk *clk;
> @@ -130,7 +174,7 @@ void __init samsung_clk_register_fixed_rate(
>  			continue;
>  		}
>  
> -		samsung_clk_add_lookup(clk, list->id);
> +		samsung_clk_add_lookup(np, clk, list->id);
>  
>  		/*
>  		 * Unconditionally add a clock lookup for the fixed rate clocks.
> @@ -144,7 +188,7 @@ void __init samsung_clk_register_fixed_rate(
>  }
>  
>  /* register a list of fixed factor clocks */
> -void __init samsung_clk_register_fixed_factor(
> +void __init samsung_clk_register_fixed_factor(struct device_node *np,
>  		struct samsung_fixed_factor_clock *list, unsigned int nr_clk)
>  {
>  	struct clk *clk;
> @@ -159,20 +203,29 @@ void __init samsung_clk_register_fixed_factor(
>  			continue;
>  		}
>  
> -		samsung_clk_add_lookup(clk, list->id);
> +		samsung_clk_add_lookup(np, clk, list->id);
>  	}
>  }
>  
>  /* register a list of mux clocks */
> -void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
> -					unsigned int nr_clk)
> +void __init samsung_clk_register_mux(struct device_node *np,
> +				struct samsung_mux_clock *list,
> +				unsigned int nr_clk)
>  {
> +	struct clk_provider_context *ctx;
>  	struct clk *clk;
>  	unsigned int idx, ret;
>  
> +	ctx = _get_clock_provider(np);
> +	if (!ctx) {
> +		pr_err("invalid node pointer.\n");
> +		return;
> +	}
> +
>  	for (idx = 0; idx < nr_clk; idx++, list++) {
>  		clk = clk_register_mux(NULL, list->name, list->parent_names,
> -			list->num_parents, list->flags, reg_base + list->offset,
> +			list->num_parents, list->flags,
> +			ctx->reg_base + list->offset,
>  			list->shift, list->width, list->mux_flags, &lock);
>  		if (IS_ERR(clk)) {
>  			pr_err("%s: failed to register clock %s\n", __func__,
> @@ -180,7 +233,7 @@ void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
>  			continue;
>  		}
>  
> -		samsung_clk_add_lookup(clk, list->id);
> +		samsung_clk_add_lookup(np, clk, list->id);
>  
>  		/* register a clock lookup only if a clock alias is specified */
>  		if (list->alias) {
> @@ -194,31 +247,39 @@ void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
>  }
>  
>  /* register a list of div clocks */
> -void __init samsung_clk_register_div(struct samsung_div_clock *list,
> -					unsigned int nr_clk)
> +void __init samsung_clk_register_div(struct device_node *np,
> +				struct samsung_div_clock *list,
> +				unsigned int nr_clk)
>  {
> +	struct clk_provider_context *ctx;
>  	struct clk *clk;
>  	unsigned int idx, ret;
>  
> +	ctx = _get_clock_provider(np);
> +	if (!ctx) {
> +		pr_err("invalid node pointer.\n");
> +		return;
> +	}
> +
>  	for (idx = 0; idx < nr_clk; idx++, list++) {
>  		if (list->table)
>  			clk = clk_register_divider_table(NULL, list->name,
> -					list->parent_name, list->flags,
> -					reg_base + list->offset, list->shift,
> -					list->width, list->div_flags,
> -					list->table, &lock);
> +				list->parent_name, list->flags,
> +				ctx->reg_base + list->offset,
> +				list->shift, list->width, list->div_flags,
> +				list->table, &lock);
>  		else
>  			clk = clk_register_divider(NULL, list->name,
> -					list->parent_name, list->flags,
> -					reg_base + list->offset, list->shift,
> -					list->width, list->div_flags, &lock);
> +				list->parent_name, list->flags,
> +				ctx->reg_base + list->offset, list->shift,
> +				list->width, list->div_flags, &lock);
>  		if (IS_ERR(clk)) {
>  			pr_err("%s: failed to register clock %s\n", __func__,
>  				list->name);
>  			continue;
>  		}
>  
> -		samsung_clk_add_lookup(clk, list->id);
> +		samsung_clk_add_lookup(np, clk, list->id);
>  
>  		/* register a clock lookup only if a clock alias is specified */
>  		if (list->alias) {
> @@ -232,15 +293,23 @@ void __init samsung_clk_register_div(struct samsung_div_clock *list,
>  }
>  
>  /* register a list of gate clocks */
> -void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
> -						unsigned int nr_clk)
> +void __init samsung_clk_register_gate(struct device_node *np,
> +				struct samsung_gate_clock *list,
> +				unsigned int nr_clk)
>  {
> +	struct clk_provider_context *ctx;
>  	struct clk *clk;
>  	unsigned int idx, ret;
>  
> +	ctx = _get_clock_provider(np);
> +	if (!ctx) {
> +		pr_err("invalid node pointer.\n");
> +		return;
> +	}
> +
>  	for (idx = 0; idx < nr_clk; idx++, list++) {
>  		clk = clk_register_gate(NULL, list->name, list->parent_name,
> -				list->flags, reg_base + list->offset,
> +				list->flags, ctx->reg_base + list->offset,
>  				list->bit_idx, list->gate_flags, &lock);
>  		if (IS_ERR(clk)) {
>  			pr_err("%s: failed to register clock %s\n", __func__,
> @@ -257,7 +326,7 @@ void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
>  					__func__, list->alias);
>  		}
>  
> -		samsung_clk_add_lookup(clk, list->id);
> +		samsung_clk_add_lookup(np, clk, list->id);
>  	}
>  }
>  
> @@ -266,21 +335,21 @@ void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
>   * tree and register it
>   */
>  #ifdef CONFIG_OF
> -void __init samsung_clk_of_register_fixed_ext(
> +void __init samsung_clk_of_register_fixed_ext(struct device_node *np,
>  			struct samsung_fixed_rate_clock *fixed_rate_clk,
>  			unsigned int nr_fixed_rate_clk,
>  			struct of_device_id *clk_matches)
>  {
>  	const struct of_device_id *match;
> -	struct device_node *np;
> +	struct device_node *clk_np;
>  	u32 freq;
>  
> -	for_each_matching_node_and_match(np, clk_matches, &match) {
> -		if (of_property_read_u32(np, "clock-frequency", &freq))
> +	for_each_matching_node_and_match(clk_np, clk_matches, &match) {
> +		if (of_property_read_u32(clk_np, "clock-frequency", &freq))
>  			continue;
>  		fixed_rate_clk[(u32)match->data].fixed_rate = freq;
>  	}
> -	samsung_clk_register_fixed_rate(fixed_rate_clk, nr_fixed_rate_clk);
> +	samsung_clk_register_fixed_rate(np, fixed_rate_clk, nr_fixed_rate_clk);
>  }
>  #endif
>  
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index c7141ba..620f7b8 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -315,26 +315,32 @@ struct samsung_pll_clock {
>  extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
>  				    unsigned long nr_clks);
>  extern void __init samsung_clk_of_register_fixed_ext(
> +		struct device_node *np,
>  		struct samsung_fixed_rate_clock *fixed_rate_clk,
>  		unsigned int nr_fixed_rate_clk,
>  		struct of_device_id *clk_matches);
>  
> -extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
> +extern void samsung_clk_add_lookup(struct device_node *np,
> +			struct clk *clk, unsigned int id);
>  
> -extern void samsung_clk_register_alias(struct samsung_clock_alias *list,
> -		unsigned int nr_clk);
> -extern void __init samsung_clk_register_fixed_rate(
> +extern void samsung_clk_register_alias(struct device_node *np,
> +			struct samsung_clock_alias *list,
> +			unsigned int nr_clk);
> +extern void __init samsung_clk_register_fixed_rate(struct device_node *np,
>  		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
> -extern void __init samsung_clk_register_fixed_factor(
> +extern void __init samsung_clk_register_fixed_factor(struct device_node *np,
>  		struct samsung_fixed_factor_clock *list, unsigned int nr_clk);
> -extern void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
> +extern void __init samsung_clk_register_mux(struct device_node *np,
> +		struct samsung_mux_clock *clk_list,
>  		unsigned int nr_clk);
> -extern void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
> +extern void __init samsung_clk_register_div(struct device_node *np,
> +		struct samsung_div_clock *clk_list,
>  		unsigned int nr_clk);
> -extern void __init samsung_clk_register_gate(
> +extern void __init samsung_clk_register_gate(struct device_node *np,
>  		struct samsung_gate_clock *clk_list, unsigned int nr_clk);
> -extern void __init samsung_clk_register_pll(struct samsung_pll_clock *pll_list,
> -		unsigned int nr_clk, void __iomem *base);
> +extern void __init samsung_clk_register_pll(struct device_node *np,
> +			struct samsung_pll_clock *pll_list,
> +			unsigned int nr_clk, void __iomem *base);
>  
>  extern unsigned long _get_rate(const char *clk_name);
>  
> 
