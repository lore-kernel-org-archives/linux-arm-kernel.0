From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 16 Mar 2012 20:25:45 +0800
Subject: [PATCH v7 3/3] clk: basic clock hardware types
In-Reply-To: <1331878280-2758-4-git-send-email-mturquette@linaro.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-4-git-send-email-mturquette@linaro.org>
Message-ID: <20120316122542.GA1774@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> +static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
> +		unsigned long *best_parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	int i, bestdiv = 0;
> +	unsigned long parent_rate, best = 0, now, maxdiv;
> +
> +	if (!rate)
> +		rate = 1;
> +
> +	maxdiv = (1 << divider->width);
> +
> +	if (divider->flags & CLK_DIVIDER_ONE_BASED)
> +		maxdiv--;
> +
> +	if (!best_parent_rate) {
> +		parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
> +		bestdiv = DIV_ROUND_UP(parent_rate, rate);
> +		bestdiv = bestdiv == 0 ? 1 : bestdiv;
> +		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
> +		return bestdiv;
> +	}
> +
> +	/*
> +	 * The maximum divider we can use without overflowing
> +	 * unsigned long in rate * i below
> +	 */
> +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +	for (i = 1; i <= maxdiv; i++) {
> +		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
> +				MULT_ROUND_UP(rate, i));
> +		now = parent_rate / i;
> +		if (now <= rate && now > best) {
> +			bestdiv = i;
> +			best = now;
> +			*best_parent_rate = parent_rate;
Better add		if (now == rate)
				break;
There may be more than one hit for (now == rate). We'd better select
smallest div, thus smallest parent_rate.

It's the same comment for v6, but not show stopper.

Thanks
Richard
> +		}
> +	}
> +
> +	if (!bestdiv) {
> +		bestdiv = (1 << divider->width);
> +		if (divider->flags & CLK_DIVIDER_ONE_BASED)
> +			bestdiv--;
> +		*best_parent_rate = __clk_round_rate(__clk_get_parent(hw->clk), 1);
> +	}
> +
> +	return bestdiv;
> +}
 
