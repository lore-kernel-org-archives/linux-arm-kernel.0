From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Mar 2015 00:40:54 +0100
Subject: Propagating clock rate constraints
Message-ID: <20150327004054.2f6f34ee@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I recently had a problem with the at91 clk implementation: the
programmable clock driver is not forwarding set_rate() requests to its
parent, meaning that, if the PLLB is set to 0, it will choose another
parent which might be inappropriate to generate the requested clock.
ITOH, if we authorize forwarding set_rate requests without taking care
of constraints imposed by other users of the PLLB we might end-up
with a erroneous rate for the USB clock.

I thought using set_rate_range() would be a good idea to address this
issue, but apparently rate constraints are not propagated to parent
clocks, and PLLB is never exposed to devices (it is accessed through
clk muxers, divisors, etc).

Is there a plan to support propagating rate constraints to parent
clocks ?

Here is an example where propagating rate constraints would be useful:

The USB controller wants a 48MHz clock and the audio controller needs a
programmable clock running at 12MHz.

1/ The USB driver calls set_rate() on the USB clock, which in turn
   configures the PLLB to generate a 96MHz signal and sets its divisor
   to 2.
   Then it should call set_rate_range(usb_clk, 48Mhz, 48MHz) to prevent
   anyone from messing up with his USB clock.

2/ The audio controller calls set_rate on the prog clock, which in
   turn configures the PLLB to generate a 12MHz.
   Since nobody explicitly set a constraint on the PLLB, the set_rate()
   call should work, right ?
   If it works, after this call, the USB clk will generate a 6MHz
   signal instead of 48MHz one. 


I started to look at how rate constraint propagation could be handled:
here [1] is a quick&dirty/untested patch adding several things to deal
with such cases.
The idea is to declare each clock as a clk user of its parent, and then
modify rate range appropriately so that all children clk constraints are
taken into account by the parent clock when a rate change is requested.

Anyway, just tell me if you're already working on a solution for this
problem or if you need any help with that ?

Best Regards,

Boris

[1]http://code.bulix.org/dcm4c8-88137

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
