From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Feb 2015 12:09:25 +0000
Subject: Delays, clocks, timers, hrtimers, etc
In-Reply-To: <54C8E125.3070905@free.fr>
References: <54C8E125.3070905@free.fr>
Message-ID: <20150203120925.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 02:16:21PM +0100, Mason wrote:
> Q1. the {n,u,m}delay function family
> 
> arch/arm/include/asm/delay.h mentions
> "Delay routines, using a pre-computed "loops_per_second" value."
> *BUT* if the frequency changes dynamically (thanks to cpufreq)
> the "loops_per_second" value cannot be pre-computed, as it would
> change dynamically too, right?

cpufreq changes the loops_per_second value, but an already in-progress
delay doesn't see that (new delays will see the update though.)

> Also, is the update of loops_per_jiffy atomic? Is it possible that
> if one core reads it while another updates it, we get garbage?

32-bit reads and writes are atomic.  You read either the old value or
the new value.  There's no inbetween.

> I suppose this is one reason why the default functions are overridden
> by register_current_timer_delay(&arch_delay_timer) right? I think the
> property of a timer is that its frequency doesn't change, even if the
> CPU's frequency changes? So we are still busy looping, but we are
> checking the actual time spent in the loop, whatever the cpufreq?

Timers are preferred because of the problems with the software delay loop.

Note that it has always been the case that the software delay loop is
"approximate" - even without cpufreq etc, the loops_per_jiffy is slightly
on the small side because of the way the calibration works.  It's about
98% of the actual value, and depends on the workload of the timer
interrupt.  It's obvious when you think about it - it's counting the
number of cycles between two timer interrupts, and the timer interrupt
consumes some of the cycles.

This means that even if you ask for a 10us delay, you'll probably get a
delay of 9.8us instead.

> Q2. Cortex A9 global and private timers
> 
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407f/CIHGECHJ.html
> 
> (What are private timers used for?)

The per-cpu private timers are mostly scheduling of threads.

> In my platform-specific code, there is a config option to choose between
> 
> 1) the ARM global timer
> 2) a platform-specific timer (timer0)

Most platforms implement their own timer, because its really sexy for
hardware engineers to create yet another different timer implementation
which is soo much better than every other timer implementation that has
already been created.  You wouldn't believe how many different ways that
there are to create a timer - and we still have people coming up with
new novel implementations!

> Q3. Using the generic global timer implementation
> 
> So, how do I use that implementation?
> (Is someone other than STMicro using it?)
> 
> I see:
> 
> static void __init global_timer_of_register(struct device_node *np)
> CLOCKSOURCE_OF_DECLARE(arm_gt, "arm,cortex-a9-global-timer", global_timer_of_register);
> 
> OF stands for open firmware, yes?
> So is this related to device tree?

Yes.

> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/arm/global_timer.txt
> 
> This file makes no sense to me.
> 
> - interrupts : One interrupt to each core
> interrupts = <1 13 0xf01>;
> what are 1 13 0xf01 ??

For this see Documentation/devicetree/bindings/arm/gic.txt, the
#interrupt-cells property defines the number of values between the <>,
and it goes on to define what each means.

The interrupts= property depends on your interrupt controller.

> - clocks : Should be phandle to a clock.
> clocks = <&arm_periph_clk>;
> 
> For my (old) 3.14 kernel, I found this:
> 
>     /*
>      * ARM Peripheral clock for timers
>      */
>     arm_periph_clk: arm_periph_clk {
>       #clock-cells = <0>;
>       compatible = "fixed-clock";
>       clock-frequency = <600000000>;
>     };
> 
> But it looks like the definitions have moved around since then?

No idea.  You do need to tell it where the global timer gets its clock
from so that it knows how fast it ticks, and whether there's anything
that needs to be enabled for that clock to be supplied.

> This device tree concept is too much to swallow in a single serving.
> Please tell me if I'm going down the correct rabbit hole, and I'll
> do some LWN readings to try to wrap my mind around the concept.

Yes, DT has made stuff more complicated; unfortunately, that's life now.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
