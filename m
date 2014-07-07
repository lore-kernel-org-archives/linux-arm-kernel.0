From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Jul 2014 13:05:52 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <20140707111712.GZ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk>
 <5774249.oWoI3gS2oa@wuerfel> <20140707110248.GA32578@arm.com>
 <20140707111712.GZ21766@n2100.arm.linux.org.uk>
Message-ID: <20140707120552.GB32276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 12:17:12PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 07, 2014 at 12:02:48PM +0100, Catalin Marinas wrote:
> > I'm not sure that's the right approach. ARM added the CPUID scheme to
> > allow the software to check specific features rather than guessing
> > specific architecture versions. Basically there isn't a clear way to
> > identify whether your CPU is ARMv6K or ARMv7 from a single ID register
> > read (you may be able to infer by reading multiple ID regs).
> > 
> > I'm now trying to figure out whether the TPIDR registers actually have a
> > dedicated ID. I think they only come as part of the VMSA version 7 as
> > identified from ID_MMFR0. The ARM1136 r1p1 TRM states that ID_MMFR0[3:0]
> > are 0x3 which mean VMSAv7.
> 
> You can't rely on the CPUID registers on 1136, because it doesn't
> advertise them as being present - the architecture field of MIDR is
> 0x7, not 0xf.

I was hoping they changed it with r1 but looking at the TRM that's not
the case.

> So actually, 1136r0 is the architecturally correct version, and 1136r1
> is the slightly cocked up non-standard version where we have to be careful
> how we treat it.

Yes. Looking at ARM1176, it seems to be using the full CPUID scheme and
reporting VMSAv7. So I guess we can safely assume TLS presence if VMSAv7
(actually what __get_cpu_architecture checks) or ARM1136 r1+. This would
be slightly different from the current assumption that TLS is present on
ARMv6+ except ARM1136r0 but I'm not aware of any other ARMv6 non-CPUID
processor without TLS (ARM1156 has CPUID and reports PMSAv6).

-- 
Catalin
