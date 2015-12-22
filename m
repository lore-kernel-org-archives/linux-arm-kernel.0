From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 15:13:14 +0000
Subject: How to get better precision out of getrusage on the ARM?
In-Reply-To: <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
References: <CAF_dkJBjs1b+73ggvJyXwab6YL94HGT2jrqbcfaLxoETtQsD9Q@mail.gmail.com>
 <20151222144907.GK8644@n2100.arm.linux.org.uk>
 <CAF_dkJDFXSEgH+kO=k=Yj0_VDnFYgPtkoYznLUWZnq4=QTNDDg@mail.gmail.com>
Message-ID: <20151222151314.GM8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 09:57:57AM -0500, Patrick Doyle wrote:
> On Tue, Dec 22, 2015 at 9:49 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Dec 22, 2015 at 09:30:30AM -0500, Patrick Doyle wrote:
> >> Short version:
> >> My application running on a Cortex-A5 processor (the SAMA5D2 from
> >> Atmel) calls getrusage(RUSAGE_THREAD, ...), which returns cpu time
> >> quantized to the kernel tick frequency (100Hz or 1Khz, depending on
> >> CONFIG_HZ_100 vs CONFIG_HZ_1000).
> >>
> >> How can I get better precision for sched_clock on the (Cortex-A5) ARM?
> >>  The x86 uses the TSC.
> >
> > You need to provide a sched_clock() implementation using
> > sched_clock_register().
> >
> Thank you, I tried that by modifying the (Atmel specific) tcb_clcksrc,
> and got a sched_clock that never incremented.  I have a question out
> at the Atmel forum asking about this, and will continue to investigate
> on my own, but I figured it was about time to ask the experts :-)
> 
> How does the kernel generate its tick clock?  Does it use a
> clocksource (or the clkevt abstraction), or does it rely upon the
> (PIT) timer registered much earlier in the boot process?
> 
> I guess I'm confused about the relationships between clocksources,
> clock events, sched_clock, and the HZ tick interrupt.  Can anybody
> point me at a good place to demystify these things for me?

sched_clock is an entirely separate clock from the rest of time keeping.

However, when a platform doesn't supply a sched_clock, it falls back to
using a HZ-based time source - that being the kernel's jiffy counter.

Otherwise, if a platform supplies a sched_clock, registered through
sched_clock_register(), the counter which is read must increment
monotonically at the rate specified to sched_clock_register().

If you're not seeing sched_clock() increment, that suggests that
the read function supplied to sched_clock_register() is returning a
constant value.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
