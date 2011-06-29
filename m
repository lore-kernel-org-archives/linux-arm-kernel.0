From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:24:15 +0100
Subject: [PATCH 16/23] ARM: entry: prefetch abort: tail-call the main
	prefetch abort handler
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbr0J-0002G3-M8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tail-call the main C prefetch abort handler code from the per-CPU
helper code.  Also note that the helper function becomes ABI
compliant in terms of the registers preserved.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |    8 +++-----
 arch/arm/mm/pabort-legacy.S  |    9 +++++----
 arch/arm/mm/pabort-v6.S      |    9 +++++----
 arch/arm/mm/pabort-v7.S      |   11 ++++++-----
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index b7c4792..54c07a8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro	pabt_helper
-	@ PABORT handler takes fault address in r4
+	@ PABORT handler takes pt_regs in r2, fault address in r4 and psr in r5
 #ifdef MULTI_PABORT
 	ldr	ip, .LCprocfns
 	mov	lr, pc
@@ -306,9 +306,8 @@ ENDPROC(__und_svc)
 	.align	5
 __pabt_svc:
 	svc_entry
-	pabt_helper
 	mov	r2, sp				@ regs
-	bl	do_PrefetchAbort		@ call abort handler
+	pabt_helper
 
 	@
 	@ IRQs off again before pulling preserved data off the stack
@@ -653,9 +652,8 @@ ENDPROC(__und_usr_unknown)
 	.align	5
 __pabt_usr:
 	usr_entry
-	pabt_helper
 	mov	r2, sp				@ regs
-	bl	do_PrefetchAbort		@ call abort handler
+	pabt_helper
  UNWIND(.fnend		)
 	/* fall through */
 /*
diff --git a/arch/arm/mm/pabort-legacy.S b/arch/arm/mm/pabort-legacy.S
index 8a5d8aa..8bbff02 100644
--- a/arch/arm/mm/pabort-legacy.S
+++ b/arch/arm/mm/pabort-legacy.S
@@ -4,10 +4,11 @@
 /*
  * Function: legacy_pabort
  *
- * Params  : r4 = address of aborted instruction
+ * Params  : r2 = pt_regs
+ *	   : r4 = address of aborted instruction
+ *	   : r5 = psr for parent context
  *
- * Returns : r0 = address of abort
- *	   : r1 = Simulated IFSR with section translation fault status
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current prefetch abort.
  */
@@ -16,5 +17,5 @@
 ENTRY(legacy_pabort)
 	mov	r0, r4
 	mov	r1, #5
-	mov	pc, lr
+	b	do_PrefetchAbort
 ENDPROC(legacy_pabort)
diff --git a/arch/arm/mm/pabort-v6.S b/arch/arm/mm/pabort-v6.S
index eaac1cb..9627646 100644
--- a/arch/arm/mm/pabort-v6.S
+++ b/arch/arm/mm/pabort-v6.S
@@ -4,10 +4,11 @@
 /*
  * Function: v6_pabort
  *
- * Params  : r4 = address of aborted instruction
+ * Params  : r2 = pt_regs
+ *	   : r4 = address of aborted instruction
+ *	   : r5 = psr for parent context
  *
- * Returns : r0 = address of abort
- *	   : r1 = IFSR
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current prefetch abort.
  */
@@ -16,5 +17,5 @@
 ENTRY(v6_pabort)
 	mov	r0, r4
 	mrc	p15, 0, r1, c5, c0, 1		@ get IFSR
-	mov	pc, lr
+	b	do_PrefetchAbort
 ENDPROC(v6_pabort)
diff --git a/arch/arm/mm/pabort-v7.S b/arch/arm/mm/pabort-v7.S
index b515e0b..875761f 100644
--- a/arch/arm/mm/pabort-v7.S
+++ b/arch/arm/mm/pabort-v7.S
@@ -2,12 +2,13 @@
 #include <asm/assembler.h>
 
 /*
- * Function: v6_pabort
+ * Function: v7_pabort
  *
- * Params  : r4 = address of aborted instruction
+ * Params  : r2 = pt_regs
+ *	   : r4 = address of aborted instruction
+ *	   : r5 = psr for parent context
  *
- * Returns : r0 = address of abort
- *	   : r1 = IFSR
+ * Returns : r4 - r11, r13 preserved
  *
  * Purpose : obtain information about current prefetch abort.
  */
@@ -16,5 +17,5 @@
 ENTRY(v7_pabort)
 	mrc	p15, 0, r0, c6, c0, 2		@ get IFAR
 	mrc	p15, 0, r1, c5, c0, 1		@ get IFSR
-	mov	pc, lr
+	b	do_PrefetchAbort
 ENDPROC(v7_pabort)
-- 
1.7.4.4
