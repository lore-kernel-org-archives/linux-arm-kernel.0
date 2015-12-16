From: yang.shi@linaro.org (Yang Shi)
Date: Tue, 15 Dec 2015 16:18:08 -0800
Subject: [PATCH] arm64: reenable interrupt when handling ptrace breakpoint
Message-ID: <1450225088-2456-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel just send out a SIGTRAP signal when handling ptrace breakpoint in
debug exception, so it sounds safe to have interrupt enabled if it is not
disabled by the parent process.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/kernel/debug-monitors.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 8aee3ae..90d70e4 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -239,6 +239,9 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		return 0;
 
 	if (user_mode(regs)) {
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
 		info.si_signo = SIGTRAP;
 		info.si_errno = 0;
 		info.si_code  = TRAP_HWBKPT;
@@ -310,6 +313,9 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 	siginfo_t info;
 
 	if (user_mode(regs)) {
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
 		info = (siginfo_t) {
 			.si_signo = SIGTRAP,
 			.si_errno = 0,
@@ -337,6 +343,10 @@ int aarch32_break_handler(struct pt_regs *regs)
 	if (!compat_user_mode(regs))
 		return -EFAULT;
 
+	/* COMPAT_PSR_I_BIT has the same bit mask with non-compat one */
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	if (compat_thumb_mode(regs)) {
 		/* get 16-bit Thumb instruction */
 		get_user(thumb_instr, (u16 __user *)pc);
-- 
2.0.2
