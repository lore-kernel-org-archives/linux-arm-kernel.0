From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:36:03 +0000
Subject: [PATCH 4/5] ARM: pgtable: provide get_top_pte() to complement
 set_top_pte()
In-Reply-To: <20120120103433.GF1068@n2100.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBpD-0005og-Hf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide get_top_pte() to complement set_top_pte(), moving the only
users of TOP_PTE to arch/arm/mm/mm.h.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/highmem.c |    8 +++-----
 arch/arm/mm/mm.h      |    5 +++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 3535251..3a9e8aa 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -69,7 +69,7 @@ void *__kmap_atomic(struct page *page)
 	 * With debugging enabled, kunmap_atomic forces that entry to 0.
 	 * Make sure it was indeed properly unmapped.
 	 */
-	BUG_ON(!pte_none(*(TOP_PTE(vaddr))));
+	BUG_ON(!pte_none(get_top_pte(vaddr)));
 #endif
 	/*
 	 * When debugging is off, kunmap_atomic leaves the previous mapping
@@ -119,7 +119,7 @@ void *kmap_atomic_pfn(unsigned long pfn)
 	idx = type + KM_TYPE_NR * smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(TOP_PTE(vaddr))));
+	BUG_ON(!pte_none(get_top_pte(vaddr)));
 #endif
 	set_top_pte(vaddr, pfn_pte(pfn, kmap_prot));
 
@@ -129,11 +129,9 @@ void *kmap_atomic_pfn(unsigned long pfn)
 struct page *kmap_atomic_to_page(const void *ptr)
 {
 	unsigned long vaddr = (unsigned long)ptr;
-	pte_t *pte;
 
 	if (vaddr < FIXADDR_START)
 		return virt_to_page(ptr);
 
-	pte = TOP_PTE(vaddr);
-	return pte_page(*pte);
+	return pte_page(get_top_pte(vaddr));
 }
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index a4e7feb..1651d5a 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -24,6 +24,11 @@ static inline void set_top_pte(unsigned long va, pte_t pte)
 	local_flush_tlb_kernel_page(va);
 }
 
+static inline pte_t get_top_pte(unsigned long va)
+{
+	return *TOP_PTE(va);
+}
+
 static inline pmd_t *pmd_off_k(unsigned long virt)
 {
 	return pmd_offset(pud_offset(pgd_offset_k(virt), virt), virt);
-- 
1.7.4.4
