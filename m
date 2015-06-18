From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:53 +0530
Subject: [RFC PATCH V2 06/10] arm64: Handle TRAP_HWBRKPT for user mode as well
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <a8c7a05683635bf86a3f90d8e420862950d7ac6c.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uprobe registers a handler at step_hook. So, single_step_handler now
checks for user mode as well if there is a valid hook.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/debug-monitors.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 486ee94304a0..7eb13dcf09fa 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -238,7 +238,14 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 	if (!reinstall_suspended_bps(regs))
 		return 0;
 
-	if (user_mode(regs)) {
+#ifdef	CONFIG_KPROBES
+	if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
+		handler_found = true;
+#endif
+	if (!handler_found && call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
+		handler_found = true;
+
+	if (!handler_found && user_mode(regs)) {
 		info.si_signo = SIGTRAP;
 		info.si_errno = 0;
 		info.si_code  = TRAP_HWBKPT;
@@ -252,22 +259,13 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		 * to the active-not-pending state).
 		 */
 		user_rewind_single_step(current);
-	} else {
-#ifdef	CONFIG_KPROBES
-		if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
-			handler_found = true;
-#endif
-		if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
-			handler_found = true;
-
-		if (!handler_found) {
-			pr_warn("Unexpected kernel single-step exception at EL1\n");
-			/*
-			 * Re-enable stepping since we know that we will be
-			 * returning to regs.
-			 */
-			set_regs_spsr_ss(regs);
-		}
+	} else if (!handler_found) {
+		pr_warning("Unexpected kernel single-step exception at EL1\n");
+		/*
+		 * Re-enable stepping since we know that we will be
+		 * returning to regs.
+		 */
+		set_regs_spsr_ss(regs);
 	}
 
 	return 0;
-- 
2.1.0
