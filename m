From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 May 2010 12:15:49 +0100
Subject: [RFC PATCH 0/3] ARM: flush_dcache_page/update_mmu_cache
	reimplementation
Message-ID: <20100513110609.21178.39630.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches are meant to fix several cache coherency issues with PIO
drivers on the ARM implementation. The code change is relatively small.

It follows some ideas from the IA-64 and PowerPC implementations where
the PG_arch_1 bit means "clean" rather than "dirty" D-cache for a given
page. The main difference is the that we do not do the cache flushing in
set_pte_at() but keep it in update_mmu_cache() and deferring the
L_PTE_EXEC attribute setting (the NX hardware bit clearing).

Even if cache flushing would be done in set_pte_at(), on SMP systems we
would still have a small window between setting the PTE and flushing the
caches so the same NX/no-NX pte setting would need to be followed.


Catalin Marinas (3):
      ARM: Use lazy cache flushing on ARMv7 SMP systems
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP


 arch/arm/include/asm/cacheflush.h |    6 +++---
 arch/arm/include/asm/pgtable.h    |   12 ++++++++++++
 arch/arm/include/asm/smp_plat.h   |    4 ++++
 arch/arm/include/asm/tlbflush.h   |    2 +-
 arch/arm/mm/copypage-v4mc.c       |    2 +-
 arch/arm/mm/copypage-v6.c         |    2 +-
 arch/arm/mm/copypage-xscale.c     |    2 +-
 arch/arm/mm/dma-mapping.c         |    6 ++++++
 arch/arm/mm/fault-armv.c          |   21 +++++++++++++--------
 arch/arm/mm/flush.c               |   15 +++++----------
 10 files changed, 47 insertions(+), 25 deletions(-)

-- 
Catalin
