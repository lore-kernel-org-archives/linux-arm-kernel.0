From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon,  4 Apr 2016 12:32:00 +0200
Subject: [PATCH] arm, hw-breakpoint: Remove superfluous SMP function call
Message-ID: <1459765920-15690-1-git-send-email-anna-maria@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
CPU_DOWN_PREPARE are processed on the hotplugged cpu. Due to this SMP
function calls are no longer required.

Replace smp_call_function_single() with a direct call of
reset_ctrl_regs(). To keep the calling convention, interrupts are
explicitely disabled around the call.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm/kernel/hw_breakpoint.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1023,8 +1023,11 @@ static void reset_ctrl_regs(void *unused
 static int dbg_reset_notify(struct notifier_block *self,
 				      unsigned long action, void *cpu)
 {
-	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
-		smp_call_function_single((int)cpu, reset_ctrl_regs, NULL, 1);
+	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE) {
+		local_irq_disable();
+		reset_ctrl_regs(NULL);
+		local_irq_enable();
+	}
 
 	return NOTIFY_OK;
 }
