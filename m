From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:36:23 +0000
Subject: [PATCH 5/5] ARM: pgtable: get rid of TOP_PTE()
In-Reply-To: <20120120103433.GF1068@n2100.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBpX-0005ok-VX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of the TOP_PTE() macro as we now have proper accessor functions
instead.  No one should be directly referencing the top pte table
anymore.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/mm.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 1651d5a..27f4a61 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -3,8 +3,6 @@
 /* the upper-most page table pointer */
 extern pmd_t *top_pmd;
 
-#define TOP_PTE(x)	pte_offset_kernel(top_pmd, x)
-
 /*
  * 0xffff8000 to 0xffffffff is reserved for any ARM architecture
  * specific hacks for copying pages efficiently, while 0xffff4000
@@ -20,13 +18,15 @@ extern pmd_t *top_pmd;
 
 static inline void set_top_pte(unsigned long va, pte_t pte)
 {
-	set_pte_ext(TOP_PTE(va), pte, 0);
+	pte_t *ptep = pte_offset_kernel(top_pmd, va);
+	set_pte_ext(ptep, pte, 0);
 	local_flush_tlb_kernel_page(va);
 }
 
 static inline pte_t get_top_pte(unsigned long va)
 {
-	return *TOP_PTE(va);
+	pte_t *ptep = pte_offset_kernel(top_pmd, va);
+	return *ptep;
 }
 
 static inline pmd_t *pmd_off_k(unsigned long virt)
-- 
1.7.4.4
