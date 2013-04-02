From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  2 Apr 2013 13:31:12 -0700
Subject: [PATCH] ARM: arch_timer: Silence debug preempt warnings
Message-ID: <1364934672-31554-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hot-plugging with CONFIG_DEBUG_PREEMPT=y on a device with arm
architected timers causes a slew of "using smp_processor_id() in
preemptible" warnings:

  BUG: using smp_processor_id() in preemptible [00000000] code: sh/111
  caller is arch_timer_cpu_notify+0x14/0xc8

This happens because sometimes the cpu notifier, arch_timer_cpu_notify(),
is called in preemptible context but we use this_cpu_ptr()
to retrieve the clockevent unconditionally. We're only going to
actually use the pointer in non-preemptible context though,
so use __this_cpu_ptr() instead to avoid the preemptible checks
and silence the warning.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d7ad425..5928c29 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -248,7 +248,7 @@ static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
 static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
 					   unsigned long action, void *hcpu)
 {
-	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
+	struct clock_event_device *evt = __this_cpu_ptr(arch_timer_evt);
 
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_STARTING:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
