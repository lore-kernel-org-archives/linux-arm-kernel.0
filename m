From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 11 Nov 2013 00:10:27 -0800
Subject: [PATCH] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
References: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1384157427-31613-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of armv7-m architecture arm instructions are not allowed.
For this architecture CONFIG_CPU_THUMBONLY is set. Use this macro
to emit conditionally arm instructions or nops in thumb mode.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/sigreturn_codes.S | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index 3c5d0f2..899fb86 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -41,17 +41,29 @@
 	.arch armv4t
 #endif
 
+/*
+ * In CPU_THUMBONLY kernel case arm opcodes are not allowed
+ */
+#ifndef CONFIG_CPU_THUMBONLY
+#define ARM_INSTR(code...) .arm ; \
+			   code
+#else
+#define ARM_INSTR(code...) .thumb ; \
+			   nop ;    \
+			   nop ;
+#endif
+
 	.section .rodata
 	.global sigreturn_codes
 	.type	sigreturn_codes, #object
 
-	.arm
+	.align
 
 sigreturn_codes:
 
 	/* ARM sigreturn syscall code snippet */
-	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
-	swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)
+ARM_INSTR(mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE))
+ARM_INSTR(swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
 
 	/* Thumb sigreturn syscall code snippet */
 	.thumb
@@ -59,9 +71,8 @@ sigreturn_codes:
 	swi	#0
 
 	/* ARM sigreturn_rt syscall code snippet */
-	.arm
-	mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
-	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)
+ARM_INSTR(mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE))
+ARM_INSTR(swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
 
 	/* Thumb sigreturn_rt syscall code snippet */
 	.thumb
@@ -74,7 +85,7 @@ sigreturn_codes:
 	 * it is thumb case or not, so we need additional
 	 * word after real last entry.
 	 */
-	.arm
+	.align
 	.space	4
 
 	.size	sigreturn_codes, . - sigreturn_codes
-- 
1.8.1.4
