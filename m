From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 17 Jan 2013 11:45:53 +0200
Subject: [PATCH V5 1/3] clk: tegra: add Tegra specific clocks
In-Reply-To: <1358369575-7325-1-git-send-email-swarren@wwwdotorg.org>
References: <1358369575-7325-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130117094553.GD4118@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static struct clk *_tegra_clk_register_pll(const char *name,
> +               const char *parent_name, void __iomem *clk_base,
> +               void __iomem *pmc, unsigned long flags,
> +               unsigned long fixed_rate,
> +               struct tegra_clk_pll_params *pll_params, u8 pll_flags,
> +               struct tegra_clk_pll_freq_table *freq_table, spinlock_t *lock,
> +               bool plle)
> +{
> +       struct tegra_clk_pll *pll;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = plle ? &tegra_clk_plle_ops : &tegra_clk_pll_ops;
> +       init.flags = flags;
> +       init.parent_names = (parent_name ? &parent_name : NULL);
> +       init.num_parents = (parent_name ? 1 : 0);
> +
> +       pll->clk_base = clk_base;
> +       pll->pmc = pmc;
> +
> +       pll->freq_table = freq_table;
> +       pll->params = pll_params;
> +       pll->fixed_rate = fixed_rate;
> +       pll->flags = pll_flags;
> +       pll->lock = lock;
> +
> +       pll->divp_shift = PLL_BASE_DIVP_SHIFT;
> +       pll->divp_width = PLL_BASE_DIVP_WIDTH;
> +       pll->divn_shift = PLL_BASE_DIVN_SHIFT;
> +       pll->divn_width = PLL_BASE_DIVN_WIDTH;
> +       pll->divm_shift = PLL_BASE_DIVM_SHIFT;
> +       pll->divm_width = PLL_BASE_DIVM_WIDTH;
> +
> +       /* Data in .init is copied by clk_register(), so stack variable OK */
> +       pll->hw.init = &init;
> +
> +       clk = clk_register(NULL, &pll->hw);
> +       if (IS_ERR(clk))
> +               kfree(pll);
> +
> +       return clk;
> +}
> +
> +struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
> +               void __iomem *clk_base, void __iomem *pmc,
> +               unsigned long flags, unsigned long fixed_rate,
> +               struct tegra_clk_pll_params *pll_params, u8 pll_flags,
> +               struct tegra_clk_pll_freq_table *freq_table, spinlock_t *lock)
> +{
> +       return _tegra_clk_register_pll(name, parent_name, clk_base, pmc,
> +                       flags, fixed_rate, pll_params, pll_flags, freq_table,
> +                       lock, false);
> +}
> +
> +struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
> +               void __iomem *clk_base, void __iomem *pmc,
> +               unsigned long flags, unsigned long fixed_rate,
> +               struct tegra_clk_pll_params *pll_params, u8 pll_flags,
> +               struct tegra_clk_pll_freq_table *freq_table, spinlock_t *lock)
> +{
> +       return _tegra_clk_register_pll(name, parent_name, clk_base, pmc,
> +                       flags, fixed_rate, pll_params, pll_flags, freq_table,
> +                       lock, true);
> +}

For Tegra114 I will need to introduce more new PLL types. So instead of using
a boolean plle, maybe just pass a pointer to the relevant struct clk_ops? This
will make extension for Tegra114 easier.

Cheers,

Peter.
