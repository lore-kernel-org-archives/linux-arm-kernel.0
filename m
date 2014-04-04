From: rabin@rab.in (Rabin Vincent)
Date: Fri,  4 Apr 2014 23:27:49 +0200
Subject: [PATCH 1/2] arm: fixmap: implement __set_fixmap()
Message-ID: <1396646870-29695-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used from set_fixmap() and clear_fixmap() via
asm-generic/fixmap.h.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
Needs "arm: use generic fixmap.h", available in linux-next.

 arch/arm/include/asm/fixmap.h | 2 ++
 arch/arm/mm/mmu.c             | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 68ea615..55ed076 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -23,6 +23,8 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
+void __set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t prot);
+
 #include <asm-generic/fixmap.h>
 
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 3e16307..61bdfb1 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -22,6 +22,7 @@
 #include <asm/cputype.h>
 #include <asm/sections.h>
 #include <asm/cachetype.h>
+#include <asm/fixmap.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
@@ -388,6 +389,12 @@ SET_MEMORY_FN(rw, pte_set_rw)
 SET_MEMORY_FN(x, pte_set_x)
 SET_MEMORY_FN(nx, pte_set_nx)
 
+void __set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t prot)
+{
+	BUG_ON(idx >= __end_of_fixed_addresses);
+	set_top_pte(__fix_to_virt(idx), pfn_pte(__phys_to_pfn(phys), prot));
+}
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
-- 
1.9.1
