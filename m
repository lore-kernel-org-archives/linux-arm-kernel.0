From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 22 Dec 2015 09:30:30 -0500
Subject: How to get better precision out of getrusage on the ARM?
Message-ID: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Short version:
My application running on a Cortex-A5 processor (the SAMA5D2 from
Atmel) calls getrusage(RUSAGE_THREAD, ...), which returns cpu time
quantized to the kernel tick frequency (100Hz or 1Khz, depending on
CONFIG_HZ_100 vs CONFIG_HZ_1000).

How can I get better precision for sched_clock on the (Cortex-A5) ARM?
 The x86 uses the TSC.

tl;dr version:

I see that RUSAGE_THREAD percolates through to use the clock for
CLOCK_THREAD_CPUTIME_ID, which percolates through to calling
task_sched_runtime(), which returns p->se.sum_exec_runtime, which is
(ultimately updated by the value returned by sched_clock_cpu().

Ok, so what is sched_clock()?

According to Documentation/timers/timekeeping.txt:

"In addition to the clock sources and clock events there is a special weak
function in the kernel called sched_clock(). This function shall return the
number of nanoseconds since the system was started. An architecture may or
may not provide an implementation of sched_clock() on its own. If a local
implementation is not provided, the system jiffy counter will be used as
sched_clock()."

OK, so it seems to me that the ARM architecture does not define a
custom sched_clock(), instead it relies upon the default
sched_clock(), which uses the clock source with the highest update
rate.  (Please correct me if I'm wrong -- I'm trying to educate myself
in a very short period of time here).

A system can have various clock sources.  A clock source may or may
not register itself with a call to sched_clock_register(). My Atmel
SAMA5D2 processor has 2 clock soruces: timer-atmel-pit.c and
tcb_clksrc.c, neither of which calls sched_clock_register(), so the
default jiffy_sched_clock_read() function is registered, leading to my
100 Hz/1kHz timing granularity.

I'm looking for some advice on where to go from here.  I could modify
timer-atmel-pit.c or tcb_clksrc.c to call sched_clock_register() with
the appropriate free running clock counter (tcb_clksrc looks like a
better candidate for that, maybe, I think).  But I feel like this
should be a solved problem and I shouldn't have to do this.  (I don't
mind doing this, I just hate reinventing wheels in the world of open
software).

I found a patch submitted in 2011
(http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/049549.html)
that proposes to provide a clocksource based sched_clock(), but I
don't see any evidence of that in my 4.1 kernel.  Why wasn't that
patch accepted?

While I'm at it, would somebody mind pointing me in the direction of
documentation of the rationale behind the whole clocksource
abstraction to begin with?  How does the kernel choose between
multiple clock sources (yes, I know the 'rating' field), but what does
it ultimately use its clocksource for if not for sched_clock()?  Or,
why doesn't sched_clock() use the selected clocksource?

Thanks.

--wpd
