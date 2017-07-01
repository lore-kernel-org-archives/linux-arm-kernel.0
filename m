From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Jun 2017 17:55:42 -0700
Subject: [PATCH 1/9] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
In-Reply-To: <20170620090815.GA6805@b29396-OptiPlex-7040>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-2-git-send-email-aisheng.dong@nxp.com>
 <20170620014512.GL4493@codeaurora.org>
 <20170620090815.GA6805@b29396-OptiPlex-7040>
Message-ID: <20170701005542.GT22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20, Dong Aisheng wrote:
> Hi Stephen,
> 
> On Mon, Jun 19, 2017 at 06:45:12PM -0700, Stephen Boyd wrote:
> > On 05/15, Dong Aisheng wrote:
> > > ---
> > >  drivers/clk/clk-divider.c    | 2 ++
> > >  include/linux/clk-provider.h | 4 ++++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > > index 96386ff..f78ba7a 100644
> > > --- a/drivers/clk/clk-divider.c
> > > +++ b/drivers/clk/clk-divider.c
> > > @@ -125,6 +125,8 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
> > >  
> > >  	div = _get_div(table, val, flags, divider->width);
> > >  	if (!div) {
> > > +		if (flags & CLK_DIVIDER_ZERO_GATE)
> > > +			return 0;
> > >  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
> > 
> > Why not use the CLK_DIVIDER_ALLOW_ZERO flag? A clk being off
> > doesn't mean the rate is 0. The divider is just disabled, so we
> > would consider the rate as whatever the parent is, which is what
> > this code does before this patch. Similarly, we don't do anything
> > about gate clocks and return a rate of 0 when they're disabled.
> > 
> 
> The semantic of CLK_DIVIDER_ALLOW_ZERO seems a bit different.
> 
> See below definition:
> * CLK_DIVIDER_ALLOW_ZERO - Allow zero divisors.  For dividers which have
> *      CLK_DIVIDER_ONE_BASED set, it is possible to end up with a zero divisor.
> *      Some hardware implementations gracefully handle this case and allow a
> *      zero divisor by not modifying their input clock
> *      (divide by one / bypass).
> 
> zero divisor is simply as divide by one or bypass which is supported by
> hardware.
> 
> But it's not true for this hardware.
> 
> If we consider the rate as whatever the parent is if divider is zero,
> we may got an issue like below:
> e.g.
> Assuming spll_bus_clk divider is 0x0 and it may be enabled by users directly
> without setting a rate first.
> 
> Then the clock tree looks like:
> ...
> spll_pfd0                    1            1   500210526          0 0  
>   spll_pfd_sel              1            1   500210526          0 0   
>     spll_sel               1            1   500210526          0 0    
>       spll_bus_clk           1            1   500210526          0 0 
> 
> But the spll_bus_clk clock rate actually is wrong and it's even not enabled,
> not like CLK_DIVIDER_ALLOW_ZERO which zero divider means simply bypass.
> 
> So for this case, we probably can't simply assume zero divider rate as its
> parent, it is actually set to 0 in hw, although it's something like gate,
> but a bit different from gate as the normal gate does not affect divider
> where you can keep the rate.
> 
> How would you suggest for this? 
> 

It seems that set_rate() and enable/disable are conflated here.
>From what you describe, it sounds like the clk is considered off
when the divider value is zero, and it's on when the divider
value is non-zero.

I'd suggest you make it so this clk supports enable/disable and
set_rate with the same register. Something like, set rate when
the clk is disabled will cache the rate request and only when the
clk is enabled will the driver actually program the hardware to
have the requested divider value. Similarly, when the clk is
disabled we'll write a 0 there, but when the clk is enabled we'll
restore whatever rate (divider) was chosen last.

It does mean that recalc rate will be sort of odd, because when
the clk is off it will return 0, and when the clk is on it will
return the right rate. So to make things work, we'll need to
return the cached rate in recalc rate when the clk is off and
read the hardware when the clk is on. Probably an if register ==
0 then lookup in cache, otherwise do normal division.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
