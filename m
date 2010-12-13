From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Dec 2010 16:01:20 +0100
Subject: [RFC] i.MX clock support
In-Reply-To: <20101213102538.GB6017@pengutronix.de>
References: <20101213102538.GB6017@pengutronix.de>
Message-ID: <20101213150120.GE26210@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Dec 13, 2010 at 11:25:38AM +0100, Sascha Hauer wrote:
> I am not willing to accept patches for adding i.MX50 support in the mess
> we currently have. These patches offer a way to cleanup the clock support
> and the i.MX50 may be a good test bed for an implementation without
> old cruft to worry about. That said the following patch is not set in
> stone, it's a request for comments and I'm of course open to other
> suggestions, but it's clear that we have to do something.
Full ack.

> +#define to_clk_divider(clk) (container_of(clk, struct clk_divider, clk))
> +
> +static unsigned long clk_divider_get_rate(struct clk *clk)
> +{
> +	struct clk_divider *divider = to_clk_divider(clk);
> +
> +	unsigned long rate = clk_get_rate(divider->parent);
> +	unsigned int div = 1;
> +
> +	if (divider->reg) {
> +		div = readl(divider->reg) >> divider->shift;
> +		div &= (1 << divider->width) - 1;
> +		div++;
> +	}
> +
> +	return rate / div / divider->div * divider->mult;
Maybe you need to spend more effort to exactness e.g. by using
DIV_ROUND_CLOSEST and/or reordering?
(You didn't describe div and mult in struct clk_divider (below), so this
is a bit guess work for me here.)

> +}
> +
> +static long clk_divider_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(clk);
> +	unsigned long parent_rate = clk_get_rate(divider->parent);
> +	unsigned int max_div, div;
> +
> +	if (rate > parent_rate)
> +		return parent_rate;
> +
> +	max_div = 1 << divider->width;
> +
> +	div = parent_rate / rate;
> +	div = max(div, max_div);
> +
> +	return parent_rate / div / divider->div * divider->mult;
ditto

> +}
> +
> +static int clk_divider_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(clk);
> +	unsigned long parent_rate = clk_get_rate(divider->parent);
> +	unsigned int max_div, div;
> +	u32 val;
> +
> +	parent_rate /= divider->div;
> +	parent_rate *= divider->mult;
> +
> +	if (rate > parent_rate)
> +		rate = parent_rate;
> +
> +	max_div = 1 << divider->width;
> +
> +	div = parent_rate / rate;
> +
> +	div = max(div, max_div);
> +	div--;
> +
> +	val = readl(divider->reg);
> +	val &= ~(((1 << divider->width) - 1) << divider->shift);
> +	val |= div << divider->shift;
> +	writel(val, divider->reg);
> +
> +	return 0;
You could spend more efforts here, but I think this is OK for now.

> [...]
> +struct clk_ops clk_multiplexer_ops = {
> +	.enable = clk_parent_enable,
> +	.disable = clk_parent_disable,
> +	.get_rate = clk_parent_get_rate,
> +	.round_rate = clk_parent_round_rate,
> +	.set_rate = clk_parent_set_rate,
Oh, this might have surprising effects if the parent is "public".
Is this intended?

> +	.get_parent = clk_multiplexer_get_parent,
> +	.set_parent = clk_multiplexer_set_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_multiplexer_ops);
> +
> +#define to_clk_group(clk) (container_of(clk, struct clk_group, clk))
> +
> +static int clk_group_enable(struct clk *clk)
> +{
> +	struct clk_group *group = to_clk_group(clk);
> +	int i, ret;
> +
> +	for (i = 0; i < group->num_clks; i++) {
> +		ret = clk_enable(group->clks[i]);
> +			if (ret)
> +				goto out;
indention error

I really like your efforts here and think this goes into the right
direction.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
