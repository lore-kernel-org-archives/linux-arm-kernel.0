From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:26 +0100
Subject: [PATCHv2 3/7] arm64: move non-entry code out of .entry.text
In-Reply-To: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1501093110-3844-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, cpu_switch_to and ret_from_fork both live in .entry.text,
though neither form the critical path for an exception entry.

In subsequent patches, we will require that code in .entry.text is part
of the critical path for exception entry, for which we can assume
certain properties (e.g. the presence of exception regs on the stack).

Neither cpu_switch_to nor ret_from_fork will meet these requirements, so
we must most them out of .entry.text. To ensure that neither are kprobed
after being moved out of .entry.text, we must explicitly blacklist them,
requiring a new NOKPROBE() asm helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 11 +++++
 arch/arm64/kernel/entry.S          | 90 +++++++++++++++++++-------------------
 2 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 1b67c37..610a420 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -403,6 +403,17 @@
 	.size	__pi_##x, . - x;	\
 	ENDPROC(x)
 
+/*
+ * Annotate a function as being unsuitable for kprobes.
+ */
+#ifdef CONFIG_KPROBES
+#define NOKPROBE(x)				\
+	.pushsection "_kprobe_blacklist", "aw";	\
+	.quad	x;				\
+	.popsection;
+#else
+#define NOKPROBE(x)
+#endif
 	/*
 	 * Emit a 64-bit absolute little endian symbol reference in a way that
 	 * ensures that it will be resolved at build time, even when building a
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 660612a..9e126d3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -711,38 +711,6 @@ el0_irq_naked:
 ENDPROC(el0_irq)
 
 /*
- * Register switch for AArch64. The callee-saved registers need to be saved
- * and restored. On entry:
- *   x0 = previous task_struct (must be preserved across the switch)
- *   x1 = next task_struct
- * Previous and next are guaranteed not to be the same.
- *
- */
-ENTRY(cpu_switch_to)
-	mov	x10, #THREAD_CPU_CONTEXT
-	add	x8, x0, x10
-	mov	x9, sp
-	stp	x19, x20, [x8], #16		// store callee-saved registers
-	stp	x21, x22, [x8], #16
-	stp	x23, x24, [x8], #16
-	stp	x25, x26, [x8], #16
-	stp	x27, x28, [x8], #16
-	stp	x29, x9, [x8], #16
-	str	lr, [x8]
-	add	x8, x1, x10
-	ldp	x19, x20, [x8], #16		// restore callee-saved registers
-	ldp	x21, x22, [x8], #16
-	ldp	x23, x24, [x8], #16
-	ldp	x25, x26, [x8], #16
-	ldp	x27, x28, [x8], #16
-	ldp	x29, x9, [x8], #16
-	ldr	lr, [x8]
-	mov	sp, x9
-	msr	sp_el0, x1
-	ret
-ENDPROC(cpu_switch_to)
-
-/*
  * This is the fast syscall return path.  We do as little as possible here,
  * and this includes saving x0 back into the kernel stack.
  */
@@ -785,18 +753,6 @@ finish_ret_to_user:
 ENDPROC(ret_to_user)
 
 /*
- * This is how we return from a fork.
- */
-ENTRY(ret_from_fork)
-	bl	schedule_tail
-	cbz	x19, 1f				// not a kernel thread
-	mov	x0, x20
-	blr	x19
-1:	get_thread_info tsk
-	b	ret_to_user
-ENDPROC(ret_from_fork)
-
-/*
  * SVC handler.
  */
 	.align	6
@@ -869,3 +825,49 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
+
+/*
+ * Register switch for AArch64. The callee-saved registers need to be saved
+ * and restored. On entry:
+ *   x0 = previous task_struct (must be preserved across the switch)
+ *   x1 = next task_struct
+ * Previous and next are guaranteed not to be the same.
+ *
+ */
+ENTRY(cpu_switch_to)
+	mov	x10, #THREAD_CPU_CONTEXT
+	add	x8, x0, x10
+	mov	x9, sp
+	stp	x19, x20, [x8], #16		// store callee-saved registers
+	stp	x21, x22, [x8], #16
+	stp	x23, x24, [x8], #16
+	stp	x25, x26, [x8], #16
+	stp	x27, x28, [x8], #16
+	stp	x29, x9, [x8], #16
+	str	lr, [x8]
+	add	x8, x1, x10
+	ldp	x19, x20, [x8], #16		// restore callee-saved registers
+	ldp	x21, x22, [x8], #16
+	ldp	x23, x24, [x8], #16
+	ldp	x25, x26, [x8], #16
+	ldp	x27, x28, [x8], #16
+	ldp	x29, x9, [x8], #16
+	ldr	lr, [x8]
+	mov	sp, x9
+	msr	sp_el0, x1
+	ret
+ENDPROC(cpu_switch_to)
+NOKPROBE(cpu_switch_to)
+
+/*
+ * This is how we return from a fork.
+ */
+ENTRY(ret_from_fork)
+	bl	schedule_tail
+	cbz	x19, 1f				// not a kernel thread
+	mov	x0, x20
+	blr	x19
+1:	get_thread_info tsk
+	b	ret_to_user
+ENDPROC(ret_from_fork)
+NOKPROBE(ret_from_fork)
-- 
1.9.1
