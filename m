From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 Aug 2013 14:09:11 +0200
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <520EB5BC.4060102@wwwdotorg.org>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130815162751.GA2403@localhost> <520EB5BC.4060102@wwwdotorg.org>
Message-ID: <1982398.OuHBuuDmYS@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 of August 2013 17:29:00 Stephen Warren wrote:
> On 08/15/2013 10:27 AM, Ezequiel Garcia wrote:
> ...
> 
> > Armada XP
> > ---------
> > 
> > Two clock sources are available for timer and watchdog counters:
> > 
> > Just as explained for the Armada 370, the timer and watchdog counters
> > decrement rate is a configurable ratio of the L2/coherency fabric
> > clock. The current clocksource driver implementation chooses an
> > abritrary ratio.
> > 
> > In addition to this, both timer and watchdog counter rate can be
> > configured to use an (internal) 25 MHz fixed clock.
> 
> So there are clearly two clocks fed into the HW block here. The DT
> should reflect that.

I fully agree. DT should list all the input clocks that are fed into the 
IP block being described.

> > However, and as explained in this patchset, using the letter fixed
> > clock is in practice the only choice. Once CPUFreq support is
> > implemented for the Armada XP SoC the L2/coherency fabric clock will
> > change its rate, and handling such change will be problematic.
> 
> It's not mandatory for an OS to implement cpufreq, so it'd be quite
> possible to still use that variable-rate clock on some HW. What SW
> may-or-may-not do on HW isn't something that should feed into the DT
> binding design.
> 
> > Maybe the most accurate representation would be something like this...
> > 
> > timer {
> > 
> > 	compatible = "marvell,armada-xp-timer";
> > 	reg = ...
> > 	interrupts = ...
> > 	clocks = ... /* either 25 MHz fixed clock
> > 	
> > 	              * or L2/coherency fabric clock */
> > 
> > };
> 
> I think better would be:
> 
> clocks = <&xxx ...> <&yyy ...>;
> clock-names = "fabric", "fixed";
> 
> In the documentation for this HW block, there's a register that switches
> between the two clock sources. What names are used for the clocks in
> the documentation of that register? Those names should be used for
> clock-names entries.
> 
> Is the fact that one of "fabric" and "fixed" is variable and one
> fixed-rate more a facet of the integration of the IP block into the SoC,
> and not forced by the design of the IP block itself? If so, perhaps
> you'd want some additional properties indicating which of those clocks
> was fixed and which was variable, which would allow SW to make
> intelligent decisions re: which to use. Perhaps it can be assumed this
> information can be queried from the source of the clock though?

Well, I believe this kind of information can be hardcoded in the driver 
itself, which can simply know which input clock to use on given platform, 
in the same way it currently knows what divisor to use.

Sure it isn't the ideal solution, but you can't know which of the clocks 
is going to be reconfigured by other drivers, as this might depend on the 
built-in set of drivers, particular OS (as you said, not all OSes might be 
implementing cpufreq, even the same OS, but with different configs might 
differ in this aspect).

Best regards,
Tomasz
