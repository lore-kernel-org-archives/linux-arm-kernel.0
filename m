From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 14:39:47 +0800
Subject: [PATCH] clk: imx: add 'is_prepared' clk_ops callback for pllv3 clk
In-Reply-To: <1446487569-20757-1-git-send-email-b51503@freescale.com>
References: <1446487569-20757-1-git-send-email-b51503@freescale.com>
Message-ID: <20151124063947.GL11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 02:06:09AM +0800, Bai Ping wrote:
> Add 'is_prepared' callback function for pllv3 type clk to make sure when
> the system is bootup, the unused clk is in a known state to match the
> prepare count info.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>

Please resend the patch with following clk maintainers and list on copy.
Also remember to add Lucas' Reviewed-by: tag.

COMMON CLK FRAMEWORK
M:      Michael Turquette <mturquette@baylibre.com>
M:      Stephen Boyd <sboyd@codeaurora.org>
L:      linux-clk at vger.kernel.org

Shawn

> ---
>  drivers/clk/imx/clk-pllv3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 6addf8f..c05c43d 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -97,6 +97,16 @@ static void clk_pllv3_unprepare(struct clk_hw *hw)
>  	writel_relaxed(val, pll->base);
>  }
>  
> +static int clk_pllv3_is_prepared(struct clk_hw *hw)
> +{
> +	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> +
> +	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static unsigned long clk_pllv3_recalc_rate(struct clk_hw *hw,
>  					   unsigned long parent_rate)
>  {
> @@ -139,6 +149,7 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
>  static const struct clk_ops clk_pllv3_ops = {
>  	.prepare	= clk_pllv3_prepare,
>  	.unprepare	= clk_pllv3_unprepare,
> +	.is_prepared	= clk_pllv3_is_prepared,
>  	.recalc_rate	= clk_pllv3_recalc_rate,
>  	.round_rate	= clk_pllv3_round_rate,
>  	.set_rate	= clk_pllv3_set_rate,
> @@ -193,6 +204,7 @@ static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate,
>  static const struct clk_ops clk_pllv3_sys_ops = {
>  	.prepare	= clk_pllv3_prepare,
>  	.unprepare	= clk_pllv3_unprepare,
> +	.is_prepared	= clk_pllv3_is_prepared,
>  	.recalc_rate	= clk_pllv3_sys_recalc_rate,
>  	.round_rate	= clk_pllv3_sys_round_rate,
>  	.set_rate	= clk_pllv3_sys_set_rate,
> @@ -265,6 +277,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
>  static const struct clk_ops clk_pllv3_av_ops = {
>  	.prepare	= clk_pllv3_prepare,
>  	.unprepare	= clk_pllv3_unprepare,
> +	.is_prepared	= clk_pllv3_is_prepared,
>  	.recalc_rate	= clk_pllv3_av_recalc_rate,
>  	.round_rate	= clk_pllv3_av_round_rate,
>  	.set_rate	= clk_pllv3_av_set_rate,
> @@ -279,6 +292,7 @@ static unsigned long clk_pllv3_enet_recalc_rate(struct clk_hw *hw,
>  static const struct clk_ops clk_pllv3_enet_ops = {
>  	.prepare	= clk_pllv3_prepare,
>  	.unprepare	= clk_pllv3_unprepare,
> +	.is_prepared	= clk_pllv3_is_prepared,
>  	.recalc_rate	= clk_pllv3_enet_recalc_rate,
>  };
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
