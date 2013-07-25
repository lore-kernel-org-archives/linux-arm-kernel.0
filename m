From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 Jul 2013 13:04:24 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <20130723163319.GA781@e102568-lin.cambridge.arm.com>
References: <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
 <20130718180323.GC2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
 <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
 <20130723104352.GA3023@localhost.localdomain>
 <alpine.LFD.2.03.1307230821270.15022@syhkavp.arg>
 <20130723163319.GA781@e102568-lin.cambridge.arm.com>
Message-ID: <20130725120424.GC2546@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 05:33:19PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jul 23, 2013 at 01:28:16PM +0100, Nicolas Pitre wrote:
> 
> [...]
> 
> > > > + * - The CPU is obviously no longer coherent with the other CPUs.
> > > > + *
> > > > + * Further considerations:
> > > > + *
> > > > + * - This relies on the presence and behavior of the AUXCR.SMP bit as
> > > > + *   documented in the ARMv7 TRM.  Vendor implementations that deviate from
> > > 
> > > Sorry to be pedantic here, but there is no "ARMv7 TRM".  The SMP bit is
> > > not part of ARMv7 at all.
> > 
> > Well, I just copied Lorenzo's words here, trusting he knew more about it 
> > than I do.
> > 
> > > Also, it seems that A9 isn't precisely the
> > > same: two ACTLR bits need to be twiddled.  R-class CPUs are generally
> > > not the same either.
> 
> If you mean the ACTLR.FW bit in A9, A5, and R7, then, IIRC, we do not need to
> clear it, clearing the SMP bit is enough.
> 
> See, Dave has a point, there is no explicit "unified v7 TRM disable
> clean and exit coherency procedure" even though the designers end goal is to
> have one and that's the one you wrote. The code you posted is perfectly ok on
> all v7 implementations in the kernel I am aware of, I stand to be corrected
> but to the best of my knowledge that's the case.

What I'm really concerned about here is not Cortex-*, but the vendors
who have their own CPU implementations.  I don't think I've ever seen
a TRM for one of those.

> 
> > > This is why I preferred to treat the whole sequence as specific to a
> > > particular CPU implementation.  The similarity between A7 and A15
> > > might be viewed as a happy coincidence (it also makes life easier in
> > > big.LITTLE land).
> > 
> > Fair enough.
> 
> I disagree on the happy coincidence but the point is taken. I am not

I confess to exaggeration!  There was obviously an effort to align A15
and A7, but we know there are differences at the system level, and there
is always the possibility of b.L pairings which differ on things like
the SMP bit, or b.L pairings of CPUs not originally designed to pair but
which are "similar enough" to be pairable.

> sure about what we should do, but I reiterate my point, the sequence as
> it stands is OK on all NS v7 implementations I am aware of. We can add
> macros to differentiate processors when we need them, but again that's
> just my opinion, as correct as it can be.

I still vote for naming them a15_* a7_* or similar.

For big.LITTLE pairings, I think we should assume that the big CPU's
macro is usable on the LITTLE CPU too.  Assuming sane CPU designs, that
will be true, and we know it works for A15+A7.

So we would use the a15 macro on TC2, but the a7 macro on an a7-only
platform.


The other way to abstract this stuff would be to add a new per-CPU
proc_fn, but that may be overkill, particularly since we know the whole
mcpm backend may tend to be platform-specific, not just the CPU coherency
exit part.

Cheers
---Dave
