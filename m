From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  8 Oct 2015 19:01:42 +0900
Subject: [PATCH v3 5/7] ftrace: allow arch-specific stack tracer
In-Reply-To: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1444298504-10392-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A stack frame may be used in a different way depending on cpu architecture.
Thus it is not always appropriate to slurp the stack contents, as current
check_stack() does, in order to calcurate a stack index (height) at a given
function call. At least not on arm64.
In addition, there is a possibility that we will mistakenly detect a stale
stack frame which has not been overwritten.

This patch makes check_stack() a weak function so as to later implement
arch-specific version.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/ftrace.h     |   10 ++++++++++
 kernel/trace/trace_stack.c |   22 ++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d77b195..e538400 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -270,7 +270,17 @@ static inline void ftrace_kill(void) { }
 #define FTRACE_STACK_FRAME_OFFSET 0
 #endif
 
+#define STACK_TRACE_ENTRIES 500
+
+struct stack_trace;
+
+extern unsigned stack_dump_index[];
+extern struct stack_trace max_stack_trace;
+extern unsigned long max_stack_size;
+extern arch_spinlock_t max_stack_lock;
+
 extern int stack_tracer_enabled;
+void print_max_stack(void);
 int
 stack_trace_sysctl(struct ctl_table *table, int write,
 		   void __user *buffer, size_t *lenp,
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 30521ea..ff1a191 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -16,24 +16,22 @@
 
 #include "trace.h"
 
-#define STACK_TRACE_ENTRIES 500
-
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
-static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
+unsigned stack_dump_index[STACK_TRACE_ENTRIES];
 
 /*
  * Reserve one entry for the passed in ip. This will allow
  * us to remove most or all of the stack size overhead
  * added by the stack tracer itself.
  */
-static struct stack_trace max_stack_trace = {
+struct stack_trace max_stack_trace = {
 	.max_entries		= STACK_TRACE_ENTRIES - 1,
 	.entries		= &stack_dump_trace[0],
 };
 
-static unsigned long max_stack_size;
-static arch_spinlock_t max_stack_lock =
+unsigned long max_stack_size;
+arch_spinlock_t max_stack_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 static DEFINE_PER_CPU(int, trace_active);
@@ -42,7 +40,7 @@ static DEFINE_MUTEX(stack_sysctl_mutex);
 int stack_tracer_enabled;
 static int last_stack_tracer_enabled;
 
-static inline void print_max_stack(void)
+void print_max_stack(void)
 {
 	long i;
 	int size;
@@ -65,7 +63,15 @@ static inline void print_max_stack(void)
 	}
 }
 
-static inline void
+/*
+ * When arch-specific code overides this function, the following
+ * data should be filled up, assuming max_stack_lock is held to
+ * prevent concurrent updates.
+ *     stack_dump_index[]
+ *     max_stack_trace
+ *     max_stack_size
+ */
+void __weak
 check_stack(unsigned long ip, unsigned long *stack)
 {
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
-- 
1.7.9.5
