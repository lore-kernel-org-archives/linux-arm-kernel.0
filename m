From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:54 +0530
Subject: [RFC PATCH V2 07/10] arm64: Handle TRAP_BRKPT for user mode as well
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <89bd3896c313cc803b108da3328b38e55d813a33.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uprobe is registered at break_hook with a unique ESR code. So, when a
TRAP_BRKPT occurs, call_break_hook checks if it was for uprobe. If not,
then send a SIGTRAP to user.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/debug-monitors.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 7eb13dcf09fa..1fe912e77f62 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -311,8 +311,18 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
 {
 	siginfo_t info;
+	bool handler_found = false;
+
+#ifdef	CONFIG_KPROBES
+	if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
+		if (kprobe_breakpoint_handler(regs, esr) == DBG_HOOK_HANDLED)
+			handler_found = true;
+	}
+#endif
+	if (!handler_found && call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
+		handler_found = true;
 
-	if (user_mode(regs)) {
+	if (!handler_found && user_mode(regs)) {
 		info = (siginfo_t) {
 			.si_signo = SIGTRAP,
 			.si_errno = 0,
@@ -321,15 +331,8 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 		};
 
 		force_sig_info(SIGTRAP, &info, current);
-	}
-#ifdef	CONFIG_KPROBES
-	else if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
-		if (kprobe_breakpoint_handler(regs, esr) != DBG_HOOK_HANDLED)
-			return -EFAULT;
-	}
-#endif
-	else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
-		pr_warn("Unexpected kernel BRK exception at EL1\n");
+	} else if (!handler_found) {
+		pr_warning("Unexpected kernel BRK exception at EL1\n");
 		return -EFAULT;
 	}
 
-- 
2.1.0
