From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 10:02:50 -0400
Subject: [PATCH] keystone: psci: adds cpu_die implementation
Message-ID: <1435240970-30869-1-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add cpu_die implementation using psci api

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/mach-keystone/platsmp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
index 5f46a7c..2c40cc0 100644
--- a/arch/arm/mach-keystone/platsmp.c
+++ b/arch/arm/mach-keystone/platsmp.c
@@ -20,6 +20,7 @@
 #include <asm/prom.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
+#include <asm/psci.h>
 
 #include "keystone.h"
 
@@ -51,7 +52,38 @@ static inline void __cpuinit keystone_smp_secondary_initmem(unsigned int cpu)
 {}
 #endif
 
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void keystone_cpu_die(unsigned int cpu)
+{
+#ifdef CONFIG_ARM_PSCI
+	struct psci_power_state pwr_state = {0, 0, 0};
+
+	pr_info("keystone_cpu_die(%d) from %d using PSCI\n", cpu,
+	       smp_processor_id());
+
+	if (psci_ops.cpu_off)
+		psci_ops.cpu_off(pwr_state);
+#else
+	/*
+	 * We may want to add here a direct smc call to monitor
+	 * if the kernel doesn't support PSCI API
+	 */
+#endif
+
+	/*
+	 * we shouldn't come here. But in case something went
+	 * wrong the code below prevents kernel from crush
+	 */
+	while (1)
+		cpu_do_idle();
+}
+#endif
+
 struct smp_operations keystone_smp_ops __initdata = {
 	.smp_boot_secondary	= keystone_smp_boot_secondary,
 	.smp_secondary_init     = keystone_smp_secondary_initmem,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= keystone_cpu_die,
+#endif
 };
-- 
1.9.1
