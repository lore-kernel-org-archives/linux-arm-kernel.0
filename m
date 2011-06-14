From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 14 Jun 2011 14:47:35 +0900
Subject: [PATCH 2/5] ARM: EXYNOS4: Add sclk_spdif clocks
In-Reply-To: <1307687667-9127-3-git-send-email-ch.naveen@samsung.com>
References: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
	<1307687667-9127-3-git-send-email-ch.naveen@samsung.com>
Message-ID: <005701cc2a56$947a7870$bd6f6950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Naveen Krishna Chatradhi wrote:
> 
> Add the sclk_spdif clock is of type 'struct clksrc_clk' clock.
> Also, add clk_spdifcdclk clocks of type 'struct clk' clock.
> 
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  arch/arm/mach-exynos4/clock.c |   70
> +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 70 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
> index 7aa4aef..57ca356 100644
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> @@ -73,6 +73,11 @@ static struct clk clk_audiocdclk2 = {
>  	.id		= 2,
>  };
> 
> +static struct clk clk_spdifcdclk = {
> +	.name		= "spdifcdclk",
> +	.id		= -1,
> +};

Do we really need this?

spdif_extclk? not spdifcdclk.

> +
>  static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
>  {
>  	return s5p_gatectrl(S5P_CLKSRC_MASK_TOP, clk, enable);
> @@ -592,6 +597,11 @@ static struct clk init_clocks_off[] = {
>  		.enable		= exynos4_clk_ip_peril_ctrl,
>  		.ctrlbit	= (1 << 21),
>  	}, {
> +		.name		= "spdif",
> +		.id		= -1,
> +		.enable		= exynos4_clk_ip_peril_ctrl,
> +		.ctrlbit	= (1 << 26),
> +	}, {
>  		.name		= "ac97",
>  		.id		= -1,
>  		.enable		= exynos4_clk_ip_peril_ctrl,
> @@ -858,6 +868,65 @@ static struct clk init_clocks[] = {
>  	}
>  };
> 
> +static int exynos4_spdif_set_rate(struct clk *clk, unsigned long rate)
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
> +static unsigned long exynos4_spdif_get_rate(struct clk *clk)
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

I think, we can move above into plat-s5p for common spdif with others.

> +
> +static struct clk_ops exynos4_sclk_spdif_ops = {
> +	.set_rate	= exynos4_spdif_set_rate,
> +	.get_rate	= exynos4_spdif_get_rate,
> +};
> +
> +static struct clk *clkset_sclk_spdif_list[] = {
> +	[0] = &clk_sclk_audio0.clk,
> +	[1] = &clk_sclk_audio1.clk,
> +	[2] = &clk_sclk_audio2.clk,
> +	[3] = &clk_spdifcdclk,
> +};
> +
> +static struct clksrc_sources clkset_sclk_spdif = {
> +	.sources	= clkset_sclk_spdif_list,
> +	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
> +};
> +
> +static struct clksrc_clk clk_sclk_spdif = {
> +	.clk	= {
> +		.name		= "sclk_spdif",
> +		.id		= -1,
> +		.enable		= exynos4_clksrc_mask_peril1_ctrl,
> +		.ctrlbit	= (1 << 8),
> +		.ops		= &exynos4_sclk_spdif_ops,
> +	},
> +		.sources = &clkset_sclk_spdif,
> +		.reg_src = { .reg = S5P_CLKSRC_PERIL1, .shift = 8, .size = 2
},
> +};
> +
>  static struct clk *clkset_group_list[] = {
>  	[0] = &clk_ext_xtal_mux,
>  	[1] = &clk_xusbxti,
> @@ -1274,6 +1343,7 @@ static struct clksrc_clk *sysclks[] = {
>  	&clk_sclk_audio0,
>  	&clk_sclk_audio1,
>  	&clk_sclk_audio2,
> +	&clk_sclk_spdif,
>  };
> 
>  static u32 epll_div[][6] = {
> --
> 1.7.2.3



Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
