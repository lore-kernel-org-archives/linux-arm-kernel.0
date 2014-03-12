From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Mar 2014 13:40:17 +0000
Subject: [RFC PATCH V3 0/6] get_user_pages_fast for ARM and ARM64
Message-ID: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
This RFC series implements get_user_pages_fast and __get_user_pages_fast.
These are required for Transparent HugePages to function correctly, as
a futex on a THP tail will otherwise result in an infinite loop (due to
the core implementation of __get_user_pages_fast always returning 0).
This series may also be beneficial for direct-IO heavy workloads and
certain KVM workloads.

The main changes since RFC V2 are:
 * pte_special logic added to the fast_gup.
 * mmu_gather in arm64 replaced entirely by core implementation.
 * arm and arm64 both reference the same gup.c to prevent code
   duplication (I'm not sure how much of a good idea that is).

I have tested the series using the Fast Model for ARM64 and an Arndale
Board. This series applies to 3.14-rc6 with one additional patch from
Will Deacon that is currently in Linux next:
 1971188 ARM: 7985/1: mm: implement pte_accessible for faulting mappings
 
Again, I would really appreciate any comments and/or testers!

Cheers,
--
Steve

Catalin Marinas (1):
  arm64: Convert asm/tlb.h to generic mmu_gather

Steve Capper (5):
  arm: mm: Introduce special ptes for LPAE
  arm: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm: mm: implement get_user_pages_fast
  arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
  arm64: mm: Activate get_user_pages_fast for arm64

 arch/arm/Kconfig                      |   1 +
 arch/arm/include/asm/pgtable-2level.h |   2 +
 arch/arm/include/asm/pgtable-3level.h |  14 ++
 arch/arm/include/asm/pgtable.h        |   3 -
 arch/arm/include/asm/tlb.h            |  38 ++++-
 arch/arm/mm/Makefile                  |   1 +
 arch/arm/mm/gup.c                     | 299 ++++++++++++++++++++++++++++++++++
 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/pgtable.h      |   6 +
 arch/arm64/include/asm/tlb.h          | 140 +++-------------
 arch/arm64/mm/Makefile                |   4 +-
 11 files changed, 389 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/mm/gup.c

-- 
1.8.1.4
