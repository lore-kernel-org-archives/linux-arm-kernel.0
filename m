From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2018 18:16:58 +0200
Subject: [PATCH] hugetlb: fix ARM 3level page tables
Message-ID: <20181005161722.904274-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check for __HAVE_ARCH_HUGE_PTEP_GET comes before the definition,
leading to an extraneous definition of huge_ptep_get:

In file included from arch/arm/include/asm/hugetlb.h:28,
                 from include/linux/hugetlb.h:456,
                 from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:22:
arch/arm/include/asm/hugetlb-3level.h:33:21: error: redefinition of 'huge_ptep_get'
 static inline pte_t huge_ptep_get(pte_t *ptep)

Change the header file inclusions to be in the correct order for
this to work.

Fixes: bb1d18ffc7ae ("hugetlb: introduce generic version of huge_ptep_get")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/hugetlb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 3fcef21ff2c2..b67256c22b08 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -23,9 +23,8 @@
 #define _ASM_ARM_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
-
 #include <asm/hugetlb-3level.h>
+#include <asm-generic/hugetlb.h>
 
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr, unsigned long len)
-- 
2.18.0
