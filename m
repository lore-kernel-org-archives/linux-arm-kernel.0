From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 13 Jul 2015 14:29:33 +0900
Subject: [RFC 1/3] ftrace: adjust a function's pc to search for in
 check_stack() for arm64
In-Reply-To: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1436765375-7119-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ftace's stack tracer on arm64 returns wrong information about call stacks:

        Depth    Size   Location    (50 entries)
        -----    ----   --------
  0)     5256       0   notifier_call_chain+0x30/0x94
  1)     5256       0   ftrace_call+0x0/0x4
  2)     5256       0   notifier_call_chain+0x2c/0x94
  3)     5256       0   raw_notifier_call_chain+0x34/0x44
  4)     5256       0   timekeeping_update.constprop.9+0xb8/0x114
  5)     5256       0   update_wall_time+0x408/0x6dc

Most of 'Size' fields are unexpectedly zero.

This is because stack tracer fails to recognize each function's stack frame
in check_stack(). Stack tracer searches for a function's pc in the stack
based on the list returned by save_stack_trace(), but save_stack_trace() on
arm64 does not return the exact return address saved in a stack frame, but
a value decrmented by 4 (which means a branch instruction's address).
This behavior was introduced by
    commit e306dfd06fcb ("ARM64: unwind: Fix PC calculation")

So the matching doesn't succeed in most cases.

This problem can be fixed either by
a) reverting the commit above
b) adding an arm64-specific hack to check_patch()

This patch does b).

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kernel/trace/trace_stack.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 3f34496..7086fc3 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -143,7 +143,11 @@ check_stack(unsigned long ip, unsigned long *stack)
 		p = start;
 
 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
+#ifdef CONFIG_ARM64
+			if (*p == (stack_dump_trace[i] + 4)) {
+#else
 			if (*p == stack_dump_trace[i]) {
+#endif
 				this_size = stack_dump_index[i++] =
 					(top - p) * sizeof(unsigned long);
 				found = 1;
-- 
1.7.9.5
