From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 9 Oct 2013 15:11:53 +0530
Subject: [PATCH 1/1] ARM64/ftrace: ftrace support on ARM64.
In-Reply-To: <1381311713-20088-1-git-send-email-gkulkarni@caviumnetworks.com>
References: <1381311713-20088-1-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <1381311713-20088-2-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support for ftrace on ARM64.

This patch implements arm64 support for function trace,
dynamic function trace, function graph trace
and dynamic function graph trace.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 arch/arm64/Kconfig                  |   5 +
 arch/arm64/include/asm/ftrace.h     |  85 ++++++++++++++++
 arch/arm64/include/asm/stacktrace.h |   1 +
 arch/arm64/kernel/Makefile          |  10 +-
 arch/arm64/kernel/arm64ksyms.c      |   5 +
 arch/arm64/kernel/entry.S           | 159 +++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c          | 194 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/insn.c            |  47 +++++++++
 arch/arm64/kernel/insn.h            |  44 ++++++++
 arch/arm64/kernel/return_address.c  |  71 +++++++++++++
 scripts/recordmcount.c              |   4 +
 scripts/recordmcount.h              |   3 +-
 scripts/recordmcount.pl             |   6 ++
 13 files changed, 632 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/ftrace.h
 create mode 100644 arch/arm64/kernel/ftrace.c
 create mode 100644 arch/arm64/kernel/insn.c
 create mode 100644 arch/arm64/kernel/insn.h
 create mode 100644 arch/arm64/kernel/return_address.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9737e97..94737a2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -18,10 +18,15 @@ config ARM64
 	select GENERIC_TIME_VSYSCALL
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
+	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
+	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
+	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
new file mode 100644
index 0000000..99861bf
--- /dev/null
+++ b/arch/arm64/include/asm/ftrace.h
@@ -0,0 +1,85 @@
+/*
+ * Based on arch/arm/include/asm/ftrace.h
+ *
+ * Copyright (C) 2008 Abhishek Sagar <sagar.abhishek@gmail.com>
+ * Copyright (C) 2010 Rabin Vincent <rabin@rab.in>
+ * Copyright (C) 2013 Cavium Inc
+ * Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#ifndef _ASM_ARM_FTRACE
+#define _ASM_ARM_FTRACE
+
+#ifdef CONFIG_FUNCTION_TRACER
+#define MCOUNT_ADDR		((unsigned long) _mcount)
+#define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
+
+#ifndef __ASSEMBLY__
+extern void _mcount(void);
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+extern unsigned long ftrace_graph_call;
+extern void ftrace_graph_caller(void);
+
+struct dyn_arch_ftrace {
+		/* No extra data needed */
+};
+
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	/* With Thumb-2, the recorded addresses have the lsb set */
+	return addr & ~1;
+}
+
+#endif
+#endif
+#endif
+
+#ifndef __ASSEMBLY__
+
+#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
+/*
+ * return_address uses walk_stackframe to do it's work.  If both
+ * CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=y walk_stackframe uses unwind
+ * information.  For this to work in the function tracer many functions would
+ * have to be marked with __notrace.  So for now just depend on
+ * !CONFIG_ARM_UNWIND.
+ */
+
+void *return_address(unsigned int);
+
+#else
+
+extern inline void *return_address(unsigned int level)
+{
+	return NULL;
+}
+
+#endif
+
+#define HAVE_ARCH_CALLER_ADDR
+
+#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
+#define CALLER_ADDR1 ((unsigned long)return_address(1))
+#define CALLER_ADDR2 ((unsigned long)return_address(2))
+#define CALLER_ADDR3 ((unsigned long)return_address(3))
+#define CALLER_ADDR4 ((unsigned long)return_address(4))
+#define CALLER_ADDR5 ((unsigned long)return_address(5))
+#define CALLER_ADDR6 ((unsigned long)return_address(6))
+
+#endif /* ifndef __ASSEMBLY__ */
+
+#endif /* _ASM_ARM_FTRACE */
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 7318f6d..fec7e84 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -19,6 +19,7 @@
 struct stackframe {
 	unsigned long fp;
 	unsigned long sp;
+	unsigned long lr;
 	unsigned long pc;
 };
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7b4b564..678c218 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -5,17 +5,25 @@
 CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_insn.o = -pg
+CFLAGS_REMOVE_return_address.o = -pg
+endif
+
 # Object file lists.
 arm64-obj-y		:= cputable.o debug-monitors.o entry.o irq.o fpsimd.o	\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
-			   hyp-stub.o psci.o
+			   hyp-stub.o psci.o return_address.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+arm64-obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
+arm64-obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o insn.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 41b4f62..c5f8887 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -58,3 +58,8 @@ EXPORT_SYMBOL(clear_bit);
 EXPORT_SYMBOL(test_and_clear_bit);
 EXPORT_SYMBOL(change_bit);
 EXPORT_SYMBOL(test_and_change_bit);
+
+#ifdef CONFIG_FUNCTION_TRACER
+EXPORT_SYMBOL(_mcount);
+#endif
+
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6ad781b..c25a93e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -28,6 +28,7 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 #include <asm/unistd32.h>
+#include <asm/ftrace.h>
 
 /*
  * Bad Abort numbers
@@ -690,3 +691,161 @@ ENDPROC(sys_rt_sigreturn_wrapper)
 
 ENTRY(handle_arch_irq)
 	.quad	0
+
+
+#ifdef CONFIG_FUNCTION_TRACER
+/*
+ * When compiling with -pg, gcc inserts a call to the mcount routine at the
+ * start of every function.  In _mcount, apart from the function's address (in
+ * lr), we need to get hold of the function's caller's address.
+ *
+ * Make sure, your GNU compiler inserts the _mcount and x30(lr) stored beneath
+ * the stack frame when compiled with -pg option as below,
+ *
+ * echo 'main(){}' | arm64-gcc -x c -S -o - - -pg
+ *		.cpu thunder+fp+simd+crypto+crc
+ *		.file	""
+ *		.global	_mcount
+ *		.text
+ *		.align	2
+ *		.global	main
+ *		.type	main, %function
+ *	main:
+ *		stp	x29, x30, [sp, -16]!
+ *		add	x29, sp, 0
+ *		bl	_mcount
+ *		ldp	x29, x30, [sp], 16
+ *		ret
+ *	.size	main, .-main
+ *
+ */
+
+.macro mcount_adjust_addr xd, xn
+	bic	\xd, \xn, #1		/* clear the Thumb bit if present*/
+	sub	\xd, \xd, #MCOUNT_INSN_SIZE
+.endm
+
+.macro __mcount
+	mcount_enter
+	ldr	x0, =ftrace_trace_function
+	ldr	x2, [x0]
+	adr	x0, .Lftrace_stub
+	cmp	x0, x2
+	bne	1f
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	ldr     x1, =ftrace_graph_return
+	ldr     x2, [x1]
+	cmp     x0, x2
+	bne     ftrace_graph_caller
+
+	ldr     x1, =ftrace_graph_entry
+	ldr     x2, [x1]
+	ldr     x0, =ftrace_graph_entry_stub
+	cmp     x0, x2
+	bne     ftrace_graph_caller
+#endif
+	mcount_exit
+
+1: 	mov 	x1, x4	   		/* lr of instrumented func */
+	mcount_adjust_addr x0, lr	/* instrumented function */
+	adr	lr, 2f
+	br x2
+2:	mcount_exit
+.endm
+
+.macro __ftrace_caller
+	mcount_enter
+
+	mov 	x1, x4	   		/* lr of instrumented func */
+	mcount_adjust_addr x0, lr	/* instrumented function */
+
+	.globl ftrace_call
+ftrace_call:
+	nop
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	nop
+#endif
+	mcount_exit
+.endm
+
+/*
+ * mcount
+ */
+
+.macro mcount_enter
+	push 	x3, x4
+	ldp     x3, x4, [sp, #16]
+	push	x1, x2
+	push	x0, lr
+.endm
+
+.macro mcount_exit
+	pop	x0, lr
+	pop	x1, x2
+	pop	x3, x4
+	ret
+.endm
+
+.macro __ftrace_graph_caller
+	/* &lr of instrumented func, saved in mcount_enter */
+	sub	x0, x29, #56
+#ifdef CONFIG_DYNAMIC_FTRACE
+	/* called from __ftrace_caller, saved in mcount_enter */
+	ldr	x1, [x29, #8]
+	mcount_adjust_addr	x1, x1
+#else
+	/* called from __mcount, untouched lr */
+	mcount_adjust_addr x1, lr	/* instrumented function */
+#endif
+	mov     x2, #0x0		/* NULL for frame pointer */
+	bl	prepare_ftrace_return
+	mcount_exit
+.endm
+
+
+ENTRY(_mcount)
+#ifdef CONFIG_DYNAMIC_FTRACE
+	ret
+#else
+	__mcount
+#endif
+ENDPROC(_mcount)
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+ENTRY(ftrace_caller)
+	__ftrace_caller
+ENDPROC(ftrace_caller)
+#endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(ftrace_graph_caller)
+	__ftrace_graph_caller
+ENDPROC(ftrace_graph_caller)
+#endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl return_to_handler
+return_to_handler:
+	push	x2, x3
+	push	x0, x1
+	mov     x0, #0x0			 /* NULL frame pointer */
+	bl	ftrace_return_to_handler
+	mov 	lr, x0
+	pop 	x0, x1
+	pop 	x2, x3
+	ret
+#endif
+
+
+ENTRY(ftrace_stub)
+.Lftrace_stub:
+	ret
+ENDPROC(ftrace_stub)
+
+.purgem mcount_enter
+.purgem mcount_exit
+#endif /* CONFIG_FUNCTION_TRACER */
+
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
new file mode 100644
index 0000000..6b4ed90
--- /dev/null
+++ b/arch/arm64/kernel/ftrace.c
@@ -0,0 +1,194 @@
+/*
+ * Dynamic and Graph function tracing support.
+ *
+ * Based on arch/arm/kernel/ftrace.c
+ *
+ * Copyright (C) 2008 Abhishek Sagar <sagar.abhishek@gmail.com>
+ * Copyright (C) 2010 Rabin Vincent <rabin@rab.in>
+ * Copyright (C) 2013 Cavium Inc
+ * Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Defines low-level handling of mcount calls when the kernel
+ * is compiled with the -pg flag. When using dynamic ftrace, the
+ * mcount call-sites get patched with NOP till they are enabled.
+ * All code mutation routines here are called under stop_machine().
+ */
+
+#include <linux/ftrace.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <asm/ftrace.h>
+
+#include "insn.h"
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define	NOP		0xd503201f	/* nop */
+
+static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
+{
+	return NOP;
+}
+
+static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
+{
+	return addr;
+}
+
+static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
+{
+	return arm_gen_branch_link(pc, addr);
+}
+
+static int ftrace_modify_code(unsigned long pc, unsigned int old,
+			      unsigned int new, bool validate)
+{
+	unsigned int replaced;
+
+	if (validate) {
+		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
+			return -EFAULT;
+
+		if (replaced != old)
+			return -EINVAL;
+	}
+
+	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
+		return -EPERM;
+
+	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+
+	return 0;
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	unsigned long pc;
+	unsigned int new;
+	int ret = 0;
+
+	pc = (unsigned long)&ftrace_call;
+	new = ftrace_call_replace(pc, (unsigned long)func);
+	ret = ftrace_modify_code(pc, 0, new, false);
+
+	return ret;
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned int new, old;
+	unsigned long ip = rec->ip;
+	int ret;
+
+	old = ftrace_nop_replace(rec);
+	new = ftrace_call_replace(ip, adjust_address(rec, addr));
+	ret = ftrace_modify_code(rec->ip, old, new, true);
+
+	return ret;
+}
+
+int ftrace_make_nop(struct module *mod,
+		    struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long ip = rec->ip;
+	unsigned int old;
+	unsigned int new;
+	int ret;
+
+	old = ftrace_call_replace(ip, adjust_address(rec, addr));
+	new = ftrace_nop_replace(rec);
+	ret = ftrace_modify_code(ip, old, new, true);
+
+	return ret;
+}
+
+int __init ftrace_dyn_arch_init(void *data)
+{
+	*(unsigned long *)data = 0;
+
+	return 0;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long) &return_to_handler;
+	struct ftrace_graph_ent trace;
+	unsigned long old;
+	int err;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+	*parent = return_hooker;
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
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+static int __ftrace_modify_caller(unsigned long *callsite,
+				  void (*func) (void), bool enable)
+{
+	unsigned long caller_fn = (unsigned long) func;
+	unsigned long pc = (unsigned long) callsite;
+	unsigned int  branch = arm_gen_branch(pc, caller_fn);
+	unsigned int nop = NOP;
+	unsigned int old = enable ? nop : branch;
+	unsigned int new = enable ? branch : nop;
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+static int ftrace_modify_graph_caller(bool enable)
+{
+	int ret;
+
+	ret = __ftrace_modify_caller(&ftrace_graph_call,
+					     ftrace_graph_caller,
+					     enable);
+
+	return ret;
+}
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(true);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	return ftrace_modify_graph_caller(false);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
new file mode 100644
index 0000000..abad4a1
--- /dev/null
+++ b/arch/arm64/kernel/insn.c
@@ -0,0 +1,47 @@
+/*
+ * Based on arch/arm/kernel/insn.c
+ *
+ * Copyright (C) 2013 Cavium Inc
+ * Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+static unsigned long
+__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
+{
+	unsigned int opcode = 0x14000000;
+	int offset;
+
+	if (link)
+		opcode |= 1 << 31;
+
+	offset = (long)addr - (long)(pc);
+	if (unlikely(offset < -33554432 || offset > 33554428)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	offset = (offset >> 2) & 0x03ffffff;
+	return opcode | offset;
+}
+
+unsigned long
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link)
+{
+		return __arm_gen_branch_arm(pc, addr, link);
+}
diff --git a/arch/arm64/kernel/insn.h b/arch/arm64/kernel/insn.h
new file mode 100644
index 0000000..8443b3f
--- /dev/null
+++ b/arch/arm64/kernel/insn.h
@@ -0,0 +1,44 @@
+/*
+ * Based on arch/arm/kernel/insn.h
+ *
+ * Copyright (C) 2013 Cavium Inc
+ * Author: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+#ifndef __ASM_ARM_INSN_H
+#define __ASM_ARM_INSN_H
+
+static inline unsigned long
+arm_gen_nop(void)
+{
+	return 0xd503201f; /* nop */
+}
+
+unsigned long
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
+
+static inline unsigned long
+arm_gen_branch(unsigned long pc, unsigned long addr)
+{
+	return __arm_gen_branch(pc, addr, false);
+}
+
+static inline unsigned long
+arm_gen_branch_link(unsigned long pc, unsigned long addr)
+{
+	return __arm_gen_branch(pc, addr, true);
+}
+
+#endif
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
new file mode 100644
index 0000000..9d28789
--- /dev/null
+++ b/arch/arm64/kernel/return_address.c
@@ -0,0 +1,71 @@
+/*
+ * Copy of arch/arm/kernel/return_address.c
+ *
+ * Copyright (C) 2009 Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ * for Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/export.h>
+#include <linux/ftrace.h>
+
+#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
+#include <linux/sched.h>
+
+#include <asm/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static int save_return_addr(struct stackframe *frame, void *d)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)frame->pc;
+
+		return 1;
+	} else {
+		--data->level;
+		return 0;
+	}
+}
+
+void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+	struct stackframe frame;
+	register unsigned long current_sp asm ("sp");
+
+	data.level = level + 2;
+	data.addr = NULL;
+
+	frame.fp = (unsigned long)__builtin_frame_address(0);
+	frame.sp = current_sp;
+	frame.lr = (unsigned long)__builtin_return_address(0);
+	frame.pc = (unsigned long)return_address;
+
+	walk_stackframe(&frame, save_return_addr, &data);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+}
+#else /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
+
+#if defined(CONFIG_ARM_UNWIND)
+#warning "TODO: return_address should use unwind tables"
+#endif
+
+void *return_address(unsigned int level)
+{
+	return NULL;
+}
+#endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
+EXPORT_SYMBOL_GPL(return_address);
+
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 9c22317..b92d9f7 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -347,6 +347,10 @@ do_file(char const *const fname)
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
 			 break;
+	case EM_AARCH64:
+			 reltype = R_AARCH64_ABS64;
+			 altmcount = "_mcount";
+			 break;
 	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
 	case EM_METAG:	 reltype = R_METAG_ADDR32;
 			 altmcount = "_mcount_wrapper";
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 9d1421e..5b7752c 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -433,7 +433,8 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
 			/* avoid STB_WEAK */
 		    && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
 			/* function symbols on ARM have quirks, avoid them */
-			if (w2(ehdr->e_machine) == EM_ARM
+			if ((w2(ehdr->e_machine) == EM_ARM
+					|| w2(ehdr->e_machine) == EM_AARCH64)
 			    && ELF_ST_TYPE(symp->st_info) == STT_FUNC)
 				continue;
 
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 858966a..126eb74 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -279,6 +279,12 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_ARM_(CALL|PC24|THM_CALL)" .
 			"\\s+(__gnu_mcount_nc|mcount)\$";
 
+} elsif ($arch eq "arm64") {
+    $alignment = 2;
+    $section_type = '%progbits';
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_ARM_(CALL|PC24|THM_CALL)" .
+			"\\s+(__gnu_mcount_nc|_mcount)\$";
+
 } elsif ($arch eq "ia64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
     $type = "data8";
-- 
1.8.1.4
