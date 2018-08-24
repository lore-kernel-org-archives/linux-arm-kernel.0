From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:35 +0100
Subject: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for intermediate
 page-table entries on arm64
Message-ID: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I hacked up this RFC on the back of the recent changes to the mmu_gather
stuff in mainline. It's had a bit of testing and it looks pretty good so
far.

The main changes in the series are:

  - Avoid emitting a DSB barrier after clearing each page-table entry.
    Instead, we can have a single DSB prior to the actual TLB invalidation.

  - Batch last-level TLB invalidation until the end of the VMA, and use
    last-level-only invalidation instructions

  - Batch intermediate TLB invalidation until the end of the gather, and
    use all-level invalidation instructions

  - Adjust the stride of TLB invalidation based upon the smallest unflushed
    granule in the gather

As a really stupid benchmark, unmapping a populated mapping of
0x4_3333_3000 bytes using munmap() takes around 20% of the time it took
before.

The core changes now track the levels of page-table that have been visited
by the mmu_gather since the last flush. It may be possible to use the
page_size field instead if we decide to resurrect that from its current
"debug" status, but I think I'd prefer to track the levels explicitly.

Anyway, I wanted to post this before disappearing for the long weekend
(Monday is a holiday in the UK) in the hope that it helps some of the
ongoing discussions.

Cheers,

Will

--->8

Peter Zijlstra (1):
  asm-generic/tlb: Track freeing of page-table directories in struct
    mmu_gather

Will Deacon (10):
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

 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/pgtable.h  | 10 ++++-
 arch/arm64/include/asm/tlb.h      | 34 +++++++----------
 arch/arm64/include/asm/tlbflush.h | 28 +++++++-------
 include/asm-generic/tlb.h         | 79 +++++++++++++++++++++++++++++++++------
 mm/memory.c                       |  4 +-
 6 files changed, 105 insertions(+), 51 deletions(-)

-- 
2.1.4
