From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 18 Nov 2013 22:49:50 -0800
Subject: [PATCH v3] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <1384843790-14394-1-git-send-email-victor.kamensky@linaro.org>
References: <1384843790-14394-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1384843790-14394-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After "ARM: signal: sigreturn_codes should be endian neutral to
work in BE8" commit, thumb only platforms, like armv7m, fails to
compile sigreturn_codes.S. The reason is that for such arch
values '.arm' directive and arm opcodes are not allowed.

Fix conditionally enables arm opcodes only if no CONFIG_CPU_THUMBONLY
defined and it uses .org instructions to keep sigreturn_codes
layout.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/sigreturn_codes.S | 40 ++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index 3c5d0f2..9d48fe9 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -30,6 +30,27 @@
  * snippets.
  */
 
+/*
+ * In CPU_THUMBONLY case kernel arm opcodes are not allowed.
+ * Note in this case codes skips those instructions but it uses .org
+ * directive to keep correct layout of sigreturn_codes array.
+ */
+#ifndef CONFIG_CPU_THUMBONLY
+#define ARM_INSTR(code...) 	code
+#else
+#define ARM_INSTR(code...)
+#endif
+
+.macro arm_slot n
+		.org	sigreturn_codes + 12 * (\n)
+ARM_INSTR(	.arm	)
+.endm
+
+.macro thumb_slot n
+		.org	sigreturn_codes + 12 * (\n) + 8
+		.thumb
+.endm
+
 #if __LINUX_ARM_ARCH__ <= 4
 	/*
 	 * Note we manually set minimally required arch that supports
@@ -45,26 +66,27 @@
 	.global sigreturn_codes
 	.type	sigreturn_codes, #object
 
-	.arm
+	.align
 
 sigreturn_codes:
 
 	/* ARM sigreturn syscall code snippet */
-	mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
-	swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)
+arm_slot 0
+ARM_INSTR(mov	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE))
+ARM_INSTR(swi	#(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE))
 
 	/* Thumb sigreturn syscall code snippet */
-	.thumb
+thumb_slot 0
 	movs	r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
 	swi	#0
 
 	/* ARM sigreturn_rt syscall code snippet */
-	.arm
-	mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
-	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)
+arm_slot 1
+ARM_INSTR(mov	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE))
+ARM_INSTR(swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE))
 
 	/* Thumb sigreturn_rt syscall code snippet */
-	.thumb
+thumb_slot 1
 	movs	r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
 	swi	#0
 
@@ -74,7 +96,7 @@ sigreturn_codes:
 	 * it is thumb case or not, so we need additional
 	 * word after real last entry.
 	 */
-	.arm
+arm_slot 2
 	.space	4
 
 	.size	sigreturn_codes, . - sigreturn_codes
-- 
1.8.1.4
