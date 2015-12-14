From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Dec 2015 11:40:23 +0000
Subject: [PATCH 2/2] arm64: mm: ensure visbility of page table zeroing
In-Reply-To: <1450093223-5117-1-git-send-email-mark.rutland@arm.com>
References: <20151211191031.GN18828@arm.com>
 <1450093223-5117-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1450093223-5117-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We allocate pages with PGALLOC_GFP, which implictly ensures that the
newly allocated tables are zeroed. However, we plumb the newly allocated
tables into (potentially live) tables without an intervening barrier,
and thus a concurrent page table walk may see stale data rather than the
zeroes written by the allocator.

Insert a dsb(ishst) in our run time page table allocators to ensure that
such zeroing is visible.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgalloc.h | 14 +++++++++++---
 arch/arm64/mm/pgd.c              | 10 ++++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index c150539..b91f6dd 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -21,6 +21,7 @@
 
 #include <asm/pgtable-hwdef.h>
 #include <asm/processor.h>
+#include <asm/barrier.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
@@ -33,7 +34,9 @@
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	pmd_t *pmd = (pmd_t *)__get_free_page(PGALLOC_GFP);
+	dsb(ishst);
+	return pmd;
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
@@ -53,7 +56,9 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pud_t *)__get_free_page(PGALLOC_GFP);
+	pud_t *pud = (pud_t *)__get_free_page(PGALLOC_GFP);
+	dsb(ishst);
+	return pud;
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -75,7 +80,9 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 {
-	return (pte_t *)__get_free_page(PGALLOC_GFP);
+	pte_t *pte = (pte_t *)__get_free_page(PGALLOC_GFP);
+	dsb(ishst);
+	return pte;
 }
 
 static inline pgtable_t
@@ -90,6 +97,7 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 		__free_page(pte);
 		return NULL;
 	}
+	dsb(ishst);
 	return pte;
 }
 
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index cb3ba1b..5420cf3 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -22,6 +22,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 
+#include <asm/barrier.h>
 #include <asm/pgalloc.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
@@ -32,10 +33,15 @@ static struct kmem_cache *pgd_cache;
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
+	pgd_t *pgd;
+
 	if (PGD_SIZE == PAGE_SIZE)
-		return (pgd_t *)__get_free_page(PGALLOC_GFP);
+		pgd = (pgd_t *)__get_free_page(PGALLOC_GFP);
 	else
-		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+		pgd = kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+
+	dsb(ishst);
+	return pgd;
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-- 
1.9.1
