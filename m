From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 May 2015 11:30:00 +0100
Subject: [PATCH v2 0/7] Fix Keystone 2 physical address switch
Message-ID: <20150506103000.GF2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some time, the Keystone 2 physical address switch has been
tainting the kernel ever since we decided that it was not safe.

This series re-works the address switch to be compliant architecturally.

There's still a niggle in the keystone2 code, where we set the
arch_virt_to_idmap function pointer in keystone_pv_fixup() - something
I'd ideally like to avoid.

I'm in two minds about how much of this code should be in SoC specific
code, and how much should be in generic code - on one hand, I don't
want to give a green light to this kind of sillyness by encouraging
it, but I'd rather not end up with multiple implementations of this.

I've incorporated my change to the update of the PV offset constants
into this series, and included the 7th patch in this set which I think
is worth having - it's quite a large patch which gets rid of the TTBR1
setting that Keystone has to do.  We basically pass the full 64-bits
for TTBR0 in the assembly code so that Keystone doesn't have to re-set
the page table pointer after secondary CPU initialisation.  That needs
us to juggle around some registers in the assembly code.

 arch/arm/include/asm/mach/arch.h  |   2 +-
 arch/arm/include/asm/memory.h     |  16 ----
 arch/arm/include/asm/proc-fns.h   |   7 --
 arch/arm/include/asm/smp.h        |   2 +-
 arch/arm/kernel/head-nommu.S      |   2 +-
 arch/arm/kernel/head.S            |  42 ++++++++---
 arch/arm/kernel/setup.c           |   7 +-
 arch/arm/kernel/smp.c             |  10 ++-
 arch/arm/mach-keystone/keystone.c |  41 +++++-----
 arch/arm/mach-keystone/platsmp.c  |  13 ----
 arch/arm/mm/Kconfig               |   4 +
 arch/arm/mm/Makefile              |   1 +
 arch/arm/mm/mmu.c                 | 153 ++++++++++++++++----------------------
 arch/arm/mm/nommu.c               |   9 ---
 arch/arm/mm/proc-v7-2level.S      |   6 +-
 arch/arm/mm/proc-v7-3level.S      |  14 ++--
 arch/arm/mm/proc-v7.S             |  26 +++----
 arch/arm/mm/pv-fixup-asm.S        |  88 ++++++++++++++++++++++
 18 files changed, 239 insertions(+), 204 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
