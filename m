From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 17:15:34 +0100
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for intermediate
 page-table entries on arm64
Message-ID: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

This is v1 of the RFC I previously posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597821.html

The main changes include:

  * Rewrite the comment in tlbflush.h to explain the various functions
    and justify the barrier semantics

  * Fix the "flush entire ASID" heuristic to work with !4K page sizes

  * Fixed the build on sh (well, it fails somewhere else that isn't my fault)

  * Report PxD_SHIFT instead of PxD_SIZE via tlb_get_unmap_shift()

It's also had a lot more testing, but has held up nicely so far on arm64.
I haven't figured out how to merge this yet, but I'll probably end up pulling
the core changes out onto a separate branch.

Cheers,

Will

--->8

Peter Zijlstra (1):
  asm-generic/tlb: Track freeing of page-table directories in struct
    mmu_gather

Will Deacon (11):
  arm64: tlb: Use last-level invalidation in flush_tlb_kernel_range()
  arm64: tlb: Add DSB ISHST prior to TLBI in
    __flush_tlb_[kernel_]pgtable()
  arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()
  arm64: tlb: Justify non-leaf invalidation in flush_tlb_range()
  arm64: tlbflush: Allow stride to be specified for __flush_tlb_range()
  arm64: tlb: Remove redundant !CONFIG_HAVE_RCU_TABLE_FREE code
  asm-generic/tlb: Guard with #ifdef CONFIG_MMU
  asm-generic/tlb: Track which levels of the page tables have been
    cleared
  arm64: tlb: Adjust stride and type of TLBI according to mmu_gather
  arm64: tlb: Avoid synchronous TLBIs when freeing page tables
  arm64: tlb: Rewrite stale comment in asm/tlbflush.h

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/pgtable.h  |  10 +++-
 arch/arm64/include/asm/tlb.h      |  34 +++++-------
 arch/arm64/include/asm/tlbflush.h | 112 ++++++++++++++++++++++++--------------
 include/asm-generic/tlb.h         |  85 +++++++++++++++++++++++++----
 mm/memory.c                       |   4 +-
 6 files changed, 168 insertions(+), 78 deletions(-)

-- 
2.1.4
