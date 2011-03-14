From: prasadjoshi124@gmail.com (Prasad Joshi)
Date: Mon, 14 Mar 2011 17:29:41 +0000
Subject: [RFC][PATCH v2 02/23] (armho) __vmalloc: add gfp flags variant of pte
	and pmd allocation
Message-ID: <AANLkTikpM6RRNoT1nPk0Jws3SKff81wJRbJUnJAi3J=3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/arm/include/asm/pgalloc.h |   11 +++++++++--
1 files changed, 9 insertions(+), 2 deletions(-)
---
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 22de005..0696068 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -28,6 +28,7 @@
 /*
  * Since we have only two-level page tables, these are trivial
  */
+#define __pmd_alloc_one(mm,addr,mask)	({ BUG(); ((pmd_t *)2); })
 #define pmd_alloc_one(mm,addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(mm, pmd)		do { } while (0)
 #define pgd_populate(mm,pmd,pte)	BUG()
@@ -59,17 +60,23 @@ static inline void clean_pte_table(pte_t *pte)
  *  +------------+
  */
 static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr,
gfp_t gfp_mask)
 {
 	pte_t *pte;

-	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
+	pte = (pte_t *)__get_free_page(gfp_mask | __GFP_NOTRACK | __GFP_ZERO);
 	if (pte)
 		clean_pte_table(pte);

 	return pte;
 }

+static inline pte_t *
+pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
+{
+	return __pte_alloc_one_kernel(mm, addr, GFP_KERNEL | __GFP_REPEAT);
+}
+
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
