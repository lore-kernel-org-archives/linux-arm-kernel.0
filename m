From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:17:35 +0000
Subject: [PATCH v2 1/5] ARM: tlbflush: remove ARMv3 support
In-Reply-To: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
References: <1364235459-17672-1-git-send-email-will.deacon@arm.com>
Message-ID: <1364235459-17672-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We no longer support any ARMv3 platforms, so remove the old tlbflushing
code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 4db8c88..a223003 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -14,7 +14,6 @@
 
 #include <asm/glue.h>
 
-#define TLB_V3_PAGE	(1 << 0)
 #define TLB_V4_U_PAGE	(1 << 1)
 #define TLB_V4_D_PAGE	(1 << 2)
 #define TLB_V4_I_PAGE	(1 << 3)
@@ -22,7 +21,6 @@
 #define TLB_V6_D_PAGE	(1 << 5)
 #define TLB_V6_I_PAGE	(1 << 6)
 
-#define TLB_V3_FULL	(1 << 8)
 #define TLB_V4_U_FULL	(1 << 9)
 #define TLB_V4_D_FULL	(1 << 10)
 #define TLB_V4_I_FULL	(1 << 11)
@@ -52,7 +50,6 @@
  *	=============
  *
  *	We have the following to choose from:
- *	  v3    - ARMv3
  *	  v4    - ARMv4 without write buffer
  *	  v4wb  - ARMv4 with write buffer without I TLB flush entry instruction
  *	  v4wbi - ARMv4 with write buffer with I TLB flush entry instruction
@@ -330,7 +327,6 @@ static inline void local_flush_tlb_all(void)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
 	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
 	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
 	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
@@ -351,9 +347,8 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (possible_tlb_flags & (TLB_V3_FULL|TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
+	if (possible_tlb_flags & (TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
 		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
-			tlb_op(TLB_V3_FULL, "c6, c0, 0", zero);
 			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
 			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
 			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
@@ -385,9 +380,8 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (possible_tlb_flags & (TLB_V3_PAGE|TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
+	if (possible_tlb_flags & (TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
 	    cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
-		tlb_op(TLB_V3_PAGE, "c6, c0, 0", uaddr);
 		tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", uaddr);
 		tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", uaddr);
 		tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", uaddr);
@@ -418,7 +412,6 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	tlb_op(TLB_V3_PAGE, "c6, c0, 0", kaddr);
 	tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", kaddr);
 	tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", kaddr);
 	tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", kaddr);
-- 
1.8.0
