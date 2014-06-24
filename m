From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 24 Jun 2014 13:23:22 +0100
Subject: [PATCH V5 0/2] PTE fixes for ARM LPAE
Message-ID: <1403612604-2645-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a couple of problems that I encountered on ARM with
LPAE.
 1) Some pte accessors can have their results cancelled out by a
    downcast. This is addressed by the first patch.

 2) It is impossible to distinguish between clean writeable ptes and
    read only ptes. This is addressed by the second patch.

Notable changes in this series from V4->V5:
 o) Rather than switch to L_PTE_WRITE semantics, we move L_PTE_RDONLY
    to a software bit. This allows for a much smaller patch set that
    does not affect the 2-level code.

Notable changes in this series from V3->V4:
 o) Rebased to take into account the BE LPAE fix in 3.16-rc1.
 o) THP logic added as this was missing.

This series has been tested with libhugetlbfs unit tests, ltp mm tests
and a custom THP test to test what happens when PROT_NONE THPs are
faulted. I have tested on an Arndale board with LPAE and classic MMU
(with classic MMU, only ltp mm tests were run). Testing was performed
against 3.16-rc2.

Any comments/feedback would be appreciated.

Cheers,
--
Steve


Steve Capper (2):
  arm: mm: Introduce {pte,pmd}_isset and {pte,pmd}_isclear
  arm: mm: Modify pte_write and pmd_write logic for LPAE

 arch/arm/include/asm/pgtable-3level-hwdef.h |  1 +
 arch/arm/include/asm/pgtable-3level.h       | 45 ++++++++++++++++++-----------
 arch/arm/include/asm/pgtable.h              | 18 +++++++-----
 arch/arm/mm/proc-v7-3level.S                |  9 ++++--
 4 files changed, 47 insertions(+), 26 deletions(-)

-- 
1.9.3
