From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 08:36:44 +0200
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: move the timeout just before
 the comparison
In-Reply-To: <1373763528-20792-1-git-send-email-peter.chen@freescale.com>
References: <1373763528-20792-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130715063644.GK14452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 08:58:48AM +0800, Peter Chen wrote:
> It can let the timeout value be more precise.
> 
> Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/mach-imx/clk-pllv3.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
> index a9fad5f..e2c026f 100644
> --- a/arch/arm/mach-imx/clk-pllv3.c
> +++ b/arch/arm/mach-imx/clk-pllv3.c
> @@ -48,7 +48,7 @@ struct clk_pllv3 {
>  static int clk_pllv3_prepare(struct clk_hw *hw)
>  {
>  	struct clk_pllv3 *pll = to_clk_pllv3(hw);
> -	unsigned long timeout = jiffies + msecs_to_jiffies(10);
> +	unsigned long timeout;
>  	u32 val;
>  
>  	val = readl_relaxed(pll->base);
> @@ -59,6 +59,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
>  		val &= ~BM_PLL_POWER;
>  	writel_relaxed(val, pll->base);
>  
> +	timeout = jiffies + msecs_to_jiffies(10);
>  	/* Wait for PLL to lock */
>  	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
>  		if (time_after(jiffies, timeout))

For a proper timeout loop you have to check the condition once after the
timeout, like this:

	while (1) {
		if (condition)
			break;
		if (time_after())
			break;
	}

	if (condition)
		res = OK;
	else
		res = -ETIMEDOUT;

Otherwise you risk being scheduled away after checking the condition but
before checking the timeout.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
