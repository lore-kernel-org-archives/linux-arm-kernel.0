From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Apr 2011 09:32:50 +0200
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <4DACF761.3050503@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
	<4DACF761.3050503@codeaurora.org>
Message-ID: <20110419073249.GK31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Apr 18, 2011 at 07:45:53PM -0700, Saravana Kannan wrote:
> On 04/18/2011 03:07 AM, Sascha Hauer wrote:
> >On Mon, Apr 18, 2011 at 11:49:09AM +0200, Uwe Kleine-K?nig wrote:
> >>On Fri, Apr 15, 2011 at 09:08:10PM +0200, Sascha Hauer wrote:
> >AFAIK there are two different implementation types in the tree. Some
> >implementations only allow to set to the exact rate round_rate returns
> >while others round down in set_rate.
> >
> >Has this been specified what behaviour is expected?
> >
> 
> This is something I have nagged Russell once or twice about and then
> sent out an email to the list for which there was very limited
> response. I think clk_round_rate() is too generic and not very
> useful.
> 
> We should really have something like:
> clk_set_rate_range(min, ideal, max)
(Note this is orthogonal to the question if set_rate may barf on values
other than the return values of round_rate.)

clk_set_rate_range can even be implemented with clk_round_rate that is
just required to fulfill:

	clk_round_rate(clk, X) > 0 =>
	clk_set_rate(clk, clk_round_rate(clk, X)) == clk_round_rate(clk, X)
		and
	clk_round_rate(clk, clk_round_rate(clk, X)) == clk_round_rate(clk, X)

and

	X >= Y =>
	clk_round_rate(clk, X) >= clk_round_rate(clk, Y)

which every implementation should assert provided that X and Y are the
domain of clk_round_rate(clk, .)

Something like:

	long clk_round_rate_range(struct clk *clk, unsigned long minrate,
		unsigned long optrate, unsigned long maxrate)
	{
		unsigned long bot = minrate, best, cur, top = maxrate;
		unsigned long delta;
		long tmp;

		if (minrate > optrate || optrate > maxrate)
			return -EINVAL;

		if (maxrate > LONG_MAX)
			/* can anything be done here? */
			return -EINVAL;

		best = cur = clk_round_rate(clk, optrate);
		if (cur == optrate)
			return optrate;

		delta = optrate > best ? optrate - best : best - optrate;

		while (1) {
			if (cur > optrate) {
				if (delta > cur - optrate)
					best = cur;
				top = cur;
				cur = (bot + cur) / 2;
			} else if (cur < optrate) {
				if (delta > optrate - cur)
					best = cur;
				bot = cur;
				cur = (cur + top + 1) / 2;
			} else {
				WARN(1, "Your clk_round_rate implementation is broken (clk = %pS, [%lu, %lu, %lu]\n.",
					clk, minrate, optrate, maxrate);
				return -EINVAL;
			}

			tmp = clk_round_rate(clk, cur);
			if (tmp < 0)
				return tmp;
			cur = tmp;

			if (bot == top)
				break;
		}

		if (best < minrate || best > maxrate)
			return -EINVAL;

		return best;
	}

	int clk_set_rate_range(struct clk *clk, unsigned long minrate,
		unsigned long optrate, unsigned long maxrate)
	{
		long rate = clk_round_rate_range(clk, minrate,
				optrate, maxrate);

		if (rate < 0)
			return rate;

		clk_set_rate(clk, rate);
	}

Completely untestet so probably broken.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
