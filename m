From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Mar 2013 18:55:32 +0100
Subject: [PATCH 07/15] ARM: cpuidle: add init/exit routine
In-Reply-To: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init and exit routine for most of the drivers are the same,
that is register the driver and register the device.

Provide a common function to do that in the cpuidle driver for ARM,
so we can get rid of a lot of code duplication in the different SOC
cpuidle drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/include/asm/cpuidle.h |    4 +++
 arch/arm/kernel/cpuidle.c      |   57 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 7367787..83a38ac 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -4,6 +4,10 @@
 extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv, int index);
 
+extern int arm_cpuidle_init(struct cpuidle_driver *drv);
+
+extern void arm_cpuidle_exit(struct cpuidle_driver *drv);
+
 /* Common ARM WFI state */
 #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
 	.enter                  = arm_cpuidle_simple_enter,\
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index 89545f6..13cfe3e 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -9,13 +9,68 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/module.h>
 #include <linux/cpuidle.h>
 #include <asm/proc-fns.h>
 
+static DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
+
 int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
-		struct cpuidle_driver *drv, int index)
+			     struct cpuidle_driver *drv, int index)
 {
 	cpu_do_idle();
 
 	return index;
 }
+
+int __init arm_cpuidle_init(struct cpuidle_driver *drv)
+{
+       int ret, cpu;
+       struct cpuidle_device *device;
+
+       ret = cpuidle_register_driver(drv);
+       if (ret) {
+               printk(KERN_ERR "failed to register idle driver '%s'\n",
+                       drv->name);
+               return ret;
+       }
+
+       for_each_online_cpu(cpu) {
+
+               device = &per_cpu(cpuidle_device, cpu);
+               device->cpu = cpu;
+               ret = cpuidle_register_device(device);
+               if (ret) {
+                       printk(KERN_ERR "Failed to register cpuidle "
+                              "device for cpu%d\n", cpu);
+                       goto out_unregister;
+               }
+       }
+
+out:
+       return ret;
+
+out_unregister:
+       for_each_online_cpu(cpu) {
+               device = &per_cpu(cpuidle_device, cpu);
+               cpuidle_unregister_device(device);
+       }
+
+       cpuidle_unregister_driver(drv);
+       goto out;
+}
+EXPORT_SYMBOL_GPL(arm_cpuidle_init);
+
+void __exit arm_cpuidle_exit(struct cpuidle_driver *drv)
+{
+	int cpu;
+	struct cpuidle_device *device;
+
+	for_each_online_cpu(cpu) {
+		device = &per_cpu(cpuidle_device, cpu);
+		cpuidle_unregister_device(device);
+	}
+
+	cpuidle_unregister_driver(drv);
+}
+EXPORT_SYMBOL_GPL(arm_cpuidle_exit);
-- 
1.7.9.5
