From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 18 Oct 2013 14:07:11 +0100
Subject: [RFC PATCH 0/2] Implement get_user_pages_fast for ARM
Message-ID: <1382101634-4723-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements get_user_pages_fast on ARM. Unlike other
architectures, we do not use IPIs/disabled IRQs as a blocking
mechanism to protect the page table walker. Instead an atomic counter
is used to indicate how many fast gup walkers are active on an address
space, and any code that would cause them problems (THP splitting or
code that could free a page table page) spins on positive values of
this counter.

This series also addresses an assumption made in kernel/futex.c that
THP page splitting can be blocked by disabling the IRQs on a processor
by introducing arch_block_thp_split and arch_unblock_thp_split.

As well as fixing a problem where futexes on THP tails cause hangs on
ARM, I expect this series to also be beneficial for direct-IO, and for
KVM (the hva_to_pfn fast path uses __get_user_pages_fast).

Any comments would be greatly appreciated.

Steve Capper (2):
  thp: Introduce arch_(un)block_thp_split
  arm: mm: implement get_user_pages_fast

 arch/arm/include/asm/mmu.h            |   1 +
 arch/arm/include/asm/pgalloc.h        |   9 ++
 arch/arm/include/asm/pgtable-2level.h |   1 +
 arch/arm/include/asm/pgtable-3level.h |  21 +++
 arch/arm/include/asm/pgtable.h        |  18 +++
 arch/arm/include/asm/tlb.h            |   8 ++
 arch/arm/mm/Makefile                  |   2 +-
 arch/arm/mm/gup.c                     | 234 ++++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h               |  16 +++
 kernel/futex.c                        |   6 +-
 10 files changed, 312 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mm/gup.c

-- 
1.8.1.4
