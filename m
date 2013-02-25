From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:21:27 +0000
Subject: [PATCH 1/2] ARM: tlb: add branch predictor maintenance operations
Message-ID: <1361805688-8886-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architecture requires explicit branch predictor maintenance
when updating an instruction stream for a given virtual address. In
reality, this isn't so much of a burden because the branch predictor
is flushed during the cache maintenance required to make the new
instructions visible to the I-side of the processor.

However, there are still some cases where explicit flushing is required,
so add a local_bp_flush_all operation to deal with this.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

I can't make my mind up about whether or not this go to -stable... on
the one hand it *is* part of a bug fix but, then again, it's not
something that's knowingly caused any problems so far.

 arch/arm/include/asm/tlbflush.h | 34 ++++++++++++++++++++++++++++------
 arch/arm/kernel/smp_tlb.c       | 12 ++++++++++++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 6e924d3..4db8c88 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -34,10 +34,13 @@
 #define TLB_V6_D_ASID	(1 << 17)
 #define TLB_V6_I_ASID	(1 << 18)
 
+#define TLB_V6_BP	(1 << 19)
+
 /* Unified Inner Shareable TLB operations (ARMv7 MP extensions) */
-#define TLB_V7_UIS_PAGE	(1 << 19)
-#define TLB_V7_UIS_FULL (1 << 20)
-#define TLB_V7_UIS_ASID (1 << 21)
+#define TLB_V7_UIS_PAGE	(1 << 20)
+#define TLB_V7_UIS_FULL (1 << 21)
+#define TLB_V7_UIS_ASID (1 << 22)
+#define TLB_V7_UIS_BP	(1 << 23)
 
 #define TLB_BARRIER	(1 << 28)
 #define TLB_L2CLEAN_FR	(1 << 29)		/* Feroceon */
@@ -150,7 +153,8 @@
 #define v6wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
 			 TLB_V6_I_FULL | TLB_V6_D_FULL | \
 			 TLB_V6_I_PAGE | TLB_V6_D_PAGE | \
-			 TLB_V6_I_ASID | TLB_V6_D_ASID)
+			 TLB_V6_I_ASID | TLB_V6_D_ASID | \
+			 TLB_V6_BP)
 
 #ifdef CONFIG_CPU_TLB_V6
 # define v6wbi_possible_flags	v6wbi_tlb_flags
@@ -166,9 +170,11 @@
 #endif
 
 #define v7wbi_tlb_flags_smp	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
-			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
+				 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | \
+				 TLB_V7_UIS_ASID | TLB_V7_UIS_BP)
 #define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
-			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
+				 TLB_V6_U_FULL | TLB_V6_U_PAGE | \
+				 TLB_V6_U_ASID | TLB_V6_BP)
 
 #ifdef CONFIG_CPU_TLB_V7
 
@@ -430,6 +436,20 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	}
 }
 
+static inline void local_flush_bp_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_V7_UIS_BP))
+		asm("mcr p15, 0, %0, c7, c1, 6" : : "r" (zero));
+	else if (tlb_flag(TLB_V6_BP))
+		asm("mcr p15, 0, %0, c7, c5, 6" : : "r" (zero));
+
+	if (tlb_flag(TLB_BARRIER))
+		isb();
+}
+
 /*
  *	flush_pmd_entry
  *
@@ -480,6 +500,7 @@ static inline void clean_pmd_entry(void *pmd)
 #define flush_tlb_kernel_page	local_flush_tlb_kernel_page
 #define flush_tlb_range		local_flush_tlb_range
 #define flush_tlb_kernel_range	local_flush_tlb_kernel_range
+#define flush_bp_all		local_flush_bp_all
 #else
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
@@ -487,6 +508,7 @@ extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr);
 extern void flush_tlb_kernel_page(unsigned long kaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void flush_bp_all(void);
 #endif
 
 /*
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 02c5d2c..bd03005 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -64,6 +64,11 @@ static inline void ipi_flush_tlb_kernel_range(void *arg)
 	local_flush_tlb_kernel_range(ta->ta_start, ta->ta_end);
 }
 
+static inline void ipi_flush_bp_all(void *ignored)
+{
+	local_flush_bp_all();
+}
+
 void flush_tlb_all(void)
 {
 	if (tlb_ops_need_broadcast())
@@ -127,3 +132,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 		local_flush_tlb_kernel_range(start, end);
 }
 
+void flush_bp_all(void)
+{
+	if (tlb_ops_need_broadcast())
+		on_each_cpu(ipi_flush_bp_all, NULL, 1);
+	else
+		local_flush_bp_all();
+}
-- 
1.8.0
