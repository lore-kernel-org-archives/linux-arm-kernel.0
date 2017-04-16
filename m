From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 16 Apr 2017 22:27:04 +0200
Subject: [PATCH 14/29] arm64: arch_timer: Save cntkctl_el1 as a per-cpu
 variable
In-Reply-To: <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
References: <20170416202542.GV2078@mai>
 <1492374441-23336-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1492374441-23336-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

As we're about to allow per CPU cntkctl_el1 configuration, we cannot
rely on the register value to be common when performing power
management.

Let's turn saved_cntkctl into a per-cpu variable.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 395f5d9..5c114da 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -839,14 +839,14 @@ static int arch_timer_dying_cpu(unsigned int cpu)
 }
 
 #ifdef CONFIG_CPU_PM
-static unsigned int saved_cntkctl;
+static DEFINE_PER_CPU(unsigned long, saved_cntkctl);
 static int arch_timer_cpu_pm_notify(struct notifier_block *self,
 				    unsigned long action, void *hcpu)
 {
 	if (action == CPU_PM_ENTER)
-		saved_cntkctl = arch_timer_get_cntkctl();
+		__this_cpu_write(saved_cntkctl, arch_timer_get_cntkctl());
 	else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT)
-		arch_timer_set_cntkctl(saved_cntkctl);
+		arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
 	return NOTIFY_OK;
 }
 
-- 
2.7.4
