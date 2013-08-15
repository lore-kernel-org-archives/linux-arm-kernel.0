From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 15 Aug 2013 13:27:52 -0300
Subject: [PATCH v4 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <20130814152621.GA18868@e106331-lin.cambridge.arm.com>
References: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1376404995-24548-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130814152621.GA18868@e106331-lin.cambridge.arm.com>
Message-ID: <20130815162751.GA2403@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks a lot for reviewing this.

On Wed, Aug 14, 2013 at 04:26:21PM +0100, Mark Rutland wrote:
> 
> On Tue, Aug 13, 2013 at 03:43:14PM +0100, Ezequiel Garcia wrote:
> > This commit fixes the DT binding for the Armada 370/XP SoC timer.
> > The previous "marvell,armada-370-xp-timer" compatible is removed and
> > two new compatible strings are introduced: "marvell,armada-xp-timer"
> > and "marvell,armada-370-timer".
> > 
> > The rationale behind this change is that the Armada 370 SoC and the
> > Armada XP SoC timers are not really compatible:
> > 
> >   * Armada 370 has no 25 MHz fixed timer.
> > 
> >   * Armada XP cannot work properly without such 25 MHz fixed timer
> >     as doing otherwise leads to using a clocksource whose frequency
> >     varies when doing cpufreq frequency changes.
> > 
> > This commit also removes the "marvell,timer-25Mhz" property, given
> > it's now meaningless.
> 
> Given we have a mechanism already for handling this, I'm not sure. The
> new binding certainly looks nicer (and if there's no-one using it, then
> migrating makes sense), but I still have concerns about it. From the
> description of the problem, and a look at the driver, the timer hardware
> actually has (at least) two clock inputs:
> 
> (a) Wired to a fixed 25MHz clock on the XP, but not described.
>     Not wired to anything on the 370?
> 
> (b) Wired to the CPU clock on the XP?
>     Wired to some external clock on the 370.
> 

Mmm.. I don't think the above describes the situation.

> If that's the case, this should be described, even if we can't use that
> information right now. (a) can be a 25MHz fixed-clock on the XP, and
> just not described on the 370. We can use clock-names to handle the
> optional presence of any input clock.
> 
> Having separate compatible strings may still make sense, but I'd prefer
> to understand the hardware better first. Not having full visibility over
> a piece of hardware at review stage is precisely why we get into a mess
> trying to change bindings later.
> 

I agree completely, let me try to describe the hardware better then.

First of all let's consider Armada 370 and Armada XP as not compatible,
they are different hardwares from my point of view.

Armada 370
----------

A single clock source is available for timer and watchdog counters:

Timer and watchdog counters decrement rate is a configurable ratio
of the L2/coherency fabric clock. The current clocksource driver
implementation chooses an abritrary ratio.

So, for this hardware the DT binding proposed in this patch is, IMO, accurate:

timer {
	compatible = "marvell,armada-370-timer";
	reg = ...
	interrupts = ...
	clocks = <&coreclk 2>; /*  L2/coherency fabric clock  */
};

Armada XP
---------

Two clock sources are available for timer and watchdog counters:

Just as explained for the Armada 370, the timer and watchdog counters decrement
rate is a configurable ratio of the L2/coherency fabric clock.
The current clocksource driver implementation chooses an abritrary ratio.

In addition to this, both timer and watchdog counter rate can be configured
to use an (internal) 25 MHz fixed clock.

However, and as explained in this patchset, using the letter fixed clock is in
practice the only choice. Once CPUFreq support is implemented for the
Armada XP SoC the L2/coherency fabric clock will change its rate, and handling
such change will be problematic.

For this reason, the DT binding proposed is:

timer {
	compatible = "marvell,armada-xp-timer";
	reg = ...
	interrupts = ...
};

Maybe the most accurate representation would be something like this...

timer {
	compatible = "marvell,armada-xp-timer";
	reg = ...
	interrupts = ...
	clocks = ... /* either 25 MHz fixed clock
	              * or L2/coherency fabric clock */
};

... adding a clock property to represent the actual clock source,
but I think such property can be added later on top of the current
patchset.

In other words, from my point of view, the current proposal is fine,
and represents the hardware in the best way possible.

Of course, I'm open to discussion. What do you think?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
