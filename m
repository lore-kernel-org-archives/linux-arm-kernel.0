From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Jul 2014 12:02:48 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <5774249.oWoI3gS2oa@wuerfel>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <5774249.oWoI3gS2oa@wuerfel>
Message-ID: <20140707110248.GA32578@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 10:58:04PM +0200, Arnd Bergmann wrote:
> On Friday 04 July 2014 21:51:44 Russell King - ARM Linux wrote:
> > Hmm, we need guidance from ARM people on that.
> > 
> > There may well be a better way to detect between ARMv6 and ARMv6K, which
> > is given by the architecture spec.  G7.3 of an early DDI0406 says that
> > the MPIDR (mp affinity register) aliases to MIDR for ARMv6, but is of
> > course implemented for ARMv6K.
> > 
> > This seems to be carried through to the latest ARM ARM.  So it seems
> > this would be a more correct way to tell ARMv6 from ARMv6K.
> > 
> > If so, we can certainly expand cpu_architecture() to detect between the
> > two and add a CPU_ARCH_ARMv6K in there.
> > 
> > Let's see what Will has to say about that when he's next around...
> > though I think it'll require another trawl through lots of
> > documentation.
> 
> I was thinking of a simpler check in __get_cpu_architecture, just
> checking if the CPUID is ARM1136r0 since that is the only ARMv6
> CPU core we support. Anything else that we currently report as
> ARMv6 is actually ARMv6K.

I'm not sure that's the right approach. ARM added the CPUID scheme to
allow the software to check specific features rather than guessing
specific architecture versions. Basically there isn't a clear way to
identify whether your CPU is ARMv6K or ARMv7 from a single ID register
read (you may be able to infer by reading multiple ID regs).

I'm now trying to figure out whether the TPIDR registers actually have a
dedicated ID. I think they only come as part of the VMSA version 7 as
identified from ID_MMFR0. The ARM1136 r1p1 TRM states that ID_MMFR0[3:0]
are 0x3 which mean VMSAv7.

-- 
Catalin
