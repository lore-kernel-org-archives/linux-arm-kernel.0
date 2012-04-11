From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 08:43:59 +0200
Subject: [PATCH] clk: clk_calc_new_rates() required for parent only if
 CLK_SET_RATE_PARENT is set
In-Reply-To: <0b5e799807b09e47db1bf2805359aae36d947f60.1334124495.git.viresh.kumar@st.com>
References: <0b5e799807b09e47db1bf2805359aae36d947f60.1334124495.git.viresh.kumar@st.com>
Message-ID: <20120411064359.GD20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:38:53AM +0530, Viresh Kumar wrote:
> We need to call clk_calc_new_rates() for parent clock only when we have
> CLK_SET_RATE_PARENT flag set for clock.
> 
> This patch fixes it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

I see no functional change in this patch. With or without this patch we
only call clk_calc_new_rates() when the parent rate actually changed.
The code is easier to read with this patch and may be slightly more
efficient, so:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/clk/clk.c |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2f58455..56e32a1 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -780,15 +780,14 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  		goto out;
>  	}
>  
> -	if (clk->flags & CLK_SET_RATE_PARENT)
> -		new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
> -	else
> -		new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
> -
> -	if (best_parent_rate != clk->parent->rate) {
> -		top = clk_calc_new_rates(clk->parent, best_parent_rate);
> +	if (clk->flags & CLK_SET_RATE_PARENT) {
> +		new_rate = clk->ops->round_rate(clk->hw, rate,
> +				&best_parent_rate);
>  
> -		goto out;
> +		if (best_parent_rate != clk->parent->rate)
> +			top = clk_calc_new_rates(clk->parent, best_parent_rate);
> +	} else {
> +		new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
>  	}
>  
>  out:
> -- 
> 1.7.9
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
