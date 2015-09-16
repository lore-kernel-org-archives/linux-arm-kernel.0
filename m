From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 16 Sep 2015 22:37:00 +0800
Subject: [PATCH] arm: add cpu_idle tracepoints to arch_cpu_idle
Message-ID: <1442414220-7204-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, if cpuidle is disabled or not supported, powertop reports
zero wakeups and zero events. This is due to the cpu_idle tracepoints
are missing.

This patch is to make cpu_idle tracepoints always available even if
cpuidle is disabled or not supported.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f192a2a..aa78e09 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
+#include <trace/events/power.h>
 
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
@@ -66,11 +67,13 @@ void (*arm_pm_idle)(void);
 
 void arch_cpu_idle(void)
 {
+	trace_cpu_idle_rcuidle(1, smp_processor_id());
 	if (arm_pm_idle)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
 	local_irq_enable();
+	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
 void arch_cpu_idle_prepare(void)
-- 
2.5.1
