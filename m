From: r.sricharan@ti.com (R Sricharan)
Date: Tue, 29 Jan 2013 20:37:16 +0530
Subject: [PATCH v4] ARM: LPAE: Fix mapping in alloc_init_pte for unaligned
 addresses
Message-ID: <1359472036-7613-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With LPAE enabled, alloc_init_section() does not map the
entire address space for unaligned addresses.

The issue also reproduced with CMA + LPAE. CMA tries to map 16MB
with page granularity mappings during boot. alloc_init_pte()
is called and out of 16MB, only 2MB gets mapped and rest remains
unaccessible.

Because of this OMAP5 boot is broken with CMA + LPAE enabled.
Fix the issue by ensuring that the entire addresses are
mapped.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <chris@cloudcar.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Christoffer Dall  <chris@cloudcar.com>
---
 [V2] Moved the loop to alloc_init_pte as per Russell's
     feedback and changed the subject accordingly.
     Using PMD_XXX instead of SECTION_XXX to avoid
     different loop increments with/without LPAE.

 [v3] Removed the dummy variable phys and updated
      the commit log for CMA case.

 [v4] Resending with updated change log and 
      updating the tags.

 arch/arm/mm/mmu.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f8388ad..b94c313 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -569,11 +569,23 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, unsigned long pfn,
 				  const struct mem_type *type)
 {
-	pte_t *pte = early_pte_alloc(pmd, addr, type->prot_l1);
+	unsigned long next;
+	pte_t *pte;
+
 	do {
-		set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
-		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		if ((end-addr) & PMD_MASK)
+			next = (addr + PMD_SIZE) & PMD_MASK;
+		else
+			next = end;
+
+		pte = early_pte_alloc(pmd, addr, type->prot_l1);
+		do {
+			set_pte_ext(pte, pfn_pte(pfn,
+					__pgprot(type->prot_pte)), 0);
+			pfn++;
+		} while (pte++, addr += PAGE_SIZE, addr != next);
+
+	} while (pmd++, addr = next, addr != end);
 }
 
 static void __init alloc_init_section(pud_t *pud, unsigned long addr,
-- 
1.7.9.5
