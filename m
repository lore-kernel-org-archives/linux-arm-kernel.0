From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:38 +0100
Subject: [PATCH 09/10] ARM: hotplug cpu: move secondary_startup,
	__enable_mmu to cpuinit
Message-ID: <E1P2oXi-00020k-Hx@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move these two functions, both of which are required for secondary
CPU booting, into the cpuinit section.  Ensure bad processors call
__error_p for better diagnostics, rather than just __error.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head.S |  206 ++++++++++++++++++++++++------------------------
 1 files changed, 104 insertions(+), 102 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 17414e2..ed9ebe5 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -97,114 +97,14 @@ ENTRY(stext)
 	 */
 	ldr	r13, =__mmap_switched		@ address to jump to after
 						@ mmu has been enabled
-	adr	lr, BSYM(__enable_mmu)		@ return (PIC) address
+	adr	lr, BSYM(1f)			@ return (PIC) address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
  THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
  THUMB(	mov	pc, r12				)
+1:	b	__enable_mmu
 ENDPROC(stext)
 	.ltorg
 
-#if defined(CONFIG_SMP)
-ENTRY(secondary_startup)
-	/*
-	 * Common entry point for secondary CPUs.
-	 *
-	 * Ensure that we're in SVC mode, and IRQs are disabled.  Lookup
-	 * the processor type - there is no need to check the machine type
-	 * as it has already been validated by the primary processor.
-	 */
-	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9
-	mrc	p15, 0, r9, c0, c0		@ get processor id
-	bl	__lookup_processor_type
-	movs	r10, r5				@ invalid processor?
-	moveq	r0, #'p'			@ yes, error 'p'
-	beq	__error
-
-	/*
-	 * Use the page tables supplied from  __cpu_up.
-	 */
-	adr	r4, __secondary_data
-	ldmia	r4, {r5, r7, r12}		@ address to jump to after
-	sub	r4, r4, r5			@ mmu has been enabled
-	ldr	r4, [r7, r4]			@ get secondary_data.pgdir
-	adr	lr, BSYM(__enable_mmu)		@ return address
-	mov	r13, r12			@ __secondary_switched address
- ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
-						  @ (return control reg)
- THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
- THUMB(	mov	pc, r12				)
-ENDPROC(secondary_startup)
-
-	/*
-	 * r6  = &secondary_data
-	 */
-ENTRY(__secondary_switched)
-	ldr	sp, [r7, #4]			@ get secondary_data.stack
-	mov	fp, #0
-	b	secondary_start_kernel
-ENDPROC(__secondary_switched)
-
-	.type	__secondary_data, %object
-__secondary_data:
-	.long	.
-	.long	secondary_data
-	.long	__secondary_switched
-#endif /* defined(CONFIG_SMP) */
-
-
-
-/*
- * Setup common bits before finally enabling the MMU.  Essentially
- * this is just loading the page table pointer and domain access
- * registers.
- */
-__enable_mmu:
-#ifdef CONFIG_ALIGNMENT_TRAP
-	orr	r0, r0, #CR_A
-#else
-	bic	r0, r0, #CR_A
-#endif
-#ifdef CONFIG_CPU_DCACHE_DISABLE
-	bic	r0, r0, #CR_C
-#endif
-#ifdef CONFIG_CPU_BPREDICT_DISABLE
-	bic	r0, r0, #CR_Z
-#endif
-#ifdef CONFIG_CPU_ICACHE_DISABLE
-	bic	r0, r0, #CR_I
-#endif
-	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
-		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
-		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
-		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
-	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
-	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
-	b	__turn_mmu_on
-ENDPROC(__enable_mmu)
-
-/*
- * Enable the MMU.  This completely changes the structure of the visible
- * memory space.  You will not be able to trace execution through this.
- * If you have an enquiry about this, *please* check the linux-arm-kernel
- * mailing list archives BEFORE sending another post to the list.
- *
- *  r0  = cp#15 control register
- *  r13 = *virtual* address to jump to upon completion
- *
- * other registers depend on the function called upon completion
- */
-	.align	5
-__turn_mmu_on:
-	mov	r0, r0
-	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
-	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
-	mov	r3, r3
-	mov	r3, r13
-	mov	pc, r3
-__enable_mmu_end:
-ENDPROC(__turn_mmu_on)
-
-
 /*
  * Setup the initial page tables.  We only setup the barest
  * amount which are required to get the kernel running, which
@@ -349,4 +249,106 @@ __enable_mmu_loc:
 	.long	__enable_mmu
 	.long	__enable_mmu_end
 
+#if defined(CONFIG_SMP)
+	__CPUINIT
+ENTRY(secondary_startup)
+	/*
+	 * Common entry point for secondary CPUs.
+	 *
+	 * Ensure that we're in SVC mode, and IRQs are disabled.  Lookup
+	 * the processor type - there is no need to check the machine type
+	 * as it has already been validated by the primary processor.
+	 */
+	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9
+	mrc	p15, 0, r9, c0, c0		@ get processor id
+	bl	__lookup_processor_type
+	movs	r10, r5				@ invalid processor?
+	moveq	r0, #'p'			@ yes, error 'p'
+	beq	__error_p
+
+	/*
+	 * Use the page tables supplied from  __cpu_up.
+	 */
+	adr	r4, __secondary_data
+	ldmia	r4, {r5, r7, r12}		@ address to jump to after
+	sub	r4, r4, r5			@ mmu has been enabled
+	ldr	r4, [r7, r4]			@ get secondary_data.pgdir
+	adr	lr, BSYM(__enable_mmu)		@ return address
+	mov	r13, r12			@ __secondary_switched address
+ ARM(	add	pc, r10, #PROCINFO_INITFUNC	) @ initialise processor
+						  @ (return control reg)
+ THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
+ THUMB(	mov	pc, r12				)
+ENDPROC(secondary_startup)
+
+	/*
+	 * r6  = &secondary_data
+	 */
+ENTRY(__secondary_switched)
+	ldr	sp, [r7, #4]			@ get secondary_data.stack
+	mov	fp, #0
+	b	secondary_start_kernel
+ENDPROC(__secondary_switched)
+
+	.type	__secondary_data, %object
+__secondary_data:
+	.long	.
+	.long	secondary_data
+	.long	__secondary_switched
+#endif /* defined(CONFIG_SMP) */
+
+
+
+/*
+ * Setup common bits before finally enabling the MMU.  Essentially
+ * this is just loading the page table pointer and domain access
+ * registers.
+ */
+__enable_mmu:
+#ifdef CONFIG_ALIGNMENT_TRAP
+	orr	r0, r0, #CR_A
+#else
+	bic	r0, r0, #CR_A
+#endif
+#ifdef CONFIG_CPU_DCACHE_DISABLE
+	bic	r0, r0, #CR_C
+#endif
+#ifdef CONFIG_CPU_BPREDICT_DISABLE
+	bic	r0, r0, #CR_Z
+#endif
+#ifdef CONFIG_CPU_ICACHE_DISABLE
+	bic	r0, r0, #CR_I
+#endif
+	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
+		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
+		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
+		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
+	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
+	b	__turn_mmu_on
+ENDPROC(__enable_mmu)
+
+/*
+ * Enable the MMU.  This completely changes the structure of the visible
+ * memory space.  You will not be able to trace execution through this.
+ * If you have an enquiry about this, *please* check the linux-arm-kernel
+ * mailing list archives BEFORE sending another post to the list.
+ *
+ *  r0  = cp#15 control register
+ *  r13 = *virtual* address to jump to upon completion
+ *
+ * other registers depend on the function called upon completion
+ */
+	.align	5
+__turn_mmu_on:
+	mov	r0, r0
+	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
+	mrc	p15, 0, r3, c0, c0, 0		@ read id reg
+	mov	r3, r3
+	mov	r3, r13
+	mov	pc, r3
+__enable_mmu_end:
+ENDPROC(__turn_mmu_on)
+
+
 #include "head-common.S"
-- 
1.6.2.5
