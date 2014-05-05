From: catalin.udma@freescale.com (Catalin Udma)
Date: Mon, 5 May 2014 14:51:25 +0300
Subject: [PATCH] arm64: ptrace: fix setting hw breakpoint/watchpoint
Message-ID: <1399290685-6336-1-git-send-email-catalin.udma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When setting hw breakpoints/watchpoints, GDB reports the error
"Unexpected error setting hardware debug registers". The problem is
reproducible on A53/A57 models where the supported number of
breakpoints/watchpoints (6 or 4 read from ID_AA64DFR0_EL1) it is
less than the maximum number of debug registers from user_hwdebug_state

This patch fixes the problem by restricting the registers access to the
maximum number of supported breakpoints/watchpoints

Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
---
 arch/arm64/kernel/ptrace.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c484d56..dea4b28 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -241,21 +241,30 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 	return 0;
 }
 
-static int ptrace_hbp_get_resource_info(unsigned int note_type, u32 *info)
+static int ptrace_hbp_get_breakpoint_slots(unsigned int note_type, u8 *num)
 {
-	u8 num;
-	u32 reg = 0;
-
 	switch (note_type) {
 	case NT_ARM_HW_BREAK:
-		num = hw_breakpoint_slots(TYPE_INST);
+		*num = hw_breakpoint_slots(TYPE_INST);
 		break;
 	case NT_ARM_HW_WATCH:
-		num = hw_breakpoint_slots(TYPE_DATA);
+		*num = hw_breakpoint_slots(TYPE_DATA);
 		break;
 	default:
 		return -EINVAL;
 	}
+	return 0;
+}
+
+static int ptrace_hbp_get_resource_info(unsigned int note_type, u32 *info)
+{
+	u8 num;
+	u32 reg = 0;
+	int ret;
+
+	ret = ptrace_hbp_get_breakpoint_slots(note_type, &num);
+	if (ret)
+		return ret;
 
 	reg |= debug_monitors_arch();
 	reg <<= 8;
@@ -425,6 +434,7 @@ static int hw_break_set(struct task_struct *target,
 	int ret, idx = 0, offset, limit;
 	u32 ctrl;
 	u64 addr;
+	u8 num_slots;
 
 	/* Resource info and pad */
 	offset = offsetof(struct user_hwdebug_state, dbg_regs);
@@ -432,9 +442,13 @@ static int hw_break_set(struct task_struct *target,
 	if (ret)
 		return ret;
 
+	ret = ptrace_hbp_get_breakpoint_slots(note_type, &num_slots);
+	if (ret)
+		return ret;
+
 	/* (address, ctrl) registers */
 	limit = regset->n * regset->size;
-	while (count && offset < limit) {
+	while (count && offset < limit && idx < num_slots) {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
 					 offset, offset + PTRACE_HBP_ADDR_SZ);
 		if (ret)
-- 
1.7.8
