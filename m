From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 19 May 2014 09:41:32 -0700
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <20140519161949.GG16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
 <91822600-39d0-4e71-b0f5-9eda35b76ec0@BN1AFFO11FD016.protection.gbl>
 <20140519161949.GG16662@pengutronix.de>
Message-ID: <db8633e5-01a9-4d3a-80e8-74e23a456d52@BN1BFFO11FD051.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-05-19 at 06:19PM +0200, Uwe Kleine-K?nig wrote:
> Hi S?ren,
> 
> On Sun, May 18, 2014 at 05:51:05PM -0700, S?ren Brinkmann wrote:
> > ------------------8<-----------------8<---------------------8<-------------8<---
> > From: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Date: Tue, 2 Apr 2013 10:08:13 -0700
> > Subject: [PATCH] clk: Introduce 'clk_round_rate_nearest()'
> > 
> > Introduce a new API function to round a rate to the closest possible
> > rate the HW clock can generate.
> > In contrast to 'clk_round_rate()' which works similar, but always returns
> > a frequency <= its input rate.
> > 
> > Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  drivers/clk/clk.c   | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/clk.h | 14 ++++++++++++--
> >  2 files changed, 53 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index dff0373f53c1..faf24d0569df 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1011,8 +1011,9 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
> >   * @rate: the rate which is to be rounded
> >   *
> >   * Takes in a rate as input and rounds it to a rate that the clk can actually
> > - * use which is then returned.  If clk doesn't support round_rate operation
> > - * then the parent rate is returned.
> > + * use and does not exceed the requested frequency, which is then returned.
> > + * If clk doesn't support round_rate operation then the parent rate
> > + * is returned.
> >   */
> >  long clk_round_rate(struct clk *clk, unsigned long rate)
> >  {
> > @@ -1027,6 +1028,44 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
> >  EXPORT_SYMBOL_GPL(clk_round_rate);
> >  
> >  /**
> > + * clk_round_rate_nearest - round the given rate for a clk
> > + * @clk: the clk for which we are rounding a rate
> > + * @rate: the rate which is to be rounded
> > + *
> > + * Takes in a rate as input and rounds it to the closest rate that the clk
> > + * can actually use which is then returned. If clk doesn't support
> > + * round_rate operation then the parent rate is returned.
> > + */
> > +long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
> Why does this function doesn't return an unsigned long when it never
> returns a negative value? Ditto for clk_round_rate?

I matched the definition of clk_round_rate(). But you're probably right,
it may be the right thing to change clk_round_rate to return an
unsigned, but with that being exposed API it would be a risky change.

> 
> > +{
> > +	unsigned long lower, upper, cur, lower_last, upper_last;
> > +
> > +	lower = clk_round_rate(clk, rate);
> > +	if (lower >= rate)
> > +		return lower;
> Is the >-case worth a warning?

No, it's correct behavior. If you request a rate that is way lower than what the
clock can generate, returning something larger is perfectly valid, IMHO.
Which reveals one problem in this whole discussion. The API does not
require clk_round_rate() to round down. It is actually an implementation
choice that had been made for clk-divider.

> 
> > +
> > +	upper = clk_round_rate(clk, rate + rate - lower);
> This was parenthesized in my original patch on purpose. If rate is big
> 
> 	rate + rate - lower
> 
> might overflow when
> 
> 	rate + (rate - lower)
> 
> doesn't. Thinking again, there is no real problem, because this is
> unsigned arithmetic. To be save we still need to check if rate + (rate -
> lower) overflows.

Good point. I'll add the parentheses.

> 
> > +	if (upper == lower)
> if (upper <= rate) is the better check here. (= would be a bug.)

I don't understand. Passing rate + x to round rate can never return
something below 'lower'. Only something in the range [lower,lower+x].
So, if upper == lower we found our closest frequency and return it.
Otherwise we have to iterate over [lower+1,upper]. Or what did I miss?

> 
> > +		return upper;
> > +
> > +	lower = rate + 1;
> ok, so your loop invariant is that the best freq is in [lower; upper].

right.

> 
> > +	do {
> > +		upper_last = upper;
> > +		lower_last = lower;
> > +
> > +		cur = clk_round_rate(clk, lower + ((upper - lower) >> 1));
> > +		if (cur < lower)
> > +			lower += (upper - lower) >> 1;
> You already know that lower + ((upper - lower) >> 1) is too small, so
> you can better do
> 
> 	lower += ((upper - lower) >> 1) + 1;

right. I'll add the '+1'

> 
> > +		else
> > +			upper = cur;
> > +
> > +	} while (lower_last != lower && upper_last != upper);
> > +
> > +	return upper;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_round_rate_nearest);
> I think the function still has potential for optimisation, what about:

At first glance, I don't see many differences except for the comments
you made above. I'll have a closer look though.

> 
> unsigned long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
> {
> 	unsigned long lower, upper, rounded;
> 
> 	rounded = clk_round_rate(clk, rate);
> 
> 	if (rounded >= rate)
> 		return rounded;
> 
> 	/*
> 	 * rounded is the best approximation for rate that is not
> 	 * bigger than rate. If there is a better one, it must be in the
> 	 * interval (rate; rate + (rate - rounded)).
> 	 * Note that the upper limit isn't better than rate itself, so
> 	 * that one doesn't need to be considered.
> 	 */
> 	 
> 	upper = rate + (rate - rounded) - 1;
> 	if (upper < rate)
> 		upper = ULONG_MAX; 

Aren't we done here? Your search for an upper boundary resulted in
'lower'. Hence there is no valid frequency closer to 'rate' than 'lower'. Why do
you extend to ULONG_MAX?

	Thanks,
	S?ren
