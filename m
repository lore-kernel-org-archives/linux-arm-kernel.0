From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 02 Nov 2015 11:10:07 +0100
Subject: [PATCH] clk: imx: add 'is_prepared' clk_ops callback for pllv3 clk
In-Reply-To: <1446487569-20757-1-git-send-email-b51503@freescale.com>
References: <1446487569-20757-1-git-send-email-b51503@freescale.com>
Message-ID: <1446459007.3156.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 03.11.2015, 02:06 +0800 schrieb Bai Ping:
> Add 'is_prepared' callback function for pllv3 type clk to make sure when
> the system is bootup, the unused clk is in a known state to match the
> prepare count info.
> 
What does this commit fix?
Is it there to ensure clocks are turned off at the disable unused clocks
phase even if they haven't been prepared even once during bootup?

Regards,
Lucas

> Signed-off-by: Bai Ping <b51503@freescale.com>
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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
