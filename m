From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 18 Oct 2011 09:47:29 -0400
Subject: [RFC/PATCH v4 2/7] ARM: ARM11 MPCore: pte_alloc_one{,
	_kernel} are not preempt safe
In-Reply-To: <1318945654-548-1-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
Message-ID: <1318945654-548-3-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

If preemption and subsequent task migration occurs during a call to
pte_alloc_one{,_kernel} on ARM11 MPCore machines, global memory state
can become inconsistent.  To prevent inconsistent memory state on
these machines, disable preemption around initialization and flushing
of new PTEs.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/include/asm/pgalloc.h |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 22de005..92d3f27 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/smp_plat.h>
 
 #define check_pgt_cache()		do { } while (0)
 
@@ -35,7 +36,7 @@
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO)
+#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT)
 
 static inline void clean_pte_table(pte_t *pte)
 {
@@ -64,8 +65,14 @@ pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 	pte_t *pte;
 
 	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
-	if (pte)
+	if (pte) {
+		if (cache_ops_need_broadcast())
+			preempt_disable();
+		memset(pte, 0, PAGE_SIZE);
 		clean_pte_table(pte);
+		if (cache_ops_need_broadcast())
+			preempt_enable();
+	}
 
 	return pte;
 }
@@ -76,13 +83,20 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 	struct page *pte;
 
 #ifdef CONFIG_HIGHPTE
-	pte = alloc_pages(PGALLOC_GFP | __GFP_HIGHMEM, 0);
+	pte = alloc_pages(PGALLOC_GFP | __GFP_ZERO | __GFP_HIGHMEM, 0);
 #else
 	pte = alloc_pages(PGALLOC_GFP, 0);
 #endif
 	if (pte) {
-		if (!PageHighMem(pte))
-			clean_pte_table(page_address(pte));
+		if (!PageHighMem(pte)) {
+			void *page = page_address(pte);
+			if (cache_ops_need_broadcast())
+				preempt_disable();
+			memset(page, 0, PAGE_SIZE);
+			clean_pte_table(page);
+			if (cache_ops_need_broadcast())
+				preempt_enable();
+		}
 		pgtable_page_ctor(pte);
 	}
 
-- 
1.7.4.4
