From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 14:20:03 -0600
Subject: [PATCH v2 1/7] clk: tegra: Add support for PLLSS
In-Reply-To: <1381850098-12357-2-git-send-email-pdeschrijver@nvidia.com>
References: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
 <1381850098-12357-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525DA373.6040805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 09:14 AM, Peter De Schrijver wrote:
> Tegra124 introduces a new PLL type, PLLSS. Add support for it.

> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c


> +static int clk_pllss_set_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long parent_rate)

This function seems pretty generic. Is it possible to share a bit more
code with any of the other pllXXX_set_rate() functions?

> +struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
> +				void __iomem *clk_base, unsigned long flags,
> +				struct tegra_clk_pll_params *pll_params,
> +				spinlock_t *lock)

> +	val = pll_readl_base(pll);
> +	if (val & PLLSS_REF_SRC_SEL_MASK) {
> +		WARN(1, "Unknown parent selected for %s: %d\n", name,
> +			(val & PLLSS_REF_SRC_SEL_MASK) >>
> +			PLLSS_REF_SRC_SEL_SHIFT);
> +		kfree(pll);
> +		return ERR_PTR(-EINVAL);
> +	}

If there's a field in HW that muxes the clock input between n clocks,
why does this function assume there's a single parent for this PLL, by
taking a "const char *parent_name" parameter?

What happens if the bootloader changed this field in HW; is the kernel
simply not able to boot?

> +
> +	_get_pll_mnp(pll, &cfg);
> +	if (cfg.n > 1) {
> +		WARN(1, "%s should not be initialized\n", name);
> +		kfree(pll);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	parent_rate = __clk_get_rate(parent);
> +
> +	pll_params->vco_min = _clip_vco_min(pll_params->vco_min, parent_rate);
> +
> +	cfg.m = _pll_fixed_mdiv(pll_params, parent_rate);
> +	cfg.n = cfg.m * pll_params->vco_min / parent_rate;
> +
> +	for (i = 0; pll_params->pdiv_tohw[i].pdiv; i++)
> +		;
> +	if (!i) {
> +		kfree(pll);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	cfg.p = pll_params->pdiv_tohw[i-1].hw_val;
> +
> +	_update_pll_mnp(pll, &cfg);

I *guess* that seems to be forcing a particular configuration of the
PLL. Why not do that in the initialization table? Some comments here re:
why this is done might be nice.
