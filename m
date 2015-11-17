From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 17 Nov 2015 15:37:35 -0700
Subject: [PATCH RFC 11/27] drivers: cpu: Define CPU devices as IRQ safe
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1447799871-56374-12-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUs may be powered off from CPUIdle or hotplug and are called with
IRQ's disabled. Define CPU devices as IRQ safe, so they may be runtime
suspended/resumed.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 91bbb19..6633210 100644
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
