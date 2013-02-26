From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Feb 2013 18:49:42 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <512CFF30.9080300@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
 <512CFF30.9080300@wwwdotorg.org>
Message-ID: <20130226184942.GV17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 11:30:08AM -0700, Stephen Warren wrote:
> On 02/26/2013 11:11 AM, Russell King - ARM Linux wrote:
> > On Tue, Feb 26, 2013 at 11:01:30AM -0700, Stephen Warren wrote:
> >> The conditional in that statement makes me wonder which of the following
> >> operations will fault in non-secure mode:
> >>
> >> 1) Reading from the diagnostic register.
> > 
> > Won't fault.
> > 
> >> 2) Writing to the diagnostic register, of a value the same as what's
> >> already there.
> > 
> > Will fault.
> > 
> >> 3) Writing to the diagnostic register, of a value different than what's
> >> already there.
> > 
> > Will fault.
> > 
> >> Would the following not fault in both secure and non-secure mode:
> >>
> >> read diagnostic register
> >> if desired bit already set:
> >>     b 1f
> >> set desired bit
> >> write value back to diagnostic register
> >> 1:
> > 
> > That is exactly what we do
> 
> Well, I asked because for the 3 WARs in question at least, that isn't
> what the code does. For example, from proc-v7.s:
> 
> #ifdef CONFIG_ARM_ERRATA_742230
> 	cmp	r6, #0x22		@ only present up to r2p2
> 	mrcle	p15, 0, r10, c15, c0, 1	@ read diagnostic register
> 	orrle	r10, r10, #1 << 4	@ set bit #4
> 	mcrle	p15, 0, r10, c15, c0, 1	@ write diagnostic register
> #endif
> 
> (unless that orrle affects the flags and hence skips the mcrle, but I
> don't think so.)

Hmm.  I've not really been taking much notice of how these work-arounds
all work - maybe it's safe to write this diagnostic register from
non-secure mode then?

I have noticed this kind of fishy thing with OMAP4430 running in non-secure
mode - some registers I thought would cause an exception don't.  No idea
why not...

> > - the problem is, that if you require
> > workaround X to be enabled, and a different platform has that errata
> > fixed, then the other platform will not enable the work-around, and
> > the bit will be clear.
> 
> The 3 WARs in question are conditional upon the CPU's revision and patch
> number (which I'll call rNpN). I assume that any Cortex-A9 with the
> affected rNpN would require the WAR enabled; is it possible that someone
> could have fixed a particular core bug directly (and hence not changed
> rNpN),

SoC folk are apparantly free to incorporate fixes into the ARM CPU
when they fabricate it, which means that the rNpN number doesn't
accurately reflect what workarounds are required.

We've had this discussion before - a few months ago - and the conclusion
that was arrived at was that the _only_ way out of this mess is to
require whatever runs _before_ the kernel to enable the appropriate
work-arounds in these apparantly secure-accessible only registers.

We've now been around this problem about three or four times, and we
ultimately end up coming back to the above, and/or talking about
ripping out the errata workarounds from the kernel which just set
bits in the register(s).
