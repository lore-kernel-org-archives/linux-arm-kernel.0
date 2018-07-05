From: alex@ghiti.fr (Alexandre Ghiti)
Date: Thu,  5 Jul 2018 05:12:32 +0000
Subject: [PATCH v2 01/11] hugetlb: Harmonize hugetlb.h arch specific defines
 with pgtable.h
In-Reply-To: <20180705050323.301-1-alex@ghiti.fr>
References: <20180705050323.301-1-alex@ghiti.fr>
Message-ID: <20180705051242.694-1-alex@ghiti.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm-generic/hugetlb.h proposes generic implementations of hugetlb
related functions: use __HAVE_ARCH_HUGE* defines in order to make arch
specific implementations of hugetlb functions consistent with pgtable.h
scheme.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/arm64/include/asm/hugetlb.h | 2 +-
 include/asm-generic/hugetlb.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index e73f68569624..3fcf14663dfa 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -81,9 +81,9 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
 extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep);
+#define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
-#define huge_pte_clear huge_pte_clear
 extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, unsigned long sz);
 #define set_huge_swap_pte_at set_huge_swap_pte_at
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 9d0cde8ab716..3da7cff52360 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -32,7 +32,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
-#ifndef huge_pte_clear
+#ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, unsigned long sz)
 {
-- 
2.16.2
