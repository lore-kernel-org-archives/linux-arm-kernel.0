From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Feb 2015 19:14:19 +0000
Subject: Delays, clocks, timers, hrtimers, etc
In-Reply-To: <54D509EC.7020708@free.fr>
References: <54C8E125.3070905@free.fr>
 <20150203120925.GM8656@n2100.arm.linux.org.uk>
 <54D509EC.7020708@free.fr>
Message-ID: <20150206191419.GA8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 10:37:32AM -0800, Mason wrote:
> Hmmm, I'm confused (again).
> 
> CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK means "use the global timer
> for the scheduler clock", right? In that case, are the local timers
> unused by Linux?
> 
> #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>   sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
> #endif
> 
> Is there generic code to set up local timers? (If so, where?)
> sched_clock_register only seems to appear in machine-specific code.
> 
> What are the pros/cons of global timer vs local timers?
> Or is such a question irrelevant?
> (Because they are used for different purposes?)

Correct.

The sched_clock itself is about providing the scheduler with a stable,
monotonically increasing 64-bit nanosecond value which it can use to
account for the passing of time (so it can accurately measure how long
a thread is running for, and make a decision when to pre-empt it.)

Local timers are used to set "alarms" to cause an interrupt at a certain
point in time to do something (like, run the scheduler to switch from
the current thread to another thread.)  It can also be used to update
the current time of day as well.

Global timers are used as a fallback when local timers are not available,
and are less efficient - the CPU receiving the global timer interrupt
has to broadcast the interrupt to other CPUs, and it also has to take
account of the earliest event across all CPUs.

There is a fourth "timer" which is used as a monotonically incrementing
counter - this is called the "clocksource".  This is used to maintain
the kernel's time-of-day.  This may be the same as the sched_clock.

> There is trouble in paradise. I was planning to give the global timer a try,
> instead of the platform-specific timer, until I noticed: "The global timer
> is clocked by PERIPHCLK." And it turns PERIPHCLK is connected to the SoC's
> CPU_CLK (the clock that drives the CPU cores); the same clock that is managed
> by cpufreq. I imagine it's double plus ungood for precise time-keeping to
> have frequency changes of the clocksource input?

Yes and no.  You can use that for local timers and/or a global timer, but
you really don't want to use that for the sched_clock nor clocksource as
these are really the fundamentals of time keeping.  I'd advise against
using a timer derived from the CPU clock in general though, but if you
have no other possible timers, then it has to do.

> $ grep -rn ARM_GLOBAL_TIMER | grep -v SCHED_CLOCK
> arch/arm/mach-vexpress/Kconfig:7:	select ARM_GLOBAL_TIMER
> arch/arm/mach-bcm/Kconfig:87:	select ARM_GLOBAL_TIMER
> arch/arm/mach-bcm/Kconfig:108:	select ARM_GLOBAL_TIMER
> arch/arm/mach-rockchip/Kconfig:14:	select ARM_GLOBAL_TIMER
> arch/arm/mach-sti/Kconfig:4:	select ARM_GLOBAL_TIMER
> arch/arm/mach-zynq/Kconfig:6:	select ARM_GLOBAL_TIMER if !CPU_FREQ
> 
> There are indeed a few users; also I wonder why mach-zynq enables
> ARM_GLOBAL_TIMER only if !CPU_FREQ. (Could it be that they have
> the CPU CLOCK driving PERIPHCLK?)

I'm afraid I don't know.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
