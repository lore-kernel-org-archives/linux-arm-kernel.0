From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 May 2012 09:58:36 +0200
Subject: [PATCH 2/5] clk: prevent spurious parent rate propagation
In-Reply-To: <1336367310-5140-3-git-send-email-mturquette@linaro.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
 <1336367310-5140-3-git-send-email-mturquette@linaro.org>
Message-ID: <20120507075836.GE4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2012 at 10:08:27PM -0700, Mike Turquette wrote:
> Patch 'clk: always pass parent_rate into .round_rate' made a subtle
> change to the semantics of .round_rate.  It is now expected for the
> parent's rate to always be passed in, simplifying the implemenation of
> various .round_rate callback definitions.
> 
> However the patch also introduced a bug in clk_calc_new_rates whereby a
> clock without the CLK_SET_RATE_PARENT flag set could still propagate a
> rate change up to a parent clock if the the .round_rate callback
> modified the &best_parent_rate value in any way.
> 
> This patch fixes the issue at the framework level (in
> clk_calc_new_rates) by specifically handling the case where the
> CLK_SET_RATE_PARENT flag is not set.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> Reported-by: Sascha Hauer<s.hauer@pengutronix.de>

I think a warning might be useful when a clk driver tries to change the
parent rate even if it is not allowed to. This can be added in a later
patch, so

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/clk/clk.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8149764..7ceca0e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -774,12 +774,18 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  	if (IS_ERR_OR_NULL(clk))
>  		return NULL;
>  
> +	/* save parent rate, if it exists */
> +	if (clk->parent)
> +		best_parent_rate = clk->parent->rate;
> +
>  	/* never propagate up to the parent */
>  	if (!(clk->flags & CLK_SET_RATE_PARENT)) {
>  		if (!clk->ops->round_rate) {
>  			clk->new_rate = clk->rate;
>  			return NULL;
>  		}
> +		new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
> +		goto out;
>  	}
>  
>  	/* need clk->parent from here on out */
> @@ -795,7 +801,6 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  		goto out;
>  	}
>  
> -	best_parent_rate = clk->parent->rate;
>  	new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
>  
>  	if (best_parent_rate != clk->parent->rate) {
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
