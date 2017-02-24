From: abelvesa@linux.com (Abel Vesa)
Date: Fri, 24 Feb 2017 22:58:20 +0000
Subject: [PATCHv4] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
Message-ID: <1487977101-29027-1-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DYNAMIC_FTRACE_WITH_REGS configuration makes it possible for a ftrace
operation to specify if registers need to saved/restored by the ftrace handler.
This is needed by kgraft and possibly other ftrace-based tools, and the ARM
architecture is currently lacking this feature. It would also be the first step
to support the "Kprobes-on-ftrace" optimization on ARM.

This patch introduces a new ftrace handler that stores the registers on the
stack before calling the next stage. The registers are restored from the stack
before going back to the instrumented function.

A side-effect of this patch is to activate the support for ftrace_modify_call()
as it defines ARCH_SUPPORTS_FTRACE_OPS for the ARM architecture.

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/ftrace.h  |  4 ++
 arch/arm/kernel/entry-ftrace.S | 83 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/ftrace.c       | 37 +++++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fda6a46..877df5b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,6 +55,7 @@ config ARM
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE && OLD_MCOUNT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 22b7311..f379881 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_ARM_FTRACE
 #define _ASM_ARM_FTRACE
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#endif
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index c73c403..3916dd6 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -92,12 +92,78 @@
 2:	mcount_exit
 .endm
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+
+.macro __ftrace_regs_caller
+
+	sub	sp, sp, #8	@ space for CPSR and OLD_R0 (not used)
+
+	add 	ip, sp, #12	@ move in IP the value of SP as it was
+				@ before the push {lr} of the mcount mechanism
+	stmdb	sp!, {ip,lr,pc}
+	stmdb	sp!, {r0-r11,lr}
+
+	@ stack content at this point:
+	@ 0  4          48   52       56   60   64    68       72
+	@ R0 | R1 | ... | LR | SP + 4 | LR | PC | PSR | OLD_R0 | previous LR |
+
+	mov r3, sp				@ struct pt_regs*
+	ldr r2, =function_trace_op
+	ldr r2, [r2]				@ pointer to the current
+						@ function tracing op
+	ldr	r1, [sp, #PT_REGS_SIZE]		@ lr of instrumented func
+	mcount_adjust_addr	r0, lr		@ instrumented function
+
+	.globl ftrace_regs_call
+ftrace_regs_call:
+	bl	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_graph_regs_call
+ftrace_graph_regs_call:
+	mov	r0, r0
+#endif
+	@ pop saved regs
+	@ first, get the previous LR value from stack
+	ldr	lr, [sp, #PT_REGS_SIZE]
+	@ now pop the rest of the saved registers INCLUDING stack pointer
+	ldmia   sp, {r0-r11, ip, sp, pc}
+.endm
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+.macro __ftrace_graph_regs_caller
+
+	sub	r0, fp, #4		@ lr of instrumented routine (parent)
+
+	@ called from __ftrace_regs_caller
+	ldr     r1, [sp, #S_LR]		@ instrumented routine (func)
+	mcount_adjust_addr	r1, r1
+
+	sub	r2, r0, #4		@ frame pointer
+	bl	prepare_ftrace_return
+
+	@ pop registers saved in ftrace_regs_caller
+	@ first, get the previous LR value from stack
+	ldr	lr, [sp, #PT_REGS_SIZE]
+	@ now pop the rest of the saved registers INCLUDING stack pointer
+	ldmia   sp, {r0-r11, ip, sp, pc}
+.endm
+#endif
+#endif
+
 .macro __ftrace_caller suffix
 	mcount_enter
 
 	mcount_get_lr	r1			@ lr of instrumented func
 	mcount_adjust_addr	r0, lr		@ instrumented function
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	ldr r2, =function_trace_op
+	ldr r2, [r2]				@ pointer to the current
+						@ function tracing op
+	mov r3, #0				@ regs is NULL
+#endif
+
 	.globl ftrace_call\suffix
 ftrace_call\suffix:
 	bl	ftrace_stub
@@ -212,6 +278,15 @@ UNWIND(.fnstart)
 	__ftrace_caller
 UNWIND(.fnend)
 ENDPROC(ftrace_caller)
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+ENTRY(ftrace_regs_caller)
+UNWIND(.fnstart)
+	__ftrace_regs_caller
+UNWIND(.fnend)
+ENDPROC(ftrace_regs_caller)
+#endif
+
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -220,6 +295,14 @@ UNWIND(.fnstart)
 	__ftrace_graph_caller
 UNWIND(.fnend)
 ENDPROC(ftrace_graph_caller)
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+ENTRY(ftrace_graph_regs_caller)
+UNWIND(.fnstart)
+	__ftrace_graph_regs_caller
+UNWIND(.fnend)
+ENDPROC(ftrace_graph_regs_caller)
+#endif
 #endif
 
 .purgem mcount_enter
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 3f17594..cb0358c 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -139,6 +139,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 	ret = ftrace_modify_code(pc, 0, new, false);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (!ret) {
+		pc = (unsigned long)&ftrace_regs_call;
+		new = ftrace_call_replace(pc, (unsigned long)func);
+
+		ret = ftrace_modify_code(pc, 0, new, false);
+	}
+#endif
+
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret) {
 		pc = (unsigned long)&ftrace_call_old;
@@ -157,11 +166,29 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	unsigned long ip = rec->ip;
 
 	old = ftrace_nop_replace(rec);
+
+	new = ftrace_call_replace(ip, adjust_address(rec, addr));
+
+	return ftrace_modify_code(rec->ip, old, new, true);
+}
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+				unsigned long addr)
+{
+	unsigned long new, old;
+	unsigned long ip = rec->ip;
+
+	old = ftrace_call_replace(ip, adjust_address(rec, old_addr));
+
 	new = ftrace_call_replace(ip, adjust_address(rec, addr));
 
 	return ftrace_modify_code(rec->ip, old, new, true);
 }
 
+#endif
+
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
@@ -229,6 +256,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 extern unsigned long ftrace_graph_call;
 extern unsigned long ftrace_graph_call_old;
 extern void ftrace_graph_caller_old(void);
+extern unsigned long ftrace_graph_regs_call;
+extern void ftrace_graph_regs_caller(void);
 
 static int __ftrace_modify_caller(unsigned long *callsite,
 				  void (*func) (void), bool enable)
@@ -251,6 +280,14 @@ static int ftrace_modify_graph_caller(bool enable)
 				     ftrace_graph_caller,
 				     enable);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	if (!ret)
+		ret = __ftrace_modify_caller(&ftrace_graph_regs_call,
+				     ftrace_graph_regs_caller,
+				     enable);
+#endif
+
+
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret)
 		ret = __ftrace_modify_caller(&ftrace_graph_call_old,
-- 
2.7.4
