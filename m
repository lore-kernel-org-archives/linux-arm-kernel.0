From: mturquette@linaro.org (Michael Turquette)
Date: Sun, 12 Apr 2015 16:50:21 -0700
Subject: Propagating clock rate constraints
In-Reply-To: <20150327004054.2f6f34ee@bbrezillon>
References: <20150327004054.2f6f34ee@bbrezillon>
Message-ID: <20150412235021.19585.27431@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris Brezillon (2015-03-26 16:40:54)
> Hello,
> 
> I recently had a problem with the at91 clk implementation: the
> programmable clock driver is not forwarding set_rate() requests to its
> parent, meaning that, if the PLLB is set to 0, it will choose another
> parent which might be inappropriate to generate the requested clock.
> ITOH, if we authorize forwarding set_rate requests without taking care
> of constraints imposed by other users of the PLLB we might end-up
> with a erroneous rate for the USB clock.
> 
> I thought using set_rate_range() would be a good idea to address this
> issue, but apparently rate constraints are not propagated to parent
> clocks, and PLLB is never exposed to devices (it is accessed through
> clk muxers, divisors, etc).
> 
> Is there a plan to support propagating rate constraints to parent
> clocks ?

Thank for the diff below. Your problem needs to be addressed, though I'm
not sure if propagating rate constraints up the tree is the right way to
do it.

Looking through the code I notice that we don't return an error code
from .determine_rate callbacks in clk_calc_new_rates if the min/max
constraints are out of bounds. We do this for .round_rate since that
function does not take min/max rate as inputs. Furthermore
.determine_returns a long, and we don't check for any kind of error
here. Sigh. See below snippet:

        /* find the closest rate and parent clk/rate */
        if (clk->ops->determine_rate) {
                parent_hw = parent ? parent->hw : NULL;
                new_rate = clk->ops->determine_rate(clk->hw, rate,
                                                    min_rate,
                                                    max_rate,
                                                    &best_parent_rate,
                                                    &parent_hw);
                parent = parent_hw ? parent_hw->core : NULL;
        } else if (clk->ops->round_rate) {
                new_rate = clk->ops->round_rate(clk->hw, rate,
                                                &best_parent_rate);
                if (new_rate < min_rate || new_rate > max_rate)
                        return NULL;


See that for round_rate we bail out if the rate change operation will go
outside of our bounds? Seems we don't do that for determine_rate. Maybe
doing so would at least bail gracefully for you case?

Stephen, Tomeu, any thoughts on this? Completely untested diff below:



diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fa5a00e..482e906 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1638,6 +1638,8 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 						    max_rate,
 						    &best_parent_rate,
 						    &parent_hw);
+		if (new_rate < min_rate || new_rate > max_rate)
+			return NULL;
 		parent = parent_hw ? parent_hw->core : NULL;
 	} else if (clk->ops->round_rate) {
 		new_rate = clk->ops->round_rate(clk->hw, rate,



> 
> Here is an example where propagating rate constraints would be useful:
> 
> The USB controller wants a 48MHz clock and the audio controller needs a
> programmable clock running at 12MHz.
> 
> 1/ The USB driver calls set_rate() on the USB clock, which in turn
>    configures the PLLB to generate a 96MHz signal and sets its divisor
>    to 2.
>    Then it should call set_rate_range(usb_clk, 48Mhz, 48MHz) to prevent
>    anyone from messing up with his USB clock.
> 
> 2/ The audio controller calls set_rate on the prog clock, which in
>    turn configures the PLLB to generate a 12MHz.
>    Since nobody explicitly set a constraint on the PLLB, the set_rate()
>    call should work, right ?
>    If it works, after this call, the USB clk will generate a 6MHz
>    signal instead of 48MHz one. 

I do not think propagating constraints up the tree is the correct way to
solve this this. If you propagate a min,max constraint of (48,48) or
(96,96) up to PLLB it may not be the right thing for all cases.

Additionally, to get the right 12MHz rate that your audio clock wants,
the clock framework will have to become a LOT smarter and end up being
able to solve for lots cases at run-time (and it will be non-trivial
run-time complexity to do this solving).

I don't mean to be hand-wavey, so I'll try to explain a bit more. Today
the clock framework tries to "solve" for complex rate relationships by
propagating rates up the tree. This is somewhat fragile:

1) it only considers the rate for the clock that was passed into
clk_set_rate, as it pre-dates any rate constraint stuff. This is the
same he-who-writes-last-wins problem that most clock framework
implementations have suffered.

2) there is no downwards traversal of the tree to try different
combinations. If child_clk propagates a rate request up to parent_clk,
and parent_clk can't do that rate then we bail. There is no logic where
parent_clk can try to "suggest" a more optimal scenario, or try to
arbitrate an agreeable solution between multiple downstream child clocks
which consume parent_clk's rate. I don't think we should strive for this
level complexity in the kernel, because it is too ... complex.

> 
> 
> I started to look at how rate constraint propagation could be handled:
> here [1] is a quick&dirty/untested patch adding several things to deal
> with such cases.
> The idea is to declare each clock as a clk user of its parent, and then
> modify rate range appropriately so that all children clk constraints are
> taken into account by the parent clock when a rate change is requested.
> 
> Anyway, just tell me if you're already working on a solution for this
> problem or if you need any help with that ?

I appreciate the feedback on the constraint propagation and the diff you
provided. Hopefully Stephen or Tomeu can comment further on it. More
ideas are welcome for the rate constraint stuff in general.

As for your case of needing to support a sane configuration where
multiple clocks consume the same parent clock, I am slowly working on a
clock driver-defined look-up table approach for this which may be
helpful. Think of it as the configuration file that a system integrator
is responsible for generating for each device to insure that the various
use cases can have sane clock configuration. No promises on delivery
dates though :-(

Regards,
Mike

> 
> Best Regards,
> 
> Boris
> 
> [1]http://code.bulix.org/dcm4c8-88137
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
