From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:35:43 +0000
Subject: [PATCH 3/5] ARM: pgtable: consolidate set_pte_ext(TOP_PTE, ...) + tlb
 flush
In-Reply-To: <20120120103433.GF1068@n2100.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBot-0005oa-3W@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of places establish a PTE in our top page table and
immediately flush the TLB.  Rather than having this at every callsite,
provide an inline function for this purpose.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/copypage-v4mc.c   |    3 +--
 arch/arm/mm/copypage-v6.c     |   10 +++-------
 arch/arm/mm/copypage-xscale.c |    3 +--
 arch/arm/mm/flush.c           |   10 ++++------
 arch/arm/mm/highmem.c         |   13 +++++--------
 arch/arm/mm/mm.h              |    6 ++++++
 6 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index e4dc2f4..6e06180 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -74,8 +74,7 @@ void v4_mc_copy_user_highpage(struct page *to, struct page *from,
 
 	raw_spin_lock(&minicache_lock);
 
-	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), mk_pte(from, minicache_pgprot), 0);
-	flush_tlb_kernel_page(COPYPAGE_MINICACHE);
+	set_top_pte(COPYPAGE_MINICACHE, mk_pte(from, minicache_pgprot));
 
 	mc_copy_user_page((void *)COPYPAGE_MINICACHE, kto);
 
diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 8652459..29c7704 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -90,11 +90,8 @@ static void v6_copy_user_highpage_aliasing(struct page *to,
 	kfrom = COPYPAGE_V6_FROM + (offset << PAGE_SHIFT);
 	kto   = COPYPAGE_V6_TO + (offset << PAGE_SHIFT);
 
-	set_pte_ext(TOP_PTE(kfrom), mk_pte(from, PAGE_KERNEL), 0);
-	set_pte_ext(TOP_PTE(kto), mk_pte(to, PAGE_KERNEL), 0);
-
-	flush_tlb_kernel_page(kfrom);
-	flush_tlb_kernel_page(kto);
+	set_top_pte(kfrom, mk_pte(from, PAGE_KERNEL));
+	set_top_pte(kto, mk_pte(to, PAGE_KERNEL));
 
 	copy_page((void *)kto, (void *)kfrom);
 
@@ -119,8 +116,7 @@ static void v6_clear_user_highpage_aliasing(struct page *page, unsigned long vad
 	 */
 	raw_spin_lock(&v6_lock);
 
-	set_pte_ext(TOP_PTE(to), mk_pte(page, PAGE_KERNEL), 0);
-	flush_tlb_kernel_page(to);
+	set_top_pte(to, mk_pte(page, PAGE_KERNEL));
 	clear_page((void *)to);
 
 	raw_spin_unlock(&v6_lock);
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 2497dcf..804eedd 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -94,8 +94,7 @@ void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
 
 	raw_spin_lock(&minicache_lock);
 
-	set_pte_ext(TOP_PTE(COPYPAGE_MINICACHE), mk_pte(from, minicache_pgprot), 0);
-	flush_tlb_kernel_page(COPYPAGE_MINICACHE);
+	set_top_pte(COPYPAGE_MINICACHE, mk_pte(from, minicache_pgprot));
 
 	mc_copy_user_page((void *)COPYPAGE_MINICACHE, kto);
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index f4d407a..4d0b70f 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -28,8 +28,7 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 	unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
 	const int zero = 0;
 
-	set_pte_ext(TOP_PTE(to), pfn_pte(pfn, PAGE_KERNEL), 0);
-	flush_tlb_kernel_page(to);
+	set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
 
 	asm(	"mcrr	p15, 0, %1, %0, c14\n"
 	"	mcr	p15, 0, %2, c7, c10, 4"
@@ -40,13 +39,12 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 
 static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned long len)
 {
-	unsigned long colour = CACHE_COLOUR(vaddr);
+	unsigned long va = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) << PAGE_SHIFT);
 	unsigned long offset = vaddr & (PAGE_SIZE - 1);
 	unsigned long to;
 
-	set_pte_ext(TOP_PTE(FLUSH_ALIAS_START) + colour, pfn_pte(pfn, PAGE_KERNEL), 0);
-	to = FLUSH_ALIAS_START + (colour << PAGE_SHIFT) + offset;
-	flush_tlb_kernel_page(to);
+	set_top_pte(va, pfn_pte(pfn, PAGE_KERNEL));
+	to = va + offset;
 	flush_icache_range(to, to + len);
 }
 
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 807c057..3535251 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -71,13 +71,12 @@ void *__kmap_atomic(struct page *page)
 	 */
 	BUG_ON(!pte_none(*(TOP_PTE(vaddr))));
 #endif
-	set_pte_ext(TOP_PTE(vaddr), mk_pte(page, kmap_prot), 0);
 	/*
 	 * When debugging is off, kunmap_atomic leaves the previous mapping
-	 * in place, so this TLB flush ensures the TLB is updated with the
-	 * new mapping.
+	 * in place, so the contained TLB flush ensures the TLB is updated
+	 * with the new mapping.
 	 */
-	local_flush_tlb_kernel_page(vaddr);
+	set_top_pte(vaddr, mk_pte(page, kmap_prot));
 
 	return (void *)vaddr;
 }
@@ -96,8 +95,7 @@ void __kunmap_atomic(void *kvaddr)
 			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
 #ifdef CONFIG_DEBUG_HIGHMEM
 		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-		set_pte_ext(TOP_PTE(vaddr), __pte(0), 0);
-		local_flush_tlb_kernel_page(vaddr);
+		set_top_pte(vaddr, __pte(0));
 #else
 		(void) idx;  /* to kill a warning */
 #endif
@@ -123,8 +121,7 @@ void *kmap_atomic_pfn(unsigned long pfn)
 #ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(!pte_none(*(TOP_PTE(vaddr))));
 #endif
-	set_pte_ext(TOP_PTE(vaddr), pfn_pte(pfn, kmap_prot), 0);
-	local_flush_tlb_kernel_page(vaddr);
+	set_top_pte(vaddr, pfn_pte(pfn, kmap_prot));
 
 	return (void *)vaddr;
 }
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 6ee1ff2..a4e7feb 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -18,6 +18,12 @@ extern pmd_t *top_pmd;
 /* PFN alias flushing, for VIPT caches */
 #define FLUSH_ALIAS_START	0xffff4000
 
+static inline void set_top_pte(unsigned long va, pte_t pte)
+{
+	set_pte_ext(TOP_PTE(va), pte, 0);
+	local_flush_tlb_kernel_page(va);
+}
+
 static inline pmd_t *pmd_off_k(unsigned long virt)
 {
 	return pmd_offset(pud_offset(pgd_offset_k(virt), virt), virt);
-- 
1.7.4.4
