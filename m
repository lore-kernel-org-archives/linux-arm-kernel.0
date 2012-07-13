From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Fri, 13 Jul 2012 21:05:59 +0200
Subject: Loading handle_arch_irq with a PC relative load
Message-ID: <50007197.8030403@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I do not know if it is really useful, but it seems it would be possible 
to reduce the number of memory accesses to just one in the irq_handler 
macro in the case where CONFIG_MULTI_IRQ_HANDLER is enabled, by using a 
PC relative load, with something like the following patch:

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0d1851c..48ee46a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -37,10 +37,9 @@
  */
 	.macro	irq_handler
 #ifdef CONFIG_MULTI_IRQ_HANDLER
-	ldr	r1, =handle_arch_irq
 	mov	r0, sp
 	adr	lr, BSYM(9997f)
-	ldr	pc, [r1]
+	ldr	pc, handle_arch_irq
 #else
 	arch_irq_handler_default
 #endif
@@ -325,6 +324,12 @@ ENDPROC(__pabt_svc)
 #endif
 .LCfp:
 	.word	fp_enter
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	.globl	handle_arch_irq
+handle_arch_irq:
+	.space	4
+#endif
+
 
 /*
  * User mode handlers
@@ -1151,9 +1156,3 @@ cr_alignment:
 	.space	4
 cr_no_alignment:
 	.space	4
-
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-	.globl	handle_arch_irq
-handle_arch_irq:
-	.space	4
-#endif


-- 
                                                                Gilles.
