From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 23 Mar 2015 17:50:24 +0100
Subject: [PATCH V4] ARM: cpuidle: Register per cpuidle device
In-Reply-To: <20150323162514.GE18904@red-moon>
References: <20150323162514.GE18904@red-moon>
Message-ID: <1427129424-17175-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, the low level PM code may not be initialized correctly for
a specific cpu. In this case, the EXNIO tells the cpuidle driver to not
initialize the cpuidle device as the associated low level PM is not operational.

That prevents the system to crash and allows to handle the error gracefully.

For example, on Qcom's platform, each core has a SPM. The device associated
with this SPM is initialized before the cpuidle framework. If there is an error
in the initialization (eg. error in the DT), the system continues to boot but
in degraded mode as some SPM may not be correctly initialized.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 46 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 1c94b88..a7a01ce 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <asm/cpuidle.h>
 
@@ -94,6 +95,7 @@ static int __init arm_idle_init(void)
 {
 	int cpu, ret;
 	struct cpuidle_driver *drv = &arm_idle_driver;
+	struct cpuidle_device *dev;
 
 	/*
 	 * Initialize idle states data, starting at index 1.
@@ -105,18 +107,58 @@ static int __init arm_idle_init(void)
 	if (ret <= 0)
 		return ret ? : -ENODEV;
 
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		pr_err("Failed to register cpuidle driver\n");
+		return ret;
+	}
+
 	/*
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
 	 */
 	for_each_possible_cpu(cpu) {
 		ret = arm_cpuidle_init(cpu);
+
+		/* 
+		 * Do not register the cpuidle device. This situation could
+		 * happen when the low level PM was not able to initialize
+		 * for any reaon.
+		 */
+		if (ret == -ENXIO)
+			continue;
+
 		if (ret) {
 			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
-			return ret;
+			goto out_fail;
+		}
+
+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev) {
+			pr_err("Failed to allocate cpuidle device\n");
+			goto out_fail;
+		}
+		dev->cpu = cpu;
+
+		ret = cpuidle_register_device(dev);
+		if (ret) {
+			pr_err("Failed to register cpuidle device for CPU %d\n",
+			       cpu);
+			kfree(dev);
+			goto out_fail;
 		}
 	}
 
-	return cpuidle_register(drv, NULL);
+	return 0;
+out_fail:
+	while (--cpu >= 0) {
+		dev = per_cpu(cpuidle_devices, cpu);
+		cpuidle_unregister_device(dev);
+		kfree(dev);
+	}
+
+	cpuidle_unregister_driver(drv);
+
+	return ret;
 }
 device_initcall(arm_idle_init);
-- 
1.9.1
