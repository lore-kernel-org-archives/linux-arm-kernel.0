From: steve.capper@arm.com (Steve Capper)
Date: Tue, 12 Mar 2013 08:14:51 +0000
Subject: [RFC PATCH] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware.
Message-ID: <1363076091-24476-1-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory pinning code in uaccess_with_memcpy.c does not check
for HugeTLB or THP pages, and will enter an infinite loop should
a __copy_to_user or __clear_user occur against a huge page.

This patch adds detection code for huge pages to pin_page_for_write.
As this code can be executed in a fast path it refers to the actual
pmds rather than the vma. It also takes advantage of the fact that
HugeTLB and THP pages have the same pmd layout on ARM.

Two helper functions are introduced; pmd_thp_or_huge will check
whether or not a page is huge or transparent huge (which have the
same pmd layout on ARM), and pmd_hugewillfault will detect whether
or not a page fault will occur on write to the page.

This patch is to be applied on top of the set at:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148451.html

I would really welcome comments/discussion on this.

Reported-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |    6 +++++
 arch/arm/include/asm/pgtable-3level.h |    3 +++
 arch/arm/lib/uaccess_with_memcpy.c    |   40 ++++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index e3b5ec2..2338ed5 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -282,8 +282,14 @@ PMD_BIT_FUNC(mknexec,	|= PMD_SECT_XN);
 	pmdret;									\
 })
 
+#define pmd_hugewillfault(pmd) (	!pmd_young(pmd) ||	\
+					!pmd_write(pmd) ||	\
+					!pmd_dirty(pmd) )
+#define pmd_thp_or_huge(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
 #else
 #define HPAGE_SIZE 0
+#define pmd_hugewillfault(pmd)	(0)
+#define pmd_thp_or_huge(pmd)	(0)
 #endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index d5ceb22..65bf7b4 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -189,6 +189,9 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
 
+#define pmd_hugewillfault(pmd) ( !pmd_young(pmd) || !pmd_write(pmd) )
+#define pmd_thp_or_huge(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT)
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 025f742..ae9fde2 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -40,7 +40,35 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 		return 0;
 
 	pmd = pmd_offset(pud, addr);
-	if (unlikely(pmd_none(*pmd) || pmd_bad(*pmd)))
+	if (unlikely(pmd_none(*pmd)))
+		return 0;
+
+	/*
+	 * A pmd can be bad if it refers to a HugeTLB or THP page.
+	 *
+	 * Both THP and HugeTLB pages have the same pmd layout
+	 * and should not be manipulated by the pte functions.
+	 * 
+	 * Lock the page table for the destination and check
+	 * to see that it's still huge and whether or not we will
+	 * need to fault on write, or if we have a splitting THP.
+	 */
+	if (unlikely(pmd_thp_or_huge(*pmd))) {
+		ptl = &current->mm->page_table_lock;
+		spin_lock(ptl);
+		if (unlikely( !pmd_thp_or_huge(*pmd)
+			|| pmd_hugewillfault(*pmd)
+			|| pmd_trans_splitting(*pmd))) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
+		*ptep = NULL;
+		*ptlp = ptl;
+		return 1;
+	}
+
+	if (unlikely(pmd_bad(*pmd)))
 		return 0;
 
 	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
@@ -94,7 +122,10 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 		from += tocopy;
 		n -= tocopy;
 
-		pte_unmap_unlock(pte, ptl);
+		if (pte)
+			pte_unmap_unlock(pte, ptl);
+		else
+			spin_unlock(ptl);
 	}
 	if (!atomic)
 		up_read(&current->mm->mmap_sem);
@@ -147,7 +178,10 @@ __clear_user_memset(void __user *addr, unsigned long n)
 		addr += tocopy;
 		n -= tocopy;
 
-		pte_unmap_unlock(pte, ptl);
+		if (pte)
+			pte_unmap_unlock(pte, ptl);
+		else
+			spin_unlock(ptl);
 	}
 	up_read(&current->mm->mmap_sem);
 
-- 
1.7.9.5
