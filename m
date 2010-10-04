From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:36 +0100
Subject: [PATCH 08/10] ARM: hotplug cpu: ensure that __enable_mmu is identity
	mapped
Message-ID: <E1P2oXg-00020g-EB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__enable_mmu is required to be executed in an identity mapped region
to ensure that variances in CPUs do not cause a crash.  We currently
achieve this by assuming that it will be co-located with
__create_page_tables.  With hotplug CPU support, this assumption
becomes invalid.  Implement a better solution which ensures that
it will be appropriately mapped no matter where it is placed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head.S |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index aa6ab9d..17414e2 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -201,6 +201,7 @@ __turn_mmu_on:
 	mov	r3, r3
 	mov	r3, r13
 	mov	pc, r3
+__enable_mmu_end:
 ENDPROC(__turn_mmu_on)
 
 
@@ -214,7 +215,7 @@ ENDPROC(__turn_mmu_on)
  * r10 = procinfo
  *
  * Returns:
- *  r0, r3, r6, r7 corrupted
+ *  r0, r3, r5-r7 corrupted
  *  r4 = physical page table address
  */
 __create_page_tables:
@@ -236,20 +237,30 @@ __create_page_tables:
 	ldr	r7, [r10, #PROCINFO_MM_MMUFLAGS] @ mm_mmuflags
 
 	/*
-	 * Create identity mapping for first MB of kernel to
-	 * cater for the MMU enable.  This identity mapping
-	 * will be removed by paging_init().  We use our current program
-	 * counter to determine corresponding section base address.
+	 * Create identity mapping to cater for __enable_mmu.
+	 * This identity mapping will be removed by paging_init().
 	 */
-	mov	r6, pc
-	mov	r6, r6, lsr #20			@ start of kernel section
-	orr	r3, r7, r6, lsl #20		@ flags + kernel base
-	str	r3, [r4, r6, lsl #2]		@ identity mapping
+	adr	r0, __enable_mmu_loc
+	ldmia	r0, {r3, r5, r6}
+	sub	r0, r0, r3			@ virt->phys offset
+	add	r5, r5, r0			@ phys __enable_mmu
+	add	r6, r6, r0			@ phys __enable_mmu_end
+	mov	r5, r5, lsr #20
+	mov	r6, r6, lsr #20
+
+1:	orr	r3, r7, r5, lsl #20		@ flags + kernel base
+	str	r3, [r4, r5, lsl #2]		@ identity mapping
+	teq	r5, r6
+	addne	r5, r5, #1			@ next section
+	bne	1b
 
 	/*
 	 * Now setup the pagetables for our kernel direct
 	 * mapped region.
 	 */
+	mov	r3, pc
+	mov	r3, r3, lsr #20
+	orr	r3, r7, r3, lsl #20
 	add	r0, r4,  #(KERNEL_START & 0xff000000) >> 18
 	str	r3, [r0, #(KERNEL_START & 0x00f00000) >> 18]!
 	ldr	r6, =(KERNEL_END - 1)
@@ -333,5 +344,9 @@ __create_page_tables:
 	mov	pc, lr
 ENDPROC(__create_page_tables)
 	.ltorg
+__enable_mmu_loc:
+	.long	.
+	.long	__enable_mmu
+	.long	__enable_mmu_end
 
 #include "head-common.S"
-- 
1.6.2.5
