From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Jul 2016 19:32:23 +0200
Subject: [PATCH 0/2] arm64: mm: use fully constructed struct pages from EFI
 page tables
Message-ID: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Sudeep, the EFI memory attributes table handling may crash
on an uninitialized spinlock in the struct page associated with a UEFI runtime
translation table page.

This is caused by a failure to take into account the fact that generic code
treats such pages differently depending on whether they are associated with
init_mm or not. The EFI page tables are completely separate from both the
kernel and the userland mappings, and are completely static during the
lifetime of the OS, but still, the most robust solution is to simply
construct these pages fully, so that generic code that compares against
&init_mm can work safely and correctly.

Patch #1 is a preparatory patch to drop a reference to late_pgtable_alloc
from code that no longer needs it.

Patch #2 renamed late_pgtable_alloc to pgd_table_alloc, and updates it to
construct the struct page associated with the allocated page.

Ard Biesheuvel (2):
  arm64: mm: make create_mapping_late() non-allocating
  arm64: mm: run pgtable_page_ctor() on non-swapper translation table
    pages

 arch/arm64/mm/mmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.7.4
