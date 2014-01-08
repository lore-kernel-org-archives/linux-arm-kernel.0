From: a.anurag@samsung.com (Anurag Aggarwal)
Date: Wed, 08 Jan 2014 09:50:25 +0530
Subject: [PATCH V7] ARM : unwinder : Prevent data abort due to stack overflow
Message-ID: <1389154825-10140-1-git-send-email-a.anurag@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While unwinding backtrace, stack overflow is possible. This stack
overflow can sometimes lead to data abort in system if the area after
stack is not mapped to physical memory.

To prevent this problem from happening, execute the instructions that
can cause a data abort in separate helper functions, where a check for
feasibility is made before reading each word from the stack.

Signed-off-by: Anurag Aggarwal <a.anurag@samsung.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/kernel/unwind.c |  137 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 37 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..3c21769 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -68,6 +68,12 @@ EXPORT_SYMBOL(__aeabi_unwind_cpp_pr2);
 struct unwind_ctrl_block {
 	unsigned long vrs[16];		/* virtual register set */
 	const unsigned long *insn;	/* pointer to the current instructions word */
+	unsigned long sp_high;		/* highest value of sp allowed */
+	/*
+	 * 1 : check for stack overflow for each register pop.
+	 * 0 : save overhead if there is plenty of stack remaining.
+	 */
+	int check_each_pop;
 	int entries;			/* number of entries left to interpret */
 	int byte;			/* current byte number in the instructions word */
 };
@@ -235,12 +241,85 @@ static unsigned long unwind_get_byte(struct unwind_ctrl_block *ctrl)
 	return ret;
 }
 
+/* Before poping a register check whether it is feasible or not */
+static int unwind_pop_register(struct unwind_ctrl_block *ctrl,
+				unsigned long **vsp, unsigned int reg)
+{
+	if (unlikely(ctrl->check_each_pop))
+		if (*vsp >= (unsigned long *)ctrl->sp_high)
+			return -URC_FAILURE;
+
+	ctrl->vrs[reg] = *(*vsp)++;
+	return URC_OK;
+}
+
+/* Helper functions to execute the instructions */
+static int unwind_exec_pop_subset_r4_to_r13(struct unwind_ctrl_block *ctrl,
+						unsigned long mask)
+{
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
+	int load_sp, reg = 4;
+
+	load_sp = mask & (1 << (13 - 4));
+	while (mask) {
+		if (mask & 1)
+			if (unwind_pop_register(ctrl, &vsp, reg))
+				return -URC_FAILURE;
+		mask >>= 1;
+		reg++;
+	}
+	if (!load_sp)
+		ctrl->vrs[SP] = (unsigned long)vsp;
+
+	return URC_OK;
+}
+
+static int unwind_exec_pop_r4_to_rN(struct unwind_ctrl_block *ctrl,
+					unsigned long insn)
+{
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
+	int reg;
+
+	/* pop R4-R[4+bbb] */
+	for (reg = 4; reg <= 4 + (insn & 7); reg++)
+		if (unwind_pop_register(ctrl, &vsp, reg))
+				return -URC_FAILURE;
+
+	if (insn & 0x80)
+		if (unwind_pop_register(ctrl, &vsp, 14))
+				return -URC_FAILURE;
+
+	ctrl->vrs[SP] = (unsigned long)vsp;
+
+	return URC_OK;
+}
+
+static int unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,
+						unsigned long mask)
+{
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
+	int reg = 0;
+
+	/* pop R0-R3 according to mask */
+	while (mask) {
+		if (mask & 1)
+			if (unwind_pop_register(ctrl, &vsp, reg))
+				return -URC_FAILURE;
+		mask >>= 1;
+		reg++;
+	}
+	ctrl->vrs[SP] = (unsigned long)vsp;
+
+	return URC_OK;
+}
+
 /*
  * Execute the current unwind instruction.
  */
 static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 {
 	unsigned long insn = unwind_get_byte(ctrl);
+	int ret = URC_OK;
 
 	pr_debug("%s: insn = %08lx\n", __func__, insn);
 
@@ -250,8 +329,6 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		ctrl->vrs[SP] -= ((insn & 0x3f) << 2) + 4;
 	else if ((insn & 0xf0) == 0x80) {
 		unsigned long mask;
-		unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
-		int load_sp, reg = 4;
 
 		insn = (insn << 8) | unwind_get_byte(ctrl);
 		mask = insn & 0x0fff;
@@ -261,29 +338,16 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 			return -URC_FAILURE;
 		}
 
-		/* pop R4-R15 according to mask */
-		load_sp = mask & (1 << (13 - 4));
-		while (mask) {
-			if (mask & 1)
-				ctrl->vrs[reg] = *vsp++;
-			mask >>= 1;
-			reg++;
-		}
-		if (!load_sp)
-			ctrl->vrs[SP] = (unsigned long)vsp;
+		ret = unwind_exec_pop_subset_r4_to_r13(ctrl, mask);
+		if (ret)
+			goto error;
 	} else if ((insn & 0xf0) == 0x90 &&
 		   (insn & 0x0d) != 0x0d)
 		ctrl->vrs[SP] = ctrl->vrs[insn & 0x0f];
 	else if ((insn & 0xf0) == 0xa0) {
-		unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
-		int reg;
-
-		/* pop R4-R[4+bbb] */
-		for (reg = 4; reg <= 4 + (insn & 7); reg++)
-			ctrl->vrs[reg] = *vsp++;
-		if (insn & 0x80)
-			ctrl->vrs[14] = *vsp++;
-		ctrl->vrs[SP] = (unsigned long)vsp;
+		ret = unwind_exec_pop_r4_to_rN(ctrl, insn);
+		if (ret)
+			goto error;
 	} else if (insn == 0xb0) {
 		if (ctrl->vrs[PC] == 0)
 			ctrl->vrs[PC] = ctrl->vrs[LR];
@@ -291,8 +355,6 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		ctrl->entries = 0;
 	} else if (insn == 0xb1) {
 		unsigned long mask = unwind_get_byte(ctrl);
-		unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
-		int reg = 0;
 
 		if (mask == 0 || mask & 0xf0) {
 			pr_warning("unwind: Spare encoding %04lx\n",
@@ -300,14 +362,9 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 			return -URC_FAILURE;
 		}
 
-		/* pop R0-R3 according to mask */
-		while (mask) {
-			if (mask & 1)
-				ctrl->vrs[reg] = *vsp++;
-			mask >>= 1;
-			reg++;
-		}
-		ctrl->vrs[SP] = (unsigned long)vsp;
+		ret = unwind_exec_pop_subset_r0_to_r3(ctrl, mask);
+		if (ret)
+			goto error;
 	} else if (insn == 0xb2) {
 		unsigned long uleb128 = unwind_get_byte(ctrl);
 
@@ -320,7 +377,8 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 	pr_debug("%s: fp = %08lx sp = %08lx lr = %08lx pc = %08lx\n", __func__,
 		 ctrl->vrs[FP], ctrl->vrs[SP], ctrl->vrs[LR], ctrl->vrs[PC]);
 
-	return URC_OK;
+error:
+	return ret;
 }
 
 /*
@@ -329,13 +387,13 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
  */
 int unwind_frame(struct stackframe *frame)
 {
-	unsigned long high, low;
+	unsigned long low;
 	const struct unwind_idx *idx;
 	struct unwind_ctrl_block ctrl;
 
-	/* only go to a higher address on the stack */
+	/* store the highest address on the stack to avoid crossing it*/
 	low = frame->sp;
-	high = ALIGN(low, THREAD_SIZE);
+	ctrl.sp_high = ALIGN(low, THREAD_SIZE);
 
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
@@ -382,11 +440,16 @@ int unwind_frame(struct stackframe *frame)
 		return -URC_FAILURE;
 	}
 
+	ctrl.check_each_pop = 0;
+
 	while (ctrl.entries > 0) {
-		int urc = unwind_exec_insn(&ctrl);
+		int urc;
+		if ((ctrl.sp_high - ctrl.vrs[SP]) < sizeof(ctrl.vrs))
+			ctrl.check_each_pop = 1;
+		urc = unwind_exec_insn(&ctrl);
 		if (urc < 0)
 			return urc;
-		if (ctrl.vrs[SP] < low || ctrl.vrs[SP] >= high)
+		if (ctrl.vrs[SP] < low || ctrl.vrs[SP] >= ctrl.sp_high)
 			return -URC_FAILURE;
 	}
 
-- 
1.7.9.5
