From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Feb 2011 12:34:40 -0800
Subject: [PATCH 12/21] ARM: tegra: clock: Add shared bus clock type
In-Reply-To: <1297590033-15035-13-git-send-email-ccross@android.com>
References: <1297590033-15035-1-git-send-email-ccross@android.com>
	<1297590033-15035-13-git-send-email-ccross@android.com>
Message-ID: <4D5C34E0.5000209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2011 01:40 AM, Colin Cross wrote:
> +/* shared bus ops */
> +/*
> + * Some clocks may have multiple downstream users that need to request a
> + * higher clock rate.  Shared bus clocks provide a unique shared_bus_user
> + * clock to each user.  The frequency of the bus is set to the highest
> + * enabled shared_bus_user clock, with a minimum value set by the
> + * shared bus.
> + */
> +static void tegra_clk_shared_bus_update(struct clk *bus)
> +{
> +	struct clk *c;
> +	unsigned long rate = bus->min_rate;
> +
> +	list_for_each_entry(c, &bus->shared_bus_list, u.shared_bus_user.node)
> +		if (c->u.shared_bus_user.enabled)
> +			rate = max(c->u.shared_bus_user.rate, rate);
> +
> +	if (rate != clk_get_rate(bus))
> +		clk_set_rate(bus, rate);

What do you do if clk_set_rate() fails? Should you unwind all the state
such as the rate and if it's enabled/disabled? Or is it safe to say
clk_set_rate() can't fail unless the kernel is buggy in which case why
aren't all those return -E* in the set rate functions just BUG_ONs?

> +};
> +
> +static void tegra_clk_shared_bus_init(struct clk *c)
> +{
> +	c->max_rate = c->parent->max_rate;
> +	c->u.shared_bus_user.rate = c->parent->max_rate;
> +	c->state = OFF;
> +#ifdef CONFIG_DEBUG_FS
> +	c->set = 1;
> +#endif
> +
> +	list_add_tail(&c->u.shared_bus_user.node,
> +		&c->parent->shared_bus_list);
> +}
> +
> +static int tegra_clk_shared_bus_set_rate(struct clk *c, unsigned long rate)
> +{
> +	c->u.shared_bus_user.rate = rate;
> +	tegra_clk_shared_bus_update(c->parent);
> +	return 0;
> +}
> +
> +static long tegra_clk_shared_bus_round_rate(struct clk *c, unsigned long rate)
> +{
> +	return clk_round_rate(c->parent, rate);
> +}
> +
> +static int tegra_clk_shared_bus_enable(struct clk *c)
> +{
> +	c->u.shared_bus_user.enabled = true;
> +	tegra_clk_shared_bus_update(c->parent);
> +	return 0;
> +}

Shouldn't you call clk_enable(c->parent)? And do you need to check for
errors from clk_enable()?

> +
> +static void tegra_clk_shared_bus_disable(struct clk *c)
> +{
> +	c->u.shared_bus_user.enabled = false;
> +	tegra_clk_shared_bus_update(c->parent);
> +}

And a similar clk_disable(c->parent) here.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
