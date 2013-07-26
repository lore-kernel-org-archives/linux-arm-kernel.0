From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 26 Jul 2013 17:24:10 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <20130726160015.GF2282@localhost.localdomain>
References: <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
 <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
 <20130723104352.GA3023@localhost.localdomain>
 <alpine.LFD.2.03.1307230821270.15022@syhkavp.arg>
 <20130723163319.GA781@e102568-lin.cambridge.arm.com>
 <20130725120424.GC2546@localhost.localdomain>
 <alpine.LFD.2.03.1307261047380.15022@syhkavp.arg>
 <20130726160015.GF2282@localhost.localdomain>
Message-ID: <20130726162410.GE28084@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 05:00:15PM +0100, Dave Martin wrote:
> On Fri, Jul 26, 2013 at 10:58:27AM -0400, Nicolas Pitre wrote:
> > On Thu, 25 Jul 2013, Dave Martin wrote:
> > 
> > > On Tue, Jul 23, 2013 at 05:33:19PM +0100, Lorenzo Pieralisi wrote:
> > > > On Tue, Jul 23, 2013 at 01:28:16PM +0100, Nicolas Pitre wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > + * - The CPU is obviously no longer coherent with the other CPUs.
> > > > > > > + *
> > > > > > > + * Further considerations:
> > > > > > > + *
> > > > > > > + * - This relies on the presence and behavior of the AUXCR.SMP bit as
> > > > > > > + *   documented in the ARMv7 TRM.  Vendor implementations that deviate from
> > > > > > 
> > > > > > Sorry to be pedantic here, but there is no "ARMv7 TRM".  The SMP bit is
> > > > > > not part of ARMv7 at all.
> > > > > 
> > > > > Well, I just copied Lorenzo's words here, trusting he knew more about it 
> > > > > than I do.
> > > > > 
> > > > > > Also, it seems that A9 isn't precisely the
> > > > > > same: two ACTLR bits need to be twiddled.  R-class CPUs are generally
> > > > > > not the same either.
> > > > 
> > > > If you mean the ACTLR.FW bit in A9, A5, and R7, then, IIRC, we do not need to
> > > > clear it, clearing the SMP bit is enough.
> > > > 
> > > > See, Dave has a point, there is no explicit "unified v7 TRM disable
> > > > clean and exit coherency procedure" even though the designers end goal is to
> > > > have one and that's the one you wrote. The code you posted is perfectly ok on
> > > > all v7 implementations in the kernel I am aware of, I stand to be corrected
> > > > but to the best of my knowledge that's the case.
> > > 
> > > What I'm really concerned about here is not Cortex-*, but the vendors
> > > who have their own CPU implementations.  I don't think I've ever seen
> > > a TRM for one of those.
> > 
> > Could we wait until they materialize before worrying about possible 
> > incompatibility issues?  After all this is not a user space ABI that 
> > cannot be changed afterwards.  Remember this is Linux internal code we 
> > have the ability to change when needed, hence we should resist the 
> > temptation to over-engineer.
> 
> If I could think of a better name, I would suggest it ... but unless we call
> it "cortexa" or something, I don't know what it should be.  I'm not sure
> how much I like that either.  Strictly speaking, that's still not correct.
> 
> So I guess this comes down to being clear about which CPUs we expect it to
> work for.
> 
> Right now, we know it works for A7 and A15.
> 
> It sounds like we believe it might work for A9.  Lorenzo might know about
> A5, A7 etc.  But I'm not sure this exact sequence has been tested on any
> of those CPUs(?)

I tested this sequence on A9 MP a while ago, even though, obviously was not
this same macro. I know for certain it has been tested on A5, again not the
same macro but the same sequence.

On R7 honestly I can't certify.

What if we postpone the consolidation till MCPM for some A9 platforms
(eg Tegra) is posted (and in the meantime you leave the macro in mach-vexpress
to avoid duplication) ?

Thank you,
Lorenzo
