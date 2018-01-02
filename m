From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jan 2018 15:28:11 -0800
Subject: [PATCH 01/33] clk_ops: change round_rate() to return unsigned long
In-Reply-To: <c2212d56-a8b5-cba5-46a7-c2c7f66e752b@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
 <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
 <20180102190159.GH7997@codeaurora.org>
 <c2212d56-a8b5-cba5-46a7-c2c7f66e752b@nexus-software.ie>
Message-ID: <20180102232811.GN7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02, Bryan O'Donoghue wrote:
> On 02/01/18 19:01, Stephen Boyd wrote:
> >On 12/31, Bryan O'Donoghue wrote:
> >>On 30/12/17 16:36, Mikko Perttunen wrote:
> >>>FWIW, we had this problem some years ago with the Tegra CPU clock
> >>>- then it was determined that a simpler solution was to have the
> >>>determine_rate callback support unsigned long rates - so clock
> >>>drivers that need to return rates higher than 2^31 can instead
> >>>implement the determine_rate callback. That is what's currently
> >>>implemented.
> >>>
> >>>Mikko
> >>
> >>Granted we could work around it but, having both zero and less than
> >>zero indicate error means you can't support larger than LONG_MAX
> >>which is I think worth fixing.
> >>
> >
> >Ok. But can you implement the determine_rate op instead of the
> >round_rate op for your clk?
> 
> Don't know .

Please try.

> 
> >It's not a work-around, it's the
> >preferred solution. That would allow rates larger than 2^31 for
> >the clk without pushing through a change to all the drivers to
> >express zero as "error" and non-zero as the rounded rate.
> >
> >I'm not entirely opposed to this approach, because we probably
> >don't care to pass the particular error value from a clk provider
> >to a clk consumer about what the error is.
> 
> Which was my thought. The return value of clk_ops->round_rate()
> appears not to get pushed up the stack, which is what the last patch
> in this series deals with.
> 
> [PATCH 33/33] clk: change handling of round_rate() such that only
> zero is an error

Hmm? clk_core_determine_round_nolock() returns 'rate' if rate < 0
from the round_rate op. clk_core_round_rate_nolock() returns that
value to clk_round_rate() which returns it to the consumer.

> 
> >It's actually what we
> >proposed as the solution for clk_round_rate() to return values
> >larger than LONG_MAX to consumers. But doing that consumer API
> >change or this provider side change is going to require us to
> >evaluate all the consumers of these clks to make sure they don't
> >check for some error value that's less than zero. This series
> >does half the work,
> 
> Do you mean users of clk_rounda_rate() ? I have a set of patches for
> that but wanted to separate that from clk_ops->round_rate() so as
> not to send ~70 patches out to LKML at once - even if they are in
> two blocks.

Ok. What have you done to the consumers of clk_round_rate()?
Made them treat 0 as an error instead of less than zero? The
documentation in clk.h needs to be updated. See this patch from
Paul Wamsley[1] for one proposed patch that went nowhere. Also
include Russell King please. It was also proposed to change the
function signature of clk_round_rate() to return unsigned long,
but that didn't go anywhere either.

> 
> If so, I can publish that set too for reference.
> 
> AFAICT on clk_ops->round_rate the last patch #33 ought to cover the
> usage of the return value of clk_ops->round_rate().
> 
> Have I missed something ?

Hopefully not!

> 
> >by changing the provider side, while ignoring
> >the consumer side and any potential fallout of the less than zero
> >to zero return value change.
> >
> 
> Can you look at #33 ? I'm not sure if you saw that one.
> 

Yeah I looked at it. From what I can tell it makes
clk_round_rate() return 0 now instead of whatever negative value
the clk_ops::round_rate function returns.

[1] https://lkml.kernel.org/r/alpine.DEB.2.02.1311251603310.23090 at tamien

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
