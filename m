From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 23 Sep 2013 15:15:42 +0100
Subject: [RESEND RFC V2] ARM: mm: make UACCESS_WITH_MEMCPY huge page aware
Message-ID: <1379945742-9457-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resending, as I ommitted a few important CC's.

---

The memory pinning code in uaccess_with_memcpy.c does not check
for HugeTLB or THP pmds, and will enter an infinite loop should
a __copy_to_user or __clear_user occur against a huge page.

This patch adds detection code for huge pages to pin_page_for_write.
As this code can be executed in a fast path it refers to the actual
pmds rather than the vma. If a HugeTLB or THP is found (they have
the same pmd representation on ARM), the page table spinlock is
taken to prevent modification whilst the page is pinned.

On ARM, huge pages are only represented as pmds, thus no huge pud
checks are performed. (For huge puds one would lock the page table
in a similar manner as in the pmd case).

Two helper functions are introduced; pmd_thp_or_huge will check
whether or not a page is huge or transparent huge (which have the
same pmd layout on ARM), and pmd_hugewillfault will detect whether
or not a page fault will occur on write to the page.

Changes since first RFC:
   * The page mask is widened for hugepages to reduce the number
     of potential locks/unlocks.
     (A knobbled /dev/zero with its latency reduction chunks
      removed shows a 2x data rate boost with hugepages backing:
      dd if=/dev/zero of=/dev/null bs=10M count=1024 )

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable-3level.h |  3 ++
 arch/arm/lib/uaccess_with_memcpy.c    | 57 ++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 5689c18..39c54cf 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -206,6 +206,9 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
 
+#define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
+#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 025f742..78756db 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -18,11 +18,13 @@
 #include <linux/hardirq.h> /* for in_atomic() */
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 #include <asm/current.h>
 #include <asm/page.h>
 
 static int
-pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
+pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp,
+			unsigned long *page_mask)
 {
 	unsigned long addr = (unsigned long)_addr;
 	pgd_t *pgd;
@@ -40,7 +42,36 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
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
+		if (unlikely(!pmd_thp_or_huge(*pmd)
+			|| pmd_hugewillfault(*pmd)
+			|| pmd_trans_splitting(*pmd))) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
+		*ptep = NULL;
+		*ptlp = ptl;
+		*page_mask = HPAGE_MASK;
+		return 1;
+	}
+
+	if (unlikely(pmd_bad(*pmd)))
 		return 0;
 
 	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
@@ -52,6 +83,7 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 
 	*ptep = pte;
 	*ptlp = ptl;
+	*page_mask = PAGE_MASK;
 
 	return 1;
 }
@@ -60,6 +92,7 @@ static unsigned long noinline
 __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 {
 	int atomic;
+	unsigned long page_mask;
 
 	if (unlikely(segment_eq(get_fs(), KERNEL_DS))) {
 		memcpy((void *)to, from, n);
@@ -76,7 +109,7 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 		spinlock_t *ptl;
 		int tocopy;
 
-		while (!pin_page_for_write(to, &pte, &ptl)) {
+		while (!pin_page_for_write(to, &pte, &ptl, &page_mask)) {
 			if (!atomic)
 				up_read(&current->mm->mmap_sem);
 			if (__put_user(0, (char __user *)to))
@@ -85,7 +118,7 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
 				down_read(&current->mm->mmap_sem);
 		}
 
-		tocopy = (~(unsigned long)to & ~PAGE_MASK) + 1;
+		tocopy = (~(unsigned long)to & ~page_mask) + 1;
 		if (tocopy > n)
 			tocopy = n;
 
@@ -94,7 +127,10 @@ __copy_to_user_memcpy(void __user *to, const void *from, unsigned long n)
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
@@ -121,6 +157,8 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 static unsigned long noinline
 __clear_user_memset(void __user *addr, unsigned long n)
 {
+	unsigned long page_mask;
+
 	if (unlikely(segment_eq(get_fs(), KERNEL_DS))) {
 		memset((void *)addr, 0, n);
 		return 0;
@@ -132,14 +170,14 @@ __clear_user_memset(void __user *addr, unsigned long n)
 		spinlock_t *ptl;
 		int tocopy;
 
-		while (!pin_page_for_write(addr, &pte, &ptl)) {
+		while (!pin_page_for_write(addr, &pte, &ptl, &page_mask)) {
 			up_read(&current->mm->mmap_sem);
 			if (__put_user(0, (char __user *)addr))
 				goto out;
 			down_read(&current->mm->mmap_sem);
 		}
 
-		tocopy = (~(unsigned long)addr & ~PAGE_MASK) + 1;
+		tocopy = (~(unsigned long)addr & ~page_mask) + 1;
 		if (tocopy > n)
 			tocopy = n;
 
@@ -147,7 +185,10 @@ __clear_user_memset(void __user *addr, unsigned long n)
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
1.8.1.4
