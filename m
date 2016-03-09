From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 9 Mar 2016 10:32:48 +0530
Subject: [PATCH] arm64: Fix the ptep_set_wrprotect() to set PTE_DIRTY if
 (PTE_DBM && !PTE_RDONLY)
Message-ID: <1457499768-31176-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2f4b829c625e ("arm64: Add support for hardware updates of the
access and dirty pte bits") introduced support for handling hardware
updates of the access flag and dirty status.

ptep_set_wrprotect is setting PTR_DIRTY if !PTE_RDONLY,
however by design it suppose to set PTE_DIRTY
only if (PTE_DBM && !PTE_RDONLY). This patch addes code to
test and set accordingly.

This patch fixes BUG,
kernel BUG at /build/linux-StrpB2/linux-4.4.0/fs/ext4/inode.c:2394!
Internal error: Oops - BUG: 0 [#1] SMP

on thunderx numa board, when ARM64_HW_AFDBM and NUMA_BALANCING are enabled.

note: this patch is not tested on platform which supports AFDBM.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 arch/arm64/include/asm/pgtable.h | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f506086..d396892 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -613,20 +613,24 @@ static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
-	pteval_t pteval;
+	pteval_t pteval, pteval2;
 	unsigned long tmp;
 
 	asm volatile("//	ptep_set_wrprotect\n"
-	"	prfm	pstl1strm, %2\n"
-	"1:	ldxr	%0, %2\n"
-	"	tst	%0, %4			// check for hw dirty (!PTE_RDONLY)\n"
-	"	csel	%1, %3, xzr, eq		// set PTE_DIRTY|PTE_RDONLY if dirty\n"
-	"	orr	%0, %0, %1		// if !dirty, PTE_RDONLY is already set\n"
-	"	and	%0, %0, %5		// clear PTE_WRITE/PTE_DBM\n"
-	"	stxr	%w1, %0, %2\n"
+	"	prfm	pstl1strm, %3\n"
+	"1:	ldxr	%0, %3\n"
+	"	and	%2, %0, %4		//extract bits PTE_WRITE and PTE_RDONLY\n"
+	"	cmp	%2, %5			// compare wth PTE_WRITE\n"
+	"	b.ne	2f\n"
+	"	orr	%0, %0, %8		// Set PTE_DIRTY if (PTE_DBM && !PTE_RDONLY)\n"
+	"2:	tst	%0, %6			// check for !PTE_RDONLY\n"
+	"	csel	%1, %6, xzr, eq		// select PTE_RDONLY if !PTE_RDONLY\n"
+	"	orr	%0, %0, %1		// set PTE_RDONLY if !PTE_RDONLY\n"
+	"	and	%0, %0, %7		// clear PTE_WRITE/PTE_DBM\n"
+	"	stxr	%w1, %0, %3\n"
 	"	cbnz	%w1, 1b\n"
-	: "=&r" (pteval), "=&r" (tmp), "+Q" (pte_val(*ptep))
-	: "r" (PTE_DIRTY|PTE_RDONLY), "L" (PTE_RDONLY), "L" (~PTE_WRITE)
+	: "=&r" (pteval), "=&r" (tmp), "=&r" (pteval2), "+Q" (pte_val(*ptep))
+	: "r" (PTE_WRITE|PTE_RDONLY), "r" (PTE_WRITE), "r" (PTE_RDONLY), "L" (~PTE_WRITE), "L" (PTE_DIRTY)
 	: "cc");
 }
 
-- 
1.8.1.4
