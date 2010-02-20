From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Feb 2010 16:33:13 +0000
Subject: [PATCH 03/13] ARM: LPC32XX: Clock driver
In-Reply-To: <1266621969-28847-4-git-send-email-wellsk40@gmail.com>
References: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
	<1266621969-28847-4-git-send-email-wellsk40@gmail.com>
Message-ID: <20100220163313.GA12409@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2010 at 03:25:59PM -0800, wellsk40 at gmail.com wrote:
> +static u32 local_return_parent_rate(struct clk *clk)
> +{
> +	/*
> +	 * If a clock has a rate of 0, then it inherits it's parent
> +	 * clock rate
> +	 */
> +	if (clk->rate == 0)
> +		return local_return_parent_rate(clk->parent);

Does this really need to be recursive?

	while (clk->rate == 0)
		clk = clk->parent;

	return clk->rate;

?

> +static u32 mmc_get_rate(struct clk *clk)
> +{
> +	u32 div, tmp, rate;
> +
> +	div = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
> +	tmp = div & LPC32XX_CLKPWR_MSCARD_SDCARD_EN;
> +
> +	if (!tmp)
> +		return 0;

There's no requirement to return a rate of zero if the clock is not enabled.
In fact, it's something that should be avoided because it prevents querying
the rate you'll get before enabling the clock (which might affect whether
you decide to enable it.)

> +static void local_clk_disable(struct clk *clk)
> +{
> +	WARN_ON(clk->usecount == 0);
> +
> +	/* Don't attempt to disable clock if it has no users */
> +	if (clk->usecount > 0) {
> +		clk->usecount--;
> +
> +		/* Only disable clock when it has no more users */
> +		if ((clk->usecount == 0) && (clk->enable))
> +			clk->enable(clk, 0);
> +
> +		/* Check parent clocks, they may need to be disabled too */
> +		if (clk->parent)
> +			local_clk_disable(clk->parent);

This is not a good idea if you ever support clock reparenting - it's
much better to have the parent enabled when the usecount changes from
0 to 1, and disabled when you move from 1 to 0 - otherwise you'll
have to call local_clk_disable() and local_clk_enable() multiple times
when you reparent.

> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +	unsigned long rate;
> +
> +	clk_lock();
> +	rate = (clk->get_rate)(clk);

parens aren't required.

> +	if (clk->set_rate) {
> +		clk_lock();
> +		ret = (clk->set_rate)(clk, rate);

Ditto.

> +/*
> + * clk_round_rate - adjust a rate to the exact rate a clock can provide
> + */
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	int ret;
> +
> +	/* Use set_rate to try to adjust the rate if it supports it */
> +	ret = clk_set_rate(clk, rate);

This is definitely wrong.  round_rate() is supposed to return the rate
which the clock will give you for the rate you're asking for _without_
setting it.
