From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 15 Sep 2016 11:35:56 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160915101330.GB6718@leverpostej>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej> <20160914180754.GA16053@kroah.com>
 <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
Message-ID: <1473935756.10230.42.camel@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-15 at 11:13 +0100, Mark Rutland wrote:
> On Thu, Sep 15, 2016 at 10:35:33AM +0100, Bryan O'Donoghue wrote:
> >?
> I don't think the history matters, 

Your comment seemed to indicate you thought we were reading a
architectural timer directly - which we aren't.

> and I don't think that one can rely
> on get_cycles() in this manner outside of arch code.

I don't follow your meaning. What's wrong with get_cycles() ? You've
already said you don't think reading an architectural timer directly is
correct.

The objective is to read one of the free-running counters in MSM8994,
clocked by the PMIC. The refclk provided by PMIC is distributed to each
processor in the system.

>  Looking at the
> state of the tree [1] as of the final commit [2] in the greybus
> branch,
> my points still stand:
> 
> * The "google,greybus-frame-time-counter" node is superfluous. It
> does
> ? not describe a particular device,

It describes a timer running @ 19.2MHz, clocked by PMIC refclk.

>  and duplicates information we have
> ? elsewhere.

Can you give an example ?

>  It does not explicitly define the relationship with the
> ? underlying clocksource.


> * The clock-frequency property isn't necessary. The architected timer
> ? drivers know the frequency of the architected timers (MMIO or
> sysreg),
> ? and they should be queried as to the frequency.

OK so if I'm understanding you. You think get_cycles() is fine but that
instead of encoding a "greybus-frame-time-counter" the platform code
should interrogate the frequency provided - is that correct ?

> Beyond that, the fallback code using cpufreq and presumably an actual
> cycle counter will be broken in a number of cases

Of course the fallback will be broken... it's not supposed to work if
you don't have a timer that can be used - just compile, run and print a
complaint - i.e., this won't really do FrameTime on an x86... then
again since so much of the underlying greybus/unipro hardware -
requires a 19.2MHz refclk - if you were to try to do greybus on x86
you'd need to solve that problem.

> 
> Per the comment at the top of the file, it looks like you want a
> system-wide stable clocksource. If you want that, you need to use a
> generic API that allows drivers and arch code to actually provide
> that,
> rather than building one yourself that doesn't work.

Hmm. The objective is to read one of the timers clocked by the PMIC
refclk input. refclk is provided to each processor in the system - and
on MSM8994 clocks the MMIO timers. It's used to drive the PLL on the
other processors - which in turn drive the timers that the Modules use
to read their own local counters. We want to read that counter on MSM
directly - get_cycles() has worked nicely so far.

> 
> If you're trying to synchronise with other agents in the system that
> are
> reading from the MMIO arch timers,

No. The MMIO timers are useful only to the MSM. We don't have any type
of parallel (or serial) bus that can access that on-chip resource.

MSM8994 -- > USB
? ? ? ? ? ? ?APBridge (timer) -> UniPro bus
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> Module with a UART
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> Module with a GPIO
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> Module with an etc, etc
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> SPI bus
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? -> SVC
? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Owns FrameTime

So the SVC owns FrameTime and diseminates that to other entities in the
system by way of a GPIO and greybus. It's up to the MSM8994 to select a
timer that works for it - the other processors in the system are
responsible for their own timers.

---
bod
