From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed,  6 Mar 2013 20:52:13 -0800
Subject: [PATCH] arm: mm: Populate initial page tables across sections
Message-ID: <1362631933-23567-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code for setting up initial page tables does
not take into account section spanning for the non-section
case. This may result in incorrect population of page tables
and unexpected aborts. These problems have been observed in two cases:

1) An iomap entry that is not section aligned but the mapped size is
greater than the section size
2) Removal a block of section aligned memory with memblock remove and
remapping of a separate region of memory to 4k chunks as part of CMA

The solution is to call alloc_init_pte in SECTION_SIZE chunks. This
ensures that alloc_init_pte will populate the page tables
correctly.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/mmu.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 25cb67c..08cf68a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -652,11 +652,30 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 
 		flush_pmd_entry(p);
 	} else {
-		/*
-		 * No need to loop; pte's aren't interested in the
-		 * individual L1 entries.
-		 */
-		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
+		unsigned long pte_end;
+
+		if (addr + SECTION_SIZE < addr)
+			pte_end = end;
+		else if (IS_ALIGNED(addr, SECTION_SIZE))
+			pte_end = min (end, addr + SECTION_SIZE);
+		else
+			pte_end = min (end, roundup(addr, SECTION_SIZE));
+
+		do {
+			unsigned int offset;
+
+			alloc_init_pte(pmd, addr, pte_end, __phys_to_pfn(phys), type);
+
+			if (addr + SECTION_SIZE < addr)
+				break;
+
+			if (end - pte_end)
+				offset = min(SECTION_SIZE, end - pte_end);
+			else
+				break;
+			addr += offset;
+			pte_end += offset;
+		} while (pmd++, addr < end);
 	}
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
