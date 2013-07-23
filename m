From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 23 Jul 2013 17:33:19 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <alpine.LFD.2.03.1307230821270.15022@syhkavp.arg>
References: <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
 <20130718180323.GC2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
 <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
 <20130723104352.GA3023@localhost.localdomain>
 <alpine.LFD.2.03.1307230821270.15022@syhkavp.arg>
Message-ID: <20130723163319.GA781@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 01:28:16PM +0100, Nicolas Pitre wrote:

[...]

> > > + * - The CPU is obviously no longer coherent with the other CPUs.
> > > + *
> > > + * Further considerations:
> > > + *
> > > + * - This relies on the presence and behavior of the AUXCR.SMP bit as
> > > + *   documented in the ARMv7 TRM.  Vendor implementations that deviate from
> > 
> > Sorry to be pedantic here, but there is no "ARMv7 TRM".  The SMP bit is
> > not part of ARMv7 at all.
> 
> Well, I just copied Lorenzo's words here, trusting he knew more about it 
> than I do.
> 
> > Also, it seems that A9 isn't precisely the
> > same: two ACTLR bits need to be twiddled.  R-class CPUs are generally
> > not the same either.

If you mean the ACTLR.FW bit in A9, A5, and R7, then, IIRC, we do not need to
clear it, clearing the SMP bit is enough.

See, Dave has a point, there is no explicit "unified v7 TRM disable
clean and exit coherency procedure" even though the designers end goal is to
have one and that's the one you wrote. The code you posted is perfectly ok on
all v7 implementations in the kernel I am aware of, I stand to be corrected
but to the best of my knowledge that's the case.

> > This is why I preferred to treat the whole sequence as specific to a
> > particular CPU implementation.  The similarity between A7 and A15
> > might be viewed as a happy coincidence (it also makes life easier in
> > big.LITTLE land).
> 
> Fair enough.

I disagree on the happy coincidence but the point is taken. I am not
sure about what we should do, but I reiterate my point, the sequence as
it stands is OK on all NS v7 implementations I am aware of. We can add
macros to differentiate processors when we need them, but again that's
just my opinion, as correct as it can be.

Lorenzo
