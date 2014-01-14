From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 Jan 2014 12:41:46 -0800
Subject: [RFC PATCH] clk: composite: support determine_rate using
 rate_ops->round_rate + mux_ops->set_parent
In-Reply-To: <1389114233-11162-1-git-send-email-b.brezillon@overkiz.com>
References: <1387769564-12894-2-git-send-email-emilio@elopez.com.ar>
 <1389114233-11162-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20140114204146.4167.2654@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2014-01-07 09:03:52)
> In case the rate_hw does not implement determine_rate, but only round_rate
> we fallback to best_parent selection if mux_hw is present and support
> reparenting.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Hi Boris,

Since this change affects users of the composite clock type I will hold
off reviewing/applying this patch until after the merge window.

Thanks,
Mike

> ---
>  drivers/clk/clk-composite.c |   49 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 753d0b7..d3cf49a 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -64,11 +64,57 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
>         const struct clk_ops *mux_ops = composite->mux_ops;
>         struct clk_hw *rate_hw = composite->rate_hw;
>         struct clk_hw *mux_hw = composite->mux_hw;
> +       struct clk *parent;
> +       unsigned long parent_rate;
> +       long tmp_rate;
> +       unsigned long rate_diff;
> +       unsigned long best_rate_diff = ULONG_MAX;
> +       int i;
>  
>         if (rate_hw && rate_ops && rate_ops->determine_rate) {
>                 rate_hw->clk = hw->clk;
>                 return rate_ops->determine_rate(rate_hw, rate, best_parent_rate,
>                                                 best_parent_p);
> +       } else if (rate_hw && rate_ops && rate_ops->round_rate &&
> +                  mux_hw && mux_ops && mux_ops->set_parent) {
> +               *best_parent_p = NULL;
> +
> +               if (__clk_get_flags(hw->clk) & CLK_SET_RATE_NO_REPARENT) {
> +                       *best_parent_p = clk_get_parent(mux_hw->clk);
> +                       *best_parent_rate = __clk_get_rate(*best_parent_p);
> +
> +                       return rate_ops->round_rate(rate_hw, rate,
> +                                                   best_parent_rate);
> +               }
> +
> +               for (i = 0; i < __clk_get_num_parents(mux_hw->clk); i++) {
> +                       parent = clk_get_parent_by_index(mux_hw->clk, i);
> +                       if (!parent)
> +                               continue;
> +
> +                       parent_rate = __clk_get_rate(parent);
> +
> +                       tmp_rate = rate_ops->round_rate(rate_hw, rate,
> +                                                       &parent_rate);
> +                       if (tmp_rate < 0)
> +                               continue;
> +
> +                       if (tmp_rate < rate)
> +                               rate_diff = rate - tmp_rate;
> +                       else
> +                               rate_diff = tmp_rate - rate;
> +
> +                       if (!rate_diff || !*best_parent_p || best_rate_diff > rate_diff) {
> +                               *best_parent_p = parent;
> +                               *best_parent_rate = parent_rate;
> +                               best_rate_diff = rate_diff;
> +                       }
> +
> +                       if (!rate_diff)
> +                               return rate;
> +               }
> +
> +               return best_rate_diff;
>         } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>                 mux_hw->clk = hw->clk;
>                 return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
> @@ -196,7 +242,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
>                 composite->rate_hw = rate_hw;
>                 composite->rate_ops = rate_ops;
>                 clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
> -               if (rate_ops->determine_rate)
> +               if (rate_ops->determine_rate ||
> +                   (rate_ops->round_rate && clk_composite_ops->set_parent))
>                         clk_composite_ops->determine_rate = clk_composite_determine_rate;
>         }
>  
> -- 
> 1.7.9.5
> 
