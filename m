From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 12 May 2015 16:16:26 +0200
Subject: [PATCH] ARM: berlin: add CPU hotplug support
Message-ID: <1431440186-14075-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds CPU hotplug support for Berlin SoCs (currently BG2 and BG2Q). The
CPUs are put in WFI after disabling the coherency.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/platsmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 702e7982015a..d9c62057be76 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cp15.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
@@ -92,8 +93,20 @@ unmap_scu:
 	iounmap(scu_base);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void berlin_cpu_die(unsigned int cpu)
+{
+	v7_exit_coherency_flush(louis);
+	while (1)
+		cpu_do_idle();
+}
+#endif
+
 static struct smp_operations berlin_smp_ops __initdata = {
 	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
 	.smp_boot_secondary	= berlin_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= berlin_cpu_die,
+#endif
 };
 CPU_METHOD_OF_DECLARE(berlin_smp, "marvell,berlin-smp", &berlin_smp_ops);
-- 
2.4.0
