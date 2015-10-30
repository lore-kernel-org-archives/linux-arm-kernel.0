From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 30 Oct 2015 14:25:37 +0900
Subject: [PATCH v4 2/6] arm64: ftrace: modify a stack frame in a safe way
In-Reply-To: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
References: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1446182741-31019-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph tracer modifies a return address (LR) in a stack frame by
calling ftrace_prepare_return() in a traced function's function prologue.
The current code does this modification before preserving an original
address at ftrace_push_return_trace() and there is always a small window
of inconsistency when an interrupt occurs.

This doesn't matter, as far as an interrupt stack is introduced, because
stack tracer won't be invoked in an interrupt context. But it would be
better to proactively minimize such a window by moving the LR modification
after ftrace_push_return_trace().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/ftrace.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index c851be7..314f82d 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -125,23 +125,20 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 * on other archs. It's unlikely on AArch64.
 	 */
 	old = *parent;
-	*parent = return_hooker;
 
 	trace.func = self_addr;
 	trace.depth = current->curr_ret_stack + 1;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		*parent = old;
+	if (!ftrace_graph_entry(&trace))
 		return;
-	}
 
 	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
 				       frame_pointer);
-	if (err == -EBUSY) {
-		*parent = old;
+	if (err == -EBUSY)
 		return;
-	}
+	else
+		*parent = return_hooker;
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
1.7.9.5
