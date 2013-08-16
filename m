From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 17:29:00 -0600
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <20130815162751.GA2403@localhost>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376404995-24548-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130814152621.GA18868@e106331-lin.cambridge.arm.com>
 <20130815162751.GA2403@localhost>
Message-ID: <520EB5BC.4060102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 10:27 AM, Ezequiel Garcia wrote:
...
> Armada XP
> ---------
> 
> Two clock sources are available for timer and watchdog counters:
> 
> Just as explained for the Armada 370, the timer and watchdog counters decrement
> rate is a configurable ratio of the L2/coherency fabric clock.
> The current clocksource driver implementation chooses an abritrary ratio.
> 
> In addition to this, both timer and watchdog counter rate can be configured
> to use an (internal) 25 MHz fixed clock.

So there are clearly two clocks fed into the HW block here. The DT
should reflect that.

> However, and as explained in this patchset, using the letter fixed clock is in
> practice the only choice. Once CPUFreq support is implemented for the
> Armada XP SoC the L2/coherency fabric clock will change its rate, and handling
> such change will be problematic.

It's not mandatory for an OS to implement cpufreq, so it'd be quite
possible to still use that variable-rate clock on some HW. What SW
may-or-may-not do on HW isn't something that should feed into the DT
binding design.

> Maybe the most accurate representation would be something like this...
> 
> timer {
> 	compatible = "marvell,armada-xp-timer";
> 	reg = ...
> 	interrupts = ...
> 	clocks = ... /* either 25 MHz fixed clock
> 	              * or L2/coherency fabric clock */
> };

I think better would be:

clocks = <&xxx ...> <&yyy ...>;
clock-names = "fabric", "fixed";

In the documentation for this HW block, there's a register that switches
between the two clock sources. What names are used for the clocks in the
documentation of that register? Those names should be used for
clock-names entries.

Is the fact that one of "fabric" and "fixed" is variable and one
fixed-rate more a facet of the integration of the IP block into the SoC,
and not forced by the design of the IP block itself? If so, perhaps
you'd want some additional properties indicating which of those clocks
was fixed and which was variable, which would allow SW to make
intelligent decisions re: which to use. Perhaps it can be assumed this
information can be queried from the source of the clock though?
