From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 11:02:21 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704094531.GB19117@e102109-lin.cambridge.arm.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
Message-ID: <20110704100221.GB8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 10:45:32AM +0100, Catalin Marinas wrote:
> Given these results, I think it's worth merging the patch. Can I add
> your Tested-by?

If we're going to make this change to use the coherent information,
let's address all the places in one go, which are:

	clean_pmd_entry
	flush_pmd_entry
	clean_pte_table

These require a little more thought as we aren't guaranteed to have
ID_MMFR3 in place - maybe they should be callbacks into the per-CPU
code.

It would also be a good idea to change the comment from "flush_pte"
to "Clean data cache to PoU".

> I think there can be a few other optimisations in the TLB area but it
> needs some digging.

The single-TLB model works fairly well, but as I thought the lack of
mcr%? processing by GCC makes the asm/tlbflush.h code fairly disgusting
even for a v6+v7 kernel.  Luckily, we can play some tricks and sort
some of that out.  The patch below is not complete (and can result in
some rules of the architecture being violated - namely the requirement
for an ISB after the BTB flush without a branch between) but it
illustrates the idea:

 arch/arm/include/asm/tlbflush.h |  216 +++++++++++++++++----------------------
 1 files changed, 92 insertions(+), 124 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index d2005de..252874c 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -34,15 +34,15 @@
 #define TLB_V6_D_ASID	(1 << 17)
 #define TLB_V6_I_ASID	(1 << 18)
 
-#define TLB_BTB		(1 << 28)
-
 /* Unified Inner Shareable TLB operations (ARMv7 MP extensions) */
 #define TLB_V7_UIS_PAGE	(1 << 19)
 #define TLB_V7_UIS_FULL (1 << 20)
 #define TLB_V7_UIS_ASID (1 << 21)
 
 /* Inner Shareable BTB operation (ARMv7 MP extensions) */
-#define TLB_V7_IS_BTB	(1 << 22)
+#define TLB_V7_IS_BTB	(1 << 26)
+#define TLB_BTB		(1 << 27)
+#define TLB_BTB_BARRIER	(1 << 28)
 
 #define TLB_L2CLEAN_FR	(1 << 29)		/* Feroceon */
 #define TLB_DCLEAN	(1 << 30)
@@ -99,7 +99,7 @@
 # define v4_always_flags	(-1UL)
 #endif
 
-#define fa_tlb_flags	(TLB_WB | TLB_BTB | TLB_DCLEAN | \
+#define fa_tlb_flags	(TLB_WB | TLB_BTB_BARRIER | TLB_BTB | TLB_DCLEAN | \
 			 TLB_V4_U_FULL | TLB_V4_U_PAGE)
 
 #ifdef CONFIG_CPU_TLB_FA
@@ -166,7 +166,7 @@
 # define v4wb_always_flags	(-1UL)
 #endif
 
-#define v6wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
+#define v6wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB_BARRIER | TLB_BTB | \
 			 TLB_V6_I_FULL | TLB_V6_D_FULL | \
 			 TLB_V6_I_PAGE | TLB_V6_D_PAGE | \
 			 TLB_V6_I_ASID | TLB_V6_D_ASID)
@@ -184,10 +184,12 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
-#define v7wbi_tlb_flags_smp	(TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
-			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
-#define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BTB | \
-			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
+#define v7wbi_tlb_flags_smp	(TLB_WB | TLB_DCLEAN | \
+				 TLB_BTB_BARRIER | TLB_V7_IS_BTB | \
+			TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
+#define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | \
+				 TLB_BTB_BARRIER | TLB_BTB | \
+			TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
 
 #ifdef CONFIG_CPU_TLB_V7
 
@@ -322,6 +324,18 @@ extern struct cpu_tlb_fns cpu_tlb;
 
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
@@ -330,26 +344,19 @@ static inline void local_flush_tlb_all(void)
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
 
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+	/* flush the branch target cache */
+	tlb_op(TLB_BTB, "c7, c5, 6", zero);
+
+	/* flush the branch target cache */
+	tlb_op(TLB_V7_IS_BTB, "c7, c1, 6", zero);
+
+	if (tlb_flag(TLB_BTB_BARRIER)) {
 		dsb();
 		isb();
 	}
@@ -364,42 +371,32 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
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
 
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
-		dsb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+	/* flush the branch target cache */
+	tlb_op(TLB_BTB, "c7, c5, 6", zero);
+
+	/* flush the branch target cache */
+	tlb_op(TLB_V7_IS_BTB, "c7, c1, 6", zero);
+
+	if (tlb_flag(TLB_BTB_BARRIER))
 		dsb();
-		isb();
-	}
 }
 
 static inline void
@@ -413,43 +410,33 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
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
 
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
-		dsb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+	/* flush the branch target cache */
+	tlb_op(TLB_BTB, "c7, c5, 6", zero);
+
+	/* flush the branch target cache */
+	tlb_op(TLB_V7_IS_BTB, "c7, c1, 6", zero);
+
+	if (tlb_flag(TLB_BTB_BARRIER))
 		dsb();
-		isb();
-	}
 }
 
 static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
@@ -462,35 +449,25 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
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
-
-	if (tlb_flag(TLB_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero) : "cc");
-		dsb();
-		isb();
-	}
-	if (tlb_flag(TLB_V7_IS_BTB)) {
-		/* flush the branch target cache */
-		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero) : "cc");
+	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", kaddr);
+	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", kaddr);
+	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", kaddr);
+
+	/* flush the branch target cache */
+	tlb_op(TLB_BTB, "c7, c5, 6", zero);
+
+	/* flush the branch target cache */
+	tlb_op(TLB_V7_IS_BTB, "c7, c1, 6", zero);
+
+	if (tlb_flag(TLB_BTB_BARRIER)) {
 		dsb();
 		isb();
 	}
@@ -513,13 +490,8 @@ static inline void flush_pmd_entry(pmd_t *pmd)
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
@@ -529,15 +501,11 @@ static inline void clean_pmd_entry(pmd_t *pmd)
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
