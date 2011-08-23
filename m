From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 12:06:02 +0100
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
Message-ID: <20110823110602.GG19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compiler does not conditionalize the assembly instructions for
the tlb operations, which leads to sub-optimal code being generated
when building a kernel for multiple CPUs.

We can tweak things fairly simply as the code fragment below shows:

    17f8:       e3120001        tst     r2, #1  ; 0x1
...
    1800:       0a000000        beq     1808 <handle_pte_fault+0x194>
    1804:       ee061f10        mcr     15, 0, r1, cr6, cr0, {0}
    1808:       e3120004        tst     r2, #4  ; 0x4
    180c:       0a000000        beq     1814 <handle_pte_fault+0x1a0>
    1810:       ee081f36        mcr     15, 0, r1, cr8, cr6, {1}
becomes:
    17f0:       e3120001        tst     r2, #1  ; 0x1
    17f4:       1e063f10        mcrne   15, 0, r3, cr6, cr0, {0}
    17f8:       e3120004        tst     r2, #4  ; 0x4
    17fc:       1e083f36        mcrne   15, 0, r3, cr8, cr6, {1}

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/tlbflush.h |  128 ++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 76 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index d2005de..252874c 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -318,6 +318,18 @@ extern struct cpu_tlb_fns cpu_tlb;
 
 #define tlb_flag(f)	((always_tlb_flags & (f)) || (__tlb_flag & possible_tlb_flags & (f)))
 
+#define tlb_op(f, regs, arg)						\
+	do {								\
+		if (always_tlb_flags & (f))				\
+			asm("mcr p15, 0, %0, " regs			\
+			    : : "r" (arg) : "cc");			\
+		else if (possible_tlb_flags & (f))			\
+			asm("tst %1, %2\n\t"				\
+			    "mcrne p15, 0, %0, " regs			\
+			    : : "r" (arg), "r" (__tlb_flag), "Ir" (f)	\
+			    : "cc");					\
+	} while (0)
+
 static inline void local_flush_tlb_all(void)
 {
 	const int zero = 0;
@@ -326,16 +338,11 @@ static inline void local_flush_tlb_all(void)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (tlb_flag(TLB_V3_FULL))
-		asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V4_U_FULL | TLB_V6_U_FULL))
-		asm("mcr p15, 0, %0, c8, c7, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V4_D_FULL | TLB_V6_D_FULL))
-		asm("mcr p15, 0, %0, c8, c6, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V4_I_FULL | TLB_V6_I_FULL))
-		asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
-	if (tlb_flag(TLB_V7_UIS_FULL))
-		asm("mcr p15, 0, %0, c8, c3, 0" : : "r" (zero) : "cc");
+	tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
+	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
+	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
+	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
+	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
 		dsb();
@@ -352,29 +359,22 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
-		if (tlb_flag(TLB_V3_FULL))
-			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
-		if (tlb_flag(TLB_V4_U_FULL))
-			asm("mcr p15, 0, %0, c8, c7, 0" : : "r" (zero) : "cc");
-		if (tlb_flag(TLB_V4_D_FULL))
-			asm("mcr p15, 0, %0, c8, c6, 0" : : "r" (zero) : "cc");
-		if (tlb_flag(TLB_V4_I_FULL))
-			asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
+	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL) &&
+	    cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
+		tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
+		tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
+		tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
+		tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
 	}
 	put_cpu();
 
-	if (tlb_flag(TLB_V6_U_ASID))
-		asm("mcr p15, 0, %0, c8, c7, 2" : : "r" (asid) : "cc");
-	if (tlb_flag(TLB_V6_D_ASID))
-		asm("mcr p15, 0, %0, c8, c6, 2" : : "r" (asid) : "cc");
-	if (tlb_flag(TLB_V6_I_ASID))
-		asm("mcr p15, 0, %0, c8, c5, 2" : : "r" (asid) : "cc");
-	if (tlb_flag(TLB_V7_UIS_ASID))
+	tlb_op(TLB_V6_U_ASID, "c8, c7, 2", asid);
+	tlb_op(TLB_V6_D_ASID, "c8, c6, 2", asid);
+	tlb_op(TLB_V6_I_ASID, "c8, c5, 2", asid);
 #ifdef CONFIG_ARM_ERRATA_720789
-		asm("mcr p15, 0, %0, c8, c3, 0" : : "r" (zero) : "cc");
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", zero);
 #else
-		asm("mcr p15, 0, %0, c8, c3, 2" : : "r" (asid) : "cc");
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", asid);
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
@@ -392,30 +392,23 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-		if (tlb_flag(TLB_V3_PAGE))
-			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (uaddr) : "cc");
-		if (tlb_flag(TLB_V4_U_PAGE))
-			asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (uaddr) : "cc");
-		if (tlb_flag(TLB_V4_D_PAGE))
-			asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (uaddr) : "cc");
-		if (tlb_flag(TLB_V4_I_PAGE))
-			asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (uaddr) : "cc");
+	if (possible_tlb_flags & (TLB_V3_PAGE|TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
+	    cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+		tlb_op(TLB_V3_PAGE, "c6, c0, 0", uaddr);
+		tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", uaddr);
+		tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", uaddr);
+		tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", uaddr);
 		if (!tlb_flag(TLB_V4_I_PAGE) && tlb_flag(TLB_V4_I_FULL))
 			asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
 	}
 
-	if (tlb_flag(TLB_V6_U_PAGE))
-		asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (uaddr) : "cc");
-	if (tlb_flag(TLB_V6_D_PAGE))
-		asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (uaddr) : "cc");
-	if (tlb_flag(TLB_V6_I_PAGE))
-		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (uaddr) : "cc");
-	if (tlb_flag(TLB_V7_UIS_PAGE))
+	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", uaddr);
+	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", uaddr);
+	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", uaddr);
 #ifdef CONFIG_ARM_ERRATA_720789
-		asm("mcr p15, 0, %0, c8, c3, 3" : : "r" (uaddr & PAGE_MASK) : "cc");
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 3", uaddr & PAGE_MASK);
 #else
-		asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (uaddr) : "cc");
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", uaddr);
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
@@ -432,25 +425,17 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (tlb_flag(TLB_V3_PAGE))
-		asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V4_U_PAGE))
-		asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V4_D_PAGE))
-		asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V4_I_PAGE))
-		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (kaddr) : "cc");
+	tlb_op(TLB_V3_PAGE, "c6, c0, 0", kaddr);
+	tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", kaddr);
+	tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", kaddr);
+	tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", kaddr);
 	if (!tlb_flag(TLB_V4_I_PAGE) && tlb_flag(TLB_V4_I_FULL))
 		asm("mcr p15, 0, %0, c8, c5, 0" : : "r" (zero) : "cc");
 
-	if (tlb_flag(TLB_V6_U_PAGE))
-		asm("mcr p15, 0, %0, c8, c7, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V6_D_PAGE))
-		asm("mcr p15, 0, %0, c8, c6, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V6_I_PAGE))
-		asm("mcr p15, 0, %0, c8, c5, 1" : : "r" (kaddr) : "cc");
-	if (tlb_flag(TLB_V7_UIS_PAGE))
-		asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (kaddr) : "cc");
+	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", kaddr);
+	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", kaddr);
+	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", kaddr);
 
 	if (tlb_flag(TLB_BARRIER)) {
 		dsb();
@@ -475,13 +460,8 @@ static inline void flush_pmd_entry(pmd_t *pmd)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	if (tlb_flag(TLB_DCLEAN))
-		asm("mcr	p15, 0, %0, c7, c10, 1	@ flush_pmd"
-			: : "r" (pmd) : "cc");
-
-	if (tlb_flag(TLB_L2CLEAN_FR))
-		asm("mcr	p15, 1, %0, c15, c9, 1  @ L2 flush_pmd"
-			: : "r" (pmd) : "cc");
+	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
+	tlb_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 
 	if (tlb_flag(TLB_WB))
 		dsb();
@@ -491,15 +471,11 @@ static inline void clean_pmd_entry(pmd_t *pmd)
 {
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	if (tlb_flag(TLB_DCLEAN))
-		asm("mcr	p15, 0, %0, c7, c10, 1	@ flush_pmd"
-			: : "r" (pmd) : "cc");
-
-	if (tlb_flag(TLB_L2CLEAN_FR))
-		asm("mcr	p15, 1, %0, c15, c9, 1  @ L2 flush_pmd"
-			: : "r" (pmd) : "cc");
+	tlb_op(TLB_DCLEAN, "c7, c10, 1	@ flush_pmd", pmd);
+	tlb_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 }
 
+#undef tlb_op
 #undef tlb_flag
 #undef always_tlb_flags
 #undef possible_tlb_flags
