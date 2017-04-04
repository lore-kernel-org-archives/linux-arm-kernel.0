From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  4 Apr 2017 18:18:22 +0100
Subject: [PATCH v3 14/18] arm64: arch_timer: Save cntkctl_el1 as a per-cpu
 variable
In-Reply-To: <20170404171826.25030-1-marc.zyngier@arm.com>
References: <20170404171826.25030-1-marc.zyngier@arm.com>
Message-ID: <20170404171826.25030-15-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're about to allow per CPU cntkctl_el1 configuration, we cannot
rely on the register value to be common when performing power
management.

Let's turn saved_cntkctl into a per-cpu variable.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 395f5d95a737..5c114da0ed71 100644
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
2.11.0
