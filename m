From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sun, 19 May 2013 21:15:08 -0700
Subject: [PATCH v3 2/4] clk: add support for clock reparent on set_rate
In-Reply-To: <1368625263-23136-3-git-send-email-james.hogan@imgtec.com>
References: <1368625263-23136-1-git-send-email-james.hogan@imgtec.com>
 <1368625263-23136-3-git-send-email-james.hogan@imgtec.com>
Message-ID: <20130520041508.GA27676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noticed another minor thing. I'm working on the set rate and
parent at the same time op on top of this patch series. Hopefully
have something soon.

On 05/15, James Hogan wrote:
> @@ -1181,6 +1242,11 @@ static void clk_change_rate(struct clk *clk)
>  
>  	old_rate = clk->rate;
>  
> +	/* set parent */
> +	if (clk->new_parent && clk->new_parent != clk->parent)
> +		__clk_set_parent_no_recalc(clk, clk->new_parent,
> +					   clk->new_parent_index);
> +

This check here for new_parent != clk->parent ...

> @@ -1451,6 +1501,27 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent, u8 p_index)
>  	return 0;
>  }
>  
> +static int __clk_set_parent_no_recalc(struct clk *clk, struct clk *parent,
> +				      u8 p_index)
> +{
> +	int ret = 0;
> +
> +	if (clk->parent == parent)
> +		goto out;

causes this to never be true, so we can probably drop it.

> +
> +	/* only re-parent if the clock is not in use */
> +	ret = __clk_set_parent(clk, parent, p_index);
> +	if (ret)
> +		goto out;
> +
> +	/* reparent, but don't propagate rate recalculation downstream */
> +	clk_reparent(clk, parent);
> +	clk_debug_reparent(clk, parent);
> +
> +out:
> +	return ret;
> +}

Also, we never check the return code so it's sort of useless.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
