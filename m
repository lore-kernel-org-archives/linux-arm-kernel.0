From: panand@redhat.com (Pratyush Anand)
Date: Thu, 20 Oct 2016 11:18:14 +0530
Subject: [PATCH V2 2/5] arm64: Allow hw watchpoint at varied offset from base
 address
In-Reply-To: <cover.1476941895.git.panand@redhat.com>
References: <cover.1476941895.git.panand@redhat.com>
Message-ID: <9394621e1b9709178ba54133a1469937fedae355.1476941895.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 hardware supports watchpoint at any double word aligned address.
However, it can select any consecutive bytes from offset 0 to 7 from that
base address. For example, if base address is programmed as 0x420030 and
byte select is 0x1C, then access of 0x420032,0x420033 and 0x420034 will
generate a watchpoint exception.

Currently, we do not have such modularity. We can only program byte,
halfword, word and double word access exception from any base address.

This patch adds support to overcome above limitations.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/hw_breakpoint.h |  2 +-
 arch/arm64/kernel/hw_breakpoint.c      | 45 ++++++++++++++++------------------
 arch/arm64/kernel/ptrace.c             |  5 ++--
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 115ea2a64520..4f4e58bee9bc 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -118,7 +118,7 @@ struct perf_event;
 struct pmu;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
-				  int *gen_len, int *gen_type);
+				  int *gen_len, int *gen_type, int *offset);
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
 extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 26a6bf77d272..3c2b96803eba 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -349,7 +349,7 @@ int arch_check_bp_in_kernelspace(struct perf_event *bp)
  * to generic breakpoint descriptions.
  */
 int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
-			   int *gen_len, int *gen_type)
+			   int *gen_len, int *gen_type, int *offset)
 {
 	/* Type */
 	switch (ctrl.type) {
@@ -369,8 +369,10 @@ int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 		return -EINVAL;
 	}
 
+	*offset = ffs(ctrl.len) - 1;
+
 	/* Len */
-	switch (ctrl.len) {
+	switch (ctrl.len >> *offset) {
 	case ARM_BREAKPOINT_LEN_1:
 		*gen_len = HW_BREAKPOINT_LEN_1;
 		break;
@@ -517,18 +519,17 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		default:
 			return -EINVAL;
 		}
-
-		info->address &= ~alignment_mask;
-		info->ctrl.len <<= offset;
 	} else {
 		if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE)
 			alignment_mask = 0x3;
 		else
 			alignment_mask = 0x7;
-		if (info->address & alignment_mask)
-			return -EINVAL;
+		offset = info->address & alignment_mask;
 	}
 
+	info->address &= ~alignment_mask;
+	info->ctrl.len <<= offset;
+
 	/*
 	 * Disallow per-task kernel breakpoints since these would
 	 * complicate the stepping code.
@@ -665,8 +666,8 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
 	int i, step = 0, *kernel_step, access;
-	u32 ctrl_reg;
-	u64 val, alignment_mask;
+	u32 ctrl_reg, lens, lene;
+	u64 val;
 	struct perf_event *wp, **slots;
 	struct debug_info *debug_info;
 	struct arch_hw_breakpoint *info;
@@ -684,25 +685,21 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 			goto unlock;
 
 		info = counter_arch_bp(wp);
-		/* AArch32 watchpoints are either 4 or 8 bytes aligned. */
-		if (is_compat_task()) {
-			if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
-				alignment_mask = 0x7;
-			else
-				alignment_mask = 0x3;
-		} else {
-			alignment_mask = 0x7;
-		}
 
-		/* Check if the watchpoint value matches. */
+		/* Check if the watchpoint value and byte select match. */
 		val = read_wb_reg(AARCH64_DBG_REG_WVR, i);
-		if (val != (addr & ~alignment_mask))
-			goto unlock;
-
-		/* Possible match, check the byte address select to confirm. */
 		ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
 		decode_ctrl_reg(ctrl_reg, &ctrl);
-		if (!((1 << (addr & alignment_mask)) & ctrl.len))
+		lens = ffs(ctrl.len) - 1;
+		lene = fls(ctrl.len) - 1;
+		/*
+		 * FIXME: reported address can be anywhere between "the
+		 * lowest address accessed by the memory access that
+		 * triggered the watchpoint" and "the highest watchpointed
+		 * address accessed by the memory access". So, it may not
+		 * lie in the interval of watchpoint address range.
+		 */
+		if (addr < val + lens || addr > val + lene)
 			goto unlock;
 
 		/*
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index e0c81da60f76..0eb366a94382 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -327,13 +327,13 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 				     struct arch_hw_breakpoint_ctrl ctrl,
 				     struct perf_event_attr *attr)
 {
-	int err, len, type, disabled = !ctrl.enabled;
+	int err, len, type, offset, disabled = !ctrl.enabled;
 
 	attr->disabled = disabled;
 	if (disabled)
 		return 0;
 
-	err = arch_bp_generic_fields(ctrl, &len, &type);
+	err = arch_bp_generic_fields(ctrl, &len, &type, &offset);
 	if (err)
 		return err;
 
@@ -352,6 +352,7 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 
 	attr->bp_len	= len;
 	attr->bp_type	= type;
+	attr->bp_addr	+= offset;
 
 	return 0;
 }
-- 
2.7.4
