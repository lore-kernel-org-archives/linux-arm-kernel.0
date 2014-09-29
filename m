From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 29 Sep 2014 01:04:02 -0700
Subject: [PATCH] arm64: ptrace: hw_break_set take into account hardware
 breakpoints number
In-Reply-To: <1411977842-16515-1-git-send-email-victor.kamensky@linaro.org>
References: <1411977842-16515-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1411977842-16515-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hw_break_set function that performs ptrace_regset for hardware
breakpoints and watchpoints needs to take into account actual
number of hardware breakpoints and watchpoints available in CPU.

Current code iterates over all 16 entries of 'struct user_hwdebug_state'
and tries to reserve hardware breakpoint for each index, which fails
if CPU supports less than 16 hardware breakpoints. One manifestation of
the issue is that gdb fails to debug multithreaded user land application
and exits with 'Unexpected error setting hardware debug registers'
error - ptrace system call for hardware breakpoints regset fails with
ENOSPC.

Solution is to read number of available hardware breakpoints and
watchpoints available in CPU and process only that number of first
entries in passed 'struct user_hwdebug_state' regset. Code assumes
that ptrace caller uses only first entries in 'struct
user_hwdebug_state' up to number of hardware breakpoints and watchpoints
supported by CPU. I.e there are no "ignore me, empty" entries in
the middle of 'struct user_hwdebug_state' entries array.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index fe63ac5..4178ba1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -248,22 +248,32 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 	return 0;
 }
 
-static int ptrace_hbp_get_resource_info(unsigned int note_type, u32 *info)
+static int ptrace_hbp_get_num_slots(unsigned int note_type, u8 *num)
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
+	int err;
+
+	err = ptrace_hbp_get_num_slots(note_type, &num);
+	if (err)
+		return err;
+
 	reg |= debug_monitors_arch();
 	reg <<= 8;
 	reg |= num;
@@ -432,6 +442,11 @@ static int hw_break_set(struct task_struct *target,
 	int ret, idx = 0, offset, limit;
 	u32 ctrl;
 	u64 addr;
+	u8 num_slots;
+
+	ret = ptrace_hbp_get_num_slots(note_type, &num_slots);
+	if (ret)
+		return ret;
 
 	/* Resource info and pad */
 	offset = offsetof(struct user_hwdebug_state, dbg_regs);
@@ -441,7 +456,7 @@ static int hw_break_set(struct task_struct *target,
 
 	/* (address, ctrl) registers */
 	limit = regset->n * regset->size;
-	while (count && offset < limit) {
+	while ((count && offset < limit) && (idx < num_slots)) {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
 					 offset, offset + PTRACE_HBP_ADDR_SZ);
 		if (ret)
-- 
1.8.1.4
