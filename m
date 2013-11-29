From: a.anurag@samsung.com (Anurag Aggarwal)
Date: Fri, 29 Nov 2013 15:04:31 +0530
Subject: [PATCH V2] ARM : unwinder : Prevent data abort due to stack overflow
 while executing unwind instructions Signed-off-by: Anurag Aggarwal
 <a.anurag@samsung.com>
Message-ID: <1385717671-28953-1-git-send-email-a.anurag@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While unwinding backtrace, stack overflow is possible. This stack overflow can sometimes
lead to data abort in system if the area after stack is not mapped to physical memory.

To prevent this problem from happening execute the instructions that can cause data
abort in there seperate functions instead of unwind_exec_insn, where a check for there
feasibility is made first.
---
 arch/arm/kernel/unwind.c |  197 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 148 insertions(+), 49 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 00df012..150e0fc 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -49,6 +49,8 @@
 #include <asm/traps.h>
 #include <asm/unwind.h>
 
+#define TOTAL_REGISTERS 16
+
 /* Dummy functions to avoid linker complaints */
 void __aeabi_unwind_cpp_pr0(void)
 {
@@ -66,7 +68,7 @@ void __aeabi_unwind_cpp_pr2(void)
 EXPORT_SYMBOL(__aeabi_unwind_cpp_pr2);
 
 struct unwind_ctrl_block {
-	unsigned long vrs[16];		/* virtual register set */
+	unsigned long vrs[TOTAL_REGISTERS];	/* virtual register set */
 	const unsigned long *insn;	/* pointer to the current instructions word */
 	int entries;			/* number of entries left to interpret */
 	int byte;			/* current byte number in the instructions word */
@@ -235,6 +237,148 @@ static unsigned long unwind_get_byte(struct unwind_ctrl_block *ctrl)
 	return ret;
 }
 
+static int unwind_exec_insn_0x80(struct unwind_ctrl_block *ctrl,
+				unsigned long insn)
+{
+	unsigned long high, low;
+	unsigned long mask;
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
+	int load_sp, reg = 4;
+
+	low = ctrl->vrs[SP];
+	high = ALIGN(low, THREAD_SIZE);
+
+	insn = (insn << 8) | unwind_get_byte(ctrl);
+	mask = insn & 0x0fff;
+	if (mask == 0) {
+		pr_warning("unwind: 'Refuse to unwind' instruction %04lx\n",
+			insn);
+		return -URC_FAILURE;
+	}
+
+	/*
+	 *  Check whether there is enough space
+	 *  on stack to execute the instruction
+	 *  if not then return failure
+	 */
+	if ((high - low) < TOTAL_REGISTERS) {
+		unsigned long mask_copy = mask;
+		int required_stack = 0;
+
+		while (mask_copy) {
+			if (mask_copy & 1)
+				required_stack++;
+			mask_copy >>= 1;
+		}
+
+		if ((high - low) < required_stack)
+			return -URC_FAILURE;
+	}
+
+	load_sp = mask & (1 << (13 - 4));
+	while (mask) {
+		if (mask & 1)
+			ctrl->vrs[reg] = *vsp++;
+		mask >>= 1;
+		reg++;
+	}
+	if (!load_sp)
+		ctrl->vrs[SP] = (unsigned long)vsp;
+
+	pr_debug("%s: fp = %08lx sp = %08lx lr = %08lx pc = %08lx\n", __func__,
+		ctrl->vrs[FP], ctrl->vrs[SP], ctrl->vrs[LR], ctrl->vrs[PC]);
+
+	return URC_OK;
+}
+
+static int unwind_exec_insn_0xa0(struct unwind_ctrl_block *ctrl,
+				unsigned long insn)
+{
+	unsigned long high, low;
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
+	int reg;
+
+	low = ctrl->vrs[SP];
+	high = ALIGN(low, THREAD_SIZE);
+
+	/*
+	 *  Check whether there is enough space
+	 *  on stack to execute the instruction
+	 *  if not then return failure
+	 */
+	if ((high-low) < TOTAL_REGISTERS) {
+		int required_stack;
+
+		required_stack = insn & 7;
+		required_stack += (insn & 0x80) ? 1 : 0;
+
+		if ((high-low) < required_stack)
+			return -URC_FAILURE;
+	}
+
+	/* pop R4-R[4+bbb] */
+	for (reg = 4; reg <= 4 + (insn & 7); reg++)
+		ctrl->vrs[reg] = *vsp++;
+	if (insn & 0x80)
+		ctrl->vrs[14] = *vsp++;
+	ctrl->vrs[SP] = (unsigned long)vsp;
+
+	pr_debug("%s: fp = %08lx sp = %08lx lr = %08lx pc = %08lx\n", __func__,
+		ctrl->vrs[FP], ctrl->vrs[SP], ctrl->vrs[LR], ctrl->vrs[PC]);
+
+	return URC_OK;
+}
+
+static int unwind_exec_insn_0xb1(struct unwind_ctrl_block *ctrl,
+				unsigned long insn)
+{
+	unsigned long high, low;
+	unsigned long mask = unwind_get_byte(ctrl);
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
+	int reg = 0;
+
+	if (mask == 0 || mask & 0xf0) {
+		pr_warning("unwind: Spare encoding %04lx\n",
+			(insn << 8) | mask);
+		return -URC_FAILURE;
+	}
+
+	low = ctrl->vrs[SP];
+	high = ALIGN(low, THREAD_SIZE);
+
+	/*
+	 *  Check whether there is enough space
+	 *  on stack to execute the instruction
+	 *  if not then return failure
+	 */
+	if ((high-low) < TOTAL_REGISTERS) {
+		unsigned long mask_copy = mask;
+		int required_stack = 0;
+
+		while (mask_copy) {
+			if (mask_copy & 1)
+				required_stack++;
+			mask_copy >>= 1;
+		}
+		if ((high-low) < required_stack)
+			return -URC_FAILURE;
+	}
+
+	/* pop R0-R3 according to mask */
+	while (mask) {
+		if (mask & 1)
+			ctrl->vrs[reg] = *vsp++;
+		mask >>= 1;
+		reg++;
+	}
+	ctrl->vrs[SP] = (unsigned long)vsp;
+
+	pr_debug("%s: fp = %08lx sp = %08lx lr = %08lx pc = %08lx\n", __func__,
+		ctrl->vrs[FP], ctrl->vrs[SP], ctrl->vrs[LR], ctrl->vrs[PC]);
+
+	return URC_OK;
+}
+
 /*
  * Execute the current unwind instruction.
  */
@@ -249,65 +393,20 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 	else if ((insn & 0xc0) == 0x40)
 		ctrl->vrs[SP] -= ((insn & 0x3f) << 2) + 4;
 	else if ((insn & 0xf0) == 0x80) {
-		unsigned long mask;
-		unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
-		int load_sp, reg = 4;
-
-		insn = (insn << 8) | unwind_get_byte(ctrl);
-		mask = insn & 0x0fff;
-		if (mask == 0) {
-			pr_warning("unwind: 'Refuse to unwind' instruction %04lx\n",
-				   insn);
-			return -URC_FAILURE;
-		}
-
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
+		return unwind_exec_insn_0x80(ctrl, insn);
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
+		 return unwind_exec_insn_0xa0(ctrl, insn);
 	} else if (insn == 0xb0) {
 		if (ctrl->vrs[PC] == 0)
 			ctrl->vrs[PC] = ctrl->vrs[LR];
 		/* no further processing */
 		ctrl->entries = 0;
 	} else if (insn == 0xb1) {
-		unsigned long mask = unwind_get_byte(ctrl);
-		unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
-		int reg = 0;
 
-		if (mask == 0 || mask & 0xf0) {
-			pr_warning("unwind: Spare encoding %04lx\n",
-			       (insn << 8) | mask);
-			return -URC_FAILURE;
-		}
-
-		/* pop R0-R3 according to mask */
-		while (mask) {
-			if (mask & 1)
-				ctrl->vrs[reg] = *vsp++;
-			mask >>= 1;
-			reg++;
-		}
-		ctrl->vrs[SP] = (unsigned long)vsp;
+		 return unwind_exec_insn_0xb1(ctrl, insn);
 	} else if (insn == 0xb2) {
 		unsigned long uleb128 = unwind_get_byte(ctrl);
 
-- 
1.7.0.4
