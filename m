From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 15 May 2014 07:10:50 -0700
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <20140515073816.GI16662@pengutronix.de>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
 <20140515073816.GI16662@pengutronix.de>
Message-ID: <ad94b743-b3f7-4fb7-b26f-03127ca38d2b@BY2FFO11FD049.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, 2014-05-15 at 09:38AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> it's great you pick that up.
> 
> On Wed, May 14, 2014 at 03:30:52PM -0700, Soren Brinkmann wrote:
> > Introduce a new API function to round a rate to the closest possible
> > rate the HW clock can generate.
> > In contrast to 'clk_round_rate()' which works similar, but always returns
> > a frequency <= its input rate.
> > 
> > The code comes from Uwe and was copied from this LKML thread:
> > https://lkml.org/lkml/2013/3/21/115
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > 
> >  drivers/clk/clk.c   | 26 ++++++++++++++++++++++++--
> >  include/linux/clk.h | 14 ++++++++++++--
> >  2 files changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index dff0373f53c1..b715f5a9826c 100644
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
> > @@ -1027,6 +1028,27 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
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
> > +{
> > +	long lower_limit = clk_round_rate(clk, rate);
> > +	long upper_limit = clk_round_rate(clk, rate + (rate - lower_limit));
> > +
> > +	if (rate - lower_limit < upper_limit - rate)
> > +		return lower_limit;
> > +	else
> > +		return upper_limit;
> I wanted to suggest to add some comment to describe why the calculation
> works here. While trying to proove it, I noticed that this
> implementation is buggy.
> Consider a clock that can provide the following frequencies: 38000,
> 38401, 38600.
> 
> 	clk_round_rate_nearest(clk, 38400)
> 	  lower_limit = clk_round_rate(clk, 38400) -> 38000
> 	  upper_limit = clk_round_rate(clk, 38800) -> 38600
> 
> 	  return 38600
> 
> but 38401 would have been the better/correct answer. I think you cannot
> implement clk_round_rate_nearest without iteration if you don't want to
> add specific logic to the clock providers.

You're right. Apparently we haven't had such a case. Anyway, this needs
to be implemented differently.

	Thanks,
	S?ren
