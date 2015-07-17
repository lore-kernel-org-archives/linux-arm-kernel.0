From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 18 Jul 2015 00:34:21 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
References: <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home> <55A6FA82.9000901@linaro.org>
 <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
 <20150717104144.6588b2f7@gandalf.local.home>
 <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
Message-ID: <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 17, 2015, at 11:59 PM, Jungseok Lee wrote:
> On Jul 17, 2015, at 11:41 PM, Steven Rostedt wrote:
>> On Fri, 17 Jul 2015 23:28:13 +0900
>> Jungseok Lee <jungseoklee85@gmail.com> wrote:
>> 
>> 
>>> 
>>> I have reviewed and tested the kernel including this patch and only [RFC 1/3].
>> 
>> Thanks! Can you repost patch 1 with the changes I recommended, so that
>> I can get an Acked-by from the arm64 maintainers and pull all the
>> changes in together. This is fine for a 4.3 release, right? That is, it
>> doesn't need to go into 4.2-rcs.
>> 
> 
> Welcome!
> 
> It's not hard to repost a patch, but I feel like we have to wait for Akashi's response.
> Also, it might be needed to consider Mark's comment on arch part.
> 
> If they are okay, I will proceed.

Akashi and Mark,

The [RFC 1/3] patch used in my environment is shaped as follows.
I leave the hunk for *only* clear synchronization. This is why I choose this format
instead of reposting a patch. I hope it would help to track down this thread.

Steve,

I think this is my best at this point.

Best Regards
Jungseok Lee

----8<----
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
index 407991b..9ab67af 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
 
+#include <asm/insn.h>
 #include <asm/stacktrace.h>
 
 /*
@@ -52,7 +53,7 @@ int notrace unwind_frame(struct stackframe *frame)
 	 * -4 here because we care about the PC at time of bl,
 	 * not where the return will go.
 	 */
-	frame->pc = *(unsigned long *)(fp + 8) - 4;
+	frame->pc = *(unsigned long *)(fp + 8) - AARCH64_INSN_SIZE;
 
 	return 0;
 }
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1da6029..6566201 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -260,6 +260,9 @@ static inline void ftrace_kill(void) { }
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_STACK_TRACER
+#ifndef FTRACE_STACK_FRAME_OFFSET
+#define FTRACE_STACK_FRAME_OFFSET 0
+#endif
 extern int stack_tracer_enabled;
 int
 stack_trace_sysctl(struct ctl_table *table, int write,
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index b746399..30521ea 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -105,7 +105,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 
 	/* Skip over the overhead of the stack tracer itself */
 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
-		if (stack_dump_trace[i] == ip)
+		if ((stack_dump_trace[i] + FTRACE_STACK_FRAME_OFFSET) == ip)
 			break;
 	}
 
@@ -133,7 +133,8 @@ check_stack(unsigned long ip, unsigned long *stack)
 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
 			if (stack_dump_trace[i] == ULONG_MAX)
 				break;
-			if (*p == stack_dump_trace[i]) {
+			if (*p == (stack_dump_trace[i]
+					+ FTRACE_STACK_FRAME_OFFSET)) {
 				stack_dump_trace[x] = stack_dump_trace[i++];
 				this_size = stack_dump_index[x++] =
 					(top - p) * sizeof(unsigned long);
----8<----
