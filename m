From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 16:31:05 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU
 advertises it has exclusives
In-Reply-To: <20140707134624.GC32276@arm.com>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel> <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <5774249.oWoI3gS2oa@wuerfel> <20140707110248.GA32578@arm.com>
 <20140707111712.GZ21766@n2100.arm.linux.org.uk>
 <20140707120552.GB32276@arm.com>
 <20140707131335.GB21766@n2100.arm.linux.org.uk>
 <20140707134624.GC32276@arm.com>
Message-ID: <20140707153105.GC21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 02:46:24PM +0100, Catalin Marinas wrote:
> On Mon, Jul 07, 2014 at 02:13:35PM +0100, Russell King - ARM Linux wrote:
> > > > So actually, 1136r0 is the architecturally correct version, and 1136r1
> > > > is the slightly cocked up non-standard version where we have to be careful
> > > > how we treat it.
> > > 
> > > Yes. Looking at ARM1176, it seems to be using the full CPUID scheme and
> > > reporting VMSAv7. So I guess we can safely assume TLS presence if VMSAv7
> > > (actually what __get_cpu_architecture checks) or ARM1136 r1+.
> > 
> > *Not* ARM1136 r1, because there the CPUID registers are ignored because
> > MIDR does not indicate their presence.  So all ARM1136 are currently
> > identified as ARMv6 by the kernel.
> 
> I agree.
> 
> > With my proposal, ARM1136 with MPIDR would be identified as ARMv6K,
> > but ARM1136 r1 without MPIDR would remain identified as ARMv6.
> 
> The ARM1136 TRM states that r1 introduces ARMv6K features. However, I
> can't find any trace of MPIDR and it may actually just return MIDR. If
> that's the case, we don't have a way to classify ARMv6K here based on
> MPIDR.

It is documented in all sorts of places, including the 1136 TRM, that
when the MPIDR is not implemented, it returns the MIDR.

> My original point was to ignore the v6K classification and, for the TLS
> presence, just check the feature registers if full CPUID is present,
> otherwise let TLS enabled for ARM1136 r1 because we know it implements
> it (according to the TRM, special case without full CPUID).

Can we please stop this pointless wandering off of the topic.  We're
not talking about TLS stuff here - that remains the same as it ever
did.

We're talking about SWP and/or the exclusives.

Right, since you like talking about stuff which isn't covered by this
patch, I'm going to assume that there are no objections to these
changes in this patch set.  In fact, I'm going to take your divergence
from the original topic as an implicit ack against the entire patch
set... if not, please keep discussions on topic rather than letting
them ramble over all sorts of other peripheral issues.

The TLS stuff is an _entirely_ separate issue from the one which this
patch addresses, and this patch does not really alter the mechanism
by which we decide whether HWCAP_TLS is set or cleared.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
