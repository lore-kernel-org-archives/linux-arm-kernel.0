From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 28 May 2015 13:51:01 +0800
Subject: [RFC PATCH 1/5] livepatch: ftrace: arm64: Add support for
 DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1432792265-24076-2-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ftrace_ops is registered with flag FTRACE_OPS_FL_SAVE_REGS, the
arch that support DYNAMIC_FTRACE_WITH_REGS will pass a full set of
pt_regs to the ftrace_ops callback function, which may read or change
the value of the pt_regs and the pt_regs will be restored to support
work flow redirection such as kernel live patching.

This patch adds DYNAMIC_FTRACE_WITH_REGS feature support for arm64
architecture.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/Kconfig               |    1 +
 arch/arm64/include/asm/ftrace.h  |    4 ++
 arch/arm64/kernel/entry-ftrace.S |   95 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c       |   28 ++++++++++-
 4 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7796af4..ea435c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -57,6 +57,7 @@ config ARM64
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index c5534fa..a7722b9 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -16,6 +16,10 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 08cafc5..fde793b 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -12,6 +12,8 @@
 #include <linux/linkage.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 
 /*
  * Gcc with -pg will put the following code in the beginning of each function:
@@ -50,11 +52,37 @@
 	mov	x29, sp
 	.endm
 
+	/* save parameter registers & corruptible registers */
+	.macro save_mcount_regs
+	sub	sp, sp, #S_FRAME_SIZE
+	stp	x0, x1, [sp]
+	stp	x2, x3, [sp, #16]
+	stp	x4, x5, [sp, #32]
+	stp	x6, x7, [sp, #48]
+	stp	x8, x9, [sp, #64]
+	stp	x10, x11, [sp, #80]
+	stp	x12, x13, [sp, #96]
+	stp	x14, x15, [sp, #112]
+	.endm
+
 	.macro mcount_exit
 	ldp	x29, x30, [sp], #16
 	ret
 	.endm
 
+	/* restore parameter registers & corruptible registers */
+	.macro restore_mcount_regs
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #16]
+	ldp	x4, x5, [sp, #32]
+	ldp	x6, x7, [sp, #48]
+	ldp	x8, x9, [sp, #64]
+	ldp	x10, x11, [sp, #80]
+	ldp	x12, x13, [sp, #96]
+	ldp	x14, x15, [sp, #112]
+	add	sp, sp, #S_FRAME_SIZE
+	.endm
+
 	.macro mcount_adjust_addr rd, rn
 	sub	\rd, \rn, #AARCH64_INSN_SIZE
 	.endm
@@ -97,6 +125,7 @@
  */
 ENTRY(_mcount)
 	mcount_enter
+	save_mcount_regs
 
 	adrp	x0, ftrace_trace_function
 	ldr	x2, [x0, #:lo12:ftrace_trace_function]
@@ -110,8 +139,10 @@ ENTRY(_mcount)
 
 #ifndef CONFIG_FUNCTION_GRAPH_TRACER
 skip_ftrace_call:			//   return;
+	restore_mcount_regs
 	mcount_exit			// }
 #else
+	restore_mcount_regs
 	mcount_exit			//   return;
 					// }
 skip_ftrace_call:
@@ -127,6 +158,7 @@ skip_ftrace_call:
 	cmp	x0, x2
 	b.ne	ftrace_graph_caller	//     ftrace_graph_caller();
 
+	restore_mcount_regs
 	mcount_exit
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 ENDPROC(_mcount)
@@ -153,15 +185,20 @@ ENDPROC(_mcount)
  */
 ENTRY(ftrace_caller)
 	mcount_enter
+	save_mcount_regs
 
+	adrp	x0, function_trace_op
+	ldr	x2, [x0, #:lo12:function_trace_op]
 	mcount_get_pc0	x0		//     function's pc
 	mcount_get_lr	x1		//     function's lr
+	mov	x3, #0
 
 	.global ftrace_call
 ftrace_call:				// tracer(pc, lr);
 	nop				// This will be replaced with "bl xxx"
 					// where xxx can be any kind of tracer.
 
+ftrace_return:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.global ftrace_graph_call
 ftrace_graph_call:			// ftrace_graph_caller();
@@ -169,8 +206,65 @@ ftrace_graph_call:			// ftrace_graph_caller();
 					// "b ftrace_graph_caller"
 #endif
 
+	restore_mcount_regs
 	mcount_exit
 ENDPROC(ftrace_caller)
+
+ENTRY(ftrace_regs_caller)
+	mcount_enter
+	save_mcount_regs
+
+	/* Save the rest of pt_regs */
+	stp	x16, x17, [sp, #128]
+	stp	x18, x19, [sp, #144]
+	stp	x20, x21, [sp, #160]
+	stp	x22, x23, [sp, #176]
+	stp	x24, x25, [sp, #192]
+	stp	x26, x27, [sp, #208]
+	stp	x28, x29, [sp, #224]
+	str	x30, [sp, #S_LR]
+
+	/* Save sp before profile calling */
+	add	x9, sp, #S_FRAME_SIZE + 16
+	str	x9, [sp, #S_SP]
+
+	/* PC of pt_regs saving lr, and can be changed by handler */
+	str x30, [sp, #S_PC]
+
+	/* Save flags */
+	mrs	x9, spsr_el1
+	str	x9, [sp, #S_PSTATE]
+
+	adrp	x0, function_trace_op
+	ldr	x2, [x0, #:lo12:function_trace_op]
+	mcount_get_pc0	x0		//     function's pc
+	mcount_get_lr	x1		//     function's lr
+	mov	x3, sp
+
+	.global ftrace_regs_call
+ftrace_regs_call:			// tracer(pc, lr);
+	nop				// This will be replaced with "bl xxx"
+					// where xxx can be any kind of tracer.
+	/* Handlers can change the PC */
+	ldr	x9, [sp, #S_PC]
+	str	x9, [x29, #8]
+
+	/* Restore the rest of pt_regs */
+	ldp	x16, x17, [sp, #128]
+	ldp	x18, x19, [sp, #144]
+	ldp	x20, x21, [sp, #160]
+	ldp	x22, x23, [sp, #176]
+	ldp	x24, x25, [sp, #192]
+	ldp	x26, x27, [sp, #208]
+	ldr	x28, [sp, #224]
+	/* x29 & x30 should be restored by mcount_exit*/
+
+	/* Restore flags */
+	ldr	x9, [sp, #S_PSTATE]
+	msr	spsr_el1, x9
+
+	b	ftrace_return
+ENDPROC(ftrace_regs_caller)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(ftrace_stub)
@@ -193,6 +287,7 @@ ENTRY(ftrace_graph_caller)
 	mcount_get_parent_fp	  x2	//     parent's fp
 	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
 
+	restore_mcount_regs
 	mcount_exit
 ENDPROC(ftrace_graph_caller)
 
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index c851be7..07175bd 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -56,12 +56,24 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned long pc;
 	u32 new;
+	int ret;
 
 	pc = (unsigned long)&ftrace_call;
 	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
-					  AARCH64_INSN_BRANCH_LINK);
+			AARCH64_INSN_BRANCH_LINK);
 
-	return ftrace_modify_code(pc, 0, new, false);
+	ret = ftrace_modify_code(pc, 0, new, false);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (!ret) {
+		pc = (unsigned long)&ftrace_regs_call;
+		new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
+				AARCH64_INSN_BRANCH_LINK);
+
+		ret = ftrace_modify_code(pc, 0, new, false);
+	}
+#endif
+	return ret;
 }
 
 /*
@@ -78,6 +90,18 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		unsigned long addr)
+{
+	unsigned long pc = rec->ip;
+	u32 old, new;
+
+	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
+	new = aarch64_insn_gen_branch_imm(pc, addr, true);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
-- 
1.7.1
