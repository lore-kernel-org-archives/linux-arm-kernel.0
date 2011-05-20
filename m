From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 13:59:36 +0200
Subject: [PATCH 1/4] clk: Add a generic clock infrastructure
In-Reply-To: <1305876469.326305.518470530485.1.gpush@pororo>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.326305.518470530485.1.gpush@pororo>
Message-ID: <20110520115936.GA10931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

Nice to see progress in this area :)

On Fri, May 20, 2011 at 03:27:49PM +0800, Jeremy Kerr wrote:
> +
> +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
> +		const char *name)
> +{
> +	struct clk *clk;
> +
> +	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> +	if (!clk)
> +		return NULL;
> +
> +	clk->name = name;
> +	clk->ops = ops;
> +	clk->hw = hw;
> +	hw->clk = clk;

is it worth to add a CLK_REGISTERED flag here? Up to now clocks do not
have to be registered at all and the registering might be forgotten for
some clocks. I suppose funny things can happen when we operate on
unregistered clocks.

> +
> +	/* Query the hardware for parent and initial rate */
> +
> +	if (clk->ops->get_parent)
> +		/* We don't to lock against prepare/enable here, as
> +		 * the clock is not yet accessible from anywhere */
> +		clk->parent = clk->ops->get_parent(clk->hw);
> +
> +	if (clk->ops->recalc_rate)
> +		clk->rate = clk->ops->recalc_rate(clk->hw);

This implicitely requires that we never register a clock before its
parent is registered. This makes perfect sense but I think we should
catch it here when the user tries to register a clock with a not yet
registered parent.

> +
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(clk_register);

BTW we planned to let the linker do the job of registering static
clocks, but this is only convenience and can be added later.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
