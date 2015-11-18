From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 18 Nov 2015 15:43:08 +0900
Subject: [PATCH v6 5/6] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
References: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1447828989-4980-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Background and issues on generic check_stack():
1) slurping stack

    Assume that a given function A was invoked, and it was invoked again in
    another context, then it called another function B which allocated
    a large size of local variables on the stack, but it has not modified
    the variable(s) yet.
    When stack tracer, check_stack(), examines the stack looking for B,
    then A, we may have a chance to accidentally find a stale, not current,
    stack frame for A because the old frame might reside on the memory for
    the variable which has not been overwritten.

    (issue) The stack_trace output may have stale entries.

2) differences between x86 and arm64

    On x86, "call" instruction automatically pushes a return address on
    the top of the stack and decrements a stack pointer. Then child
    function allocates its local variables on the stack.

    On arm64, a child function is responsible for allocating memory for
    local variables as well as a stack frame, and explicitly pushes
    a return address (LR) and old frame pointer in its function prologue
    *after* decreasing a stack pointer.

    Generic check_stack() recogizes 'idxB,' which is the next address of
    the location where 'fpB' is found, in the picture below as an estimated
    stack pointer. This seems to fine with x86, but on arm64, 'idxB' is
    not appropriate just because it contains child function's "local
    variables."
    We should instead use spB, if possible, for better interpretation of
    func_B's stack usage.

LOW      |  ...   |
fpA      +--------+   func_A (pcA, fpA, spA)
         |  fpB   |
    idxB + - - - -+
         |  pcB   |
         |  ... <----------- static local variables in func_A
         |  ...   |             and extra function args to func_A
spB      + - - - -+
         |  ... <----------- dynamically allocated variables in func_B
fpB      +--------+   func_B (pcB, fpB, spB)
         |  fpC   |
    idxC + - - - -+
         |  pcC   |
         |  ... <----------- static local variables in func_B
         |  ...   |             and extra function args to func_B
spC      + - - - -+
         |  ...   |
fpC      +--------+   func_C (pcC, fpC, spC)
HIGH     |        |

    (issue) Stack size for a function in stack_trace output is inaccurate,
            or rather wrong.  It looks as if <Size> field is one-line
	    offset against <Location>.

                Depth    Size   Location    (49 entries)
                -----    ----   --------
         40)     1416      64   path_openat+0x128/0xe00       -> 176
         41)     1352     176   do_filp_open+0x74/0xf0        -> 256
         42)     1176     256   do_open_execat+0x74/0x1c8     -> 80
         43)      920      80   open_exec+0x3c/0x70           -> 32
         44)      840      32   load_elf_binary+0x294/0x10c8

Stack tracer on arm64:
Our approach in check_stack() is uniqeue in the following points:
* analyze a function prologue of a traced function to estimate a more
  accurate stack pointer value, replacing naive '<child's fp> + 0x10.'
* use walk_stackframe(), instead of slurping stack contents as orignal
  check_stack() does, to identify a stack frame and a stack index (height)
  for every callsite.

Regarding a function prologue analyzer, there is no guarantee that we can
handle all the possible patterns of function prologue as gcc does not use
any fixed templates to generate them. 'Instruction scheduling' is another
issue here.
Nevertheless, the current version will surely cover almost all the cases
in the kernel image and give us useful information on stack pointers.

So this patch utilizes a function prologue only for stack tracer, and
does not affect the behaviors of existing stacktrace functions.

Reviewed-by: Jungseok Lee <jungseoklee85@gmail.com>
Tested-by: Jungseok Lee <jungseoklee85@gmail.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ftrace.h     |    2 +-
 arch/arm64/include/asm/stacktrace.h |    4 +
 arch/arm64/kernel/ftrace.c          |   64 ++++++++++++
 arch/arm64/kernel/stacktrace.c      |  190 ++++++++++++++++++++++++++++++++++-
 4 files changed, 256 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 3c60f37..6795219 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -26,7 +26,7 @@ struct dyn_arch_ftrace {
 	/* No extra data needed for arm64 */
 };
 
-extern unsigned long ftrace_graph_call;
+extern u32 ftrace_graph_call;
 
 extern void return_to_handler(void);
 
diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 801a16db..0eee008 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -30,5 +30,9 @@ struct stackframe {
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
+#ifdef CONFIG_STACK_TRACER
+struct stack_trace;
+extern void save_stack_trace_sp(struct stack_trace *trace, unsigned long *sp);
+#endif
 
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 314f82d..102ed59 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/bug.h>
 #include <linux/ftrace.h>
 #include <linux/swab.h>
 #include <linux/uaccess.h>
@@ -16,6 +17,7 @@
 #include <asm/cacheflush.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/stacktrace.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
@@ -173,3 +175,65 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#ifdef CONFIG_STACK_TRACER
+static unsigned long stack_trace_sp[STACK_TRACE_ENTRIES];
+static unsigned long raw_stack_trace_max_size;
+
+void check_stack(unsigned long ip, unsigned long *stack)
+{
+	unsigned long this_size, flags;
+	unsigned long top;
+	int i, j;
+
+	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
+	this_size = THREAD_SIZE - this_size;
+
+	if (this_size <= raw_stack_trace_max_size)
+		return;
+
+	/* we do not handle an interrupt stack yet */
+	if (!object_is_on_stack(stack))
+		return;
+
+	local_irq_save(flags);
+	arch_spin_lock(&stack_trace_max_lock);
+
+	/* check again */
+	if (this_size <= raw_stack_trace_max_size)
+		goto out;
+
+	/* find out stack frames */
+	stack_trace_max.nr_entries = 0;
+	stack_trace_max.skip = 0;
+	save_stack_trace_sp(&stack_trace_max, stack_trace_sp);
+	stack_trace_max.nr_entries--; /* for the last entry ('-1') */
+
+	/* calculate a stack index for each function */
+	top = ((unsigned long)stack & ~(THREAD_SIZE-1)) + THREAD_SIZE;
+	for (i = 0; i < stack_trace_max.nr_entries; i++)
+		stack_trace_index[i] = top - stack_trace_sp[i];
+	raw_stack_trace_max_size = this_size;
+
+	/* Skip over the overhead of the stack tracer itself */
+	for (i = 0; i < stack_trace_max.nr_entries; i++)
+		if (stack_trace_max.entries[i] == ip)
+			break;
+
+	stack_trace_max.nr_entries -= i;
+	for (j = 0; j < stack_trace_max.nr_entries; j++) {
+		stack_trace_index[j] = stack_trace_index[j + i];
+		stack_trace_max.entries[j] = stack_trace_max.entries[j + i];
+	}
+	stack_trace_max_size = stack_trace_index[0];
+
+	if (task_stack_end_corrupted(current)) {
+		WARN(1, "task stack is corrupted.\n");
+		stack_trace_print();
+	}
+
+ out:
+	arch_spin_unlock(&stack_trace_max_lock);
+	local_irq_restore(flags);
+}
+#endif /* CONFIG_STACK_TRACER */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 0a39049..1d18bc4 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -24,6 +24,149 @@
 #include <asm/irq.h>
 #include <asm/stacktrace.h>
 
+#ifdef CONFIG_STACK_TRACER
+/*
+ * This function parses a function prologue of a traced function and
+ * determines its stack size.
+ * A return value indicates a location of @pc in a function prologue.
+ * @return value:
+ * <case 1>                       <case 1'>
+ * 1:
+ *     sub sp, sp, #XX            sub sp, sp, #XX
+ * 2:
+ *     stp x29, x30, [sp, #YY]    stp x29, x30, [sp, #--ZZ]!
+ * 3:
+ *     add x29, sp, #YY           mov x29, sp
+ * 0:
+ *
+ * <case 2>
+ * 1:
+ *     stp x29, x30, [sp, #-XX]!
+ * 3:
+ *     mov x29, sp
+ * 0:
+ *
+ * @size: sp offset from calller's sp (XX or XX + ZZ)
+ * @size2: fp offset from new sp (YY or 0)
+ */
+static int analyze_function_prologue(unsigned long pc,
+		unsigned long *size, unsigned long *size2)
+{
+	unsigned long offset;
+	u32 *addr, insn;
+	int pos = -1;
+	enum aarch64_insn_register src, dst, reg1, reg2, base;
+	int imm;
+	enum aarch64_insn_variant variant;
+	enum aarch64_insn_adsb_type adsb_type;
+	enum aarch64_insn_ldst_type ldst_type;
+
+	*size = *size2 = 0;
+
+	if (!pc)
+		goto out;
+
+	if (unlikely(!kallsyms_lookup_size_offset(pc, NULL, &offset)))
+		goto out;
+
+	addr = (u32 *)(pc - offset);
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (addr == (u32 *)ftrace_graph_caller)
+#ifdef CONFIG_DYNAMIC_FTRACE
+		addr = (u32 *)ftrace_caller;
+#else
+		addr = (u32 *)_mcount;
+#endif
+	else
+#endif
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (addr == (u32 *)ftrace_call)
+		addr = (u32 *)ftrace_caller;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	else if (addr == &ftrace_graph_call)
+		addr = (u32 *)ftrace_caller;
+#endif
+#endif
+
+	insn = le32_to_cpu(*addr);
+	pos = 1;
+
+	/* analyze a function prologue */
+	while ((unsigned long)addr < pc) {
+		if (aarch64_insn_is_branch_imm(insn) ||
+		    aarch64_insn_is_br(insn) ||
+		    aarch64_insn_is_blr(insn) ||
+		    aarch64_insn_is_ret(insn) ||
+		    aarch64_insn_is_eret(insn))
+			/* exiting a basic block */
+			goto out;
+
+		if (aarch64_insn_decode_add_sub_imm(insn, &dst, &src,
+					&imm, &variant, &adsb_type)) {
+			if ((adsb_type == AARCH64_INSN_ADSB_SUB) &&
+				(dst == AARCH64_INSN_REG_SP) &&
+				(src == AARCH64_INSN_REG_SP)) {
+				/*
+				 * Starting the following sequence:
+				 *   sub sp, sp, #xx
+				 *   stp x29, x30, [sp, #yy]
+				 *   add x29, sp, #yy
+				 */
+				WARN_ON(pos != 1);
+				pos = 2;
+				*size += imm;
+			} else if ((adsb_type == AARCH64_INSN_ADSB_ADD) &&
+				(dst == AARCH64_INSN_REG_29) &&
+				(src == AARCH64_INSN_REG_SP)) {
+				/*
+				 *   add x29, sp, #yy
+				 * or
+				 *   mov x29, sp
+				 */
+				WARN_ON(pos != 3);
+				pos = 0;
+				*size2 = imm;
+
+				break;
+			}
+		} else if (aarch64_insn_decode_load_store_pair(insn,
+					&reg1, &reg2, &base, &imm,
+					&variant, &ldst_type)) {
+			if ((ldst_type ==
+				AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX) &&
+			    (reg1 == AARCH64_INSN_REG_29) &&
+			    (reg2 == AARCH64_INSN_REG_30) &&
+			    (base == AARCH64_INSN_REG_SP)) {
+				/*
+				 * Starting the following sequence:
+				 *   stp x29, x30, [sp, #-xx]!
+				 *   mov x29, sp
+				 */
+				WARN_ON(!((pos == 1) || (pos == 2)));
+				pos = 3;
+				*size += -imm;
+			} else if ((ldst_type ==
+				AARCH64_INSN_LDST_STORE_PAIR) &&
+			    (reg1 == AARCH64_INSN_REG_29) &&
+			    (reg2 == AARCH64_INSN_REG_30) &&
+			    (base == AARCH64_INSN_REG_SP)) {
+				/*
+				 *   stp x29, x30, [sp, #yy]
+				 */
+				WARN_ON(pos != 2);
+				pos = 3;
+			}
+		}
+
+		addr++;
+		insn = le32_to_cpu(*addr);
+	}
+
+out:
+	return pos;
+}
+#endif
+
 /*
  * AArch64 PCS assigns the frame pointer to x29.
  *
@@ -112,6 +255,9 @@ struct stack_trace_data {
 	struct stack_trace *trace;
 	unsigned int no_sched_functions;
 	unsigned int skip;
+#ifdef CONFIG_STACK_TRACER
+	unsigned long *sp;
+#endif
 };
 
 static int save_trace(struct stackframe *frame, void *d)
@@ -127,18 +273,42 @@ static int save_trace(struct stackframe *frame, void *d)
 		return 0;
 	}
 
+#ifdef CONFIG_STACK_TRACER
+	if (data->sp) {
+		if (trace->nr_entries) {
+			unsigned long child_pc, sp_off, fp_off;
+			int pos;
+
+			child_pc = trace->entries[trace->nr_entries - 1];
+			pos = analyze_function_prologue(child_pc,
+					&sp_off, &fp_off);
+			/*
+			 * frame->sp - 0x10 is actually a child's fp.
+			 * See above.
+			 */
+			data->sp[trace->nr_entries] = (pos < 0 ? frame->sp :
+					(frame->sp - 0x10) + sp_off - fp_off);
+		} else {
+			data->sp[0] = frame->sp;
+		}
+	}
+#endif
 	trace->entries[trace->nr_entries++] = addr;
 
 	return trace->nr_entries >= trace->max_entries;
 }
 
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+static void __save_stack_trace_tsk(struct task_struct *tsk,
+		struct stack_trace *trace, unsigned long *stack_dump_sp)
 {
 	struct stack_trace_data data;
 	struct stackframe frame;
 
 	data.trace = trace;
 	data.skip = trace->skip;
+#ifdef CONFIG_STACK_TRACER
+	data.sp = stack_dump_sp;
+#endif
 
 	if (tsk != current) {
 		data.no_sched_functions = 1;
@@ -149,7 +319,8 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		data.no_sched_functions = 0;
 		frame.fp = (unsigned long)__builtin_frame_address(0);
 		frame.sp = current_stack_pointer;
-		frame.pc = (unsigned long)save_stack_trace_tsk;
+		asm("1:");
+		asm("ldr %0, =1b" : "=r" (frame.pc));
 	}
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	frame.graph = tsk->curr_ret_stack;
@@ -160,9 +331,22 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(tsk, trace, NULL);
+}
+
 void save_stack_trace(struct stack_trace *trace)
 {
-	save_stack_trace_tsk(current, trace);
+	__save_stack_trace_tsk(current, trace, NULL);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
+
+#ifdef CONFIG_STACK_TRACER
+void save_stack_trace_sp(struct stack_trace *trace,
+					unsigned long *stack_dump_sp)
+{
+	__save_stack_trace_tsk(current, trace, stack_dump_sp);
+}
+#endif /* CONFIG_STACK_TRACER */
 #endif
-- 
1.7.9.5
