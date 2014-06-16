From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 16 Jun 2014 15:32:37 +0100
Subject: [PATCH V4 0/2] PTE fixes for ARM LPAE
Message-ID: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a couple of problems that I encountered on ARM with
LPAE.
 1) Some pte accessors can have their results cancelled out by a
    downcast. This is addressed by the first patch.

 2) It is impossible to distinguish between clean writable ptes and
    read only ptes. This is addressed by the second patch.

I was going to put V3 of this series into the patch system, but got
distracted, and some recent activity has necessitated a revision of
this series.

Notable changes in this series from V3->V4:
 o) Rebased to take into account the BE LPAE fix in 3.16-rc1.
 o) THP logic added as this was missing.

I was tempted to put a third patch in the series to re-route THP through
the pte setters, but decided to take baby steps instead.

This series has been tested with libhugetlbfs unit tests, ltp mm tests
and a custom THP test to test what happens when PROT_NONE THPs are
faulted. I have tested on an Arndale board with LPAE and classic MMU
(with classic MMU, only ltp mm tests were run), and would appreciate
any testers for anything not covered by proc-v7-[23]level.S.

Also any comments/feedback would be appreciated.

Cheers,
--
Steve

Steve Capper (2):
  arm: mm: Introduce {pte,pmd}_isset and {pte,pmd}_isclear
  arm: mm: Switch back to L_PTE_WRITE

 arch/arm/include/asm/pgtable-2level.h |  2 +-
 arch/arm/include/asm/pgtable-3level.h | 24 ++++++++++++----
 arch/arm/include/asm/pgtable.h        | 52 +++++++++++++++++++----------------
 arch/arm/mm/dump.c                    |  8 +++---
 arch/arm/mm/mmu.c                     | 25 +++++++++--------
 arch/arm/mm/proc-macros.S             | 16 +++++------
 arch/arm/mm/proc-v7-2level.S          |  6 ++--
 arch/arm/mm/proc-v7-3level.S          |  4 ++-
 arch/arm/mm/proc-xscale.S             |  4 +--
 9 files changed, 80 insertions(+), 61 deletions(-)

-- 
1.8.1.4
