From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 21 Oct 2016 12:22:55 +0100
Subject: [PATCH v4 0/3] arm64/mm: use the contiguous attribute for kernel
 mappings
Message-ID: <1477048978-4140-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back to a 3-piece series.

Changes in v4:
- dropped handling of contiguous PUDs and folded PMDs, given that the hardware
  is likely to ignore the contiguous bit at this level anyway
- factor out the pte/pmd/pgd attribute BUG check (#1)

Changes in v3 [0]:
- add support for contiguous PMDs for all granule sizes (not just 16k)
- add a separate patch to deal with contiguous PUDs (4k granule only), and
  contiguous PMDs for 2 levels of translation (which requires special handling)
- avoid pmd_none/pud_none in the BUG() statements in patch #1, since they
  may resolve in unexpected ways with folded PMDs/PUDs

Version v2 [1] addressed the following issues:
- the contiguous attribute is also useful for contigous PMD mappings on 16k
  granule kernels (i.e., 1 GB blocks)
- the function parameter 'block_mappings_allowed' does not clearly convey
  whether contiguous page mappings should be used, so it is renamed to
  'page_mappings_only', and its meaning inverted
- instead of BUGging on changes in the PTE_CONT attribute in PMD or PTE entries
  that have been populated already, BUG on any modification except for
  permission attributes, which don't require break-before-make when changed.

[0] http://marc.info/?l=linux-arm-kernel&m=147627155206982
[1] http://marc.info/?l=linux-arm-kernel&m=147618975314593

Ard Biesheuvel (3):
  arm64: mm: BUG on unsupported manipulations of live kernel mappings
  arm64: mm: replace 'block_mappings_allowed' with 'page_mappings_only'
  arm64: mm: set the contiguous bit for kernel mappings where
    appropriate

 arch/arm64/include/asm/mmu.h |   2 +-
 arch/arm64/kernel/efi.c      |   8 +-
 arch/arm64/mm/mmu.c          | 134 +++++++++++++-------
 3 files changed, 93 insertions(+), 51 deletions(-)

-- 
2.7.4
