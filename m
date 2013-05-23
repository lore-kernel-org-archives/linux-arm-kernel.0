From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 23 May 2013 16:31:16 +0100
Subject: [PATCH v2 0/4] ARM: mm: HugeTLB + THP support.
Message-ID: <1369323080-9673-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches bring both HugeTLB support and Transparent
HugePage (THP) support to ARM.

Only long descriptors (LPAE) are supported in this series.

The code has been tested on an Arndale board (Exynos 5250).

This patch set is based on 3.10-rc2.

Major changes since the Patch:
 * LPAE code has been separated from non-LPAE code (this series
   is the LPAE code).
 * PROT_NONE support for HugeTLB and THP has been implemented.

Major changes since the RFC:
 * huge pmd sharing removed from the 3-level code as this was
   found to be very rarely, if ever?, used. This allowed for some
   code simplification.

 * hardware pmd bits for 2-levels of paging are now taken from
   mmu.c. Also the mapping code now uses pte/pmd bit helper
   functions rather than the custom pre-processor logic.

Cheers,
-- 
Steve

Catalin Marinas (2):
  ARM: mm: HugeTLB support for LPAE systems.
  ARM: mm: Transparent huge page support for LPAE systems.

Steve Capper (2):
  ARM: mm: correct pte_same behaviour for LPAE.
  ARM: mm: Add support for flushing HugeTLB pages.

 arch/arm/Kconfig                            |   8 +++
 arch/arm/include/asm/hugetlb-3level.h       |  71 +++++++++++++++++++
 arch/arm/include/asm/hugetlb.h              |  84 +++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |   4 ++
 arch/arm/include/asm/pgtable-3level.h       |  88 ++++++++++++++++++++++++
 arch/arm/include/asm/pgtable.h              |   3 +
 arch/arm/include/asm/tlb.h                  |   6 ++
 arch/arm/include/asm/tlbflush.h             |   2 +
 arch/arm/mm/Makefile                        |   1 +
 arch/arm/mm/dma-mapping.c                   |   2 +-
 arch/arm/mm/flush.c                         |  25 ++++---
 arch/arm/mm/fsr-3level.c                    |   4 +-
 arch/arm/mm/hugetlbpage.c                   | 101 ++++++++++++++++++++++++++++
 13 files changed, 386 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage.c

-- 
1.8.1.4
