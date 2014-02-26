From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 26 Feb 2014 00:37:30 -0800
Subject: [PATCH 1/3] clk: socfpga: Fix integer overflow in clock
 calculation
In-Reply-To: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
References: <1392844273-11918-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140226083730.22529.8405@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting dinguyen at altera.com (2014-02-19 13:11:10)
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Use 64-bit integer for calculating clock rate. Also use do_div for the
> 64-bit division.
> 
> Signed-off-by: Graham Moore <grmoore@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Changes to the clk driver look good to me.

Regards,
Mike

> ---
>  drivers/clk/socfpga/clk-pll.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index 362004e..834b6e9 100644
> --- a/drivers/clk/socfpga/clk-pll.c
> +++ b/drivers/clk/socfpga/clk-pll.c
> @@ -44,7 +44,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
>                                          unsigned long parent_rate)
>  {
>         struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
> -       unsigned long divf, divq, vco_freq, reg;
> +       unsigned long divf, divq, reg;
> +       unsigned long long vco_freq;
>         unsigned long bypass;
>  
>         reg = readl(socfpgaclk->hw.reg);
> @@ -54,8 +55,9 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
>  
>         divf = (reg & SOCFPGA_PLL_DIVF_MASK) >> SOCFPGA_PLL_DIVF_SHIFT;
>         divq = (reg & SOCFPGA_PLL_DIVQ_MASK) >> SOCFPGA_PLL_DIVQ_SHIFT;
> -       vco_freq = parent_rate * (divf + 1);
> -       return vco_freq / (1 + divq);
> +       vco_freq = (unsigned long long)parent_rate * (divf + 1);
> +       do_div(vco_freq, (1 + divq));
> +       return (unsigned long)vco_freq;
>  }
>  
>  static struct clk_ops clk_pll_ops = {
> -- 
> 1.7.9.5
> 
