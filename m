From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 28 Mar 2014 14:22:32 +0000
Subject: [PATCH V3 0/2] PTE fixes for ARM LPAE
Message-ID: <1396016554-5843-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a couple of problems that I have come across on ARM
with LPAE.
 1) Some pte accessors can have their results cancelled out by a
    downcast. This is addressed by the first patch.

 2) It is impossible to distinguish between clean writable ptes and
    read only ptes. This is addressed by the second patch.

The big change in V3 is going back to the pte_isset macros, also an
additional macro, pte_isclear, is introduced. For cases where the bits
to be tested are in the lower 32-bits of the pte, the double logical
invert is dropped.

Steve Capper (2):
  arm: mm: Introduce pte_isset and pte_isclear
  arm: mm: Switch back to L_PTE_WRITE

 arch/arm/include/asm/pgtable-2level.h |  2 +-
 arch/arm/include/asm/pgtable-3level.h |  1 +
 arch/arm/include/asm/pgtable.h        | 50 +++++++++++++++++++----------------
 arch/arm/mm/dump.c                    |  8 +++---
 arch/arm/mm/mmu.c                     | 25 +++++++++---------
 arch/arm/mm/proc-macros.S             | 16 +++++------
 arch/arm/mm/proc-v7-2level.S          |  6 ++---
 arch/arm/mm/proc-v7-3level.S          |  4 ++-
 arch/arm/mm/proc-xscale.S             |  4 +--
 9 files changed, 62 insertions(+), 54 deletions(-)

-- 
1.8.1.4
