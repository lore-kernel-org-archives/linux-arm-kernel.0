From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri,  3 Mar 2017 12:41:28 -0800
Subject: [PATCH V5 2/9] drivers: cpu: Setup CPU devices to do runtime PM
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1488573695-106680-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU devices just like any other device, can do runtime PM. However, CPU
devices may only do runtime only when IRQs are disabled. The devices
must be set as IRQ safe.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/cpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 2c3b359..77451ad 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -18,6 +18,7 @@
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -345,6 +346,19 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+#ifdef CONFIG_PM
+static void cpu_runtime_pm_init(struct device *dev)
+{
+	pm_runtime_irq_safe(dev);
+	pm_runtime_enable(dev);
+	if (cpu_online(dev->id))
+		pm_runtime_set_active(dev);
+}
+#else
+static void cpu_runtime_pm_init(struct device *dev)
+{ }
+#endif
+
 /*
  * register_cpu - Setup a sysfs device for a CPU.
  * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
@@ -379,6 +393,7 @@ int register_cpu(struct cpu *cpu, int num)
 	register_cpu_under_node(num, cpu_to_node(num));
 	dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
 
+	cpu_runtime_pm_init(&cpu->dev);
 	return 0;
 }
 
-- 
2.7.4
