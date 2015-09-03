From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  3 Sep 2015 13:58:30 -0600
Subject: [PATCH v2 3/7] drivers: cpu: Define CPU devices as IRQ safe
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1441310314-8857-4-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUs may be powered off from CPUIdle or hotplug and are called with
IRQ's disabled. Define CPU devices as IRQ safe, so they may be runtime
suspended/resumed.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 78720e7..56cb1d2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/cpufeature.h>
 #include <linux/tick.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 
@@ -371,10 +372,11 @@ int register_cpu(struct cpu *cpu, int num)
 	if (cpu->hotpluggable)
 		cpu->dev.groups = hotplugable_cpu_attr_groups;
 	error = device_register(&cpu->dev);
-	if (!error)
+	if (!error) {
+		pm_runtime_irq_safe(&cpu->dev);
 		per_cpu(cpu_sys_devices, num) = &cpu->dev;
-	if (!error)
 		register_cpu_under_node(num, cpu_to_node(num));
+	}
 
 	return error;
 }
-- 
2.1.4
