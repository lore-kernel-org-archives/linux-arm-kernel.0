From: duwe@lst.de (Torsten Duwe)
Date: Fri, 10 Aug 2018 18:03:06 +0200 (CEST)
Subject: [PATCH 2/3] arm64: implement live patching
In-Reply-To: <20180810160043.9E45568C76@newverein.lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de>
Message-ID: <20180810160306.2954D68C76@newverein.lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on ftrace with regs, do the usual thing. Also allocate a
task flag for whatever consistency handling is implemented.
Watch out for interactions with the graph tracer.
This code has been compile-tested, but has not yet seen any
heavy livepatching.

Signed-off-by: Torsten Duwe <duwe@suse.de>

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 28c8c03..31df287 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -117,6 +117,7 @@ config ARM64
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_LIVEPATCH
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
 	select HAVE_NMI
@@ -1343,4 +1344,6 @@ if CRYPTO
 source "arch/arm64/crypto/Kconfig"
 endif
 
+source "kernel/livepatch/Kconfig"
+
 source "lib/Kconfig"
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -76,6 +76,7 @@ void arch_release_task_struct(struct tas
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_PATCH_PENDING	6
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -94,6 +95,7 @@ void arch_release_task_struct(struct tas
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
+#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
@@ -106,7 +108,8 @@ void arch_release_task_struct(struct tas
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | \
+				 _TIF_PATCH_PENDING)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
new file mode 100644
index 0000000..6b9a3d1
--- /dev/null
+++ b/arch/arm64/include/asm/livepatch.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * livepatch.h - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2016 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _ASM_ARM64_LIVEPATCH_H
+#define _ASM_ARM64_LIVEPATCH_H
+
+#include <linux/module.h>
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_LIVEPATCH
+static inline int klp_check_compiler_support(void)
+{
+	return 0;
+}
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->pc = ip;
+}
+#endif /* CONFIG_LIVEPATCH */
+
+#endif /* _ASM_ARM64_LIVEPATCH_H */
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index cdb5866..cf640e8 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -195,6 +195,9 @@ ENTRY(ftrace_caller)
 	str	x9, [sp, #S_LR]
 	/* The program counter just after the ftrace call site */
 	str	lr, [sp, #S_PC]
+#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	mov	x19,lr          /* remember old return address */
+#endif
 	/* The stack pointer as it was on ftrace_caller entry... */
 	add	x29, sp, #S_FRAME_SIZE+16	/* ...is also our new FP */
 	str	x29, [sp, #S_SP]
@@ -210,6 +213,16 @@ ftrace_call:
 
 	bl	ftrace_stub
 
+#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	/* Is the trace function a live patcher an has messed with
+	 * the return address?
+	*/
+	ldr	x9, [sp, #S_PC]
+	cmp	x9, x19		/* compare with the value we remembered */
+	/* to not call graph tracer's "call" mechanism twice! */
+	b.ne	ftrace_regs_return
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.global ftrace_graph_call
 ftrace_graph_call:			// ftrace_graph_caller();
