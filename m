From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 21:52:22 +0000
Subject: Status of the following patch (clocksource sched_clock) ?
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B724963A@DFLE34.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
 <20111219172557.GH14542@n2100.arm.linux.org.uk>
 <3E54258959B69E4282D79E01AB1F32B724934E@DFLE34.ent.ti.com>
 <20111219210438.GJ14542@n2100.arm.linux.org.uk>
 <3E54258959B69E4282D79E01AB1F32B724963A@DFLE34.ent.ti.com>
Message-ID: <20111219215222.GN14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:39:16PM +0000, Karicheri, Muralidharan wrote:
> I am relatively new to this. Here is more explanation of the issue.
> 
> We have clocksource timer implemented using a 32bit hw timer which at
> 166.84MHz of the clock rate wraps around at approximately 25secs. Our
> platform uses the arch/arm/mach-davinci/time.c at
> http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=blob;f=arch/arm/mach-davinci/time.c;h=e1969ce904dc5b4de9ff8f0d44442175c7c2497f;hb=1ea6b8f48918282bdca0b32a34095504ee65bab5
> 
> In this file, sched_clock() is implemented to override the weak
> sched_clock() as 
> 
> unsigned long long notrace sched_clock(void) { 
>       const cycle_t cyc = clocksource_davinci.read(&clocksource_davinci); 
>       return clocksource_cyc2ns(cyc, clocksource_davinci.mult,
>                                 clocksource_davinci.shift);
> } 

Ah.  That implementation (and any other similar implementation) of
sched_clock() is indeed buggy, and _will_ lead to sched_clock wraps.

That's not because the clocksource wraps - the time keeping subsystem
internally deals with clocksource wrapping.  However, the calculation
method used above is such that the returned nanoseconds _will_ always
wrap each time the clocksource cycle counter itself wraps.

I implemented replacement sched_clock() across the ARM architecture,
replacing at the time every single ARM sched_clock() implementation in
the tree with it.  This implements necessary infrastructure to allow
for a _fast_ sched_clock() function, yet solving completely the wrap
problem.

> Based on your previous response, I did some research and found
> arch/arm/kernel/sched_clock.c that seems to solve clocksource
> wraparound. So I have enabled HAVE_SCHED_CLOCK to pick this
> implementation in my build. Also I have modified
> arch/arm/mach-davinci/time.c to call init_sched_clock(), but I got
> a kernel crash when Linux booted up (given below). Looks like this
> has to happen early in the initialization (postcoreinit() ??) so
> that sched_init() can use this. In the above time.c, the timer gets
> initialized late in the boot up stage. Is my understanding correct?

The kernel expects sched_clock() to be available really early in the
system boot - platforms should do their best to ensure that sched_clock
is indeed up and running.

This generally means before clocksource initialisation - and means
typically at init_early time.  However, while I converted some platforms,
I wasn't prepared to reorganize their code to achieve this, so I just
made the reading of the timer register conditional on the clocksource
having been enabled.

It would be preferable for new implementations to get this right -
ensure that sched_clock() is operable at the init_early machine
callback.
