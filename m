From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jun 2016 14:51:25 +0200
Subject: [PATCH 0/5] arm64: avoid block entries that we need to split later
Message-ID: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to Catalin's series 'arm64: Avoid overlapping EFI regions'
whose aim was to get rid of the split_pmd() and split_pud() routines in
mm/mmu.c, which may violate the architecture when used in the wrong way.

This series updates the MMU mapping routines invoked by the code that sets
up the UEFI runtime services environment so that regions that may be subject
to splitting are always mapped down to pages. On the one hand, these are
regions that are covered by the Memory Attributes table as well as the UEFI
memory map, in which case we need to map down to pages in the first pass to
ensure that the more granular permission attributes do not require splitting
block entries. On the other hand, any region that is not aligned to the OS's
page size is mapped down to pages as well, so that the page such a region may
share with the next region is always mapped using pages, and no splitting is
required for mapping the second region.

Finally, remove the split_pmd() and split_pud() routines. Patch #5 is a cleanup
patch,

[0] http://thread.gmane.org/gmane.linux.kernel.efi/8649

Ard Biesheuvel (4):
  arm64: mm: add param to force create_pgd_mapping() to use page
    mappings
  arm64: efi: always map runtime services code and data regions down to
    pages
  arm64: efi: avoid block mappings for unaligned UEFI memory regions
  arm64: mm: fold init_pgd() into __create_pgd_mapping()

Catalin Marinas (1):
  arm64: mm: Remove split_p*d() functions

 arch/arm64/include/asm/efi.h |   3 +-
 arch/arm64/include/asm/mmu.h |   2 +-
 arch/arm64/kernel/efi.c      |  50 +++++++-
 arch/arm64/mm/mmu.c          | 126 +++++---------------
 4 files changed, 82 insertions(+), 99 deletions(-)

-- 
2.7.4
