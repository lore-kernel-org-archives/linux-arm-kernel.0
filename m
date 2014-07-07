From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Jul 2014 16:59:42 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <20140707153105.GC21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <5774249.oWoI3gS2oa@wuerfel> <20140707110248.GA32578@arm.com>
 <20140707111712.GZ21766@n2100.arm.linux.org.uk>
 <20140707120552.GB32276@arm.com>
 <20140707131335.GB21766@n2100.arm.linux.org.uk>
 <20140707134624.GC32276@arm.com>
 <20140707153105.GC21766@n2100.arm.linux.org.uk>
Message-ID: <20140707155942.GD32578@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 04:31:05PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 07, 2014 at 02:46:24PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 07, 2014 at 02:13:35PM +0100, Russell King - ARM Linux wrote:
> > > > > So actually, 1136r0 is the architecturally correct version, and 1136r1
> > > > > is the slightly cocked up non-standard version where we have to be careful
> > > > > how we treat it.
> > > > 
> > > > Yes. Looking at ARM1176, it seems to be using the full CPUID scheme and
> > > > reporting VMSAv7. So I guess we can safely assume TLS presence if VMSAv7
> > > > (actually what __get_cpu_architecture checks) or ARM1136 r1+.
> > > 
> > > *Not* ARM1136 r1, because there the CPUID registers are ignored because
> > > MIDR does not indicate their presence.  So all ARM1136 are currently
> > > identified as ARMv6 by the kernel.
> > 
> > I agree.
> > 
> > > With my proposal, ARM1136 with MPIDR would be identified as ARMv6K,
> > > but ARM1136 r1 without MPIDR would remain identified as ARMv6.
> > 
> > The ARM1136 TRM states that r1 introduces ARMv6K features. However, I
> > can't find any trace of MPIDR and it may actually just return MIDR. If
> > that's the case, we don't have a way to classify ARMv6K here based on
> > MPIDR.
> 
> It is documented in all sorts of places, including the 1136 TRM, that
> when the MPIDR is not implemented, it returns the MIDR.

Yes. So how do you check that an ARM1136 is v6K or not? I don't think
you can do this based on MPIDR because all ARM1136 revisions would
return MIDR when MPIDR is read (at least to my reading of the TRMs).

> > My original point was to ignore the v6K classification and, for the TLS
> > presence, just check the feature registers if full CPUID is present,
> > otherwise let TLS enabled for ARM1136 r1 because we know it implements
> > it (according to the TRM, special case without full CPUID).
> 
> Can we please stop this pointless wandering off of the topic.  We're
> not talking about TLS stuff here - that remains the same as it ever
> did.

Sorry, it went off topic. TLS is one case, SWP is another covered by the
same elf_hwcap_fixup() function (but it can be addressed separately).

> We're talking about SWP and/or the exclusives.

Going on topic again, LDREXB is present in ARM1136 r1 but your changes
would not detect it (and it's a different ID_ISAR3 format anyway). If we
care about this case, you could either pretend that ARM1136 r1 is ARMv6K
and link those decisions to v6K+ tests or check for individual features
which for ARM1136 would require a different check from standard CPUID.

-- 
Catalin
