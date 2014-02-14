From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Feb 2014 16:30:39 +0000
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
Message-ID: <20140214163039.GG21986@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, the results are in (*drum roll*)...

On Fri, Feb 07, 2014 at 11:23:37AM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2014 at 03:20:48PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 06, 2014 at 01:26:44PM +0000, Will Deacon wrote:
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
> Rather than attempt to solve this via email (your examples below are already
> getting hard to follow :), how about we sit down with $drink_of_choice and
> post back here with our conclusions?

... and it turns out that a dmb(ishst) is sufficient!

This counter-intuitive result was brought to you by ARM Ltd, purveyors of
fine grained memory barrier instructions.

I'll spin the patch again.

Will
