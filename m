From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 9 Oct 2014 13:44:33 -0700
Subject: [PATCH v3 6/8] clk: Change clk_ops->determine_rate to return a
 clk_hw as the best parent
In-Reply-To: <1412866903-6970-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1412866903-6970-1-git-send-email-tomeu.vizoso@collabora.com>
 <1412866903-6970-7-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20141009204433.GE5493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09, Tomeu Vizoso wrote:
> @@ -946,6 +946,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>  {
>  	unsigned long parent_rate = 0;
>  	struct clk *parent;
> +	struct clk_hw *parent_hw;
>  
>  	if (!clk)
>  		return 0;
> @@ -956,7 +957,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>  
>  	if (clk->ops->determine_rate)
>  		return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
> -						&parent);
> +						&parent_hw);

We should assign the value of parent_hw somewhere here so that
drivers don't need to if they want the current parent. This would
match the current behavior where parent is already assigned the
current parent.

>  	else if (clk->ops->round_rate)
>  		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
>  	else if (clk->flags & CLK_SET_RATE_PARENT)
> @@ -1345,6 +1346,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  {
>  	struct clk *top = clk;
>  	struct clk *old_parent, *parent;
> +	struct clk_hw *parent_hw;
>  	unsigned long best_parent_rate = 0;
>  	unsigned long new_rate;
>  	int p_index = 0;
> @@ -1362,7 +1364,8 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  	if (clk->ops->determine_rate) {
>  		new_rate = clk->ops->determine_rate(clk->hw, rate,
>  						    &best_parent_rate,
> -						    &parent);
> +						    &parent_hw);
> +		parent = parent_hw->clk;

Same comment here.

>  	} else if (clk->ops->round_rate) {
>  		new_rate = clk->ops->round_rate(clk->hw, rate,
>  						&best_parent_rate);
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
