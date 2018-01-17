From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 17 Jan 2018 17:39:51 +0100
Subject: [1/5] clk: divider: read-only divider can propagate rate change
In-Reply-To: <999439aa-276a-575d-d6dc-6e9d1bdf5b15@lechnology.com>
References: <20180105170959.17266-2-jbrunet@baylibre.com>
 <999439aa-276a-575d-d6dc-6e9d1bdf5b15@lechnology.com>
Message-ID: <1516207191.2608.122.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-01-11 at 16:55 -0600, David Lechner wrote:
> On 01/05/2018 11:09 AM, Jerome Brunet wrote:
> > When a divider clock has CLK_DIVIDER_READ_ONLY set, it means that the
> > register shall be left un-touched, but it does not mean the clock
> > should stop rate propagation if CLK_SET_RATE_PARENT is set
> > 
> > This is properly handled in qcom clk-regmap-divider but it was not in
> > the generic divider
> > 
> > Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >   drivers/clk/clk-divider.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index b49942b9fe50..a851d3e04c7f 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -348,6 +348,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> >   				unsigned long *prate)
> >   {
> >   	struct clk_divider *divider = to_clk_divider(hw);
> > +	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
> 
> Very minor suggestion: This could be moved inside the if block since it is only used there.

Even if correct, this is something I have seen done in CCF. I tend to just
follow the way to be honest.

Stephen, do you have any preference ?

> 
> >   	int bestdiv;
> >   
> >   	/* if read only, just return current value */
> > @@ -356,6 +357,15 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> >   		bestdiv &= div_mask(divider->width);
> >   		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
> >   			divider->width);
> > +
> > +		/* Even a read-only clock can propagate a rate change */
> > +		if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
> > +			if (!hw_parent)
> > +				return -EINVAL;
> > +
> > +			*prate = clk_hw_round_rate(hw_parent, rate * bestdiv);
> > +		}
> > +
> >   		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
> >   	}
> >   
> > 
> 
> Tested-by: David Lechner <david@lechnology.com>
