From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Feb 2014 12:57:07 +0000
Subject: [PATCH 3/6] irqchip: gic: use writel instead of dsb +
 writel_relaxed
In-Reply-To: <20140207112337.GC5976@mudshark.cambridge.arm.com>
References: <20140206114559.GK29446@arm.com>
 <20140206115121.GN26035@mudshark.cambridge.arm.com>
 <20140206115430.GN29446@arm.com>
 <20140206115739.GP26035@mudshark.cambridge.arm.com>
 <20140206120035.GQ29446@arm.com>
 <20140206121350.GQ26035@mudshark.cambridge.arm.com>
 <20140206122340.GC32520@arm.com>
 <20140206132643.GS26035@mudshark.cambridge.arm.com>
 <20140206152048.GD32520@arm.com>
 <20140207112337.GC5976@mudshark.cambridge.arm.com>
Message-ID: <20140207125707.GA4061@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 11:23:38AM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2014 at 03:20:48PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 06, 2014 at 01:26:44PM +0000, Will Deacon wrote:
> > > On Thu, Feb 06, 2014 at 12:23:40PM +0000, Catalin Marinas wrote:
> > > > On Thu, Feb 06, 2014 at 12:13:50PM +0000, Will Deacon wrote:
> > > > > Ok, so if we assume that a dsb(ishst) is sufficient because the CPU we're
> > > > > talking to is either (a) coherent in the inner-shareable domain or (b)
> > > > > incoherent, and we flushed everything to PoC, then why wouldn't a dmb(ishst)
> > > > > work?
> > > > 
> > > > Because you want to guarantee the ordering between a store to Normal
> > > > Cacheable memory vs store to Device for the IPI (see the mailbox example
> > > > in the Barrier Litmus section ;)). The second is just a slave access, DMB
> > > > guarantees observability from the master access perspective.
> > > 
> > > Ok, my reasoning is as follows:
> > > 
> > >   - CPU0 tries to message CPU1. It writes to a location in normal memory,
> > >     then writes to the GICD to send the SGI
> > > 
> > >   - We need to ensure that CPU1 observes the write to normal memory before
> > >     the write to GICD reaches the distributor. This is *not* about end-point
> > >     ordering (the usual non-coherent DMA example).
> > > 
> > >   - A dmb ishst ensures that the two writes are observed in order by CPU1
> > >     (and, in fact, the inner-shareable domain containing CPU0).
> > 
> > The last bullet point is not correct. DMB would only guarantee that the
> > two writes (memory and GICD) are observed by CPU1 if CPU1 actually read
> > the GICD (observability is defined for master accesses).
> 
> No, that's not how observability is defined, unfortunately.

According to the ARM ARM, "an observer is a master in the system that is
capable of observing memory accesses". GICD is not memory, hence the
assumptions about DMB in this context no longer work.

> Rather than attempt to solve this via email (your examples below are already
> getting hard to follow :), how about we sit down with $drink_of_choice and
> post back here with our conclusions?

Sounds good (though not a wide choice of drinks).

> In the meantime, I'll use dsb(ishst) because I think we now agree that
> works. The question is whether it can be relaxed further to a dmb.

I'm fine with dsb(ishst).

-- 
Catalin
