From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 May 2014 21:52:23 +0100
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <20140508192209.GH3693@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1405081600260.980@knanqh.ubzr>
Message-ID: <20140508205223.GI3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:12:14PM -0400, Nicolas Pitre wrote:
> On Thu, 8 May 2014, Russell King - ARM Linux wrote:
> 
> > Anything which is expecting precise timings from udelay() is broken.
> > Firstly, udelay() does _not_ guarantee to give you a delay of at least
> > the requested period - it tries to give an _approximate_ delay.
> > 
> > The first thing to realise is that loops_per_jiffy is calibrated with
> > interrupts _on_, which means that the calculated loops_per_jiffy is
> > the number of iterations in a jiffy _minus_ the time it takes for the
> > timer interrupt to be processed.  This means loops_per_jiffy will
> > always be smaller than the number of loops that would be executed
> > within the same period.
> > 
> > This leads to udelay() always producing slightly shorter than
> > requested delays - this is quite measurable.
> 
> OK, this is certainly bad.  Hopefully it won't be that far off like it 
> would when the CPU is in the middle of a clock freq transition.

It depends on the system, but my point is that assumption that udelay()
gives a delay of at least the requested time is something that is false,
and has *always* been false.

It's not "broken" either - it's just how the thing works, and the "fix"
for it is to use a timer based implementation which isn't affected by
interrupts.

> > So, the only /real/ solution if you want proper delays is for udelay()
> > to use a timer or counter, and this is should always the preferred
> > method where it's available.  Quite rightly, we're not hacking udelay()
> > stuff to work around not having that, or if someone configures it out.
> 
> What about using a default based on ktime_get(), or even sched_clock(), 
> when SMP and cpufreq are configured in?

I see no reason to play those kinds of games.  Keep the message simple.
If you're in a preempt or SMP environment, provide a timer for udelay().
IF you're in an environment with IRQs which can take a long time, use
a timer for udelay().  If you're in an environment where the CPU clock
can change unexpectedly, use a timer for udelay().

The very last thing we want to do is to sit around doing expensive calls
into various time keeping code which themselves add conversion on top,
which then end up making udelay() latency even worse than the loop-based
versions on slower machines.

So... the message is nice and simple: where possible, use a timer for
udelay().

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
