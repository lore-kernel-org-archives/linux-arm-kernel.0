From: sivaramn@nvidia.com (Sivaram Nair)
Date: Mon, 14 Jan 2013 09:28:55 +0200
Subject: [PATCH v4 2/9] clk: tegra: Add tegra specific clocks
In-Reply-To: <1357890387-23245-3-git-send-email-pgaikwad@nvidia.com>
References: <1357890387-23245-1-git-send-email-pgaikwad@nvidia.com>
 <1357890387-23245-3-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20130114072855.GB17884@sivaramn-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 08:46:20AM +0100, Prashant Gaikwad wrote:
> +static int _program_pll(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
> +                       unsigned long rate)
> +{
> +       struct tegra_clk_pll *pll = to_clk_pll(hw);
> +       unsigned long flags = 0;
> +       u32 divp, val, old_base;
> +       int state;
> +
> +       divp = __ffs(cfg->p);
> +
> +       if (pll->flags & TEGRA_PLLU)
> +               divp ^= 1;
> +
> +       if (pll->lock)
> +               spin_lock_irqsave(pll->lock, flags);
> +
> +       old_base = val = pll_readl_base(pll);
> +       val &= ~((divm_mask(pll) << pll->divm_shift) |
> +                (divn_mask(pll) << pll->divn_shift) |
> +                (divp_mask(pll) << pll->divp_shift));
> +       val |= ((cfg->m << pll->divm_shift) |
> +               (cfg->n << pll->divn_shift) |
> +               (divp << pll->divp_shift));
> +       if (val == old_base) {
> +               if (pll->lock)
> +                       spin_unlock_irqrestore(pll->lock, flags);
> +               return 0;
> +       }
> +
> +       state = clk_pll_is_enabled(hw);
> +
> +       if (state) {
> +               if (pll->lock)
> +                       spin_unlock_irqrestore(pll->lock, flags);
> +
> +               clk_pll_disable(hw);
> +               val &= ~(PLL_BASE_BYPASS | PLL_BASE_ENABLE);
> +
> +               if (pll->lock)
> +                       spin_lock_irqsave(pll->lock, flags);

Instead of doing spin_unlock, disable and spin_lock, can't we use
_clk_pll_disable here, without the locks?

regards,
Sivaram
