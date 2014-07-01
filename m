From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 1 Jul 2014 10:52:09 -0700
Subject: [PATCH 1/4] clk: Introduce 'clk_find_nearest_rate()'
In-Reply-To: <20140701082302.GL14781@pengutronix.de>
References: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
 <1404147396-8041-2-git-send-email-soren.brinkmann@xilinx.com>
 <20140701082302.GL14781@pengutronix.de>
Message-ID: <1cc8398e-bbbb-47f9-9f02-30f4d1237ab4@BY2FFO11FD003.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, 2014-07-01 at 10:23AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Jun 30, 2014 at 09:56:33AM -0700, Soren Brinkmann wrote:
> > Introduce a new API function to find the rate a clock can provide which
> > is closest to a given rate.
> > 
> > clk_round_rate() leaves it to the clock driver how rounding is done.
> > Commonly implementations round down due to use-cases that have a certain
> > frequency maximum that must not be exceeded.
> > 
> > The new API call enables use-cases where accuracy is preferred. E.g.
> > Ethernet clocks.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > 
> >  drivers/clk/clk.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h |  9 +++++++++
> >  2 files changed, 66 insertions(+)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 8b73edef151d..fce1165cd879 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1030,6 +1030,63 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
> >  EXPORT_SYMBOL_GPL(clk_round_rate);
> >  
> >  /**
> > + * clk_find_nearest_rate - round the given rate for a clk
> > + * @clk: the clk for which we are rounding a rate
> > + * @rate: the rate which is to be rounded
> > + *
> > + * Takes in a rate as input and finds the closest rate that the clk
> > + * can actually use which is then returned.
> > + * Note: This function relies on the clock's clk_round_rate() implementation.
> > + * For cases clk_round_rate() rounds up, not the closest but the rounded up
> > + * rate is found.
> > + */
> > +long clk_find_nearest_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	long ret, lower, upper;
> > +	unsigned long tmp;
> > +
> > +	clk_prepare_lock();
> > +
> > +	lower = __clk_round_rate(clk, rate);
> > +	if (lower >= rate || lower < 0) {
> > +		ret = lower;
> > +		goto unlock;
> > +	}
> > +
> > +	tmp = rate + (rate - lower) - 1;
> > +	if (tmp > LONG_MAX)
> > +		upper = LONG_MAX;
> > +	else
> > +		upper = tmp;
> Consider rate = 0xf0000000, lower = 0x7fffffff (= LONG_MAX). Then tmp =
> (unsigned long)0x160000000 = 0x60000000. In this case you pick upper =
> 0x60000000 while you should use upper = LONG_MAX.
Strictly speaking yes, but isn't 0xf000000 already an invalid argument?
I kept it as unsigned long to match the round_rate prototype, but as we
discussed before, rates should probably all be long only since the
return type of these functions is signed. Unless I miss something,
requesting a rate > LONG_MAX while we can return a long only should not
be possible. Hence, I was assuming to work with rates in the range up to
LONG_MAX only for now.
But adding a something like 'if (rate > LONG_MAX) return -EINVAL;' would
probably be a good idea in this case.

> 
> I think you need
> 
> -	if (tmp > LONG_MAX)
> +	if (tmp > LONG_MAX || tmp < rate)
I was looking for how to correctly check for arithmetic overflows (since
you pointed out the flaws with my solution using casts), and this check
relies on undefined behavior as well, IIUC.

> 
> (and a comment)
> 
> > +
> > +	upper = __clk_round_rate(clk, upper);
> > +	if (upper <= lower || upper < 0) {
> Is it an idea to do something like:
> 
> 		if (IS_ENABLED(CONFIG_CLK_SANITY_CHECKS))
> 			WARN_ON(upper < lower && upper >= 0);
> 
> here?
Probably a good idea. I assumed that we can - more or less - safely
count on that behavior once we are through those checks above.

> 
> > +		ret = lower;
> > +		goto unlock;
> > +	}
> > +
> > +	lower = rate + 1;
> > +	while (lower < upper) {
> > +		long rounded, mid;
> > +
> > +		mid = lower + ((upper - lower) >> 1);
> > +		rounded = __clk_round_rate(clk, mid);
> > +		if (rounded < lower)
> > +			lower = mid + 1;
> > +		else
> > +			upper = rounded;
> > +	}
> This is broken if you don't assume that __clk_round_rate rounds down.
> Consider an implementation that already does round_nearest and clk can
> assume the values 0x60000 and 0x85000 (and nothing in between), and rate
> = 0x70000. This results in
> 
> 	lower = 0x60000;
> 	tmp = 0x7ffff;
> 	upper = __clk_round_rate(clk, 0x7ffff) = 0x85000
> 
> before the loop and the loop then doesn't even terminate.
Good catch. With rounding being unspecified, there are a lot of
corner cases.
I think this change would fix that corner case, but I'm not sure it
covers all:
 
        tmp = rate + (rate - lower) - 1;
        if (tmp > LONG_MAX)
-               upper = LONG_MAX;
-       else
-               upper = tmp;
+               tmp = LONG_MAX;
 
-       upper = __clk_round_rate(clk, upper);
-       if (upper <= lower || upper < 0) {
+       upper = __clk_round_rate(clk, tmp);
+       if (upper <= lower || upper < 0 || upper > tmp) {
                ret = lower;
                goto unlock;
        }

	Thanks,
	S?ren
