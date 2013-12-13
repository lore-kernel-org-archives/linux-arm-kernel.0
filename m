From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 19:05:40 +0000
Subject: [RFC PATCH 0/6] Huge pages for short descriptors on ARM
Message-ID: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This RFC is another attempt at bringing HugeTLB pages and Transparent
Huge Pages (THP) to ARM on short descriptors.

Since my last resend in October I have rebased the code and simplified
it quite a lot. Rather than translate pte representations from software
bits to hardware bits and from hardware bits to software bits, I use
huge_pte_... analogues of the pte functions to deal with huge pages
directly.

There is one small bit of translation that takes place to populate an
appropriate pgprot_t value for the VMA containing the huge page. Once
we have that pgprot_t, we can manipulate huge ptes/pmds as normal with
the bit and modify funcs.

I have tested this series on an Arndale board running 3.13-rc3 with the
cache flushing fixes mentioned at:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219081.html

The libhugetlbfs checks, LTP and some custom THP PROT_NONE tests were
used to test this series.

To go forward with this series I would really like to know if anyone is
interested in huge pages for short-descriptors on ARM, and whether or
not these patches work well for those people?

As always, I would also appreciate any comments, critique or flames :-).

Cheers,
--
Steve

Steve Capper (6):
  mm: hugetlb: Introduce huge_pte_page and huge_pte_present
  arm: mm: Adjust the parameters for __sync_icache_dcache
  arm: mm: Make mmu_gather aware of huge pages
  arm: mm: Compute pgprot values for huge page sections
  arm: mm: HugeTLB support for non-LPAE systems
  arm: mm: Add Transparent HugePage support for non-LPAE

 arch/arm/Kconfig                      |   4 +-
 arch/arm/include/asm/hugetlb-2level.h | 121 ++++++++++++++++++++++++++++++
 arch/arm/include/asm/hugetlb-3level.h |   6 ++
 arch/arm/include/asm/hugetlb.h        |  10 +--
 arch/arm/include/asm/pgtable-2level.h | 137 ++++++++++++++++++++++++++++++++--
 arch/arm/include/asm/pgtable-3level.h |   6 ++
 arch/arm/include/asm/pgtable.h        |   9 +--
 arch/arm/include/asm/tlb.h            |  10 ++-
 arch/arm/kernel/head.S                |  10 ++-
 arch/arm/mm/fault.c                   |  13 ----
 arch/arm/mm/flush.c                   |   9 +--
 arch/arm/mm/fsr-2level.c              |   4 +-
 arch/arm/mm/hugetlbpage.c             |   2 +-
 arch/arm/mm/mmu.c                     |  52 +++++++++++++
 include/linux/hugetlb.h               |   8 ++
 mm/hugetlb.c                          |  18 ++---
 16 files changed, 368 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h

-- 
1.8.1.4
