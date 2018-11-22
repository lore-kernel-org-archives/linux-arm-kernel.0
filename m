From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 21 Nov 2018 20:27:11 -0500
Subject: [RFC][PATCH 03/14] arm64: function_graph: Remove use of
 FTRACE_NOTRACE_DEPTH
References: <20181122012708.491151844@goodmis.org>
Message-ID: <20181122012803.040221352@goodmis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The curr_ret_stack is no longer set to -1 when not tracing a function. It is
now done differently, and the FTRACE_NOTRACE_DEPTH value is no longer used.
Remove the reference to it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/kernel/stacktrace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4989f7ea1e59..7723dadf25be 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -61,9 +61,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 			(frame->pc == (unsigned long)return_to_handler)) {
 		if (WARN_ON_ONCE(frame->graph == -1))
 			return -EINVAL;
-		if (frame->graph < -1)
-			frame->graph += FTRACE_NOTRACE_DEPTH;
-
 		/*
 		 * This is a case where function graph tracer has
 		 * modified a return address (LR) in a stack frame
-- 
2.19.1
