From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:34 +0100
Subject: [PATCH 07/10] ARM: cleanup lookup_machine_type data and ensure these
	are placed in __HEAD
Message-ID: <E1P2oXe-00020c-AO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head-common.S |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 7c6f9ab..c4effcf 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -24,6 +24,7 @@
  * and hope for the best (useful if bootloader fails to pass a proper
  * machine ID for example).
  */
+	__HEAD
 __error_a:
 #ifdef CONFIG_DEBUG_LL
 	mov	r4, r1				@ preserve machine ID
@@ -33,7 +34,7 @@ __error_a:
 	bl	printhex8
 	adr	r0, str_a2
 	bl	printascii
-	adr	r3, 4f
+	adr	r3, __lookup_machine_type_data
 	ldmia	r3, {r4, r5, r6}		@ get machine desc list
 	sub	r4, r3, r4			@ get offset between virt&phys
 	add	r5, r5, r4			@ convert virt addresses to
@@ -62,15 +63,6 @@ str_a3:	.asciz	"\nPlease check your kernel config and/or bootloader.\n"
 #endif
 
 /*
- * Look in <asm/procinfo.h> and arch/arm/kernel/arch.[ch] for
- * more information about the __proc_info and __arch_info structures.
- */
-	.align	2
-4:	.long	.
-	.long	__arch_info_begin
-	.long	__arch_info_end
-
-/*
  * Lookup machine architecture in the linker-build list of architectures.
  * Note that we can't use the absolute addresses for the __arch_info
  * lists since we aren't running with the MMU on (and therefore, we are
@@ -82,7 +74,7 @@ str_a3:	.asciz	"\nPlease check your kernel config and/or bootloader.\n"
  *  r5 = mach_info pointer in physical address space
  */
 __lookup_machine_type:
-	adr	r3, 4b
+	adr	r3, __lookup_machine_type_data
 	ldmia	r3, {r4, r5, r6}
 	sub	r3, r3, r4			@ get offset between virt&phys
 	add	r5, r5, r3			@ convert virt addresses to
@@ -97,6 +89,18 @@ __lookup_machine_type:
 2:	mov	pc, lr
 ENDPROC(__lookup_machine_type)
 
+/*
+ * Look in arch/arm/kernel/arch.[ch] for information about the
+ * __arch_info structures.
+ */
+	.align	2
+	.type	__lookup_machine_type_data, %object
+__lookup_machine_type_data:
+	.long	.
+	.long	__arch_info_begin
+	.long	__arch_info_end
+	.size	__lookup_machine_type_data, . - __lookup_machine_type_data
+
 /* Determine validity of the r2 atags pointer.  The heuristic requires
  * that the pointer be aligned, in the first 16k of physical RAM and
  * that the ATAG_CORE marker is first and present.  Future revisions
-- 
1.6.2.5
