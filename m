From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Sep 2016 12:20:29 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <1473935756.10230.42.camel@nexus-software.ie>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
 <1473935756.10230.42.camel@nexus-software.ie>
Message-ID: <20160915112029.GC6718@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

More questions below. Perhaps some of these will be implicitly answered
when the linearised patches appear, and I'm happy to wait until then to
continue the discussion, as I suspect otherwise we're all likely to end
up exasperated.

Please do Cc me on those.

Regardless, until those appear and a reasonable time has been given for
replies, my comments regarding the lack of review stand, as does my NAK
for the series.

On Thu, Sep 15, 2016 at 11:35:56AM +0100, Bryan O'Donoghue wrote:
> On Thu, 2016-09-15 at 11:13 +0100, Mark Rutland wrote:
> > On Thu, Sep 15, 2016 at 10:35:33AM +0100, Bryan O'Donoghue wrote:
> > >?
> > I don't think the history matters, 
> 
> Your comment seemed to indicate you thought we were reading a
> architectural timer directly - which we aren't.

Sure, and as I pointed out, the comment in the HEAD commit still claims
it does, even if the code doesn't. This is at best, confusing, and the
history of how it came to be there doesn't really matter...

> > and I don't think that one can rely
> > on get_cycles() in this manner outside of arch code.
> 
> I don't follow your meaning. What's wrong with get_cycles() ? You've
> already said you don't think reading an architectural timer directly is
> correct.

I pointed out a number of issues in my previous reply.

For example, you have absolutely no guarantee as to what backs
get_cycles(). Despite this, the code assumes that get_cycles() is backed
by something running at the frequency described in a
"google,greybus-frame-time-counter" node.

Even if this *happens* to match what some piece of arch code provides
today on some platform, it is in no way *guaranteed*.

> The objective is to read one of the free-running counters in MSM8994,
> clocked by the PMIC. The refclk provided by PMIC is distributed to each
> processor in the system.
> 
> >  Looking at the
> > state of the tree [1] as of the final commit [2] in the greybus
> > branch,
> > my points still stand:
> > 
> > * The "google,greybus-frame-time-counter" node is superfluous. It
> > does
> > ? not describe a particular device,
> 
> It describes a timer running @ 19.2MHz, clocked by PMIC refclk.

... which you assume is whatever backs get_cycles(), which you in
practice assume is the architected timer. For which we *already* have a
binding and driver.

Given that, as far as I can tell, "google,greybus-frame-time-counter"
describes a software construct that uses this, not an actual piece of
hardware.

> >  and duplicates information we have ? elsewhere.
> 
> Can you give an example ?

Trivially, the CNTFRQ register in the architected timer (which is common
across MMIO/sysreg), which you can query with arch_timer_get_rate().

Note that isn't guaranteed to match get_cycles() either. You need a
better API to call.

> > * The clock-frequency property isn't necessary. The architected timer
> > ? drivers know the frequency of the architected timers (MMIO or
> > sysreg),
> > ? and they should be queried as to the frequency.
> 
> OK so if I'm understanding you. You think get_cycles() is fine but that
> instead of encoding a "greybus-frame-time-counter" the platform code
> should interrogate the frequency provided - is that correct ?

You should definitely interrogate the relevant driver, somehow.

Without a higher-level view of what you're trying to achieve, it's not
clear to me whether get_cycles() is the right interface.

> > Beyond that, the fallback code using cpufreq and presumably an actual
> > cycle counter will be broken in a number of cases
> 
> Of course the fallback will be broken... it's not supposed to work if
> you don't have a timer that can be used - just compile, run and print a
> complaint - i.e., this won't really do FrameTime on an x86... then
> again since so much of the underlying greybus/unipro hardware -
> requires a 19.2MHz refclk - if you were to try to do greybus on x86
> you'd need to solve that problem.

If it's never going to work, why give the illusion that it might?

If you don't have the necessary prerequisites, fail to probe entirely.
Prevent drivers that depend on the non-existent functionality from
probing, or have them avoid the facility which is not available.

Don't provide them with something that can appear to work for a while,
yet will fall over in a breeze.

> > Per the comment at the top of the file, it looks like you want a
> > system-wide stable clocksource. If you want that, you need to use a
> > generic API that allows drivers and arch code to actually provide
> > that, rather than building one yourself that doesn't work.
> 
> Hmm. The objective is to read one of the timers clocked by the PMIC
> refclk input. refclk is provided to each processor in the system - and
> on MSM8994 clocks the MMIO timers. It's used to drive the PLL on the
> other processors - which in turn drive the timers that the Modules use
> to read their own local counters. We want to read that counter on MSM
> directly - get_cycles() has worked nicely so far.

This is too low-level for me to see what you're actually trying to
achieve. The fact that you want to read a specific timer is an
implementation detail.

Why can't you use any other timer? Correctness? Performance? (Why) is
the fact that the PLL drives module timers important?

> > If you're trying to synchronise with other agents in the system that
> > are reading from the MMIO arch timers,
> 
> No. The MMIO timers are useful only to the MSM. We don't have any type
> of parallel (or serial) bus that can access that on-chip resource.

To be clear, by "other agents in the system", I'm also asking about
other devices within the SoC (e.g. anything other than the CPUs running
this instance of Linux).

> MSM8994 -- > USB
> ? ? ? ? ? ? ?APBridge (timer) -> UniPro bus
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> Module with a UART
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> Module with a GPIO
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> Module with an etc, etc
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> SPI bus
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> SVC
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Owns FrameTime
> 
> So the SVC owns FrameTime and diseminates that to other entities in the
> system by way of a GPIO and greybus. It's up to the MSM8994 to select a
> timer that works for it - the other processors in the system are
> responsible for their own timers.

Sorry, but this doesn't clarify much from my PoV.

* What are the requirements for that timer? 

* Is there_any_ implicit relationship with the module timers derived
  from the fact they share a parent PLL? Is that a requirement somehow?

Thanks,
Mark.
