From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jan 2018 16:11:56 +0000
Subject: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
In-Reply-To: <20180117154959.GP17719@n2100.armlinux.org.uk>
References: <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180116172407.GA22781@e103592.cambridge.arm.com>
 <871sipl9p9.fsf@xmission.com>
 <20180117115708.GM17719@n2100.armlinux.org.uk>
 <20180117121505.GD22781@e103592.cambridge.arm.com>
 <20180117123752.GN17719@n2100.armlinux.org.uk>
 <20180117153731.GG22781@e103592.cambridge.arm.com>
 <20180117154959.GP17719@n2100.armlinux.org.uk>
Message-ID: <20180117161156.GH22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 03:49:59PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 17, 2018 at 03:37:31PM +0000, Dave Martin wrote:
> > On Wed, Jan 17, 2018 at 12:37:52PM +0000, Russell King - ARM Linux wrote:

[...]

> > > I'd be more inclined to agree with you if VFP exceptions were synchronous
> > > but they aren't.
> > 
> > Hmmm, it looks like imprecise fp exception traps are disallowed from
> > ARMv8 onwards.  I guess they made more sense when the FPU really was a
> > coprocessor, or at least semidetached from the integer core.
> > 
> > I think force_sig_info() makes sense here if and only if the traps
> > are guaranteed to be precise, so we probably should use this on arm64.
> > Not arm though (alpha doesn't either, if I understand the code
> > correctly.)
> > 
> > Does that make sense?
> > 
> > Apparently, few recent cores (at least ARM's own ones) support fp
> > exception trapping anyway...  1176 may be the most recent.
> 
> ... and that makes the feenableexcept() argument about "A program
> really wants to know" moot.  It can enable the exceptions in the
> FPSCR but its never going to receive a SIGFPE on CPUs that don't
> do exception trapping.

Sort of.  If the hardware doesn't support traps then those FP(S)CR
bits can't be set.  feenableexcept() returns -1 if the requested
bits don't stick, but I'll bet there's software that doesn't bother
to check...

Relying on fp exception traps therefore isn't portable, but software
that does so can at least portably fail safe if it checks for the -1
return.

I'll cook up some RFC patches for arm64, then I could take a look at
arm is nobody else is working on it.

Cheers
---Dave
