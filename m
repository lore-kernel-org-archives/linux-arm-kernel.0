From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 13 Jul 2015 14:29:35 +0900
Subject: [RFC 3/3] arm64: ftrace: mcount() should not create a stack frame
In-Reply-To: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1436765375-7119-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ftrace's stack tracer on arm64 returns wrong information about call stacks:

        Depth    Size   Location    (50 entries)
        -----    ----   --------
  0)     5256       0   notifier_call_chain+0x30/0x94
  1)     5256       0   ftrace_call+0x0/0x4
  2)     5256       0   notifier_call_chain+0x2c/0x94
  3)     5256       0   raw_notifier_call_chain+0x34/0x44
  4)     5256       0   timekeeping_update.constprop.9+0xb8/0x114
  5)     5256       0   update_wall_time+0x408/0x6dc

The instrumented function, notifier_call_chain(), appears twice.

On x86 (and other arch's), mcount (or ftrace_call) does not create a new
stack frame. This will eventually result in not listing the instrumented
function in save_stack_call() because the function's returned address does
not appear as saved lr in the stack. Stack tracer, instead, explicitly adds
this skipped function at the top of the list later in check_stack().
That is why it is listed twice on arm64 as shown above.

This patch modifies arm64 function tracer not to create a stack frame at
mcount() in order to fix this issue.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/entry-ftrace.S |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 08cafc5..c74fa12 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -26,9 +26,11 @@
  * as long as the kernel is compiled without -fomit-frame-pointer.
  * (or CONFIG_FRAME_POINTER, this is forced on arm64)
  *
+ * We don't update a frame pointer here as ftrace, in special stack tracer,
+ * assumes not. If we did, the instrumented function would be listed twice.
  * stack layout after mcount_enter in _mcount():
  *
- * current sp/fp =>  0:+-----+
+ * current sp    =>  0:+-----+
  * in _mcount()        | x29 | -> instrumented function's fp
  *                     +-----+
  *                     | x30 | -> _mcount()'s lr (= instrumented function's pc)
@@ -47,7 +49,6 @@
 
 	.macro mcount_enter
 	stp	x29, x30, [sp, #-16]!
-	mov	x29, sp
 	.endm
 
 	.macro mcount_exit
@@ -61,7 +62,7 @@
 
 	/* for instrumented function's parent */
 	.macro mcount_get_parent_fp reg
-	ldr	\reg, [x29]
+	ldr	\reg, [sp]
 	ldr	\reg, [\reg]
 	.endm
 
@@ -71,18 +72,18 @@
 	.endm
 
 	.macro mcount_get_pc reg
-	ldr	\reg, [x29, #8]
+	ldr	\reg, [sp, #8]
 	mcount_adjust_addr	\reg, \reg
 	.endm
 
 	.macro mcount_get_lr reg
-	ldr	\reg, [x29]
+	ldr	\reg, [sp]
 	ldr	\reg, [\reg, #8]
 	mcount_adjust_addr	\reg, \reg
 	.endm
 
 	.macro mcount_get_lr_addr reg
-	ldr	\reg, [x29]
+	ldr	\reg, [sp]
 	add	\reg, \reg, #8
 	.endm
 
@@ -205,7 +206,7 @@ ENDPROC(ftrace_graph_caller)
  */
 ENTRY(return_to_handler)
 	str	x0, [sp, #-16]!
-	mov	x0, x29			//     parent's fp
+	mov	x0, sp			//     parent's fp
 	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
 	mov	x30, x0			// restore the original return address
 	ldr	x0, [sp], #16
-- 
1.7.9.5
