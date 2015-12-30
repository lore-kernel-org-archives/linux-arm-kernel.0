From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 30 Dec 2015 10:00:46 -0500
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <CAF_dkJBrfd=YUnG=ja2KE_z2DM8NQTLGiWVyvW6mrPYP4i+sFA@mail.gmail.com>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
 <20151222144907.GK8644@n2100.arm.linux.org.uk>
 <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
 <20151222151314.GM8644@n2100.arm.linux.org.uk>
 <CAF_dkJAUyD3GRAETZUQG2yJTmOR95XKVguohBpBjUaM9JMaQyg@mail.gmail.com>
 <CAF_dkJBrfd=YUnG=ja2KE_z2DM8NQTLGiWVyvW6mrPYP4i+sFA@mail.gmail.com>
Message-ID: <CAF_dkJBM3qbs3GB8jdgonus7dgVSyn-7QtogtqmMQWzR2BK+OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Continuing on...
I now have a CLOCKSOURCE_OF_DECLARED()'ed 10 MHz clock source running
on my ARM processor (Atmel SAMA5D2 Xplained board).  It registers
itself through sched_clock_register() to provide a high resolution
sched clock.  Once I turned on "Full dynticks CPU time accounting"
(CONFIG_VIRT_CPU_ACCOUNTING_GEN), I was able to get better than jiffy
resolution from my calls to getrusage(RUSAGE_THREAD,..).  But things
still aren't quite right.  I am using getrusage() to provide some
runtime profile information to an existing application (that was
ported to run on Linux instead of a custom RTOS).  I have code that
looks like:

tick()
// commented out code that used to do something
tock()

where tick() & tock() are my profile "start" and "stop" points that
call getrusage() to record and and accumulate time spent between calls
to tick() & tock().  Most of the time, I get a delta of 0 between the
two calls, which I expect.  But occasionally, I get a delta ranging
between 800us and 1000us, which I don't understand at all.  It seems
like my thread is being "charged" for time spent doing something else.
Perhaps an interrupt occurred and its time got charged to my thread;
perhaps a higher priority thread ran for 1ms, I don't know (yet).

Does anybody have any suggestions as to where I might look, or as to
what kernel CONFIG options might make the most sense for an
application such as this?

--wpd
