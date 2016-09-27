From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 13:17:58 +0530
Subject: [PATCH V2 4/6] arm64: Handle TRAP_BRKPT for user mode as well
In-Reply-To: <cover.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
Message-ID: <1959b06ec04920a6909c16656ca3413f996c1a45.1474960629.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uprobe is registered at break_hook with a unique ESR code. So, when a
TRAP_BRKPT occurs, call_break_hook checks if it was for uprobe. If not,
then send a SIGTRAP to user.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/debug-monitors.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index a8f8de012250..605df76f0a06 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -306,16 +306,20 @@ NOKPROBE_SYMBOL(call_break_hook);
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		send_user_sigtrap(TRAP_BRKPT);
-	}
+	bool handler_found = false;
+
 #ifdef	CONFIG_KPROBES
-	else if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
-		if (kprobe_breakpoint_handler(regs, esr) != DBG_HOOK_HANDLED)
-			return -EFAULT;
+	if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
+		if (kprobe_breakpoint_handler(regs, esr) == DBG_HOOK_HANDLED)
+			handler_found = true;
 	}
 #endif
-	else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
+	if (!handler_found && call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
+		handler_found = true;
+
+	if (!handler_found && user_mode(regs)) {
+		send_user_sigtrap(TRAP_BRKPT);
+	} else if (!handler_found) {
 		pr_warn("Unexpected kernel BRK exception at EL1\n");
 		return -EFAULT;
 	}
-- 
2.7.4
