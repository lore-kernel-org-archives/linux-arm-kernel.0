From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:35:02 +0000
Subject: [PATCH 1/5] ARM: pgtable: move TOP_PTE address definitions to
 arch/arm/mm/mm.h
In-Reply-To: <20120120103433.GF1068@n2100.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBoE-0005oQ-Hf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the TOP_PTE address definitions to one central place so that it's
easy to discover what they're being used for.  This helps to ensure
that there are no overlaps.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/copypage-v4mc.c   |   10 +++-------
 arch/arm/mm/copypage-v6.c     |   16 ++++++----------
 arch/arm/mm/copypage-xscale.c |    6 ------
 arch/arm/mm/flush.c           |    8 +++-----
 arch/arm/mm/mm.h              |   13 +++++++++++++
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 7d0a8c2..87a23ca 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -23,10 +23,6 @@
 
 #include "mm.h"
 
-/*
- * 0xffff8000 to 0xffffffff is reserved for any ARM architecture
- * specific hacks for copying pages efficiently.
- */
 #define minicache_pgprot __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | \
 				  L_PTE_MT_MINICACHE)
 
@@ -78,10 +74,10 @@ void v4_mc_copy_user_highpage(struct page *to, struct page *from,
 
 	raw_spin_lock(&minicache_lock);
 
-	set_pte_ext(TOP_PTE(0xffff8000), pfn_pte(page_to_pfn(from), minicache_pgprot), 0);
-	flush_tlb_kernel_page(0xffff8000);
+	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), pfn_pte(page_to_pfn(from), minicache_pgprot), 0);
+	flush_tlb_kernel_page(COPYPAGE_MINICACHE);
 
-	mc_copy_user_page((void *)0xffff8000, kto);
+	mc_copy_user_page((void *)COPYPAGE_MINICACHE, kto);
 
 	raw_spin_unlock(&minicache_lock);
 
diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 3d9a155..c00a750 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -24,9 +24,6 @@
 #error FIX ME
 #endif
 
-#define from_address	(0xffff8000)
-#define to_address	(0xffffc000)
-
 static DEFINE_RAW_SPINLOCK(v6_lock);
 
 /*
@@ -90,11 +87,11 @@ static void v6_copy_user_highpage_aliasing(struct page *to,
 	 */
 	raw_spin_lock(&v6_lock);
 
-	set_pte_ext(TOP_PTE(from_address) + offset, pfn_pte(page_to_pfn(from), PAGE_KERNEL), 0);
-	set_pte_ext(TOP_PTE(to_address) + offset, pfn_pte(page_to_pfn(to), PAGE_KERNEL), 0);
+	kfrom = COPYPAGE_V6_FROM + (offset << PAGE_SHIFT);
+	kto   = COPYPAGE_V6_TO + (offset << PAGE_SHIFT);
 
-	kfrom = from_address + (offset << PAGE_SHIFT);
-	kto   = to_address + (offset << PAGE_SHIFT);
+	set_pte_ext(TOP_PTE(kfrom), pfn_pte(page_to_pfn(from), PAGE_KERNEL), 0);
+	set_pte_ext(TOP_PTE(kto), pfn_pte(page_to_pfn(to), PAGE_KERNEL), 0);
 
 	flush_tlb_kernel_page(kfrom);
 	flush_tlb_kernel_page(kto);
@@ -111,8 +108,7 @@ static void v6_copy_user_highpage_aliasing(struct page *to,
  */
 static void v6_clear_user_highpage_aliasing(struct page *page, unsigned long vaddr)
 {
-	unsigned int offset = CACHE_COLOUR(vaddr);
-	unsigned long to = to_address + (offset << PAGE_SHIFT);
+	unsigned long to = COPYPAGE_V6_TO + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
 
 	/* FIXME: not highmem safe */
 	discard_old_kernel_data(page_address(page));
@@ -123,7 +119,7 @@ static void v6_clear_user_highpage_aliasing(struct page *page, unsigned long vad
 	 */
 	raw_spin_lock(&v6_lock);
 
-	set_pte_ext(TOP_PTE(to_address) + offset, pfn_pte(page_to_pfn(page), PAGE_KERNEL), 0);
+	set_pte_ext(TOP_PTE(to), pfn_pte(page_to_pfn(page), PAGE_KERNEL), 0);
 	flush_tlb_kernel_page(to);
 	clear_page((void *)to);
 
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 610c24c..90f3bb5 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -23,12 +23,6 @@
 
 #include "mm.h"
 
-/*
- * 0xffff8000 to 0xffffffff is reserved for any ARM architecture
- * specific hacks for copying pages efficiently.
- */
-#define COPYPAGE_MINICACHE	0xffff8000
-
 #define minicache_pgprot __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | \
 				  L_PTE_MT_MINICACHE)
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 1a8d4aa..f4d407a 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -23,11 +23,9 @@
 
 #ifdef CONFIG_CPU_CACHE_VIPT
 
-#define ALIAS_FLUSH_START	0xffff4000
-
 static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 {
-	unsigned long to = ALIAS_FLUSH_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
+	unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
 	const int zero = 0;
 
 	set_pte_ext(TOP_PTE(to), pfn_pte(pfn, PAGE_KERNEL), 0);
@@ -46,8 +44,8 @@ static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned
 	unsigned long offset = vaddr & (PAGE_SIZE - 1);
 	unsigned long to;
 
-	set_pte_ext(TOP_PTE(ALIAS_FLUSH_START) + colour, pfn_pte(pfn, PAGE_KERNEL), 0);
-	to = ALIAS_FLUSH_START + (colour << PAGE_SHIFT) + offset;
+	set_pte_ext(TOP_PTE(FLUSH_ALIAS_START) + colour, pfn_pte(pfn, PAGE_KERNEL), 0);
+	to = FLUSH_ALIAS_START + (colour << PAGE_SHIFT) + offset;
 	flush_tlb_kernel_page(to);
 	flush_icache_range(to, to + len);
 }
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 70f6d3ea..6ee1ff2 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -5,6 +5,19 @@ extern pmd_t *top_pmd;
 
 #define TOP_PTE(x)	pte_offset_kernel(top_pmd, x)
 
+/*
+ * 0xffff8000 to 0xffffffff is reserved for any ARM architecture
+ * specific hacks for copying pages efficiently, while 0xffff4000
+ * is reserved for VIPT aliasing flushing by generic code.
+ *
+ * Note that we don't allow VIPT aliasing caches with SMP.
+ */
+#define COPYPAGE_MINICACHE	0xffff8000
+#define COPYPAGE_V6_FROM	0xffff8000
+#define COPYPAGE_V6_TO		0xffffc000
+/* PFN alias flushing, for VIPT caches */
+#define FLUSH_ALIAS_START	0xffff4000
+
 static inline pmd_t *pmd_off_k(unsigned long virt)
 {
 	return pmd_offset(pud_offset(pgd_offset_k(virt), virt), virt);
-- 
1.7.4.4
