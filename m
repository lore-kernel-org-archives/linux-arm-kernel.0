From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 15 Jul 2015 12:13:37 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150715105536.42949ea9@gandalf.local.home>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
 <1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>
 <DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>
 <20150714093154.4d73e551@gandalf.local.home>
 <55A5A75A.1060401@linaro.org>
 <20150714225105.6c1e4f15@gandalf.local.home>
 <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
Message-ID: <20150715121337.3b31aa84@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015 10:55:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> I'll take a look at it and try to clean up the code.

Does the  following patch make sense for you?

-- Steve

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 3f34496244e9..9384647d07c3 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -18,12 +18,6 @@
 
 #define STACK_TRACE_ENTRIES 500
 
-#ifdef CC_USING_FENTRY
-# define fentry		1
-#else
-# define fentry		0
-#endif
-
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
 static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
@@ -35,7 +29,7 @@ static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
  */
 static struct stack_trace max_stack_trace = {
 	.max_entries		= STACK_TRACE_ENTRIES - 1,
-	.entries		= &stack_dump_trace[1],
+	.entries		= &stack_dump_trace[0],
 };
 
 static unsigned long max_stack_size;
@@ -77,7 +71,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
 	static int tracer_frame;
 	int frame_size = ACCESS_ONCE(tracer_frame);
-	int i;
+	int i, x;
 
 	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
 	this_size = THREAD_SIZE - this_size;
@@ -105,26 +99,20 @@ check_stack(unsigned long ip, unsigned long *stack)
 	max_stack_size = this_size;
 
 	max_stack_trace.nr_entries = 0;
-
-	if (using_ftrace_ops_list_func())
-		max_stack_trace.skip = 4;
-	else
-		max_stack_trace.skip = 3;
+	max_stack_trace.skip = 0;
 
 	save_stack_trace(&max_stack_trace);
 
-	/*
-	 * Add the passed in ip from the function tracer.
-	 * Searching for this on the stack will skip over
-	 * most of the overhead from the stack tracer itself.
-	 */
-	stack_dump_trace[0] = ip;
-	max_stack_trace.nr_entries++;
+	/* Skip over the overhead of the stack tracer itself */
+	for (i = 0; i < max_stack_trace.nr_entries; i++) {
+		if (stack_dump_trace[i] == ip)
+			break;
+	}
 
 	/*
 	 * Now find where in the stack these are.
 	 */
-	i = 0;
+	x = 0;
 	start = stack;
 	top = (unsigned long *)
 		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
@@ -139,12 +127,13 @@ check_stack(unsigned long ip, unsigned long *stack)
 	while (i < max_stack_trace.nr_entries) {
 		int found = 0;
 
-		stack_dump_index[i] = this_size;
+		stack_dump_index[x] = this_size;
 		p = start;
 
 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
 			if (*p == stack_dump_trace[i]) {
-				this_size = stack_dump_index[i++] =
+				stack_dump_trace[x] = stack_dump_trace[i++];
+				this_size = stack_dump_index[x++] =
 					(top - p) * sizeof(unsigned long);
 				found = 1;
 				/* Start the search from here */
@@ -168,6 +157,9 @@ check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
+	for (; x < max_stack_trace.nr_entries; x++)
+		stack_dump_trace[x] = ULONG_MAX;
+
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
 		BUG();
@@ -192,24 +184,7 @@ stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (per_cpu(trace_active, cpu)++ != 0)
 		goto out;
 
-	/*
-	 * When fentry is used, the traced function does not get
-	 * its stack frame set up, and we lose the parent.
-	 * The ip is pretty useless because the function tracer
-	 * was called before that function set up its stack frame.
-	 * In this case, we use the parent ip.
-	 *
-	 * By adding the return address of either the parent ip
-	 * or the current ip we can disregard most of the stack usage
-	 * caused by the stack tracer itself.
-	 *
-	 * The function tracer always reports the address of where the
-	 * mcount call was, but the stack will hold the return address.
-	 */
-	if (fentry)
-		ip = parent_ip;
-	else
-		ip += MCOUNT_INSN_SIZE;
+	ip += MCOUNT_INSN_SIZE;
 
 	check_stack(ip, &stack);
 
