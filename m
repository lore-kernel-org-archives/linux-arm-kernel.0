From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  3 Sep 2015 13:58:32 -0600
Subject: [PATCH v2 5/7] ARM: cpuidle: Add runtime PM support for CPU idle
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1441310314-8857-6-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU as well as
its  PM domain.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..7c791f9 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,13 +11,16 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #include <asm/cpuidle.h>
 
@@ -37,6 +40,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
 	int ret;
+	struct device *cpu_dev = get_cpu_device(dev->cpu);
 
 	if (!idx) {
 		cpu_do_idle();
@@ -46,12 +50,19 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 	ret = cpu_pm_enter();
 	if (!ret) {
 		/*
+		 * Notify runtime PM as well of this cpu powering down
+		 * TODO: Merge CPU_PM and runtime PM.
+		 */
+		RCU_NONIDLE(pm_runtime_put_sync(cpu_dev));
+
+		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		arm_cpuidle_suspend(idx);
 
+		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
 		cpu_pm_exit();
 	}
 
-- 
2.1.4
