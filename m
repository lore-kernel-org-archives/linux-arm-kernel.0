From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 14 Mar 2012 16:54:14 +0800
Subject: [PATCH v6 3/3] clk: basic clock hardware types
In-Reply-To: <1331366064-1273-4-git-send-email-mturquette@linaro.org>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-4-git-send-email-mturquette@linaro.org>
Message-ID: <20120314085413.GG3261@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

> +static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
> +		unsigned long *best_parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	int i, bestdiv = 0;
> +	unsigned long parent_rate, best = 0, now, maxdiv;
> +
> +	maxdiv = (1 << divider->width);
> +
> +	if (divider->flags & CLK_DIVIDER_ONE_BASED)
> +		maxdiv--;
> +
> +	if (!(__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT)) {
> +		parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
> +		bestdiv = parent_rate / rate;
> +		bestdiv = bestdiv == 0 ? 1 : bestdiv;
> +		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
> +		goto out;
> +	}
> +
> +	/*
> +	 * The maximum divider we can use without overflowing
> +	 * unsigned long in rate * i below
> +	 */
> +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +	for (i = 1; i <= maxdiv; i++) {
> +		int div;
> +		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
> +				rate * i);
> +		div = parent_rate / rate;
> +		div = div > maxdiv ? maxdiv : div;
> +		div = div < 1 ? 1 : div;
> +		now = parent_rate / div;
> +
> +		if (now <= rate && now >= best) {
> +			bestdiv = div;
> +			best = now;
> +			*best_parent_rate = parent_rate;
			if (now == rate)
				break;
we don't need it to loop to end, and smaller parent_rate is better.
> +		}
> +	}
> +
> +	if (!bestdiv) {
> +		bestdiv = (1 << divider->width);
> +		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk), 1);
> +	} else {
> +		parent_rate = best * bestdiv;
> +	}
> +
> +out:
> +	if (best_parent_rate)
> +		*best_parent_rate = parent_rate;
> +
> +	return bestdiv;
> +}
