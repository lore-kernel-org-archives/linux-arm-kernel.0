From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 13:39:46 +0100
Subject: [PATCH v2 0/3] arm64/mm: use the contiguous attribute for kernel
 mappings
Message-ID: <1476189589-1443-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This 3-piece series is a followup to the single patch 'arm64: mmu: set the
contiguous for kernel mappings when appropriate' sent out on the 10th [0].

This v2 addresses the following issues:
- the contiguous attribute is also useful for contigous PMD mappings on 16k
  granule kernels (i.e., 1 GB blocks)
- the function parameter 'block_mappings_allowed' does not clearly convey
  whether contiguous page mappings should be used, so it is renamed to
  'page_mappings_only', and its meaning inverted
- instead of BUGging on changes in the PTE_CONT attribute in PMD or PTE entries
  that have been populated already, BUG on any modification except for
  permission attributes, which don't require break-before-make when changed.

[0] http://marc.info/?l=linux-arm-kernel&m=147612332130714

Ard Biesheuvel (3):
  arm64: mm: BUG on unsupported manipulations of live kernel mappings
  arm64: mm: replace 'block_mappings_allowed' with 'page_mappings_only'
  arm64: mm: set the contiguous bit for kernel mappings where
    appropriate

 arch/arm64/include/asm/mmu.h |   2 +-
 arch/arm64/kernel/efi.c      |   8 +-
 arch/arm64/mm/mmu.c          | 135 +++++++++++++-------
 3 files changed, 93 insertions(+), 52 deletions(-)

-- 
2.7.4
