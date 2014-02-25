From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 25 Feb 2014 14:10:03 -0800
Subject: [PATCH] clk: zynq: Use clk_readl/clk_writel helper function
In-Reply-To: <fcff6030d4dd07c43482a551cf1bc79545fbb55d.1392886522.git.michal.simek@xilinx.com>
References: <fcff6030d4dd07c43482a551cf1bc79545fbb55d.1392886522.git.michal.simek@xilinx.com>
Message-ID: <20140225221003.22529.54270@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Michal Simek (2014-02-20 00:55:46)
> Do not use readl/writel directly because the whole
> clk subsystem is using clk_readl/clk_writel functions.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Taken into clk-next.

Regards,
Mike

> ---
> 
>  drivers/clk/zynq/clkc.c |  4 ++--
>  drivers/clk/zynq/pll.c  | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 09dd017..e726c1b 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -148,7 +148,7 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
>         clks[fclk] = clk_register_gate(NULL, clk_name,
>                         div1_name, CLK_SET_RATE_PARENT, fclk_gate_reg,
>                         0, CLK_GATE_SET_TO_DISABLE, fclk_gate_lock);
> -       enable_reg = readl(fclk_gate_reg) & 1;
> +       enable_reg = clk_readl(fclk_gate_reg) & 1;
>         if (enable && !enable_reg) {
>                 if (clk_prepare_enable(clks[fclk]))
>                         pr_warn("%s: FCLK%u enable failed\n", __func__,
> @@ -277,7 +277,7 @@ static void __init zynq_clk_setup(struct device_node *np)
>                         SLCR_IOPLL_CTRL, 4, 1, 0, &iopll_lock);
> 
>         /* CPU clocks */
> -       tmp = readl(SLCR_621_TRUE) & 1;
> +       tmp = clk_readl(SLCR_621_TRUE) & 1;
>         clk = clk_register_mux(NULL, "cpu_mux", cpu_parents, 4,
>                         CLK_SET_RATE_NO_REPARENT, SLCR_ARM_CLK_CTRL, 4, 2, 0,
>                         &armclk_lock);
> diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
> index 3226f54..cec9759 100644
> --- a/drivers/clk/zynq/pll.c
> +++ b/drivers/clk/zynq/pll.c
> @@ -90,7 +90,7 @@ static unsigned long zynq_pll_recalc_rate(struct clk_hw *hw,
>          * makes probably sense to redundantly save fbdiv in the struct
>          * zynq_pll to save the IO access.
>          */
> -       fbdiv = (readl(clk->pll_ctrl) & PLLCTRL_FBDIV_MASK) >>
> +       fbdiv = (clk_readl(clk->pll_ctrl) & PLLCTRL_FBDIV_MASK) >>
>                         PLLCTRL_FBDIV_SHIFT;
> 
>         return parent_rate * fbdiv;
> @@ -112,7 +112,7 @@ static int zynq_pll_is_enabled(struct clk_hw *hw)
> 
>         spin_lock_irqsave(clk->lock, flags);
> 
> -       reg = readl(clk->pll_ctrl);
> +       reg = clk_readl(clk->pll_ctrl);
> 
>         spin_unlock_irqrestore(clk->lock, flags);
> 
> @@ -138,10 +138,10 @@ static int zynq_pll_enable(struct clk_hw *hw)
>         /* Power up PLL and wait for lock */
>         spin_lock_irqsave(clk->lock, flags);
> 
> -       reg = readl(clk->pll_ctrl);
> +       reg = clk_readl(clk->pll_ctrl);
>         reg &= ~(PLLCTRL_RESET_MASK | PLLCTRL_PWRDWN_MASK);
> -       writel(reg, clk->pll_ctrl);
> -       while (!(readl(clk->pll_status) & (1 << clk->lockbit)))
> +       clk_writel(reg, clk->pll_ctrl);
> +       while (!(clk_readl(clk->pll_status) & (1 << clk->lockbit)))
>                 ;
> 
>         spin_unlock_irqrestore(clk->lock, flags);
> @@ -168,9 +168,9 @@ static void zynq_pll_disable(struct clk_hw *hw)
>         /* shut down PLL */
>         spin_lock_irqsave(clk->lock, flags);
> 
> -       reg = readl(clk->pll_ctrl);
> +       reg = clk_readl(clk->pll_ctrl);
>         reg |= PLLCTRL_RESET_MASK | PLLCTRL_PWRDWN_MASK;
> -       writel(reg, clk->pll_ctrl);
> +       clk_writel(reg, clk->pll_ctrl);
> 
>         spin_unlock_irqrestore(clk->lock, flags);
>  }
> @@ -225,9 +225,9 @@ struct clk *clk_register_zynq_pll(const char *name, const char *parent,
> 
>         spin_lock_irqsave(pll->lock, flags);
> 
> -       reg = readl(pll->pll_ctrl);
> +       reg = clk_readl(pll->pll_ctrl);
>         reg &= ~PLLCTRL_BPQUAL_MASK;
> -       writel(reg, pll->pll_ctrl);
> +       clk_writel(reg, pll->pll_ctrl);
> 
>         spin_unlock_irqrestore(pll->lock, flags);
> 
> --
> 1.8.2.3
> 
