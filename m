From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 5 Oct 2015 11:09:29 -0700
Subject: [PATCH v3 1/5] clk: Add a basic multiplier clock
In-Reply-To: <20151005101932.GH2696@lukather>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151002204308.GY12338@codeaurora.org>
 <20151005101932.GH2696@lukather>
Message-ID: <20151005180929.GB12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Oct 02, 2015 at 01:43:08PM -0700, Stephen Boyd wrote:
> > On 09/29, Maxime Ripard wrote:
> > > +
> > > +	if (!val && mult->flags & CLK_MULTIPLIER_ZERO_BYPASS)
> > > +		val = 1;
> > > +	
> > > +	return parent_rate * val;
> > > +}
> > > +
> > > +static bool __is_best_rate(unsigned long rate, unsigned long new,
> > > +			   unsigned long best, unsigned long flags)
> > > +{
> > > +	if (flags & CLK_MULTIPLIER_ROUND_CLOSEST)
> > 
> > Is the only difference in this function vs the divider one that
> > flag? Maybe we should make this function generic to the framework
> > and pass a flag indicating closest or not.
> 
> Actually, the logic is also reversed.
> 
> The divider driver will always try to find some rate that is higher
> than the one we already have, without going above than the one
> requested.
> 
> Here, we're tring to be lower than the best rate, without going below
> the requested rate.

So then a tri-state flag that indicates, closest, less than,
greater than?

> 
> > 
> > > +	unsigned long val;
> > > +
> > > +	if (mult->lock)
> > > +		spin_lock_irqsave(mult->lock, flags);
> > 
> > This needs the same "trick" that we did in the generic clock
> > types to avoid sparse warnings.
> 
> The __acquire call ?

Yes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
