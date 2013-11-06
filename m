From: a.anurag@samsung.com (Anurag Aggarwal)
Date: Wed, 06 Nov 2013 15:20:48 +0530
Subject: [PATCH] ARM: unwinder: Handle Stackoverflow in unwind_exec_insn
Message-ID: <1383731448-847-1-git-send-email-a.anurag@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Altough stack overflow is expected in unwind_exec_insn, but in cases when area beyond stack is not mapped to physical memory this can cause data abort. 

To avoid above condition handle stack overflow in unwind_exec_insn by checking vsp pointer from top of stack 
Signed-off-by: Anurag Aggarwal <a.anurag@samsung.com>
---
 arch/arm/kernel/unwind.c | 23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-) 
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c 
index 00df012..d8b8721 100644 
--- a/arch/arm/kernel/unwind.c 
+++ b/arch/arm/kernel/unwind.c 
@@ -241,6 +241,10 @@ static unsigned long unwind_get_byte(struct unwind_ctrl_block *ctrl)
static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 {
 	unsigned long insn = unwind_get_byte(ctrl); 
+	unsigned long high, low; 
+	unsigned long *vsp = (unsigned long *)ctrl->vrs[SP]; 
+	low = ctrl->vrs[SP]; 
+	high = ALIGN(low, THREAD_SIZE);
 
 	pr_debug("%s: insn = %08lx\n", __func__, insn);
 
@@ -263,27 +267,27 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 
 		/* pop R4-R15 according to mask */
 		load_sp = mask & (1 << (13 - 4)); 
- 		while (mask) { 
+ 		while (mask && vsp < high) {
 			if (mask & 1)
 				ctrl->vrs[reg] = *vsp++;
 			mask >>= 1;
 			reg++;
 		}
- 		if (!load_sp) 
+ 		if (!load_sp && vsp < high)
 			ctrl->vrs[SP] = (unsigned long)vsp;
 	} else if ((insn & 0xf0) == 0x90 &&
 		   (insn & 0x0d) != 0x0d)
 		ctrl->vrs[SP] = ctrl->vrs[insn & 0x0f];
 	else if ((insn & 0xf0) == 0xa0) { 
- 		unsigned long *vsp = (unsigned long *)ctrl->vrs[SP];
 		int reg;

 		/* pop R4-R[4+bbb] */
-		for (reg = 4; reg <= 4 + (insn & 7); reg++)
+		for (reg = 4;  (reg <= 4 + (insn & 7)) && (vsp < high; reg++)
 			ctrl->vrs[reg] = *vsp++;
-		if (insn & 0x80)
+		if (insn & 0x80 && vsp < high)
 			ctrl->vrs[14] = *vsp++;
-		ctrl->vrs[SP] = (unsigned long)vsp;
+		if (vsp < high)
+			ctrl->vrs[SP] = (unsigned long)vsp;
 	} else if (insn == 0xb0) {
 		if (ctrl->vrs[PC] == 0)
 			ctrl->vrs[PC] = ctrl->vrs[LR];
@@ -301,13 +305,14 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		}
 
 		/* pop R0-R3 according to mask */
-		while (mask) {
+		while (mask && vsp < high) {
 			if (mask & 1)
 				ctrl->vrs[reg] = *vsp++;
 			mask >>= 1;
 			reg++;
 		}
-		ctrl->vrs[SP] = (unsigned long)vsp;
+		if (vsp < high)
+			ctrl->vrs[SP] = (unsigned long)vsp;
 	} else if (insn == 0xb2) {
 		unsigned long uleb128 = unwind_get_byte(ctrl);
 
@@ -317,6 +322,8 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		return -URC_FAILURE;
 	}
 
+	if (vsp >= high)
+		return -URC_FAILURE;
 	pr_debug("%s: fp = %08lx sp = %08lx lr = %08lx pc = %08lx\n", __func__,
 		 ctrl->vrs[FP], ctrl->vrs[SP], ctrl->vrs[LR], ctrl->vrs[PC]);
 
-- 
