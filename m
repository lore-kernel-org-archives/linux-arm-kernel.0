From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 07 Jul 2016 12:26:54 +0200
Subject: [PATCH v3 2/2] clk: samsung: exynos7: Add clocks for atlas block
In-Reply-To: <1467750561-13957-3-git-send-email-a.kesavan@samsung.com>
References: <1467750561-13957-1-git-send-email-a.kesavan@samsung.com>
 <1467750561-13957-3-git-send-email-a.kesavan@samsung.com>
Message-ID: <577E2E6E.3040809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 10:29 PM, Abhilash Kesavan wrote:

> +static const struct samsung_pll_rate_table pll1450x_24mhz_tbl[] = {
> +	/* rate, m, p, s */
> +	PLL_35XX_RATE(2496000000, 208, 2, 0),

Please add U postfix to these constants to address compiler warning
as reported by kbuild-all at 01.org:

>> drivers/clk/samsung/clk-exynos7.c:43:2: warning: this decimal constant is
unsigned only in ISO C90
     PLL_35XX_RATE(2496000000, 208, 2, 0),
     ^~~~~~~~~~~~~


> +static void __init exynos7_clk_atlas_init(struct device_node *np)
> +{
> +	void __iomem *reg_base;
> +	struct samsung_clk_provider *ctx;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		panic("%s: failed to map registers\n", __func__);
> +		return;
> +	}
> +
> +	ctx = samsung_clk_init(np, reg_base, ATLAS_NR_CLK);
> +	if (!ctx) {
> +		panic("%s: unable to allocate ctx\n", __func__);

You can remove this panic() call, there is already one inside
samsung_clk_init().
