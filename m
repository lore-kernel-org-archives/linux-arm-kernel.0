From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 11 Jul 2013 10:16:41 +0200
Subject: [PATCH v2 3/6] clk: samsung: add plls used in s3c2416 and s3c2443
In-Reply-To: <201307100059.08621.heiko@sntech.de>
References: <201307100057.06061.heiko@sntech.de>
 <201307100059.08621.heiko@sntech.de>
Message-ID: <1525015.XUBJYYqnvA@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wednesday 10 of July 2013 00:59:08 Heiko St?bner wrote:
> This adds support for pll2126x, pll3000x, pll6552x and pll6553x.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/samsung/clk-pll.c |  280
> +++++++++++++++++++++++++++++++++++++++++ drivers/clk/samsung/clk-pll.h |  
>  8 ++
>  2 files changed, 288 insertions(+)

Generally the patch looks good, but I have some comments to the part related 
to 655xx PLLs.

I had a patch adding support for them too, but we can go with yours, since the 
way of registration has been changed by Yadwinder's patches and mine would 
have to be updated anyway.

> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index 0afaec6..35c15a1 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -323,6 +323,73 @@ struct clk * __init samsung_clk_register_pll46xx(const
> char *name, }
> 
>  /*
> + * PLL2126x Clock Type
> + */
> +
> +#define PLL2126X_MDIV_MASK	(0xFF)
> +#define PLL2126X_PDIV_MASK	(0x3)
> +#define PLL2126X_SDIV_MASK	(0x3)
> +#define PLL2126X_MDIV_SHIFT	(16)
> +#define PLL2126X_PDIV_SHIFT	(8)
> +#define PLL2126X_SDIV_SHIFT	(0)
> +
> +struct samsung_clk_pll2126x {
> +	struct clk_hw		hw;
> +	const void __iomem	*con_reg;
> +};
> +
> +#define to_clk_pll2126x(_hw) container_of(_hw, struct samsung_clk_pll2126x,
> hw) +
> +static unsigned long samsung_pll2126x_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct samsung_clk_pll2126x *pll = to_clk_pll2126x(hw);
> +	u32 pll_con, mdiv, pdiv, sdiv;
> +	u64 fvco = parent_rate;
> +
> +	pll_con = __raw_readl(pll->con_reg);
> +	mdiv = (pll_con >> PLL2126X_MDIV_SHIFT) & PLL2126X_MDIV_MASK;
> +	pdiv = (pll_con >> PLL2126X_PDIV_SHIFT) & PLL2126X_PDIV_MASK;
> +	sdiv = (pll_con >> PLL2126X_SDIV_SHIFT) & PLL2126X_SDIV_MASK;
> +
> +	fvco *= (mdiv + 8);
> +	do_div(fvco, (pdiv + 2) << sdiv);
> +
> +	return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll2126x_clk_ops = {
> +	.recalc_rate = samsung_pll2126x_recalc_rate,
> +};
> +
> +struct clk * __init samsung_clk_register_pll2126x(const char *name,
> +			const char *pname, const void __iomem *con_reg)
> +{
> +	struct samsung_clk_pll2126x *pll;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &samsung_pll2126x_clk_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE;
> +	init.parent_names = &pname;
> +	init.num_parents = 1;
> +
> +	pll->hw.init = &init;
> +	pll->con_reg = con_reg;
> +
> +	clk = samsung_register_pll(&pll->hw);
> +	if (IS_ERR(clk))
> +		kfree(pll);
> +
> +	return clk;
> +}
> +
> +/*
>   * PLL2550x Clock Type
>   */
> 
> @@ -396,3 +463,216 @@ struct clk * __init
> samsung_clk_register_pll2550x(const char *name,
> 
>  	return clk;
>  }
> +
> +/*
> + * PLL3000x Clock Type
> + */
> +
> +#define PLL3000X_MDIV_MASK	(0xFF)
> +#define PLL3000X_PDIV_MASK	(0x3)
> +#define PLL3000X_SDIV_MASK	(0x3)
> +#define PLL3000X_MDIV_SHIFT	(16)
> +#define PLL3000X_PDIV_SHIFT	(8)
> +#define PLL3000X_SDIV_SHIFT	(0)
> +
> +struct samsung_clk_pll3000x {
> +	struct clk_hw		hw;
> +	const void __iomem	*con_reg;
> +};
> +
> +#define to_clk_pll3000x(_hw) container_of(_hw, struct samsung_clk_pll3000x,
> hw) +
> +static unsigned long samsung_pll3000x_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct samsung_clk_pll3000x *pll = to_clk_pll3000x(hw);
> +	u32 pll_con, mdiv, pdiv, sdiv;
> +	u64 fvco = parent_rate;
> +
> +	pll_con = __raw_readl(pll->con_reg);
> +	mdiv = (pll_con >> PLL3000X_MDIV_SHIFT) & PLL3000X_MDIV_MASK;
> +	pdiv = (pll_con >> PLL3000X_PDIV_SHIFT) & PLL3000X_PDIV_MASK;
> +	sdiv = (pll_con >> PLL3000X_SDIV_SHIFT) & PLL3000X_SDIV_MASK;
> +
> +	fvco *= (2 * (mdiv + 8));
> +	do_div(fvco, pdiv << sdiv);
> +
> +	return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll3000x_clk_ops = {
> +	.recalc_rate = samsung_pll3000x_recalc_rate,
> +};
> +
> +struct clk * __init samsung_clk_register_pll3000x(const char *name,
> +			const char *pname, const void __iomem *con_reg)
> +{
> +	struct samsung_clk_pll3000x *pll;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &samsung_pll3000x_clk_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE;
> +	init.parent_names = &pname;
> +	init.num_parents = 1;
> +
> +	pll->hw.init = &init;
> +	pll->con_reg = con_reg;
> +
> +	clk = samsung_register_pll(&pll->hw);
> +	if (IS_ERR(clk))
> +		kfree(pll);
> +
> +	return clk;
> +}
> +
> +/*
> + * PLL6552x Clock Type
> + */
> +
> +#define PLL6552X_MDIV_MASK	(0x3FF)
> +#define PLL6552X_PDIV_MASK	(0x3F)
> +#define PLL6552X_SDIV_MASK	(0x7)
> +#define PLL6552X_MDIV_SHIFT	(14)
> +#define PLL6552X_PDIV_SHIFT	(5)
> +#define PLL6552X_SDIV_SHIFT	(0)

Are you sure about those bitfields?

In S3C6410 User's Manual they are different. You can look at my patch for a 
comparison:

http://thread.gmane.org/gmane.linux.usb.general/87571/focus=88344

> +struct samsung_clk_pll6552x {
> +	struct clk_hw		hw;
> +	const void __iomem	*con_reg;
> +};
> +
> +#define to_clk_pll6552x(_hw) container_of(_hw, struct samsung_clk_pll6552x,
> hw) +
> +static unsigned long samsung_pll6552x_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct samsung_clk_pll6552x *pll = to_clk_pll6552x(hw);
> +	u32 pll_con, mdiv, pdiv, sdiv;
> +	u64 fvco = parent_rate;
> +
> +	pll_con = __raw_readl(pll->con_reg);
> +	mdiv = (pll_con >> PLL6552X_MDIV_SHIFT) & PLL6552X_MDIV_MASK;
> +	pdiv = (pll_con >> PLL6552X_PDIV_SHIFT) & PLL6552X_PDIV_MASK;
> +	sdiv = (pll_con >> PLL6552X_SDIV_SHIFT) & PLL6552X_SDIV_MASK;
> +
> +	fvco *= mdiv;
> +	do_div(fvco, (pdiv << sdiv));
> +
> +	return (unsigned long)fvco;
> +}
> +
> +static const struct clk_ops samsung_pll6552x_clk_ops = {
> +	.recalc_rate = samsung_pll6552x_recalc_rate,
> +};
> +
> +struct clk * __init samsung_clk_register_pll6552x(const char *name,
> +			const char *pname, const void __iomem *con_reg)
> +{
> +	struct samsung_clk_pll6552x *pll;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +
> +	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +	if (!pll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.ops = &samsung_pll6552x_clk_ops;
> +	init.flags = CLK_GET_RATE_NOCACHE;
> +	init.parent_names = &pname;
> +	init.num_parents = 1;
> +
> +	pll->hw.init = &init;
> +	pll->con_reg = con_reg;
> +
> +	clk = samsung_register_pll(&pll->hw);
> +	if (IS_ERR(clk))
> +		kfree(pll);
> +
> +	return clk;
> +}
> +
> +/*
> + * PLL6553x Clock Type
> + */
> +
> +#define PLL6553X_MDIV_MASK	(0x7F)
> +#define PLL6553X_PDIV_MASK	(0x1F)
> +#define PLL6553X_SDIV_MASK	(0x3)
> +#define PLL6553X_KDIV_MASK	(0xFFFF)
> +#define PLL6553X_MDIV_SHIFT	(16)
> +#define PLL6553X_PDIV_SHIFT	(8)
> +#define PLL6553X_SDIV_SHIFT	(0)

Same about those bitfields. They seem to be different on S3C64xx.

Best regards,
Tomasz
