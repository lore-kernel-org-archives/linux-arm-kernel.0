From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Jul 2011 14:35:32 +0900
Subject: [PATCH v2 1/3] ARM: Samsung: Move duplicate code
In-Reply-To: <1308655463-8787-2-git-send-email-ch.naveen@samsung.com>
References: <1308655463-8787-1-git-send-email-ch.naveen@samsung.com>
	<1308655463-8787-2-git-send-email-ch.naveen@samsung.com>
Message-ID: <048401cc450c$85a9e5d0$90fdb170$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen Krishna Chatradhi wrote:
> 
> Move the duplicated code for SPDIF ops from S5PV210 and S5PC100.
> So, the same can be used in EXYNOS4.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
> Note: Moved common code to plat-s5p, as suggested by Kukjin Kim.

Yes, I did :)
Looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> 
>  arch/arm/mach-s5pc100/clock.c              |   37
+---------------------------
>  arch/arm/mach-s5pv210/clock.c              |   37
+---------------------------
>  arch/arm/plat-s5p/clock.c                  |   35
> ++++++++++++++++++++++++++
>  arch/arm/plat-s5p/include/plat/s5p-clock.h |    5 ++++
>  4 files changed, 42 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> index cd248e6..ff5cbb3 100644
> --- a/arch/arm/mach-s5pc100/clock.c
> +++ b/arch/arm/mach-s5pc100/clock.c
> @@ -910,47 +910,12 @@ struct clksrc_sources clk_src_sclk_spdif = {
>  	.nr_sources	= ARRAY_SIZE(clk_sclk_spdif_list),
>  };
> 
> -static int s5pc100_spdif_set_rate(struct clk *clk, unsigned long rate)
> -{
> -	struct clk *pclk;
> -	int ret;
> -
> -	pclk = clk_get_parent(clk);
> -	if (IS_ERR(pclk))
> -		return -EINVAL;
> -
> -	ret = pclk->ops->set_rate(pclk, rate);
> -	clk_put(pclk);
> -
> -	return ret;
> -}
> -
> -static unsigned long s5pc100_spdif_get_rate(struct clk *clk)
> -{
> -	struct clk *pclk;
> -	int rate;
> -
> -	pclk = clk_get_parent(clk);
> -	if (IS_ERR(pclk))
> -		return -EINVAL;
> -
> -	rate = pclk->ops->get_rate(clk);
> -	clk_put(pclk);
> -
> -	return rate;
> -}
> -
> -static struct clk_ops s5pc100_sclk_spdif_ops = {
> -	.set_rate	= s5pc100_spdif_set_rate,
> -	.get_rate	= s5pc100_spdif_get_rate,
> -};
> -
>  static struct clksrc_clk clk_sclk_spdif = {
>  	.clk	= {
>  		.name		= "sclk_spdif",
>  		.ctrlbit	= (1 << 11),
>  		.enable		= s5pc100_sclk1_ctrl,
> -		.ops		= &s5pc100_sclk_spdif_ops,
> +		.ops		= &s5p_sclk_spdif_ops,
>  	},
>  	.sources = &clk_src_sclk_spdif,
>  	.reg_src = { .reg = S5P_CLK_SRC3, .shift = 24, .size = 2 },
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index b5c95e6..ae72f87 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -686,47 +686,12 @@ static struct clksrc_sources clkset_sclk_spdif = {
>  	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
>  };
> 
> -static int s5pv210_spdif_set_rate(struct clk *clk, unsigned long rate)
> -{
> -	struct clk *pclk;
> -	int ret;
> -
> -	pclk = clk_get_parent(clk);
> -	if (IS_ERR(pclk))
> -		return -EINVAL;
> -
> -	ret = pclk->ops->set_rate(pclk, rate);
> -	clk_put(pclk);
> -
> -	return ret;
> -}
> -
> -static unsigned long s5pv210_spdif_get_rate(struct clk *clk)
> -{
> -	struct clk *pclk;
> -	int rate;
> -
> -	pclk = clk_get_parent(clk);
> -	if (IS_ERR(pclk))
> -		return -EINVAL;
> -
> -	rate = pclk->ops->get_rate(clk);
> -	clk_put(pclk);
> -
> -	return rate;
> -}
> -
> -static struct clk_ops s5pv210_sclk_spdif_ops = {
> -	.set_rate	= s5pv210_spdif_set_rate,
> -	.get_rate	= s5pv210_spdif_get_rate,
> -};
> -
>  static struct clksrc_clk clk_sclk_spdif = {
>  	.clk		= {
>  		.name		= "sclk_spdif",
>  		.enable		= s5pv210_clk_mask0_ctrl,
>  		.ctrlbit	= (1 << 27),
> -		.ops		= &s5pv210_sclk_spdif_ops,
> +		.ops		= &s5p_sclk_spdif_ops,
>  	},
>  	.sources = &clkset_sclk_spdif,
>  	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 12, .size = 2 },
> diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
> index 8d081d9..02af235 100644
> --- a/arch/arm/plat-s5p/clock.c
> +++ b/arch/arm/plat-s5p/clock.c
> @@ -168,6 +168,41 @@ unsigned long s5p_epll_get_rate(struct clk *clk)
>  	return clk->rate;
>  }
> 
> +int s5p_spdif_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk *pclk;
> +	int ret;
> +
> +	pclk = clk_get_parent(clk);
> +	if (IS_ERR(pclk))
> +		return -EINVAL;
> +
> +	ret = pclk->ops->set_rate(pclk, rate);
> +	clk_put(pclk);
> +
> +	return ret;
> +}
> +
> +unsigned long s5p_spdif_get_rate(struct clk *clk)
> +{
> +	struct clk *pclk;
> +	int rate;
> +
> +	pclk = clk_get_parent(clk);
> +	if (IS_ERR(pclk))
> +		return -EINVAL;
> +
> +	rate = pclk->ops->get_rate(clk);
> +	clk_put(pclk);
> +
> +	return rate;
> +}
> +
> +struct clk_ops s5p_sclk_spdif_ops = {
> +	.set_rate	= s5p_spdif_set_rate,
> +	.get_rate	= s5p_spdif_get_rate,
> +};
> +
>  static struct clk *s5p_clks[] __initdata = {
>  	&clk_ext_xtal_mux,
>  	&clk_48m,
> diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-
> s5p/include/plat/s5p-clock.h
> index 2b6dcff..769b5bd 100644
> --- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
> +++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
> @@ -47,4 +47,9 @@ extern int s5p_gatectrl(void __iomem *reg, struct clk
*clk, int
> enable);
>  extern int s5p_epll_enable(struct clk *clk, int enable);
>  extern unsigned long s5p_epll_get_rate(struct clk *clk);
> 
> +/* SPDIF clk operations common for S5PC100/V210/C110 and Exynos4 */
> +extern int s5p_spdif_set_rate(struct clk *clk, unsigned long rate);
> +extern unsigned long s5p_spdif_get_rate(struct clk *clk);
> +
> +extern struct clk_ops s5p_sclk_spdif_ops;
>  #endif /* __ASM_PLAT_S5P_CLOCK_H */
> --
> 1.7.2.3
