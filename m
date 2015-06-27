From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Jun 2015 21:02:30 -0600
Subject: [PATCH RFC v2 10/16] drivers: cpuidle: Add runtime PM support for
 CPUIdle
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1435374156-19214-11-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Notify runtime PM when the CPU is going to be powered off in the idle
state. This allows for runtime PM suspend/resume of the CPU's PM domain.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d..77fd673 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,12 +11,14 @@
 
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
 
 #include <asm/cpuidle.h>
@@ -45,12 +47,20 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 
 	ret = cpu_pm_enter();
 	if (!ret) {
+		struct device *cpu_dev = get_cpu_device(dev->cpu);
+
+		/*
+		 * Notify runtime PM as well of this cpu powering down
+		 * TODO: Merge CPU_PM and runtime PM.
+		 */
+		pm_runtime_put_sync(cpu_dev);
 		/*
 		 * Pass idle state index to cpu_suspend which in turn will
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
 		arm_cpuidle_suspend(idx);
+		pm_runtime_get_sync(cpu_dev);
 
 		cpu_pm_exit();
 	}
@@ -146,6 +156,7 @@ static int __init arm_idle_init(void)
 			kfree(dev);
 			goto out_fail;
 		}
+
 	}
 
 	return 0;
-- 
2.1.4
