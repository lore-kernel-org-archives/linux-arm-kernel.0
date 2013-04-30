From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 30 Apr 2013 17:30:39 +0100
Subject: [RFC PATCH 0/9] HugeTLB and THP support for ARM64.
Message-ID: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series brings huge pages and transparent huge pages to ARM64.
The functionality is very similar to x86, and a lot of code that can
be used by both ARM64 and x86 is brought into mm to avoid the need
for code duplication.

One notable difference from x86 is that ARM64 supports normal pages
that are 64KB. When 64KB pages are enabled, huge page and
transparent huge pages are 512MB only, otherwise the sizes match
x86.

This series applies to 3.9, and requires one additional patch
ARM64: mm: Correct show_pte behaviour
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/164157.html

I've tested this under the ARMv8 models (Fast and Foundation) and
the x86 code has been tested in a KVM guest. libhugetlbfs was used
for testing under both architectures.

Any comments would be greatly appreciated.

Steve Capper (9):
  mm: hugetlb: Copy huge_pmd_share from x86 to mm.
  x86: mm: Remove x86 version of huge_pmd_share.
  mm: hugetlb: Copy general hugetlb code from x86 to mm.
  x86: mm: Remove general hugetlb code from x86.
  ARM64: mm: Add support for flushing huge pages.
  ARM64: mm: Restore memblock limit when map_mem finished.
  ARM64: mm: HugeTLB support.
  ARM64: mm: Introduce MAX_ZONE_ORDER for 64K and THP.
  ARM64: mm: THP support.

 arch/arm64/Kconfig                     |  29 +++++
 arch/arm64/include/asm/hugetlb.h       | 121 ++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h |   2 +
 arch/arm64/include/asm/pgtable.h       |  56 +++++++++
 arch/arm64/include/asm/tlb.h           |   6 +
 arch/arm64/include/asm/tlbflush.h      |   2 +
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/fault.c                  |  19 +--
 arch/arm64/mm/flush.c                  |   3 +-
 arch/arm64/mm/hugetlbpage.c            |  70 +++++++++++
 arch/arm64/mm/mmu.c                    |  19 ++-
 arch/x86/Kconfig                       |   6 +
 arch/x86/mm/hugetlbpage.c              | 187 ----------------------------
 include/linux/hugetlb.h                |   4 +
 mm/hugetlb.c                           | 219 +++++++++++++++++++++++++++++++--
 15 files changed, 526 insertions(+), 218 deletions(-)
 create mode 100644 arch/arm64/include/asm/hugetlb.h
 create mode 100644 arch/arm64/mm/hugetlbpage.c

-- 
1.8.1.4
