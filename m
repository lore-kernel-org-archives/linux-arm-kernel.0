From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 11 Mar 2012 12:34:14 +0100
Subject: [PATCH v6 2/3] clk: introduce the common clock framework
In-Reply-To: <1331366064-1273-3-git-send-email-mturquette@linaro.org>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-3-git-send-email-mturquette@linaro.org>
Message-ID: <20120311113414.GM3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

I was about to give my tested-by when I decided to test the set_rate
function. Unfortunately this is broken for several reasons. I'll try
to come up with a fixup series later the day.

On Fri, Mar 09, 2012 at 11:54:23PM -0800, Mike Turquette wrote:
> +
> +/**
> + * DOC: Using the CLK_SET_RATE_PARENT flag
> + *
> + * __clk_set_rate changes the child's rate before the parent's to more
> + * easily handle failure conditions.
> + *
> + * This means clk might run out of spec for a short time if its rate is
> + * increased before the parent's rate is updated.
> + *
> + * To prevent this consider setting the CLK_SET_RATE_GATE flag on any
> + * clk where you also set the CLK_SET_RATE_PARENT flag
> + *
> + * PRE_RATE_CHANGE notifications are supposed to stack as a rate change
> + * request propagates up the clk tree.  This reflects the different
> + * rates that a downstream clk might experience if left enabled while
> + * upstream parents change their rates.
> + */
> +static struct clk *__clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk *fail_clk = NULL;
> +	int ret = NOTIFY_DONE;
> +	unsigned long old_rate = clk->rate;
> +	unsigned long new_rate;
> +	unsigned long parent_old_rate;
> +	unsigned long parent_new_rate = 0;
> +	struct clk *child;
> +	struct hlist_node *tmp;
> +
> +	/* bail early if we can't change rate while clk is enabled */
> +	if ((clk->flags & CLK_SET_RATE_GATE) && clk->enable_count)
> +		return clk;
> +
> +	/* find the new rate and see if parent rate should change too */
> +	WARN_ON(!clk->ops->round_rate);
> +
> +	new_rate = clk->ops->round_rate(clk->hw, rate, &parent_new_rate);

You don't need a WARN_ON when you derefence clk->ops->round_rate anyway.
Also, even when the current clock does not have a set_rate function it
can still change its rate when the CLK_SET_RATE_PARENT is set.

> +
> +	/* NOTE: pre-rate change notifications will stack */
> +	if (clk->notifier_count)
> +		ret = __clk_notify(clk, PRE_RATE_CHANGE, clk->rate, new_rate);
> +
> +	if (ret == NOTIFY_BAD)
> +		return clk;
> +
> +	/* speculate rate changes down the tree */
> +	hlist_for_each_entry(child, tmp, &clk->children, child_node) {
> +		ret = __clk_speculate_rates(child, new_rate);
> +		if (ret == NOTIFY_BAD)
> +			return clk;
> +	}
> +
> +	/* change the rate of this clk */
> +	if (clk->ops->set_rate)
> +		ret = clk->ops->set_rate(clk->hw, new_rate);

I don't know the reason why you change the child clock before the parent
clock, but it cannot work since this clock will change its rate based on
the old parent rate and not the new one.

There are more things, as said I'll try to come up with a fixup series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
