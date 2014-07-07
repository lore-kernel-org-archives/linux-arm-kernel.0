From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 17:31:43 +0100
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU
 advertises it has exclusives
In-Reply-To: <20140707155942.GD32578@arm.com>
References: <4606711.7KmFAGVNmG@wuerfel>
 <20140704205144.GK21766@n2100.arm.linux.org.uk> <5774249.oWoI3gS2oa@wuerfel>
 <20140707110248.GA32578@arm.com>
 <20140707111712.GZ21766@n2100.arm.linux.org.uk>
 <20140707120552.GB32276@arm.com>
 <20140707131335.GB21766@n2100.arm.linux.org.uk>
 <20140707134624.GC32276@arm.com>
 <20140707153105.GC21766@n2100.arm.linux.org.uk>
 <20140707155942.GD32578@arm.com>
Message-ID: <20140707163143.GE21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 04:59:42PM +0100, Catalin Marinas wrote:
> Going on topic again, LDREXB is present in ARM1136 r1 but your changes
> would not detect it (and it's a different ID_ISAR3 format anyway). If we
> care about this case, you could either pretend that ARM1136 r1 is ARMv6K
> and link those decisions to v6K+ tests or check for individual features
> which for ARM1136 would require a different check from standard CPUID.

Ever since ARMv6 was first added, HWCAP_SWP has been indicated for all
ARMv6 CPUs and their derivatives.  Indeed, the SWP instruction is
supported in hardware.

Hence, indicating HWCAP_SWP on ARMv6 whether or not there is LDREXB
support is /not/ incorrect in any way.

ARM1136 r1 added LDREXB as part of the ARMv6K adoption, but it kept
the SWP instruction (which can't be disabled.)  So, indicating
HWCAP_SWP also is /not/ incorrect.

However, when it comes to SMP, we would _prefer_ userspace to use
the exclusives instructions, though it seems that the SWP behaviour
on an ARMv6K SMP system with respect to other CPUs is not documented.
All things being equal, we would prefer SWP not be used there because
we don't know whether it's safe.  Unfortunately, we can't turn the
instruction off, so we can't emulate it.

However, we know that some userspace running there may well contain
SWP instructions.  So, as there aren't any bug reports, it's probably
safe to assume that SWP is safe on ARMv6K SMP systems.


So, the upshot of this is:
* SWP on all ARMv6 is fine.
* Advertising HWCAP_SWP on all ARMv6 is fine too.
* We would prefer not to advertise HWCAP_SWP on ARMv6 with support
  for the exclusives, and we can do that trivially where we can
  check the CPUID values.
* ARM1136 is either ARMv6 or ARMv6K depending on its revision -
  and thus may have LDREXB, but LDREXB is not trivially detectable.


I believe what I'm doing in this patch is architecturally correct, I
also believe it to be safe for the troublesome ARM1136 by way of
defaulting to advertising HWCAP_SWP.

The killer argument for this is that we've been advertising HWCAP_SWP
for over the last decade on these anyway, and that situation is not
changing.

What is changing is whether we advertise HWCAP_SWP on CPUs with the
architected CPUID registers (maybe some ARMv6 if we're lucky, and
all ARMv7) which also indicate that they have LDREXB support.

Hence, this is the conservative change: we could include ARM1136 r1
in this, but I don't see the need to complicate the code further
right now.

Also, adding a CPU_ARCH_ARMv6K doesn't buy us very much, and carries
many risks that we will end up breaking something.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
