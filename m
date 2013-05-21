From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 20 May 2013 21:44:38 -0700
Subject: [PATCH v4 5/5] clk: clk-mux: implement remuxing on set_rate
In-Reply-To: <1369056507-32521-6-git-send-email-james.hogan@imgtec.com>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-6-git-send-email-james.hogan@imgtec.com>
Message-ID: <519AFBB6.90700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 06:28 AM, James Hogan wrote:
> Implement clk-mux remuxing if the CLK_SET_RATE_NO_REPARENT flag isn't
> set. This implements determine_rate for clk-mux to propagate to each
> parent and to choose the best one (like clk-divider this chooses the
> parent which provides the fastest rate <= the requested rate).
>
> The determine_rate op is implemented as a core helper function so that
> it can be easily used by more complex clocks which incorporate muxes.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> Changes in v4:
>
> * never pass NULL to determine_rate's best_parent_clk parameter.
>
> Changes in v3:
>
> * rename/invert CLK_SET_RATE_REMUX to CLK_SET_RATE_NO_REPARENT and move
>    to patch 3.
>
>   drivers/clk/clk-mux.c        |  1 +
>   drivers/clk/clk.c            | 49 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/clk-provider.h |  3 +++
>   3 files changed, 53 insertions(+)
>
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 25b1734..cecfa01 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -100,6 +100,7 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
>   const struct clk_ops clk_mux_ops = {
>   	.get_parent = clk_mux_get_parent,
>   	.set_parent = clk_mux_set_parent,
> +	.determine_rate = __clk_mux_determine_rate,
>   };
>   EXPORT_SYMBOL_GPL(clk_mux_ops);
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 3ce4810..85b661d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -692,6 +692,55 @@ struct clk *__clk_lookup(const char *name)
>   	return NULL;
>   }
>
> +/*
> + * Helper for finding best parent to provide a given frequency. This can be used
> + * directly as a determine_rate callback (e.g. for a mux), or from a more
> + * complex clock that may combine a mux with other operations.
> + */
> +long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
> +			      unsigned long *best_parent_rate,
> +			      struct clk **best_parent_p)
> +{
> +	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
> +	int i, num_parents;
> +	unsigned long parent_rate, best = 0;
> +
> +	/* if NO_REPARENT flag set, pass through to current parent */
> +	if (clk->flags & CLK_SET_RATE_NO_REPARENT) {
> +		parent = clk->parent;
> +		if (clk->flags & CLK_SET_RATE_PARENT)
> +			best = __clk_round_rate(parent, rate);
> +		else if (parent)
> +			best = __clk_get_rate(parent);
> +		else
> +			best = __clk_get_rate(clk);
> +		goto out;
> +	}
> +
> +	/* find the parent that can provide the fastest rate <= rate */
> +	num_parents = clk->num_parents;
> +	for (i = 0; i < num_parents; i++) {

While writing a similar code for our internal tree, I quickly came to 
the realization that, "all parents are equal, but some are more equal 
than others". The simplest example is a clock tree like this:

Source -> Divider -> Mux
Source -> Mux

A rate of Y can be achieved for Mux by either running Source at Y and 
picking that input or running Source at Y * 2 and Divider set to div-2 
and picking the Divider input.

The solution seems to be a priority list of parents. I'm sure there 
would be other reason (jitter, clock quality, etc) for a mux to pick one 
parent vs. another when both of them can provide the required rate.

I think this loop should loop over parents based on their priority 
order. So, parents should become a struct of { clk, index } and have the 
parents listed in the order of priority. Well, at least in that long run 
that would be better to avoid messing up parent/index values. But for 
now, you could just have a priority array of index or parents.

It might not fit 100% of the cases where two parents can provide the 
same rate, but it should fit most use cases.

> +		parent = clk_get_parent_by_index(clk, i);
> +		if (!parent)
> +			continue;
> +		if (clk->flags & CLK_SET_RATE_PARENT)
> +			parent_rate = __clk_round_rate(parent, rate);
> +		else
> +			parent_rate = __clk_get_rate(parent);
> +		if (parent_rate <= rate && parent_rate > best) {
> +			best_parent = parent;
> +			best = parent_rate;
> +		}
> +	}
> +
> +out:
> +	if (best_parent)
> +		*best_parent_p = best_parent;
> +	*best_parent_rate = best;
> +
> +	return best;
> +}
> +

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
