From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 22 Apr 2010 16:37:44 +0200
Subject: [PATCH] arm: mxc: utilise usecount field in clock operations
In-Reply-To: <b9f250fee8e5300e859b2afc234868ba7632f619.1271864861.git.amit.kucheria@canonical.com>
References: <b9f250fee8e5300e859b2afc234868ba7632f619.1271864861.git.amit.kucheria@canonical.com>
Message-ID: <20100422143744.GC32348@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 09:37:31PM +0300, Amit Kucheria wrote:
> clk->usecount can be used by platform code to check if a clock is active or
> not.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
>  arch/arm/plat-mxc/clock.c |   37 ++++++++++++++++++++++++-------------
>  1 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> index 323ff8c..c791f38 100644
> --- a/arch/arm/plat-mxc/clock.c
> +++ b/arch/arm/plat-mxc/clock.c
> @@ -50,15 +50,15 @@ static DEFINE_MUTEX(clocks_mutex);
>  
>  static void __clk_disable(struct clk *clk)
>  {
> -	if (clk == NULL || IS_ERR(clk))
> +	if (clk == NULL || IS_ERR(clk) || !clk->usecount)
>  		return;
>  
> -	__clk_disable(clk->parent);
> -	__clk_disable(clk->secondary);
> -
> -	WARN_ON(!clk->usecount);
> -	if (!(--clk->usecount) && clk->disable)
> -		clk->disable(clk);
> +	if (!(--clk->usecount)) {
> +		if (clk->disable)
> +			clk->disable(clk);
> +		__clk_disable(clk->parent);
> +		__clk_disable(clk->secondary);
> +	}
>  }
This removes the WARN_ON if the clock is already off.  Is this intended?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
