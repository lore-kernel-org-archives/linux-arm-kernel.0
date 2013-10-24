From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Oct 2013 16:08:03 +0900
Subject: [PATCH v2 1/6] arm64: Add ftrace support
In-Reply-To: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1382598488-13511-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables FUNCTION_TRACER and FUNCTION_GRAPH_TRACER, and also
provides the base for other tracers which depend on FUNCTION_TRACER.

_mcount() is the entry point which is inserted at the very beginning
of every function by gcc with -pg option.
function graph tracer intercepts instrumented function's return path
by faking the return address (lr) stored in stack in order to trace
a call graph.

See Documentation/trace/ftrace-design.txt

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig               |    2 +
 arch/arm64/include/asm/ftrace.h  |   23 +++++
 arch/arm64/kernel/Makefile       |    6 ++
 arch/arm64/kernel/arm64ksyms.c   |    4 +
 arch/arm64/kernel/entry-ftrace.S |  172 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c       |   83 ++++++++++++++++++
 6 files changed, 290 insertions(+)
 create mode 100644 arch/arm64/include/asm/ftrace.h
 create mode 100644 arch/arm64/kernel/entry-ftrace.S
 create mode 100644 arch/arm64/kernel/ftrace.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index da388e4..3776319 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,6 +23,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
+	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
new file mode 100644
index 0000000..0d5dfdb
--- /dev/null
+++ b/arch/arm64/include/asm/ftrace.h
@@ -0,0 +1,23 @@
+/*
+ * arch/arm64/include/asm/ftrace.h
+ *
+ * Copyright (C) 2013 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_FTRACE_H
+#define __ASM_FTRACE_H
+
+#ifdef CONFIG_FUNCTION_TRACER
+#define MCOUNT_ADDR		((unsigned long)_mcount)
+#define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
+
+#ifndef __ASSEMBLY__
+extern void _mcount(unsigned long);
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_FUNCTION_TRACER */
+
+#endif /* __ASM_FTRACE_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index b7db65e..92429e4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -5,6 +5,11 @@
 CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_insn.o = -pg
+endif
+
 # Object file lists.
 arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
@@ -13,6 +18,7 @@ arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
+arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 41b4f62..ef9b63d 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -58,3 +58,7 @@ EXPORT_SYMBOL(clear_bit);
 EXPORT_SYMBOL(test_and_clear_bit);
 EXPORT_SYMBOL(change_bit);
 EXPORT_SYMBOL(test_and_change_bit);
+
+#ifdef CONFIG_FUNCTION_TRACER
+EXPORT_SYMBOL(_mcount);
+#endif
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
new file mode 100644
index 0000000..ae14ece
--- /dev/null
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -0,0 +1,172 @@
+/*
+ * arch/arm64/kernel/entry-ftrace.S
+ *
+ * Copyright (C) 2013 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/ftrace.h>
+
+/*
+ * Gcc with -pg will put the following code in the beginning of each function:
+ *      mov x0, x30
+ *      bl _mcount
+ * On contrary to tricky arm(32) implementation, this is a normal function
+ * call and so x0 & x30 will be safely saved and restored around tracer
+ * call (_mcount/ftrace_caller) in an instrumented function (callsite).
+ *
+ * stack layout:
+ *   0 ---------------------------------------- sp in tracer function
+ *      x29: fp in instrumented function	fp is not winded
+ *     --------------------
+ *      x30: lr in tracer function
+ * +16 --------------------
+ *      x0: arg 0 (lr in instrumented function)
+ *     --------------------
+ *      x1 (temporary)
+ * +32 --------------------
+ *      x2 (temporary)
+ *     --------------------
+ *      (don't care)
+ * +48 ---------------------------------------- sp in instrumented function
+ *
+ *     ....
+ *
+ * +xx ---------------------------------------- fp in instrumented function
+ *      x29: fp in parent function
+ *     --------------------
+ *      x30: lr in insturmented function
+ *     --------------------
+ *      xxx
+ */
+
+	.macro mcount_enter
+	stp	x29, x30, [sp, #-48]!
+	stp	x0, x1,   [sp, #16]
+	str	x2,       [sp, #32]
+	.endm
+
+	.macro mcount_exit
+	ldr	x2,       [sp, #32]
+	ldp	x0, x1,   [sp, #16]
+	ldp	x29, x30, [sp], #48
+	ret
+	.endm
+
+	.macro mcount_adjust_addr rd, rn
+	sub	\rd, \rn, #MCOUNT_INSN_SIZE
+	.endm
+
+	/* for instrumented function's parent */
+	.macro mcount_get_parent_fp reg
+	ldr	\reg, [sp]
+	ldr	\reg, [\reg]
+	.endm
+
+	/* for instrumented function */
+	.macro mcount_get_pc0 reg
+	mcount_adjust_addr	\reg, x30
+	.endm
+
+	.macro mcount_get_pc reg
+	ldr	\reg, [sp, #8]
+	mcount_adjust_addr	\reg, \reg
+	.endm
+
+	.macro mcount_get_lr reg
+	ldr	\reg, [sp, #16]
+	mcount_adjust_addr	\reg, \reg
+	.endm
+
+	.macro mcount_get_saved_lr_addr reg
+	ldr	\reg, [sp]
+	add	\reg, \reg, #8
+	.endm
+
+/*
+ * void _mcount(unsigned long return_address)
+ * @return_address: return address to instrumented function (callsite)
+ */
+ENTRY(_mcount)
+#ifdef CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST
+	ldr	x0, =ftrace_trace_stop
+	ldr	x0, [x0]		// if ftrace_trace_stop
+	ret				//   return;
+#endif
+	mcount_enter
+
+	ldr	x0, =ftrace_trace_function
+	ldr	x2, [x0]
+	adr	x0, ftrace_stub
+	cmp	x0, x2			// if (ftrace_trace_function
+	b.eq	skip_ftrace_call	//     != ftrace_stub) {
+
+	mcount_get_pc	x0		//       pc in callsite
+	mcount_get_lr	x1		//       callsite's lr (adjusted)
+	blr	x2			//   (*ftrace_trace_function)(pc, lr);
+
+#ifndef CONFIG_FUNCTION_GRAPH_TRACER
+skip_ftrace_call:			//   return;
+	mcount_exit			// }
+#else
+	mcount_exit			//   return;
+					// }
+skip_ftrace_call:
+	ldr	x1, =ftrace_graph_return
+	ldr	x2, [x1]		//   if ((ftrace_graph_return
+	cmp	x0, x2			//        != ftrace_stub)
+	b.ne	ftrace_graph_caller
+
+	ldr	x1, =ftrace_graph_entry	//     || (ftrace_graph_entry
+	ldr	x2, [x1]		//        != ftrace_graph_entry_stub))
+	ldr	x0, =ftrace_graph_entry_stub
+	cmp	x0, x2
+	b.ne	ftrace_graph_caller	//     ftrace_graph_caller();
+
+	mcount_exit
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+ENDPROC(_mcount)
+
+ENTRY(ftrace_stub)
+	ret
+ENDPROC(ftrace_stub)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/*
+ * void ftrace_graph_caller(void)
+ *
+ * This function fakes instrumented function's return address to make a hook
+ * on function return path by calling prepare_ftrace_return(). This function
+ * is assumed to be jumped into from  _mcount() or ftrace_caller() and so no
+ * context need be saved here.
+ */
+ENTRY(ftrace_graph_caller)
+	mcount_get_saved_lr_addr  x0	//     pointer to callsite's saved lr
+	mcount_get_pc		  x1	//     pc in callsite
+	mcount_get_parent_fp	  x2	//     parent's fp
+	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
+
+	mcount_exit
+ENDPROC(ftrace_graph_caller)
+
+/*
+ * void return_to_handler(void)
+ *
+ * return hook handler
+ * @fp is used to check against the value specified in ftrace_graph_caller()
+ * only when CONFIG_FUNCTION_GRAPH_FP_TEST is enabled.
+ */
+	.global return_to_handler
+return_to_handler:
+	str	x0, [sp, #-16]!
+	mov	x0, x29			//     parent's fp
+	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
+	mov	x30, x0			// restore the original return address
+	ldr	x0, [sp], #16
+	ret
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
new file mode 100644
index 0000000..e779e16
--- /dev/null
+++ b/arch/arm64/kernel/ftrace.c
@@ -0,0 +1,83 @@
+/*
+ * arch/arm64/kernel/ftrace.c
+ *
+ * Copyright (C) 2013 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/ftrace.h>
+#include <linux/swab.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/ftrace.h>
+#include <asm/insn.h>
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old, faulted;
+	struct ftrace_graph_ent trace;
+	int err;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+#if 1 /* FIXME */
+	/*
+	 * Protect against fault, even if it shouldn't
+	 * happen. This tool is too much intrusive to
+	 * ignore such a protection.
+	 * Actually we want to do
+	 *     old = *parent;
+	 *     parent = return_hooker;
+	 */
+	asm volatile(
+"1:	ldr	%0, [%2]\n"
+"2:	str	%3, [%2]\n"
+"	mov	%1, #0\n"
+"3:\n"
+"	.pushsection .fixup, \"ax\"\n"
+"4:	mov	%1, #1\n"
+"	b	3b\n"
+"	.popsection\n"
+"	.pushsection __ex_table, \"a\"\n"
+"	.align 3\n"
+"	.quad 1b, 4b, 2b, 4b\n"
+"	.popsection\n"
+	: "=&r" (old), "=r" (faulted) : "r" (parent), "r" (return_hooker)
+	);
+
+	if (unlikely(faulted)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		return;
+	}
+#else
+	old = *parent;
+	*parent = return_hooker;
+#endif
+
+	trace.func = self_addr;
+	trace.depth = current->curr_ret_stack + 1;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace)) {
+		*parent = old;
+		return;
+	}
+
+	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
+				       frame_pointer);
+	if (err == -EBUSY) {
+		*parent = old;
+		return;
+	}
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
1.7.9.5
