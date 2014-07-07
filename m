From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 12:23:22 +0100
Subject: [PATCH 0/4] ABI updates
In-Reply-To: <20140707111947.GP28884@atomide.com>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <20140707111947.GP28884@atomide.com>
Message-ID: <20140707112322.GA21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 04:19:48AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140704 12:56]:
> > As a result of the recent discussions about android, several issues
> > have been identified with existing kernels:
> > 
> > 1. HWCAP_SWP does not properly reflect whether the SWP instruction
> >    should be used.  Turn HWCAP_SWP off on ARMv6+ where the exclusives
> >    are available.
> > 
> > 2. SWP is unsafe when running on a SMP CPU; there is no bus locking
> >    between the read and write parts of the instruction execution.
> >    Force SWP emulation on ARMv7+ where we can disable the SWP
> >    instruction.
> > 
> > 3. Reporting of alignment faults - kernel mode faults are silent due to
> >    the requirements of the network stack, but we can note where the
> >    last one occurs.
> > 
> > Testing reveals that at least my OMAP4430 userspace (supplied from TI)
> > executes lots of SWP instructions, which is something that wasn't known
> > before this patch.
> > 
> > Many systems today are not configured with SWP emulation enabled on SMP.
> > This means that the SWP instruction is available, but unsafe.
> > 
> >  arch/arm/kernel/setup.c       | 29 ++++++++++++++++++++++-------
> >  arch/arm/kernel/swp_emulate.c |  4 ++++
> >  arch/arm/mm/Kconfig           |  2 +-
> >  arch/arm/mm/alignment.c       |  4 +++-
> >  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> Tried testing this on omap2 which is ARMv6 with no K, but got this:
> 
> arch/arm/kernel/setup.c: In function ?elf_hwcap_fixup?:
> arch/arm/kernel/setup.c:405:2: error: implicit declaration of function ?read_cpuid_part? [-Werror=implicit-function-declaration]

That's because they rely upon my "ARM: make it easier to check the CPU part
number correctly" patch in linux-next.

> That should be read_cpuid_part_number instead. After fixing that,
> omap2 booted fine, so for ARMv6 with no K:

Great, I hope you checked /proc/cpuinfo came out correctly, as well as
noticing that it merely booted.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
