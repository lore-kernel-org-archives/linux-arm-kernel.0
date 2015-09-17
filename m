From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:09 +0100
Subject: [PATCH 00/10] arm64 switch_mm improvements
Message-ID: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series aims to improve out switch_mm implementation and bring the
ASID allocator up-to-speed with what we already have for arch/arm/.

In particular, this series:

  - Introduces routines for CPU-local I-cache and TLB invalidation, and
    converts relevant callers to use these in preference to the
    inner-shareable variants

  - Rewrites the ASID allocator to use the bitmap algorithm implemented
    for arch/arm/ plus the new relaxed atomics introduced with 4.3 (a
    subsequent patch series will optimise these for arm64).

  - Degrades fullm TLB flushing on exit/execve to a NOP, since the ASID
    allocator will never re-allocate a dirty ASID

  - Kills mm_cpumask, as it is no longer used and therefore doesn't need
    to be kept up-to-date

  - Removes some redundant DSB instructions for synchronising page-table
    updates

Feedback (particularly as a result of testing!) is more than welcome.

Will

--->8

Will Deacon (10):
  arm64: mm: remove unused cpu_set_idmap_tcr_t0sz function
  arm64: proc: de-scope TLBI operation during cold boot
  arm64: flush: use local TLB and I-cache invalidation
  arm64: mm: rewrite ASID allocator and MM context-switching code
  arm64: tlbflush: remove redundant ASID casts to (unsigned long)
  arm64: tlbflush: avoid flushing when fullmm == 1
  arm64: switch_mm: simplify mm and CPU checks
  arm64: mm: kill mm_cpumask usage
  arm64: tlb: remove redundant barrier from __flush_tlb_pgtable
  arm64: mm: remove dsb from update_mmu_cache

 arch/arm64/include/asm/cacheflush.h  |   7 ++
 arch/arm64/include/asm/mmu.h         |  10 +-
 arch/arm64/include/asm/mmu_context.h | 113 ++++-------------
 arch/arm64/include/asm/pgtable.h     |   6 +-
 arch/arm64/include/asm/thread_info.h |   1 -
 arch/arm64/include/asm/tlb.h         |  26 ++--
 arch/arm64/include/asm/tlbflush.h    |  18 ++-
 arch/arm64/kernel/asm-offsets.c      |   2 +-
 arch/arm64/kernel/efi.c              |   5 +-
 arch/arm64/kernel/smp.c              |   9 +-
 arch/arm64/kernel/suspend.c          |   2 +-
 arch/arm64/mm/context.c              | 236 +++++++++++++++++++++--------------
 arch/arm64/mm/mmu.c                  |   2 +-
 arch/arm64/mm/proc.S                 |   6 +-
 14 files changed, 217 insertions(+), 226 deletions(-)

-- 
2.1.4
