From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Oct 2010 18:09:32 +0100
Subject: [PATCH 06/10] ARM: hotplug cpu: move __error and __error_p to cpuinit
	section
Message-ID: <E1P2oXc-00020Y-6g@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__error and __error_p may be used by secondary CPUs, so these
need to be in the cpuinit section.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/head-common.S |   67 ++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 24dfa14..7c6f9ab 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -24,21 +24,6 @@
  * and hope for the best (useful if bootloader fails to pass a proper
  * machine ID for example).
  */
-__error_p:
-#ifdef CONFIG_DEBUG_LL
-	adr	r0, str_p1
-	bl	printascii
-	mov	r0, r9
-	bl	printhex8
-	adr	r0, str_p2
-	bl	printascii
-	b	__error
-str_p1:	.asciz	"\nError: unrecognized/unsupported processor variant (0x"
-str_p2:	.asciz	").\n"
-	.align
-#endif
-ENDPROC(__error_p)
-
 __error_a:
 #ifdef CONFIG_DEBUG_LL
 	mov	r4, r1				@ preserve machine ID
@@ -76,25 +61,6 @@ str_a3:	.asciz	"\nPlease check your kernel config and/or bootloader.\n"
 	.align
 #endif
 
-__error:
-#ifdef CONFIG_ARCH_RPC
-/*
- * Turn the screen red on a error - RiscPC only.
- */
-	mov	r0, #0x02000000
-	mov	r3, #0x11
-	orr	r3, r3, r3, lsl #8
-	orr	r3, r3, r3, lsl #16
-	str	r3, [r0], #4
-	str	r3, [r0], #4
-	str	r3, [r0], #4
-	str	r3, [r0], #4
-#endif
-1:	mov	r0, r0
-	b	1b
-ENDPROC(__error)
-
-
 /*
  * Look in <asm/procinfo.h> and arch/arm/kernel/arch.[ch] for
  * more information about the __proc_info and __arch_info structures.
@@ -275,3 +241,36 @@ __lookup_processor_type_data:
 	.long	__proc_info_begin
 	.long	__proc_info_end
 	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
+
+__error_p:
+#ifdef CONFIG_DEBUG_LL
+	adr	r0, str_p1
+	bl	printascii
+	mov	r0, r9
+	bl	printhex8
+	adr	r0, str_p2
+	bl	printascii
+	b	__error
+str_p1:	.asciz	"\nError: unrecognized/unsupported processor variant (0x"
+str_p2:	.asciz	").\n"
+	.align
+#endif
+ENDPROC(__error_p)
+
+__error:
+#ifdef CONFIG_ARCH_RPC
+/*
+ * Turn the screen red on a error - RiscPC only.
+ */
+	mov	r0, #0x02000000
+	mov	r3, #0x11
+	orr	r3, r3, r3, lsl #8
+	orr	r3, r3, r3, lsl #16
+	str	r3, [r0], #4
+	str	r3, [r0], #4
+	str	r3, [r0], #4
+	str	r3, [r0], #4
+#endif
+1:	mov	r0, r0
+	b	1b
+ENDPROC(__error)
-- 
1.6.2.5
