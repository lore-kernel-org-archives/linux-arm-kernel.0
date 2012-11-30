From: vitalya@ti.com (Vitaly Andrianov)
Date: Fri, 30 Nov 2012 08:04:53 -0500
Subject: [PATCH] arm: mm: lpae: add PTE loop to alloc_init_section
Message-ID: <1354280693-28696-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without enabled LPAE the alloc_init_pud never calls the alloc_init_section
to map more then one segment. In that case the alloc_init_section doesn't
need the loop when makes pte mapping. The loop is required when LPAE is
enabled and alloc_init_pud may ask to map multiple sections.

This patch adds the loop.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/mm/mmu.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2dbacf9..5ac134a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -614,11 +614,20 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 
 		flush_pmd_entry(p);
 	} else {
+#ifndef CONFIG_ARM_LPAE
 		/*
 		 * No need to loop; pte's aren't interested in the
 		 * individual L1 entries.
 		 */
 		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
+#else
+		unsigned long next;
+		do {
+			next = pmd_addr_end(addr, end);
+			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
+			phys += next - addr;
+		} while (pmd++, addr=next, addr != end);
+#endif
 	}
 }
 
-- 
1.7.9.5
