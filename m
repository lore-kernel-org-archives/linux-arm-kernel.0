From: gdavis@mvista.com (gdavis at mvista.com)
Date: Thu,  6 Oct 2011 01:08:29 -0400
Subject: [RFC/PATCH 2/7] ARM: ARM11 MPCore: pte_alloc_one{,
	_kernel} are not preempt safe
In-Reply-To: <1317877714-11355-1-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
Message-ID: <1317877714-11355-3-git-send-email-gdavis@mvista.com>
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
 arch/arm/include/asm/pgalloc.h |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 22de005..cc2ac8b 100644
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
+			get_cpu();
+		memset(pte, 0, PAGE_SIZE);
 		clean_pte_table(pte);
+		if (cache_ops_need_broadcast())
+			put_cpu();
+	}
 
 	return pte;
 }
@@ -81,8 +88,14 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 	pte = alloc_pages(PGALLOC_GFP, 0);
 #endif
 	if (pte) {
+		void *p = page_address(pte);
+		if (cache_ops_need_broadcast())
+			get_cpu();
+		memset(p, 0, PAGE_SIZE);
 		if (!PageHighMem(pte))
-			clean_pte_table(page_address(pte));
+			clean_pte_table(p);
+		if (cache_ops_need_broadcast())
+			put_cpu();
 		pgtable_page_ctor(pte);
 	}
 
-- 
1.7.4.4
