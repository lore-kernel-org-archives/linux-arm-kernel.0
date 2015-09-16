From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 16 Sep 2015 22:23:21 +0800
Subject: [PATCH] arm64: add cpu_idle tracepoints to arch_cpu_idle
Message-ID: <1442413401-2955-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, if cpuidle is disabled or not supported, powertop reports
zero wakeups and zero events. This is due to the cpu_idle tracepoints
are missing.

This patch is to make cpu_idle tracepoints always available even if
cpuidle is disabled or not supported.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 223b093..f75b540 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -44,6 +44,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/personality.h>
 #include <linux/notifier.h>
+#include <trace/events/power.h>
 
 #include <asm/compat.h>
 #include <asm/cacheflush.h>
@@ -75,8 +76,10 @@ void arch_cpu_idle(void)
 	 * This should do all the clock switching and wait for interrupt
 	 * tricks
 	 */
+	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	cpu_do_idle();
 	local_irq_enable();
+	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.5.1
