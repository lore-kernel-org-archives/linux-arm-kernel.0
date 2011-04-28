From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 16:22:17 +0100
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110418094909.GE31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
Message-ID: <20110428152217.GT17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 11:49:09AM +0200, Uwe Kleine-K?nig wrote:
> > +static int clk_divider_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	unsigned long best_parent_rate;
> > +	struct clk_divider *divider = to_clk_divider(clk);
> > +	unsigned int div;
> > +	int ret;
> > +	unsigned long flags = 0;
> > +	u32 val;
> > +
> > +	div = clk_divider_bestdiv(clk, rate, &best_parent_rate);
> > +
> > +	if (rate != best_parent_rate / div)
> > +		return -EINVAL;
> This is too harsh, isn't it. Or can you expect to only get values that
> are returned by round_rate? Again you need DIV_ROUND_UP.

It is too harsh, and I've wished many a time that people would implement
clk_set_rate() and clk_round_rate() as:

long clk_round_rate(struct clk *clk, unsigned long rate)
{
	err = calculate_clock_paramters(clk, params, rate);
	if (err < 0)
		return err;
	return calculate_clock_rate(clk, params);
}

int clk_set_rate(struct clk *clk, unsigned long rate)
{
	err = calculate_clock_parameters(clk, params, rate);
	if (err < 0)
		return err;
	set_clock_parameters(clk, params);
	clk->rate = calculate_clock_rate(clk, params);
	return 0;
}

IOW, clk_round_rate() does what clk_set_rate() does but does _not_ set
the hardware rate itself.
