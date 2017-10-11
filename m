From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:24 +0800
Subject: [PATCH 08/11] Add support arm LPAE
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-9-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  On arm LPAE architecture,  the mapping table of KASan shadow memory(if
PAGE_OFFSET is 0xc0000000, the KASan shadow memory's virtual space is
0xb6e000000~0xbf000000) can't be filled in do_translation_fault function,
because kasan instrumentation maybe cause do_translation_fault function
accessing KASan shadow memory. The accessing of KASan shadow memory in
do_translation_fault function maybe cause dead circle. So the mapping table
of KASan shadow memory need be copyed in pgd_alloc function.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/mm/pgd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index c1c1a5c..4f73978 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -64,6 +64,18 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	new_pmd = pmd_alloc(mm, new_pud, 0);
 	if (!new_pmd)
 		goto no_pmd;
+#ifdef CONFIG_KASAN
+	/*
+	 *Copy PMD table for KASAN shadow mappings.
+	 */
+	init_pgd = pgd_offset_k(TASK_SIZE); 
+	init_pud = pud_offset(init_pgd, TASK_SIZE);
+	init_pmd = pmd_offset(init_pud, TASK_SIZE);
+	new_pmd = pmd_offset(new_pud,TASK_SIZE);
+	memcpy(new_pmd, init_pmd, (pmd_index(MODULES_VADDR)-pmd_index(TASK_SIZE)) * sizeof(pmd_t));
+	clean_dcache_area(new_pmd,PTRS_PER_PMD*sizeof(pmd_t));
+#endif
+
 #endif
 
 	if (!vectors_high()) {
-- 
2.9.0
