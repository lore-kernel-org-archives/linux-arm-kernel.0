From: wpdster@gmail.com (Patrick Doyle)
Date: Wed, 30 Dec 2015 10:52:14 -0500
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <CAF_dkJBM3qbs3GB8jdgonus7dgVSyn-7QtogtqmMQWzR2BK+OQ@mail.gmail.com>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
 <20151222144907.GK8644@n2100.arm.linux.org.uk>
 <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
 <20151222151314.GM8644@n2100.arm.linux.org.uk>
 <CAF_dkJAUyD3GRAETZUQG2yJTmOR95XKVguohBpBjUaM9JMaQyg@mail.gmail.com>
 <CAF_dkJBrfd=YUnG=ja2KE_z2DM8NQTLGiWVyvW6mrPYP4i+sFA@mail.gmail.com>
 <CAF_dkJBM3qbs3GB8jdgonus7dgVSyn-7QtogtqmMQWzR2BK+OQ@mail.gmail.com>
Message-ID: <CAF_dkJBOf87J__X9Gdpb_b0P9NzS44w-bhRaUi+z0EKXLkg_5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 10:00 AM, Patrick Doyle <wpdster@gmail.com> wrote:
> Continuing on...
> I now have a CLOCKSOURCE_OF_DECLARED()'ed 10 MHz clock source running
> on my ARM processor (Atmel SAMA5D2 Xplained board).  It registers
> itself through sched_clock_register() to provide a high resolution
> sched clock.  Once I turned on "Full dynticks CPU time accounting"
> (CONFIG_VIRT_CPU_ACCOUNTING_GEN), I was able to get better than jiffy
> resolution from my calls to getrusage(RUSAGE_THREAD,..).  But things
> still aren't quite right.  I am using getrusage() to provide some
> runtime profile information to an existing application (that was
> ported to run on Linux instead of a custom RTOS).  I have code that
> looks like:
>
> tick()
> // commented out code that used to do something
> tock()
>
> where tick() & tock() are my profile "start" and "stop" points that
> call getrusage() to record and and accumulate time spent between calls
> to tick() & tock().  Most of the time, I get a delta of 0 between the
> two calls, which I expect.  But occasionally, I get a delta ranging
> between 800us and 1000us, which I don't understand at all.  It seems
> like my thread is being "charged" for time spent doing something else.
> Perhaps an interrupt occurred and its time got charged to my thread;
> perhaps a higher priority thread ran for 1ms, I don't know (yet).
>
> Does anybody have any suggestions as to where I might look, or as to
> what kernel CONFIG options might make the most sense for an
> application such as this?
>
> --wpd

A couple of more (confusing) data points...
- Changing the tick rate to 100Hz results in deltas as extreme as 9400us.
- Using clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) instead of
getrusage(RUSAGE_THREAD,...) gives much more believable numbers in the
15-25us range, but still with a few bizarre excursions to 41, 69, and
172us (for one random test case).

--wpd
