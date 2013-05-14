From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:48:51 +0100
Subject: [PATCH 1/7] ARM: nommu: add entry point for secondary CPUs to
 head-nommu.S
In-Reply-To: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
References: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368532137-8871-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

This patch adds a secondary_startup entry point to head-nommu.S so that
we can boot secondary CPUs on an SMP nommu configuration.

Signed-off-by: Will Deacon <will.deacon@arm.com>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
CC: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/head-nommu.S |   50 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 6a2e09c..2d4bf12 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -59,12 +59,56 @@ ENTRY(stext)
 	movs	r10, r5				@ invalid processor (r5=0)?
 	beq	__error_p				@ yes, error 'p'
 
-	adr	lr, BSYM(__after_proc_init)	@ return (PIC) address
+	ldr	r13, =__mmap_switched		@ address to jump to after
+						@ initialising sctlr
+	adr	lr, BSYM(1f)			@ return (PIC) address
  ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
  THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
  THUMB(	mov	pc, r12				)
+ 1:	b	__after_proc_init
 ENDPROC(stext)
 
+#ifdef CONFIG_SMP
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
+#ifndef CONFIG_CPU_CP15
+	ldr	r9, =CONFIG_PROCESSOR_ID
+#else
+	mrc	p15, 0, r9, c0, c0		@ get processor id
+#endif
+	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
+	movs	r10, r5				@ invalid processor?
+	beq	__error_p			@ yes, error 'p'
+
+	adr	r4, __secondary_data
+	ldmia	r4, {r7, r12}
+	adr	lr, BSYM(__after_proc_init)	@ return address
+	mov	r13, r12			@ __secondary_switched address
+ ARM(	add	pc, r10, #PROCINFO_INITFUNC	)
+ THUMB(	add	r12, r10, #PROCINFO_INITFUNC	)
+ THUMB(	mov	pc, r12				)
+ENDPROC(secondary_startup)
+
+ENTRY(__secondary_switched)
+	ldr	sp, [r7, #8]			@ set up the stack pointer
+	mov	fp, #0
+	b	secondary_start_kernel
+ENDPROC(__secondary_switched)
+
+	.type	__secondary_data, %object
+__secondary_data:
+	.long	secondary_data
+	.long	__secondary_switched
+#endif /* CONFIG_SMP */
+
 /*
  * Set the Control Register and Read the process ID.
  */
@@ -95,9 +139,7 @@ __after_proc_init:
 #endif
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
 #endif /* CONFIG_CPU_CP15 */
-
-	b	__mmap_switched			@ clear the BSS and jump
-						@ to start_kernel
+	mov	pc, r13
 ENDPROC(__after_proc_init)
 	.ltorg
 
-- 
1.7.9.5
