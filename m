From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon,  4 Apr 2016 12:42:49 +0200
Subject: [PATCH] arm64: hw-breakpoint: Remove superfluous SMP function call
Message-ID: <1459766569-17237-1-git-send-email-anna-maria@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
CPU_DOWN_PREPARE are processed on the hotplugged cpu. Due to this SMP
function calls are no longer required.

Replace smp_call_function_single() with a direct call of
hw_breakpoint_reset(). To keep the calling convention, interrupts are
explicitely disabled around the call.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm64/kernel/hw_breakpoint.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -886,9 +886,11 @@ static int hw_breakpoint_reset_notify(st
 						unsigned long action,
 						void *hcpu)
 {
-	int cpu = (long)hcpu;
-	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
-		smp_call_function_single(cpu, hw_breakpoint_reset, NULL, 1);
+	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE) {
+		local_irq_disable();
+		hw_breakpoint_reset(NULL);
+		local_irq_enable();
+	}
 	return NOTIFY_OK;
 }
 
