From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 25 Jun 2014 09:57:50 +0200
Subject: [PATCH v4 01/13] clk: composite: support determine_rate using
 rate_ops->round_rate + mux_ops->set_parent
In-Reply-To: <2257244.FrPXR4AKP7@diego>
References: <1808429.dNxms7FR7U@diego>
	<2257244.FrPXR4AKP7@diego>
Message-ID: <CAG374jAeMKm-6D3Ai2Bzayr=jUJYMgtTuAdi6PjbCr4JUpo-zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Seems to be good, tested on stih416 board.

Only small remarks below

Best Regards

Gabriel.


On 22 June 2014 22:43, Heiko St?bner <heiko@sntech.de> wrote:
> From: Boris BREZILLON <b.brezillon@overkiz.com>
>
> In case the rate_hw does not implement determine_rate, but only round_rate
> we fallback to best_parent selection if mux_hw is present and support
> reparenting.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>
> This also fixes a rate calculation problem when using the standard div and
> mux ops, as in this case currently only the mux->determine_rate is used
> in the composite rate calculation.
> So when for example the composite clock has two parents at 600 and 800MHz,
> the requested rate is 75MHz, which the divider could provide, without this
> change the rate would be set 600MHz ignoring the divider completely.
> This may be way out of spec for the component.
>
> [fixed the output to actually return a rate instead of the diff]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/clk-composite.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 57a078e..0a4cd21 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -64,11 +64,59 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
>         const struct clk_ops *mux_ops = composite->mux_ops;
>         struct clk_hw *rate_hw = composite->rate_hw;
>         struct clk_hw *mux_hw = composite->mux_hw;
> +       struct clk *parent;
> +       unsigned long parent_rate;
> +       long tmp_rate, best_rate;
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

rate_dif = abs(rate - tmp_rate) is not better ?

> +
> +                       if (!rate_diff || !*best_parent_p
> +                                      || best_rate_diff > rate_diff) {
> +                               *best_parent_p = parent;
> +                               *best_parent_rate = parent_rate;
> +                               best_rate_diff = rate_diff;
> +                               best_rate = tmp_rate;
> +                       }
> +
> +                       if (!rate_diff)
> +                               return rate;
> +               }
> +
> +               return best_rate;

warning compilation: 'best_rate' may be used uninitialized in this function

>         } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>                 mux_hw->clk = hw->clk;
>                 return mux_ops->determine_rate(mux_hw, rate, best_parent_rate,
> @@ -196,7 +244,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
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
> 1.9.0
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
