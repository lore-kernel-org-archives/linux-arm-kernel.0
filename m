From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 31 Jul 2013 12:44:40 -0400
Subject: [PATCH v2 0/6] ARM: mm: Extend the runtime patch stub for PAE systems
Message-ID: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of the series which addresses the comments/suggestions
we received on earlier version. The series trying to extend the existing
v2p runtime patching for LPAE machines which can have physical memory
beyond 4 GB. Keystone is one such ARM machine.

In testing various modes(LPAE/non-LPAE, ARM/THMUB), we found an issue
with the patching code for THUMB2 build. So there is a patch added in
the series to address it. I was planning to squash it in the parent
64 bit patch but thought of keeping it separate for ease of review.
We can squash it while merging the patches. 

Special thanks to Nicolas for his valuable feedback on the earlier
version.

Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>

Santosh Shilimkar (4):
  ARM: mm: LPAE: use phys_addr_t appropriately in p2v and v2p
    conversions
  ARM: mm: Introduce virt_to_idmap() with an arch hook
  ARM: mm: Move the idmap print to appropriate place in the code
  ARM: mm: Recreate kernel mappings in early_paging_init()

Sricharan R (2):
  ARM: mm: LPAE: Correct virt_to_phys patching for 64 bit physical
    addresses
  ARM: mm: Update runtime patching code to THUMB2 mode

 arch/arm/include/asm/mach/arch.h |    1 +
 arch/arm/include/asm/memory.h    |   73 +++++++++++++++++++++---
 arch/arm/kernel/armksyms.c       |    1 +
 arch/arm/kernel/head.S           |  115 +++++++++++++++++++++++++++-----------
 arch/arm/kernel/setup.c          |    3 +
 arch/arm/kernel/smp.c            |    2 +-
 arch/arm/mm/idmap.c              |    8 +--
 arch/arm/mm/mmu.c                |   82 +++++++++++++++++++++++++++
 8 files changed, 237 insertions(+), 48 deletions(-)

-- 
1.7.9.5
