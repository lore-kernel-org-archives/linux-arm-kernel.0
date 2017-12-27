From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Dec 2017 17:06:38 -0800
Subject: [PATCH 1/2] clk: rename clk_core_get_boundaries() to
 clk_hw_get_boundaries() and expose
In-Reply-To: <8EC4D15B-4A89-43FA-953E-95AF81417067@gmail.com>
References: <1513872282-5370-1-git-send-email-al.kochet@gmail.com>
 <1513872282-5370-2-git-send-email-al.kochet@gmail.com>
 <20171221200743.GM7997@codeaurora.org>
 <8EC4D15B-4A89-43FA-953E-95AF81417067@gmail.com>
Message-ID: <20171227010638.GP7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/25, Alexander Kochetkov wrote:
> 
> > 21 ???. 2017 ?., ? 23:07, Stephen Boyd <sboyd@codeaurora.org> ???????(?):
> > 
> > Can you convert to the determine_rate op instead of round_rate?
> > That function should tell you the min/max limits so that you
> > don't need to query that information from the core.
> 
> I converted rockchip_fractional_approximation() to rockchip_determine_rate() (see the patch attached).
> If it increase parent?s clock for out of limits value, than clock request will fail with -EINVAL, like
> with round_rate() approach.
> 
> The problem is that min/max limits provided to determine_rate() is for clock for which the determine_rate()
> was called. While rockchip_determine_rate() (rockchip_fractional_approximation()) requires information
> about parent clock limits.

Are these limits the min/max limits that the parent clk can
output at? Or the min/max limits that software has constrained on
the clk?

> 
> How can I know parents clock limits for current clock? Implement determine_rate() for each parent clocks
> the same way I did for this one clock?

If the parent can change rate, then the idea is that the child
will calculate the limits that it can handle based on what it can
do with the incoming min/max constraints, and then call
__clk_determine_rate() on its parent with a request structure
that has limits for whatever the child clk is able to handle. The
parent can then determine a rate it can output that's within that
range and tell the child clk if it will satisfy the constraints
or not along with the resulting rate it will output when the
__clk_determine_rate() function returns. I would expect the
constraints to get closer together the higher in the tree we go.

I haven't looked in detail at this
rockchip_fractional_approximation() code, but it shouldn't be
doing the work of both the child rate determination and the
parent rate determination in one place. It should work with the
parent to figure out the rate the parent can provide and then
figure out how to achieve the desired rate from there.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
