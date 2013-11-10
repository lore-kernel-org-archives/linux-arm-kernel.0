From: ming.lei@canonical.com (Ming Lei)
Date: Sun, 10 Nov 2013 17:23:23 +0800
Subject: [PATCH] arm64: emulate aarch32 CP15 barriers if needed
Message-ID: <1384075404-19605-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CP15BEN of SCTLR_EL1 may not be implemented, so we need
to emulate these three CP15 barriers to avoid breaking
aarch32 applications since they can be used in user mode.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm64/kernel/traps.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7ffaddd..c9f009d 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -257,6 +257,34 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 		die(str, regs, err);
 }
 
+/*
+ * CP15BEN of SCTLR_EL1 may not be implemented, so emulate
+ * these three instructions when they trap in
+ */
+static int aarch32_cp15_barriers(struct pt_regs *regs)
+{
+	unsigned int instr;
+	void __user *pc = (void __user *)instruction_pointer(regs);
+
+	if (!compat_user_mode(regs))
+		return -EFAULT;
+
+	get_user(instr, (u32 __user *)pc);
+	instr &= ~0xf000f000;
+
+	if (instr == 0x0e070fba)	/* CP15DMB */
+		smp_mb();
+	else if (instr == 0x0e070f9a)	/* CP15DSB */
+		dsb();
+	else if (instr == 0x0e070f95)	/* CP15ISB */
+		isb();
+	else
+		return -EFAULT;
+
+	regs->pc += 4;
+	return 0;
+}
+
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -266,6 +294,10 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (!aarch32_break_handler(regs))
 		return;
 
+	/* check for AArch32 CP15DMB/CP15DSB/CP15ISB */
+	if (!aarch32_cp15_barriers(regs))
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(current, SIGILL) &&
 	    printk_ratelimit()) {
 		pr_info("%s[%d]: undefined instruction: pc=%p\n",
-- 
1.7.9.5
