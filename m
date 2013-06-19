From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 19 Jun 2013 19:00:35 +0200
Subject: [PATCH v6 3/7] clk: samsung: Add support to register rate_table
 for samsung plls
In-Reply-To: <1370870659-10929-4-git-send-email-yadi.brar@samsung.com>
References: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
 <1370870659-10929-4-git-send-email-yadi.brar@samsung.com>
Message-ID: <18048618.0Xj2V5N5dY@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 of June 2013 18:54:15 Yadwinder Singh Brar wrote:
> This patch defines a common rate_table which will contain recommended p,
> m, s, k values for supported rates that needs to be changed for
> changing corresponding PLL's rate.
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    |    8 ++++----
>  drivers/clk/samsung/clk-exynos5250.c |   14 +++++++-------
>  drivers/clk/samsung/clk-exynos5420.c |   22 +++++++++++-----------
>  drivers/clk/samsung/clk-pll.c        |   22 ++++++++++++++++++++--
>  drivers/clk/samsung/clk-pll.h        |   27 +++++++++++++++++++++++++++
> drivers/clk/samsung/clk.h            |   14 +++++++++-----
>  6 files changed, 78 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c
> b/drivers/clk/samsung/clk-exynos4.c index ba25a1b..ceee66c 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -997,13 +997,13 @@ static __initdata struct of_device_id
> ext_clk_match[] = {
> 
>  struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
>  	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", 
APLL_LOCK,
> -		APLL_CON0, "fout_apll"),
> +		APLL_CON0, "fout_apll", NULL),
>  	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll",
> -		E4X12_MPLL_LOCK, E4X12_MPLL_CON0, "fout_mpll"),
> +		E4X12_MPLL_LOCK, E4X12_MPLL_CON0, "fout_mpll", NULL),
>  	[epll] = PLL_A(pll_36xx, fout_epll, "fout_epll", "fin_pll", 
EPLL_LOCK,
> -		EPLL_CON0, "fout_epll"),
> +		EPLL_CON0, "fout_epll", NULL),
>  	[vpll] = PLL_A(pll_36xx, fout_vpll, "fout_vpll", "fin_pll", 
VPLL_LOCK,
> -		VPLL_CON0, "fout_vpll"),
> +		VPLL_CON0, "fout_vpll", NULL),
>  };
> 
>  /* register exynos4 clocks */
> diff --git a/drivers/clk/samsung/clk-exynos5250.c
> b/drivers/clk/samsung/clk-exynos5250.c index dc6a700..21f5491 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -492,19 +492,19 @@ static __initdata struct of_device_id
> ext_clk_match[] = {
> 
>  struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
>  	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", 
APLL_LOCK,
> -		APLL_CON0, "fout_apll"),
> +		APLL_CON0, "fout_apll", NULL),
>  	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll", 
MPLL_LOCK,
> -		MPLL_CON0, "fout_mpll"),
> +		MPLL_CON0, "fout_mpll", NULL),
>  	[bpll] = PLL(pll_35xx, fout_bpll, "fout_bpll", "fin_pll", 
BPLL_LOCK,
> -		BPLL_CON0),
> +		BPLL_CON0, NULL),
>  	[gpll] = PLL(pll_35xx, fout_gpll, "fout_gpll", "fin_pll", 
GPLL_LOCK,
> -		GPLL_CON0),
> +		GPLL_CON0, NULL),
>  	[cpll] = PLL(pll_35xx, fout_cpll, "fout_cpll", "fin_pll", 
CPLL_LOCK,
> -		CPLL_CON0),
> +		CPLL_CON0, NULL),
>  	[epll] = PLL(pll_36xx, fout_epll, "fout_epll", "fin_pll", 
EPLL_LOCK,
> -		EPLL_CON0),
> +		EPLL_CON0, NULL),
>  	[vpll] = PLL(pll_36xx, fout_vpll, "fout_vpll", "fin_pll", 
VPLL_LOCK,
> -		VPLL_CON0),
> +		VPLL_CON0, NULL),
>  };
> 
>  /* register exynox5250 clocks */
> diff --git a/drivers/clk/samsung/clk-exynos5420.c
> b/drivers/clk/samsung/clk-exynos5420.c index 3ea6b4f..86dfc64 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -729,27 +729,27 @@ struct samsung_gate_clock exynos5420_gate_clks[]
> __initdata = {
> 
>  struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
>  	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", 
APLL_LOCK,
> -		APLL_CON0),
> +		APLL_CON0, NULL),
>  	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", 
MPLL_LOCK,
> -		MPLL_CON0),
> +		MPLL_CON0, NULL),
>  	[dpll] = PLL(pll_2550, fout_dpll, "fout_dpll", "fin_pll", 
DPLL_LOCK,
> -		DPLL_CON0),
> +		DPLL_CON0, NULL),
>  	[epll] = PLL(pll_2650, fout_epll, "fout_epll", "fin_pll", 
EPLL_LOCK,
> -		EPLL_CON0),
> +		EPLL_CON0, NULL),
>  	[rpll] = PLL(pll_2650, fout_rpll, "fout_rpll", "fin_pll", 
RPLL_LOCK,
> -		RPLL_CON0),
> +		RPLL_CON0, NULL),
>  	[ipll] = PLL(pll_2550, fout_ipll, "fout_ipll", "fin_pll", 
IPLL_LOCK,
> -		IPLL_CON0),
> +		IPLL_CON0, NULL),
>  	[spll] = PLL(pll_2550, fout_spll, "fout_spll", "fin_pll", 
SPLL_LOCK,
> -		SPLL_CON0),
> +		SPLL_CON0, NULL),
>  	[vpll] = PLL(pll_2550, fout_vpll, "fout_vpll", "fin_pll", 
VPLL_LOCK,
> -		VPLL_CON0),
> +		VPLL_CON0, NULL),
>  	[mpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", 
MPLL_LOCK,
> -		MPLL_CON0),
> +		MPLL_CON0, NULL),
>  	[bpll] = PLL(pll_2550, fout_bpll, "fout_bpll", "fin_pll", 
BPLL_LOCK,
> -		BPLL_CON0),
> +		BPLL_CON0, NULL),
>  	[kpll] = PLL(pll_2550, fout_kpll, "fout_kpll", "fin_pll", 
KPLL_LOCK,
> -		KPLL_CON0),
> +		KPLL_CON0, NULL),
>  };
> 
>  static __initdata struct of_device_id ext_clk_match[] = {
> diff --git a/drivers/clk/samsung/clk-pll.c
> b/drivers/clk/samsung/clk-pll.c index f132353..b2088dd 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -18,6 +18,8 @@ struct samsung_clk_pll {
>  	void __iomem		*lock_reg;
>  	void __iomem		*con_reg;
>  	enum samsung_pll_type	type;
> +	unsigned int		rate_count;
> +	const struct samsung_pll_rate_table *rate_table;
>  };
> 
>  #define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
> @@ -350,7 +352,7 @@ void __init samsung_clk_register_pll(struct
> samsung_pll_clock *clk_list, struct clk *clk;
>  	struct clk_init_data init;
>  	struct samsung_pll_clock *list = clk_list;
> -	int cnt;
> +	int cnt, len;
> 
>  	for (cnt = 0; cnt < nr_pll; cnt++, list++) {
>  		pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> @@ -365,6 +367,21 @@ void __init samsung_clk_register_pll(struct
> samsung_pll_clock *clk_list, init.parent_names = &list->parent_name;
>  		init.num_parents = 1;
> 
> +		if (list->rate_table) {
> +			/* find count of rates in rate_table */
> +			for (len = 0; list->rate_table[len].rate != 0; )
> +				len++;
> +
> +			pll->rate_count = len;
> +			pll->rate_table = kmemdup(list->rate_table,
> +					list->rate_count *
> +					sizeof(struct 
samsung_pll_rate_table),
> +					GFP_KERNEL);
> +			WARN(!pll->rate_table,
> +				"%s: could not allocate rate table for 
%s\n",
> +				__func__, list->name);

This warning is not needed, because kmalloc() already prints a warning 
when allocation fails.

> +		}
> +
>  		switch (list->type) {
>  		/* clk_ops for 35xx and 2550 are similar */
>  		case pll_35xx:
> @@ -396,10 +413,11 @@ void __init samsung_clk_register_pll(struct
> samsung_pll_clock *clk_list,
> 
>  		samsung_clk_add_lookup(clk, list->id);
> 
> -		if (list->alias)
> +		if (list->alias) {

What about

		if (!list->alias)
			return;

		ret = clk_register_clkdev(clk, list->alias, list-
>dev_name);
		if (ret)
			pr_err("%s: failed to register lookup for %s",

This will make the code a bit nicer to read.

Otherwise looks good.

Best regards,
Tomasz

>  			if (clk_register_clkdev(clk, list->alias,
>  				list->dev_name))
>  				pr_err("%s: failed to register lookup for 
%s",
>  					__func__, list->name);
> +		}
>  	}
>  }
> diff --git a/drivers/clk/samsung/clk-pll.h
> b/drivers/clk/samsung/clk-pll.h index 1536f27..95ae23d 100644
> --- a/drivers/clk/samsung/clk-pll.h
> +++ b/drivers/clk/samsung/clk-pll.h
> @@ -19,6 +19,33 @@ enum samsung_pll_type {
>  	pll_2650,
>  };
> 
> +#define PLL_35XX_RATE(_rate, _m, _p, _s)			\
> +	{							\
> +		.rate	=	(_rate),				\
> +		.mdiv	=	(_m),				\
> +		.pdiv	=	(_p),				\
> +		.sdiv	=	(_s),				\
> +	}
> +
> +#define PLL_36XX_RATE(_rate, _m, _p, _s, _k)			\
> +	{							\
> +		.rate	=	(_rate),				\
> +		.mdiv	=	(_m),				\
> +		.pdiv	=	(_p),				\
> +		.sdiv	=	(_s),				\
> +		.kdiv	=	(_k),				\
> +	}
> +
> +/* NOTE: Rate table should be kept sorted in descending order. */
> +
> +struct samsung_pll_rate_table {
> +	unsigned int rate;
> +	unsigned int pdiv;
> +	unsigned int mdiv;
> +	unsigned int sdiv;
> +	unsigned int kdiv;
> +};
> +
>  enum pll45xx_type {
>  	pll_4500,
>  	pll_4502,
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index 51f60ca..3e6501c 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -280,10 +280,13 @@ struct samsung_pll_clock {
>  	const int		con_offset;
>  	const int		lock_offset;
>  	enum			samsung_pll_type type;
> +	const struct samsung_pll_rate_table *rate_table;
> +	unsigned int		rate_count;
>  	const char              *alias;
>  };
> 
> -#define __PLL(_typ, _id, _dname, _name, _pname, _flags, _lock, _con,
> _alias) \ +#define __PLL(_typ, _id, _dname, _name, _pname, _flags,
> _lock, _con,	\ +		_rtable, _alias)				
	\
>  	{								\
>  		.id		= _id,					\
>  		.type		= _typ,					\
> @@ -293,16 +296,17 @@ struct samsung_pll_clock {
>  		.flags		= CLK_GET_RATE_NOCACHE,			\
>  		.con_offset	= _con,					\
>  		.lock_offset	= _lock,				\
> +		.rate_table	= _rtable,				\
>  		.alias		= _alias,				\
>  	}
> 
> -#define PLL(_typ, _id, _name, _pname, _lock, _con)			\
> +#define PLL(_typ, _id, _name, _pname, _lock, _con, _rtable)	\
>  	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
> -		_lock, _con, NULL)
> +		_lock, _con, _rtable, _name)
> 
> -#define PLL_A(_typ, _id, _name, _pname, _lock, _con, _alias)		\
> +#define PLL_A(_typ, _id, _name, _pname, _lock, _con, _alias, _rtable) \
> __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\ -		
_lock,
> _con, _alias)
> +		_lock, _con, _rtable, _alias)
> 
>  extern void __init samsung_clk_init(struct device_node *np, void
> __iomem *base, unsigned long nr_clks, unsigned long *rdump,
