From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 13:17:57 +0530
Subject: [PATCH V2 3/6] arm64: Handle TRAP_TRACE for user mode as well
In-Reply-To: <cover.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
Message-ID: <fa1ba7b617633efe53a16cc0e438e03472784061.1474960629.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uprobe registers a handler at step_hook. So, single_step_handler now
checks for user mode as well if there is a valid hook.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/debug-monitors.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 73ae90ef434c..a8f8de012250 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -226,6 +226,8 @@ static void send_user_sigtrap(int si_code)
 static int single_step_handler(unsigned long addr, unsigned int esr,
 			       struct pt_regs *regs)
 {
+	bool handler_found = false;
+
 	/*
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
@@ -233,7 +235,14 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
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
 		send_user_sigtrap(TRAP_TRACE);
 
 		/*
@@ -243,15 +252,8 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		 * to the active-not-pending state).
 		 */
 		user_rewind_single_step(current);
-	} else {
-#ifdef	CONFIG_KPROBES
-		if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
-			return 0;
-#endif
-		if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
-			return 0;
-
-		pr_warning("Unexpected kernel single-step exception at EL1\n");
+	} else if (!handler_found) {
+		pr_warn("Unexpected kernel single-step exception at EL1\n");
 		/*
 		 * Re-enable stepping since we know that we will be
 		 * returning to regs.
-- 
2.7.4
