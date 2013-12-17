From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Dec 2013 15:58:02 -0700
Subject: [PATCH 2/4] clk: tegra: add EMC clock driver
In-Reply-To: <1387272400-4689-3-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
 <1387272400-4689-3-git-send-email-josephl@nvidia.com>
Message-ID: <52B0D6FA.2060101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 02:26 AM, Joseph Lo wrote:
> Add External Memory Controller (EMC) clock interface for the Tegra CCF
> driver to support EMC scaling.

> diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c

> +static long clk_emc_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *prate)
> +{
> +	struct tegra_clk_emc *emc = to_clk_emc(hw);
> +	struct clk *parent_clk = __clk_get_parent(hw->clk);
> +	unsigned long parent_rate = __clk_get_rate(parent_clk);
> +	unsigned long ret;
> +
> +	if (!emc->emc_ops)
> +		return parent_rate;
> +
> +	ret = emc->emc_ops->emc_round_rate(rate);
> +	if (!ret)
> +		return parent_rate;
> +
> +	return ret;
> +}

Rather than implementing this custom "emc_ops" feature, isn't there a
standard clock notifier feature that the EMC driver can use?

Isn't the EMC driver the only thing that will be changing the EMC clock
rate? If so, why not just have the EMC driver perform the appropriate
pre-/post-rate-change actions before/after calling clk_set_rate()?

> +void tegra_register_emc_clk_ops(struct clk *emc_clk,
> +				const struct emc_clk_ops *emc_ops)
> +{
> +	struct clk_hw *hw;
> +	struct tegra_clk_emc *emc;
> +
> +	if (IS_ERR_OR_NULL(emc_clk))
> +		return;

IS_ERROR_OR_NULL() shouldn't be used. "struct clk *" is either IS_ERR()
on error, or it's NULL on error, not both. The body of clk_get() implies
you need to use IS_ERR().
