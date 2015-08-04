From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  4 Aug 2015 16:44:08 +0900
Subject: [RFC v2 3/4] arm64: ftrace: fix a stack trace result under function
 graph tracer
In-Reply-To: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1438674249-3447-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph tracer modifies a saved lr register on stack in order
to hook a function return. This results in finding many bogus entries
in a stack trace list.

This patch replaces such entries with originals values stored in
current->ret_stack[].

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/stacktrace.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 496ab0f..d1790eb 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -100,6 +100,28 @@ static void notrace arm64_stack_index(struct stackframe *frame,
 	/* should not go beyond this frame */
 	if (trace->index[x] == THREAD_SIZE)
 		trace->index[x] = 0;
+
+	if (trace->entries[x] ==
+			((unsigned long)return_to_handler + 0x8)) {
+		/*
+		 * This is a case where return_to_handler() is calling
+		 * ftrace_return_to_handler(). As we are already on
+		 * an original function's stack, we have no way to fetch
+		 * a correct pc value, just skip it.
+		 */
+		trace->entries[x] = 0x0;
+	} else if (trace->entries[x] ==
+			(unsigned long)return_to_handler - AARCH64_INSN_SIZE) {
+		/*
+		 * This is a case where function graph tracer has
+		 * modified lr register on a stack to hook a function
+		 * return.
+		 * So replace it to original value.
+		 */
+		trace->entries[x] =
+			current->ret_stack[data->ret_stack_index--].ret
+							- AARCH64_INSN_SIZE;
+	}
 }
 #endif /* CONFIG_STACK_TRACER */
 
-- 
1.7.9.5
