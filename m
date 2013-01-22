From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 22 Jan 2013 10:31:42 -0800
Subject: [PATCH] clk: tegra: use _clk_pll_disable from _program_pll
In-Reply-To: <1358188572-13005-1-git-send-email-swarren@wwwdotorg.org>
References: <1358188572-13005-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130122183142.24671.75933@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-01-14 10:36:12)
> From: Stephen Warren <swarren@nvidia.com>
> 
> _program_pll() was dropping the PLL's lock and calling clk_pll_disable().
> clk_pll_disable() does nothing but acquire the same lock and call
> _clk_pll_disable(). So, remove the lock manipulation code, and just call
> _clk_pll_disable() directly instead.
> 
> Reported-by: Sivaram Nair <sivaramn@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Mike, this also will need to go through the Tegra tree; just looking for
> any review/ack from you. Thanks.
> 

Stephen,

This change looks good to me, but should it not be rolled into the tegra
CCF series?  Several patches on top of that series have surfaced; do you
plan on posting a V6?

Regards,
Mike

>  drivers/clk/tegra/clk-pll.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 474ce1f..9f9bb73 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -339,14 +339,8 @@ static int _program_pll(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
>         state = clk_pll_is_enabled(hw);
>  
>         if (state) {
> -               if (pll->lock)
> -                       spin_unlock_irqrestore(pll->lock, flags);
> -
> -               clk_pll_disable(hw);
> +               _clk_pll_disable(hw);
>                 val &= ~(PLL_BASE_BYPASS | PLL_BASE_ENABLE);
> -
> -               if (pll->lock)
> -                       spin_lock_irqsave(pll->lock, flags);
>         }
>         pll_writel_base(val, pll);
>  
> -- 
> 1.7.10.4
