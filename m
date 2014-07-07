From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 12:17:12 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU
 advertises it has exclusives
In-Reply-To: <20140707110248.GA32578@arm.com>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel> <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <5774249.oWoI3gS2oa@wuerfel> <20140707110248.GA32578@arm.com>
Message-ID: <20140707111712.GZ21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 12:02:48PM +0100, Catalin Marinas wrote:
> I'm not sure that's the right approach. ARM added the CPUID scheme to
> allow the software to check specific features rather than guessing
> specific architecture versions. Basically there isn't a clear way to
> identify whether your CPU is ARMv6K or ARMv7 from a single ID register
> read (you may be able to infer by reading multiple ID regs).
> 
> I'm now trying to figure out whether the TPIDR registers actually have a
> dedicated ID. I think they only come as part of the VMSA version 7 as
> identified from ID_MMFR0. The ARM1136 r1p1 TRM states that ID_MMFR0[3:0]
> are 0x3 which mean VMSAv7.

You can't rely on the CPUID registers on 1136, because it doesn't
advertise them as being present - the architecture field of MIDR is
0x7, not 0xf.

What we know is that if it has the MPIDR, then it must be ARMv6K (the
ARM tells us that.)  Where there is a hole is where a CPU is ARMv6K
but does not have the MPIDR, in which case we fall back to treating it
as a plain ARMv6. I don't think that can be worked around for the reason
you state above - there isn't a way to reliably identify the two apart.

It looks like 1136r1 falls into that category.  It didn't have to had
the MIDR had been updated to indicate the presence of the CPUID scheme.
It should be noted that the 1136r1 CPUID registers don't quite have the
same definition as those specified by the ARM ARM (irrespective of the
version of the ARM ARM.)

So actually, 1136r0 is the architecturally correct version, and 1136r1
is the slightly cocked up non-standard version where we have to be careful
how we treat it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
