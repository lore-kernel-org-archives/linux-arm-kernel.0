From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 15:57:15 +0800
Subject: [PATCH 4/7] Store huge page linux pte in mm_struct
In-Reply-To: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1327910238-18704-5-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bill Carson <bill4carson@gmail.com>

One easy way to store huge page linux pte is mm_struct instead of thread_info
that's because when parent task with huge page VMA calls fork, parent huge page
pagetable entries are copied into child pagetable. This is done in

int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
			    struct vm_area_struct *vma)

We cannot derive child's thread_info just using struct mm_struct *dst.
if we have struct mm_struct **dst, then it's easy to find the corresponding
task_struct as well as thread_info, but we only get struct mm_struct *dst.
It's possible to find the desired task_struct by iterating the global task list
by comparing task_struct->mm with dst.
So mm_struct is used for huge page linux pte for faster lookup and efficient.

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/mm/pgd.c        |   28 ++++++++++++++++++++++++++++
 include/linux/mm_types.h |   11 +++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index a3e78cc..b04a69a 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -91,6 +91,14 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		pte_unmap(new_pte);
 	}
 
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+	/* reset the hugepage linux pte pointer
+	 * for new mm_struct when we do the fork
+	 */
+	mm->huge_2m_pte[HUGE_2M_PTE_1ST_ARRAY] = 0;
+	mm->huge_2m_pte[HUGE_2M_PTE_2ND_ARRAY] = 0;
+	mm->huge_16m_pte   = 0;
+#endif
 	return new_pgd;
 
 no_pte:
@@ -103,6 +111,25 @@ no_pgd:
 	return NULL;
 }
 
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+static void free_huge_linuxpte(struct mm_struct *mm)
+{
+	pte_t **huge_linuxpte = &mm->huge_2m_pte[0];
+	int i;
+
+	for (i = 0; i < HUGE_2M_PTE_SIZE; i++)
+		if (huge_linuxpte[i] != 0)
+			free_page((unsigned long)huge_linuxpte[i]);
+
+	if (mm->huge_16m_pte != NULL)
+		kfree(mm->huge_16m_pte);
+}
+#else
+static void free_huge_linuxpte(struct mm_struct *mm)
+{
+}
+#endif
+
 void pgd_free(struct mm_struct *mm, pgd_t *pgd_base)
 {
 	pgd_t *pgd;
@@ -135,6 +162,7 @@ no_pud:
 	pgd_clear(pgd);
 	pud_free(mm, pud);
 no_pgd:
+	free_huge_linuxpte(mm);
 #ifdef CONFIG_ARM_LPAE
 	/*
 	 * Free modules/pkmap or identity pmd tables.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3cc3062..88f76e6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -23,6 +23,11 @@
 struct address_space;
 
 #define USE_SPLIT_PTLOCKS	(NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+#define HUGE_2M_PTE_SIZE      2
+#define HUGE_2M_PTE_1ST_ARRAY 0
+#define HUGE_2M_PTE_2ND_ARRAY 1
+#endif
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -388,6 +393,12 @@ struct mm_struct {
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	struct cpumask cpumask_allocation;
 #endif
+
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+	/* we place hugepage linux pte at mm_struct  */
+	pte_t *huge_2m_pte[HUGE_2M_PTE_SIZE];
+	pte_t *huge_16m_pte;
+#endif
 };
 
 static inline void mm_init_cpumask(struct mm_struct *mm)
-- 
1.7.1
