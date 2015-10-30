From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 30 Oct 2015 14:25:36 +0900
Subject: [PATCH v4 1/6] arm64: ftrace: adjust callsite addresses examined by
 stack tracer
In-Reply-To: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1446182741-31019-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, no PC values returned by save_stack_trace() will match to LR
values saved in stack frames on a stack after the following commit:
    commit e306dfd06fcb ("ARM64: unwind: Fix PC calculation")
As a result, the output from stack tracer will be messed up.

This patch introduces an arch-defined macro, FTRACE_STACK_FRAME_OFFSET,
so that check_stack() can handle this case correctly.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/ftrace.h |    5 +++--
 arch/arm64/kernel/stacktrace.c  |    7 ++++---
 include/linux/ftrace.h          |    7 +++++++
 kernel/trace/trace_stack.c      |    8 +++++---
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index c5534fa..2b43e20 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -13,8 +13,9 @@
 
 #include <asm/insn.h>
 
-#define MCOUNT_ADDR		((unsigned long)_mcount)
-#define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
+#define MCOUNT_ADDR			((unsigned long)_mcount)
+#define MCOUNT_INSN_SIZE		AARCH64_INSN_SIZE
+#define FTRACE_STACK_FRAME_OFFSET	AARCH64_INSN_SIZE
 
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991b..bc0689a 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
+#include <asm/insn.h>
 #include <asm/stacktrace.h>
 
 /*
@@ -49,10 +50,10 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->sp = fp + 0x10;
 	frame->fp = *(unsigned long *)(fp);
 	/*
-	 * -4 here because we care about the PC at time of bl,
-	 * not where the return will go.
+	 * decrement PC by AARCH64_INSN_SIZE here because we care about
+	 * the PC at time of bl, not where the return will go.
 	 */
-	frame->pc = *(unsigned long *)(fp + 8) - 4;
+	frame->pc = *(unsigned long *)(fp + 8) - AARCH64_INSN_SIZE;
 
 	return 0;
 }
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6cd8c0e..d77b195 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -263,6 +263,13 @@ static inline void ftrace_kill(void) { }
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_STACK_TRACER
+/*
+ * the offset value to add to return address from save_stack_trace()
+ */
+#ifndef FTRACE_STACK_FRAME_OFFSET
+#define FTRACE_STACK_FRAME_OFFSET 0
+#endif
+
 extern int stack_tracer_enabled;
 int
 stack_trace_sysctl(struct ctl_table *table, int write,
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 8abf1ba..2e452e8 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -68,7 +68,7 @@ static inline void print_max_stack(void)
 static inline void
 check_stack(unsigned long ip, unsigned long *stack)
 {
-	unsigned long this_size, flags; unsigned long *p, *top, *start;
+	unsigned long this_size, flags; unsigned long *p, *top, *start, addr;
 	static int tracer_frame;
 	int frame_size = ACCESS_ONCE(tracer_frame);
 	int i, x;
@@ -115,7 +115,8 @@ check_stack(unsigned long ip, unsigned long *stack)
 
 	/* Skip over the overhead of the stack tracer itself */
 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
-		if (stack_dump_trace[i] == ip)
+		addr = stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET;
+		if (addr == ip)
 			break;
 	}
 
@@ -143,7 +144,8 @@ check_stack(unsigned long ip, unsigned long *stack)
 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
 			if (stack_dump_trace[i] == ULONG_MAX)
 				break;
-			if (*p == stack_dump_trace[i]) {
+			addr = stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET;
+			if (*p == addr) {
 				stack_dump_trace[x] = stack_dump_trace[i++];
 				this_size = stack_dump_index[x++] =
 					(top - p) * sizeof(unsigned long);
-- 
1.7.9.5
