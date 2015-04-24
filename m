From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 11:44:08 +0900
Subject: [RFC 3/4] arm64: ftrace: add DYNAMIC_TRACE_WITH_REGS version
In-Reply-To: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1429843449-7388-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_DYNAMIC_TRACE_WITH_REGS is a prerequisite for ftrace-based kprobes
as well as livepatch.
This patch adds ftrace_regs_caller(), which will pass pt_regs info to
ftrace handlers, to enable this config.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig               |    1 +
 arch/arm64/include/asm/ftrace.h  |    4 ++
 arch/arm64/kernel/entry-ftrace.S |  124 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c       |   24 +++++++-
 4 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..c3678ed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -54,6 +54,7 @@ config ARM64
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index c5534fa..5a14269 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -16,6 +16,10 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+#define ARCH_SUPPORTS_FTRACE_OPS	1
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 08cafc5..fed28eb 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -10,6 +10,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 
@@ -86,6 +87,95 @@
 	add	\reg, \reg, #8
 	.endm
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+/*
+ * stack layout after mcount_save_regs in _mcount():
+ *
+ * current sp/fp =>  0:+---------+
+ * in _mcount()        |pt_regs  |
+ *                     |         |
+ *                     |   +-----+
+ *                     |   | x29 | -> instrumented function's fp
+ *                     |   +-----+
+ *                     |   | x30 | -> _mcount()'s lr
+ *                     |   +-----+     (= instrumented function's pc)
+ *       +S_FRAME_SIZE |         |
+ * old sp =>          :+-----+---
+ * when instrumented   |     |
+ * function calls      | ... |
+ * _mcount()           |     |
+ *                     |     |
+ * instrumented => +xx:+-----+
+ * function's fp       | x29 | -> parent's fp
+ *                     +-----+
+ *                     | x30 | -> instrumented function's lr (= parent's pc)
+ *                     +-----+
+ *                     | ... |
+ */
+	.macro mcount_save_regs
+	sub	sp, sp, #S_FRAME_SIZE
+
+	stp	x0, x1, [sp, #8 * 0]
+	stp	x2, x3, [sp, #8 * 2]
+	stp	x4, x5, [sp, #8 * 4]
+	stp	x6, x7, [sp, #8 * 6]
+	stp	x8, x9, [sp, #8 * 8]
+	stp	x10, x11, [sp, #8 * 10]
+	stp	x12, x13, [sp, #8 * 12]
+	stp	x14, x15, [sp, #8 * 14]
+	stp	x16, x17, [sp, #8 * 16]
+	stp	x18, x19, [sp, #8 * 18]
+	stp	x20, x21, [sp, #8 * 20]
+	stp	x22, x23, [sp, #8 * 22]
+	stp	x24, x25, [sp, #8 * 24]
+	stp	x26, x27, [sp, #8 * 26]
+	stp	x28, x29, [sp, #8 * 28]
+
+	ldr	x0, [x29, #8]
+	mcount_adjust_addr	x0, x0
+	str	x0, [sp, #S_LR]
+
+	add	x0, sp, #S_FRAME_SIZE
+	str	x0, [sp, #S_SP]
+
+	mcount_adjust_addr	x0, x30
+	str	x0, [sp, #S_PC]
+
+	ldr	x0, [sp, #8 * 0]
+
+	mov	x29, sp
+	.endm
+
+	/* for instrumented function */
+	.macro mcount_get_lr1 reg
+	ldr	\reg, [x29, #8 * 29]
+	ldr	\reg, [\reg, #8]
+	mcount_adjust_addr	\reg, \reg
+	.endm
+
+	.macro mcount_restore_rest_regs
+	ldp	x0, x1, [sp, #8 * 0]
+	ldp	x2, x3, [sp, #8 * 2]
+	ldp	x4, x5, [sp, #8 * 4]
+	ldp	x6, x7, [sp, #8 * 6]
+	ldp	x8, x9, [sp, #8 * 8]
+	ldp	x10, x11, [sp, #8 * 10]
+	ldp	x12, x13, [sp, #8 * 12]
+	ldp	x14, x15, [sp, #8 * 14]
+	ldp	x16, x17, [sp, #8 * 16]
+	ldp	x18, x19, [sp, #8 * 18]
+	ldp	x20, x21, [sp, #8 * 20]
+	ldp	x22, x23, [sp, #8 * 22]
+	ldp	x24, x25, [sp, #8 * 24]
+	ldp	x26, x27, [sp, #8 * 26]
+	ldp	x28, x29, [sp, #8 * 28]
+	ldr	x30, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE
+
+	mcount_enter
+	.endm
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
 #ifndef CONFIG_DYNAMIC_FTRACE
 /*
  * void _mcount(unsigned long return_address)
@@ -156,6 +246,10 @@ ENTRY(ftrace_caller)
 
 	mcount_get_pc0	x0		//     function's pc
 	mcount_get_lr	x1		//     function's lr
+	adrp x2, function_trace_op
+	add  x2, x2, #:lo12:function_trace_op
+	ldr x2, [x2]			//     current ftrace_ops
+	mov x3, xzr			//     pt_regs (NULL)
 
 	.global ftrace_call
 ftrace_call:				// tracer(pc, lr);
@@ -171,6 +265,36 @@ ftrace_graph_call:			// ftrace_graph_caller();
 
 	mcount_exit
 ENDPROC(ftrace_caller)
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+/*
+ * void ftrace_regs_caller()
+ */
+ENTRY(ftrace_regs_caller)
+	mcount_save_regs
+
+	mcount_get_pc0	x0		//     function's pc
+	mcount_get_lr1	x1		//     function's lr
+	adrp x2, function_trace_op
+	add  x2, x2, #:lo12:function_trace_op
+	ldr x2, [x2]			//     current ftrace_ops
+	mov x3, sp			//     pt_regs
+
+	.global ftrace_regs_call
+ftrace_regs_call:			// tracer(pc, lr, ops, regs);
+	nop				// This will be replaced with "bl xxx"
+					// where xxx can be any kind of tracer.
+
+	mcount_restore_rest_regs
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	b ftrace_graph_call
+#endif
+
+	mcount_exit
+ENDPROC(ftrace_regs_caller)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(ftrace_stub)
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index c851be7..5440673 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -56,12 +56,21 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned long pc;
 	u32 new;
+	int ret;
 
 	pc = (unsigned long)&ftrace_call;
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
 					  AARCH64_INSN_BRANCH_LINK);
+	ret = ftrace_modify_code(pc, 0, new, false);
 
-	return ftrace_modify_code(pc, 0, new, false);
+	if (!ret) {
+		pc = (unsigned long)&ftrace_regs_call;
+		new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
+						  AARCH64_INSN_BRANCH_LINK);
+		ret = ftrace_modify_code(pc, 0, new, false);
+	}
+
+	return ret;
 }
 
 /*
@@ -97,6 +106,19 @@ int __init ftrace_dyn_arch_init(void)
 {
 	return 0;
 }
+
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		       unsigned long addr)
+{
+	unsigned long pc = rec->ip;
+	u32 old, new;
+
+	old = aarch64_insn_gen_branch_imm(pc, old_addr,
+						AARCH64_INSN_BRANCH_LINK);
+	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-- 
1.7.9.5
