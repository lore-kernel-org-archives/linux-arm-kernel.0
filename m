From: anderson@redhat.com (Dave Anderson)
Date: Tue, 15 Apr 2014 13:53:24 -0400
Subject: [PATCH] Fix for the arm64 kern_addr_valid() function
Message-ID: <1397584404-28762-1-git-send-email-anderson@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Fix for the arm64 kern_addr_valid() function to recognize
 virtual addresses in the kernel logical memory map.  The
 function fails as written because it does not check whether
 the addresses in that region are mapped at the pmd level to
 2MB or 512MB pages, continues the page table walk to the
 pte level, and issues a garbage value to pfn_valid().

 Tested on 4K-page and 64K-page kernels.

Signed-off-by: Dave Anderson <anderson@redhat.com>
---
 arch/arm64/mm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6b7e895..0a472c4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -374,6 +374,9 @@ int kern_addr_valid(unsigned long addr)
 	if (pmd_none(*pmd))
 		return 0;
 
+	if (pmd_sect(*pmd))
+		return pfn_valid(pmd_pfn(*pmd));
+
 	pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(*pte))
 		return 0;
-- 
1.7.11.7
