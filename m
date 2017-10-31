From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 31 Oct 2017 17:15:34 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
Message-ID: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello BDFL,

I am writing to you directly because Russell has bluntly stated (paraphrased)
"Send your patches to Linus; it's his kernel, and he has the final say." which
is his diplomatic way of telling me to fsck off.

Basically, I want to improve the accuracy of clock-based delays, in order to
improve the boot-time delay in the NAND framework. I will send a patch, but
I wanted to have a discussion about the design first.

The key points under discussion below are

a) guarantee of no under-delays
b) availability of ndelay for arm32


Below is the long-winded rationale.

1) Delays and sleeps (clocks, timers, alarms, etc)

Every operating system kernel (that I know of) offers some way for a kernel thread to
wait for a specified amount of time (expressed in seconds, milliseconds, microseconds,
or even nanoseconds).

For relatively small amounts of time, such a primitive is typically implemented as
a busy-wait spin-loop. Let us call it delay().

Such a primitive cannot guarantee that the calling thread will be delayed *exactly*
the amount of time specified, because there are many sources of inaccuracy:

* the timer's period may not divide the requested amount
* sampling the timer value may have variable latency
* the thread might be preempted for whatever reason
* the timer itself may have varying frequencies
* etc

Therefore, users are accustomed to having delays be longer (within a reasonable margin).
However, very few users would expect delays to be *shorter* than requested.

As you have stated yourself, the vast majority of code in Linux is driver code.

Typical driver writers (of which I am one) are not experts on Linux internals, and may
sometimes need some guidance, either from another programmer or a maintainer (whose time
is a rare resource), or from clear APIs (either well-documented, or just "natural" and
"obvious" interfaces).

A typical driver writer has some HW spec in front of them, which e.g. states:

* poke register A
* wait 1 microsecond for the dust to settle
* poke register B

which most programmers would translate to:

	poke(reg_A, val_A);
	udelay(1);
	poke(reg_B, val_B);


Given a similar example, Russell has stated:

> And if a data sheet says "needs a delay of 2us" and you put in the
> driver udelay(2) then you're doing it wrong, and you need to read
> Linus' mails on this subject, such as the one I've provided a link
> to... that udelay() must be _at least_ udelay(3), if not 4.

I see two key points in this reply.

i) There seems to be an implicit agreement that it is BAD for the *actual*
delay to be less than what the data sheet specifies, leading to...

ii) It is the responsibility of the *driver writer* to figure out how much
of a cushion they need, in order to guarantee a minimal delay.


Obviously, I agree with the first point.

The second point is troubling. It means driver writers are required to be
aware of the quirkiness of Linux internals.

And because drivers are supposed to work on all platforms, are we saying
that driver writers should be aware of the quirkiness for ALL platforms?

For example, assume that for short delays, such as 1 ?s:

* amd64 has  5% relative error, 10 ns absolute error
* arm32 has 10% relative error,  1 ?s absolute error
* alpha has  3% relative error,  3 ?s absolute error

The driver writer would need to write udelay(4); ?

In my opinion, it makes more sense to hide the complexity and quirkiness
of udelay inside each platform's implementation. Which brings me to...



2) Different implementations of udelay and ndelay

On arm32, it is possible to set up udelay() to be clock-based.
In that case, udelay simply polls a constant-frequency tick-counter.
For example, on my puny little platform, there is a 27 MHz crystal oscillator
(37 ns period) which is wired to a tick counter mapped on the system bus.
The latency to sample the register is within [10-200] ns.

This implies two things:

i) it is possible to guarantee a minimum delay (in quanta of 37 ns)

ii) the sampling error is limited to ~250 ns


[NB: some platforms are even "better", and move the tick counter inside the
CPU block (e.g. ARM architected timer) to achieve a lower sampling error.]


There is one minor trap when handling tick counter sampling:
Assume we are waiting for one period to elapse. Consider the timeline below,
where x marks the cycle when the tick counter register is incremented.


-------x----------x----------x----------x----------x----->  time
                 ^ ^           ^
                 A B           C

If the execution flow leads to sampling at times A and B, then B-A equals 1,
yet only a tiny amount of time has elapsed. To guarantee that at least one
period has elapsed, we must wait until the arithmetic difference is 2
(i.e. one more than required). In the example, until time C.

In other words, if we need to delay for N cycles, the correct code should be:

	t0 = readl(tick_address);
	while (readl(tick_address) - t0 <= N)
		/* spin */ ;



There is another source of "error" (in the sense that udelay might spin too little)
caused by the conversion from ?s to cycles -- which rounds down.

Consider arch/arm/include/asm/delay.h

loops = (loops_per_jiffy * delay_us * UDELAY_MULT) >> 31
where UDELAY_MULT = 2147 * HZ + 483648 * HZ / 1000000


Consider a platform with a 27 MHz clock, and HZ=300
The proper conversion is trivially

	loops = delay_us * 27

Thus, for a 1 microsecond delay, loops equals 27.

But when using UDELAY_MULT = 644245 (rounded down from 644245,0944)
loops equals 26.

This "off-by-one" error is systematic over the entire range of allowed
delay_us input (1 to 2000), so it is easy to fix, by adding 1 to the result.



3) Why does all this even matter?

At boot, the NAND framework scans the NAND chips for bad blocks;
this operation generates approximately 10^5 calls to ndelay(100);
which cause a 100 ms delay, because ndelay is implemented as a
call to the nearest udelay (rounded up).

My current NAND chips are tiny (2 x 512 MB) but with larger chips,
the number of calls to ndelay would climb to 10^6 and the delay
increase to 1 second, with is starting to be a problem.

One solution is to implement ndelay, but ndelay is more prone to
under-delays, and thus a prerequisite is fixing under-delays.


Regards.
