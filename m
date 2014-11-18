From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Tue, 18 Nov 2014 19:53:25 +0400
Subject: [PATCH RFC 3/3] ARM: reduce size of page table directory for short
 mode
In-Reply-To: <20141118165313.9958.1242.stgit@buzz>
References: <20141118165313.9958.1242.stgit@buzz>
Message-ID: <20141118165325.9958.84370.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Virtual memory above PAGE_OFFSET is covered by TTBR1 which always points
to swapper_pg_dir, thus size of the rest pgd tables might be reduced.
Of course idmap_pgd must be full 16k because it's used without split.
It seems nobody accesses pgd entries above PAGE_OFFSET via pgd_offset(),
all access is done via pgd_offset_k() which refers directly to init_mm.

This patch saves 8k per process for 2G/2G split (12k for 1G/3G split)
and kills source of frequent order-2 allocations. Unfortunately most
commonly used 3G/1G mode isn't supported, because first part must be
power of two. LPAE supports this mode, but it's pgd is already tiny.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 arch/arm/mm/idmap.c |    6 ++++++
 arch/arm/mm/pgd.c   |   14 +++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index cc51b40..cea7ee1 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -100,7 +100,13 @@ extern char  __idmap_text_start[], __idmap_text_end[];
 
 static int __init init_static_idmap(void)
 {
+#ifdef CONFIG_ARM_LPAE
 	idmap_pgd = pgd_alloc(&init_mm);
+#else
+	idmap_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, 2);
+	if (idmap_pgd)
+		memcpy(idmap_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
+#endif
 	if (!idmap_pgd)
 		return -ENOMEM;
 
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index 2493795..3fbcb5a 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -20,15 +20,19 @@
 #include "mm.h"
 
 #ifdef CONFIG_ARM_LPAE
+#define TTBR0_PTRS_PER_PGD	PTRS_PER_PGD
 #define __pgd_alloc()	kmalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL)
 #define __pgd_free(pgd)	kfree(pgd)
 #else
-#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_REPEAT, 2)
-#define __pgd_free(pgd)	free_pages((unsigned long)pgd, 2)
+#define TTBR0_PTRS_PER_PGD	(PTRS_PER_PGD >> TTBR1_SIZE)
+#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_REPEAT, \
+							2 - TTBR1_SIZE)
+#define __pgd_free(pgd)	free_pages((unsigned long)pgd, 2 - TTBR1_SIZE)
 #endif
 
 /*
- * need to get a 16k page for level 1
+ * We need 4k/8k/16k for pgd in short mode for CONFIG_VMSPLIT_1G/2G/3G
+ * or only 64 bytes if LPAE is enabled.
  */
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
@@ -48,9 +52,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	 */
 	init_pgd = pgd_offset_k(0);
 	memcpy(new_pgd + USER_PTRS_PER_PGD, init_pgd + USER_PTRS_PER_PGD,
-		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+		(TTBR0_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 
-	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
+	clean_dcache_area(new_pgd, TTBR0_PTRS_PER_PGD * sizeof(pgd_t));
 
 #ifdef CONFIG_ARM_LPAE
 	/*
