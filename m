From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 19:24:20 +0100
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <BANLkTin9_=zwLCkqVcAfg-_pGTXk9GaZsg@mail.gmail.com>
References: <4DB0F249.6000307@codeaurora.org>
	<BANLkTinkkMkyy3OnSiOqgUBHiytFPparbQ@mail.gmail.com>
	<20110426203756.GD17290@n2100.arm.linux.org.uk>
	<BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
	<alpine.LFD.2.02.1104271015000.3323@ionos>
	<BANLkTi=WRw9pphieBAnDRhSH_WSdyUdb_A@mail.gmail.com>
	<20110428133826.GM17290@n2100.arm.linux.org.uk>
	<BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
	<20110428142822.GN17290@n2100.arm.linux.org.uk>
	<BANLkTin9_=zwLCkqVcAfg-_pGTXk9GaZsg@mail.gmail.com>
Message-ID: <20110428182420.GF17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 10:59:01PM +0530, Vikram Narayanan wrote:
> On Thu, Apr 28, 2011 at 7:58 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > What basically happens is:
> >
> > ? ? ? ?now = cs->read(cs);
> > ? ? ? ?delta = (now - cs->cycle_last) & cs->mask;
> > ? ? ? ?cs->cycle_last = now;
> >
> > ? ? ? ?ns = clocksource_cyc2ns(delta, cs...);
> >
> > ns now represents the amount of time which passed between this read and
> > the previous read. ?Note the mask in the calculation of delta ensures
> > that overflows are taken care of.
> 
> The timekeeping_get_ns() in kernel/time/timekeeping.c takes care of the above.
> So my job is to provide a good *continuous* clocksource with correct
> mult,shift and mask values.
> And also, the mult and shift values can be calculated from the
> clocks_calc_mult_shift() function.

For clocksources, please, no, don't use clocks_calc_mult_shift().  There
is clocksource_register_hz() and clocksource_register_khz() which will
sort out the shift and multiplier automatically for you.

> The define HZ is important only for one-shot mode. and for a tickless
> kernel this value is not of great importance.

ITYM periodic mode.

> And also if I use the same timer for clocksource and clockevent, it
> will surely gonna mess up my system's time sooner or latter.

Indeed it will.

> > When you're called to switch to one-shot mode, program it for one-shot
> > mode, disable it, and wait for set_next_event(). ?On set_next_event(),
> > you program the timer to produce an interrupt after the specified
> > interval and enable it.
>
> For the clockevent device, If I provide all the data structures,
> next_event and set_mode, then this will work perfectly.
> 
> Hope I have understood your explanations in the right way and all my
> above statements make sense.

I think so.
