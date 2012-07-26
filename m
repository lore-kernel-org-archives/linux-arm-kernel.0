From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 26 Jul 2012 09:20:24 +0200
Subject: Clocksource/clockevent with non self-reloading timer blocks?
In-Reply-To: <1772014.SXB9lS46ng@bender>
References: <1772014.SXB9lS46ng@bender>
Message-ID: <5010EFB8.4000409@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2012 09:14 PM, Florian Fainelli wrote:

> Hi all,
> 
> The SoC I work on (Moschip MCS8140) has several timer blocks, but none of them 
> are self-reloading timers, yet I can enable/disable the free-running timer, 
> and enable/disable the interrupt generation.
> 
> Are there any existing in kernel clocksource/clockevent drivers with the same 
> constraints?
> 
> Thank you very much for your answer.


Hi,

I see nobody answered. A timer which does not reload itself is called a
"one-shot" timer. So, any clockevent_device structure definition with:
CLOCK_EVT_FEAT_ONESHOT
present in its feature field is an example of timer programmed in
one-shot mode. For instance, have a look at:
arch/arm/common/timer-sp.c

For this case, you have to implement the two following callbacks of the
clockevent_device structure:
- void (*set_mode)(enum clock_event_mode mode, struct clock_event_device
*dev)
  Should prepare the timer if the "mode" parameter is
"CLOCK_EVT_MODE_ONESHOT" and stop it for other values.

- int (*set_next_event)(unsigned long evt, struct clock_event_device *dev)
  Should program the timer to tick in "evt" ticks, return 0 if it was
successful or a negative value if it fails (namely, if the delay was to
short).

>From a performance point of view, it is important for "set_next_event"
to be as short as possible: one job of the timer interupt is, most of
the time, to program the next tick, so set_next_event gets called during
the timer interrupt. So, for instance if you need to write to some
register to "start" or "enable" the timer once before you can program it
as many times as you want, do this in the set_mode callback, not in
set_next_event, writing to hardware registers may not be as fast as you
think.

That is for the clockevent.

For the clocksource, the simplest solution is to use another hardware
timer in free-running mode and use the appropriate clocksource_mmio
function, if the hardware timer is able to wrap automatically. If the
timers you have are only able to be programmed to run for some time then
stop, then I guess it is best to do with clocksource what you have done
with "gettimeoffset" in the patches you sent.


-- 
                                                                Gilles.
