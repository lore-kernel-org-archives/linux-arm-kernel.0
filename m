From: bill4carson@gmail.com (Bill Carson)
Date: Mon, 13 Feb 2012 17:44:25 +0800
Subject: [PATCH 4/7] Store huge page linux pte in mmu_context_t
In-Reply-To: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1329126268-11032-5-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/mmu.h |    4 ++++
 arch/arm/mm/pgd.c          |   11 +++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 1496565..579bf82 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -9,6 +9,10 @@ typedef struct {
 	raw_spinlock_t id_lock;
 #endif
 	unsigned int kvm_seq;
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+	/* we place hugepage linux pte at mm_struct.context  */
+	pte_t *huge_linux_pte;
+#endif
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index a3e78cc..895bb3f 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -91,6 +91,12 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 		pte_unmap(new_pte);
 	}
 
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+	/* reset the hugepage linux pte pointer
+	 * for new mm_struct when we do the fork
+	 */
+	mm->context.huge_linux_pte = NULL;
+#endif
 	return new_pgd;
 
 no_pte:
@@ -135,6 +141,11 @@ no_pud:
 	pgd_clear(pgd);
 	pud_free(mm, pud);
 no_pgd:
+#ifdef CONFIG_ARM_HUGETLB_SUPPORT
+	/* free huge linux pte table */
+	if (mm->context.huge_linux_pte != NULL)
+		kfree(mm->context.huge_linux_pte);
+#endif
 #ifdef CONFIG_ARM_LPAE
 	/*
 	 * Free modules/pkmap or identity pmd tables.
-- 
1.7.1
