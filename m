From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 15:28:22 +0100
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
References: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
	<4DB0F249.6000307@codeaurora.org>
	<BANLkTinkkMkyy3OnSiOqgUBHiytFPparbQ@mail.gmail.com>
	<20110426203756.GD17290@n2100.arm.linux.org.uk>
	<BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
	<alpine.LFD.2.02.1104271015000.3323@ionos>
	<BANLkTi=WRw9pphieBAnDRhSH_WSdyUdb_A@mail.gmail.com>
	<20110428133826.GM17290@n2100.arm.linux.org.uk>
	<BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
Message-ID: <20110428142822.GN17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 07:24:41PM +0530, Vikram Narayanan wrote:
> On Thu, Apr 28, 2011 at 7:08 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Apr 28, 2011 at 07:01:53PM +0530, Vikram Narayanan wrote:
> >> I am still confused about the terms clocksource and clockevents. Can
> >> someone please explain it in simple terms or lead me to a good
> >> documentation that elaborates clearly about this?
> >
> > A clocksource is a monotonically incrementing counter which measures the
> > passing of time.
>
> So, this is the timer that keeps the wall time always up as long as
> the system is running. If the system isn't running, a backup RTC
> should take care of the time. When the system is back, again
> clocksource will be having the control.
> Even if the above timer count overflows, that should be taken care of.

What basically happens is:

	now = cs->read(cs);
	delta = (now - cs->cycle_last) & cs->mask;
	cs->cycle_last = now;

	ns = clocksource_cyc2ns(delta, cs...);

ns now represents the amount of time which passed between this read and
the previous read.  Note the mask in the calculation of delta ensures
that overflows are taken care of.

> > This counter should never be reset.
>
> So this timer should always be on, no matter what happens to the system.

What I mean is that at no point should the clocksource counter be re-
initialized while the system is running and it is in use, otherwise
the 'delta' value will spike and 'ns' will become very large.  You'll
then find the kernels idea of time spontaneously jumps forward when
it shouldn't.

> > A clockevent device is some sort of timer which it used to trigger either
> > a periodic interrupt or a one-shot interrupt to cause CPUs to do some
> > maintainence task (such as reading the clock source, comparing that with
> > the previous reading, and using the delta to update the kernels idea of
> > current time.)
>
> This is used for setting up the next event by using the set_next_event
> callback and set the mode(one shot or periodic) by set_mode callback.
> So, this timer is the heart of tickless kernel functionality(NO_HZ).

Correct.  The mode is changed when required - when switching to periodic
mode, you're expected to program the hardware for that mode and set it
up to produce interrupts at a frequency of HZ.

When you're called to switch to one-shot mode, program it for one-shot
mode, disable it, and wait for set_next_event().  On set_next_event(),
you program the timer to produce an interrupt after the specified
interval and enable it.
