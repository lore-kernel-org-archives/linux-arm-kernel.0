From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Wed,  6 Apr 2016 10:42:28 +0200
Subject: [PATCH v2] arm64/debug: Remove superfluous SMP function call
Message-ID: <1459932148-44003-1-git-send-email-anna-maria@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
function calls are no longer required.

Replace smp_call_function_single() with a direct call to
clear_os_lock(). The function writes the OSLAR register to clear OS
locking. This does not require to be called with interrupts disabled,
therefore the smp_call_function_single() calling convention is not
preserved.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/arm64/kernel/debug-monitors.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -135,9 +135,8 @@ static void clear_os_lock(void *unused)
 static int os_lock_notify(struct notifier_block *self,
 				    unsigned long action, void *data)
 {
-	int cpu = (unsigned long)data;
 	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
-		smp_call_function_single(cpu, clear_os_lock, NULL, 1);
+		clear_os_lock(NULL);
 	return NOTIFY_OK;
 }
 
