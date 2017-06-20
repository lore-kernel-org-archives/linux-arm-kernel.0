From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 20 Jun 2017 17:08:15 +0800
Subject: [PATCH 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
In-Reply-To: <20170620014512.GL4493@codeaurora.org>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-2-git-send-email-aisheng.dong@nxp.com>
 <20170620014512.GL4493@codeaurora.org>
Message-ID: <20170620090815.GA6805@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jun 19, 2017 at 06:45:12PM -0700, Stephen Boyd wrote:
> On 05/15, Dong Aisheng wrote:
> > ---
> >  drivers/clk/clk-divider.c    | 2 ++
> >  include/linux/clk-provider.h | 4 ++++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 96386ff..f78ba7a 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -125,6 +125,8 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
> >  
> >  	div = _get_div(table, val, flags, divider->width);
> >  	if (!div) {
> > +		if (flags & CLK_DIVIDER_ZERO_GATE)
> > +			return 0;
> >  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
> 
> Why not use the CLK_DIVIDER_ALLOW_ZERO flag? A clk being off
> doesn't mean the rate is 0. The divider is just disabled, so we
> would consider the rate as whatever the parent is, which is what
> this code does before this patch. Similarly, we don't do anything
> about gate clocks and return a rate of 0 when they're disabled.
> 

The semantic of CLK_DIVIDER_ALLOW_ZERO seems a bit different.

See below definition:
* CLK_DIVIDER_ALLOW_ZERO - Allow zero divisors.  For dividers which have
*      CLK_DIVIDER_ONE_BASED set, it is possible to end up with a zero divisor.
*      Some hardware implementations gracefully handle this case and allow a
*      zero divisor by not modifying their input clock
*      (divide by one / bypass).

zero divisor is simply as divide by one or bypass which is supported by
hardware.

But it's not true for this hardware.

If we consider the rate as whatever the parent is if divider is zero,
we may got an issue like below:
e.g.
Assuming spll_bus_clk divider is 0x0 and it may be enabled by users directly
without setting a rate first.

Then the clock tree looks like:
...
spll_pfd0                    1            1   500210526          0 0  
  spll_pfd_sel              1            1   500210526          0 0   
    spll_sel               1            1   500210526          0 0    
      spll_bus_clk           1            1   500210526          0 0 

But the spll_bus_clk clock rate actually is wrong and it's even not enabled,
not like CLK_DIVIDER_ALLOW_ZERO which zero divider means simply bypass.

So for this case, we probably can't simply assume zero divider rate as its
parent, it is actually set to 0 in hw, although it's something like gate,
but a bit different from gate as the normal gate does not affect divider
where you can keep the rate.

How would you suggest for this? 

Regards
Dong Aisheng

> >  			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
> >  			clk_hw_get_name(hw));
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
