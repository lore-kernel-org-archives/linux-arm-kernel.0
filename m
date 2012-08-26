From: ccross@android.com (Colin Cross)
Date: Sun, 26 Aug 2012 15:46:56 -0700
Subject: [PATCH 2/2] ARM: unwind: enable dumping stacks for SMP && ARM_UNWIND
In-Reply-To: <1346021216-21979-1-git-send-email-ccross@android.com>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
Message-ID: <1346021216-21979-3-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unwinding with CONFIG_ARM_UNWIND is much more complicated than
unwinding with CONFIG_FRAME_POINTER, but there are only a few points
that require validation in order to avoid faults or infinite loops.
Avoiding faults is easy by adding checks to verify that all accesses
relative to the frame's stack pointer remain inside the stack.

When CONFIG_FRAME_POINTER is not set it is possible for two frames to
have the same SP, so there is no way to avoid repeated calls to
unwind_frame continuing forever.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/kernel/stacktrace.c |   12 ------------
 arch/arm/kernel/unwind.c     |   31 +++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 45e6b7e..f51dd68 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -105,23 +105,11 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	data.skip = trace->skip;
 
 	if (tsk != current) {
-#if defined(CONFIG_SMP) || \
-	(defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND))
-		/*
-		 * What guarantees do we have here that 'tsk' is not
-		 * running on another CPU?  For now, ignore it as we
-		 * can't guarantee we won't explode.
-		 */
-		if (trace->nr_entries < trace->max_entries)
-			trace->entries[trace->nr_entries++] = ULONG_MAX;
-		return;
-#else
 		data.no_sched_functions = 1;
 		frame.fp = thread_saved_fp(tsk);
 		frame.sp = thread_saved_sp(tsk);
 		frame.lr = 0;		/* recovered from the stack */
 		frame.pc = thread_saved_pc(tsk);
-#endif
 	} else {
 		register unsigned long current_sp asm ("sp");
 
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
 00df012..b3a09ad 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -98,6 +98,16 @@ enum regs {
 	(unsigned long)(ptr) + offset;			\
 })
 
+static bool valid_stack_addr(unsigned long sp, unsigned long *vsp)
+{
+	unsigned long low;
+	unsigned long high;
+
+	low = round_down(sp, THREAD_SIZE) + sizeof(struct thread_info);
+	high = ALIGN(sp, THREAD_SIZE);
+	return ((unsigned long)vsp >= low && (unsigned long)vsp < high);
+}
+
 /*
  * Binary search in the unwind index. The entries are
  * guaranteed to be sorted in ascending order by the linker.
@@ -241,6 +251,7 @@ static unsigned long unwind_get_byte(struct unwind_ctrl_block *ctrl)
 static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 {
 	unsigned long insn = unwind_get_byte(ctrl);
+	unsigned long orig_sp = ctrl->vrs[SP];
 
 	pr_debug("%s: insn = %08lx\n", __func__, insn);
 
@@ -264,8 +275,11 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		/* pop R4-R15 according to mask */
 		load_sp = mask & (1 << (13 - 4));
 		while (mask) {
-			if (mask & 1)
+			if (mask & 1) {
+				if (!valid_stack_addr(orig_sp, vsp))
+					return -URC_FAILURE;
 				ctrl->vrs[reg] = *vsp++;
+			}
 			mask >>= 1;
 			reg++;
 		}
@@ -279,10 +293,16 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		int reg;
 
 		/* pop R4-R[4+bbb] */
-		for (reg = 4; reg <= 4 + (insn & 7); reg++)
+		for (reg = 4; reg <= 4 + (insn & 7); reg++) {
+			if (!valid_stack_addr(orig_sp, vsp))
+				return -URC_FAILURE;
 			ctrl->vrs[reg] = *vsp++;
-		if (insn & 0x80)
+		}
+		if (insn & 0x80) {
+			if (!valid_stack_addr(orig_sp, vsp))
+				return -URC_FAILURE;
 			ctrl->vrs[14] = *vsp++;
+		}
 		ctrl->vrs[SP] = (unsigned long)vsp;
 	} else if (insn == 0xb0) {
 		if (ctrl->vrs[PC] == 0)
@@ -302,8 +322,11 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 
 		/* pop R0-R3 according to mask */
 		while (mask) {
-			if (mask & 1)
+			if (mask & 1) {
+				if (!valid_stack_addr(orig_sp, vsp))
+					return -URC_FAILURE;
 				ctrl->vrs[reg] = *vsp++;
+			}
 			mask >>= 1;
 			reg++;
 		}
-- 
1.7.7.3
