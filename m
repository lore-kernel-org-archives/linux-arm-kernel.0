From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:30 +0100
Subject: [PATCH 05/10] ARM: move __mmap_switched,
	C-API functions to init section
Message-ID: <E1P2oXa-00020U-3D@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move these functions, which are only ever used during boot CPU
initialization, to the init section.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head-common.S |  142 +++++++++++++++++++++--------------------
 1 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 9f473ef..24dfa14 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -15,54 +15,6 @@
 #define ATAG_CORE_SIZE ((2*4 + 3*4) >> 2)
 #define ATAG_CORE_SIZE_EMPTY ((2*4) >> 2)
 
-	.align	2
-	.type	__switch_data, %object
-__switch_data:
-	.long	__data_loc			@ r4
-	.long	_data				@ r5
-	.long	__bss_start			@ r6
-	.long	_end				@ r7
-	.long	processor_id			@ r4
-	.long	__machine_arch_type		@ r5
-	.long	__atags_pointer			@ r6
-	.long	cr_alignment			@ r7
-	.long	init_thread_union + THREAD_START_SP @ sp
-
-/*
- * The following fragment of code is executed with the MMU on in MMU mode,
- * and uses absolute addresses; this is not position independent.
- *
- *  r0  = cp#15 control register
- *  r1  = machine ID
- *  r2  = atags pointer
- *  r9  = processor ID
- */
-__mmap_switched:
-	adr	r3, __switch_data
-
-	ldmia	r3!, {r4, r5, r6, r7}
-	cmp	r4, r5				@ Copy data segment if needed
-1:	cmpne	r5, r6
-	ldrne	fp, [r4], #4
-	strne	fp, [r5], #4
-	bne	1b
-
-	mov	fp, #0				@ Clear BSS (and zero fp)
-1:	cmp	r6, r7
-	strcc	fp, [r6],#4
-	bcc	1b
-
- ARM(	ldmia	r3, {r4, r5, r6, r7, sp})
- THUMB(	ldmia	r3, {r4, r5, r6, r7}	)
- THUMB(	ldr	sp, [r3, #16]		)
-	str	r9, [r4]			@ Save processor ID
-	str	r1, [r5]			@ Save machine type
-	str	r2, [r6]			@ Save atags pointer
-	bic	r4, r0, #CR_A			@ Clear 'A' bit
-	stmia	r7, {r0, r4}			@ Save control register values
-	b	start_kernel
-ENDPROC(__mmap_switched)
-
 /*
  * Exception handling.  Something went wrong and we can't proceed.  We
  * ought to tell the user, but since we don't have any guarantee that
@@ -144,17 +96,6 @@ ENDPROC(__error)
 
 
 /*
- * This provides a C-API version of __lookup_processor_type
- */
-ENTRY(lookup_processor_type)
-	stmfd	sp!, {r4 - r6, r9, lr}
-	mov	r9, r0
-	bl	__lookup_processor_type
-	mov	r0, r5
-	ldmfd	sp!, {r4 - r6, r9, pc}
-ENDPROC(lookup_processor_type)
-
-/*
  * Look in <asm/procinfo.h> and arch/arm/kernel/arch.[ch] for
  * more information about the __proc_info and __arch_info structures.
  */
@@ -190,17 +131,6 @@ __lookup_machine_type:
 2:	mov	pc, lr
 ENDPROC(__lookup_machine_type)
 
-/*
- * This provides a C-API version of the above function.
- */
-ENTRY(lookup_machine_type)
-	stmfd	sp!, {r4 - r6, lr}
-	mov	r1, r0
-	bl	__lookup_machine_type
-	mov	r0, r5
-	ldmfd	sp!, {r4 - r6, pc}
-ENDPROC(lookup_machine_type)
-
 /* Determine validity of the r2 atags pointer.  The heuristic requires
  * that the pointer be aligned, in the first 16k of physical RAM and
  * that the ATAG_CORE marker is first and present.  Future revisions
@@ -233,6 +163,78 @@ __vet_atags:
 ENDPROC(__vet_atags)
 
 /*
+ * The following fragment of code is executed with the MMU on in MMU mode,
+ * and uses absolute addresses; this is not position independent.
+ *
+ *  r0  = cp#15 control register
+ *  r1  = machine ID
+ *  r2  = atags pointer
+ *  r9  = processor ID
+ */
+	__INIT
+__mmap_switched:
+	adr	r3, __mmap_switched_data
+
+	ldmia	r3!, {r4, r5, r6, r7}
+	cmp	r4, r5				@ Copy data segment if needed
+1:	cmpne	r5, r6
+	ldrne	fp, [r4], #4
+	strne	fp, [r5], #4
+	bne	1b
+
+	mov	fp, #0				@ Clear BSS (and zero fp)
+1:	cmp	r6, r7
+	strcc	fp, [r6],#4
+	bcc	1b
+
+ ARM(	ldmia	r3, {r4, r5, r6, r7, sp})
+ THUMB(	ldmia	r3, {r4, r5, r6, r7}	)
+ THUMB(	ldr	sp, [r3, #16]		)
+	str	r9, [r4]			@ Save processor ID
+	str	r1, [r5]			@ Save machine type
+	str	r2, [r6]			@ Save atags pointer
+	bic	r4, r0, #CR_A			@ Clear 'A' bit
+	stmia	r7, {r0, r4}			@ Save control register values
+	b	start_kernel
+ENDPROC(__mmap_switched)
+
+	.align	2
+	.type	__mmap_switched_data, %object
+__mmap_switched_data:
+	.long	__data_loc			@ r4
+	.long	_data				@ r5
+	.long	__bss_start			@ r6
+	.long	_end				@ r7
+	.long	processor_id			@ r4
+	.long	__machine_arch_type		@ r5
+	.long	__atags_pointer			@ r6
+	.long	cr_alignment			@ r7
+	.long	init_thread_union + THREAD_START_SP @ sp
+	.size	__mmap_switched_data, . - __mmap_switched_data
+
+/*
+ * This provides a C-API version of __lookup_machine_type
+ */
+ENTRY(lookup_machine_type)
+	stmfd	sp!, {r4 - r6, lr}
+	mov	r1, r0
+	bl	__lookup_machine_type
+	mov	r0, r5
+	ldmfd	sp!, {r4 - r6, pc}
+ENDPROC(lookup_machine_type)
+
+/*
+ * This provides a C-API version of __lookup_processor_type
+ */
+ENTRY(lookup_processor_type)
+	stmfd	sp!, {r4 - r6, r9, lr}
+	mov	r9, r0
+	bl	__lookup_processor_type
+	mov	r0, r5
+	ldmfd	sp!, {r4 - r6, r9, pc}
+ENDPROC(lookup_processor_type)
+
+/*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses
  * for the __proc_info lists since we aren't running with the MMU on
-- 
1.6.2.5
