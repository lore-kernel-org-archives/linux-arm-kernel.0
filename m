From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 12 Mar 2014 13:40:23 +0000
Subject: [RFC PATCH V3 6/6] arm64: mm: Activate get_user_pages_fast for arm64
In-Reply-To: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1394631623-17883-7-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The get_user_pages fast implementation in arch/arm is valid for arm64
too. This patch references get_user_pages_fast from arch/arm, rather
than duplicate the code.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/include/asm/pgtable.h | 6 ++++++
 arch/arm64/mm/Makefile           | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa3917c..d5ae326 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -242,9 +242,15 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		(!(pmd_val(pmd) & PMD_SECT_RDONLY))
 
+#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
+#define __HAVE_ARCH_PMDP_SPLITTING_FLUSH
+struct vm_area_struct;
+void pmdp_splitting_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp);
 #endif
 
 #define PMD_BIT_FUNC(fn,op) \
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index b51d364..212f229 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -1,5 +1,7 @@
+ARM=../../../arch/arm/mm
+
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
-				   context.o tlb.o proc.o
+				   context.o tlb.o proc.o $(ARM)/gup.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
-- 
1.8.1.4
