From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Sep 2012 10:13:37 +0200
Subject: [PATCH 4/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
Message-ID: <1347524018-19301-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Exynos-based boards contain secure firmware and must use firmware
operations to set up some hardware.

This patch adds firmware operations for Exynos secure firmware and a way
for board code and device tree to specify that they must be used.

Example of use:

In board code:

	...MACHINE_START(...)
		/* ... */
		.init_early	= exynos_firmware_init,
		/* ... */
	MACHINE_END

In device tree:

	/ {
		/* ... */

		firmware {
			compatible = "samsung,secure-firmware";
		};

		/* ... */
	};

This is a follow-up on the patch by Kyungmin Park:
[PATCH v5 2/2] ARM: EXYNOS: SMC instruction (aka firmware) support
http://thread.gmane.org/gmane.linux.ports.arm.kernel/183608/focus=184109

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 .../devicetree/bindings/arm/samsung-boards.txt     |  8 ++++
 arch/arm/mach-exynos/Makefile                      |  1 +
 arch/arm/mach-exynos/common.h                      |  2 +
 arch/arm/mach-exynos/firmware.c                    | 52 ++++++++++++++++++++++
 arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
 5 files changed, 64 insertions(+)
 create mode 100644 arch/arm/mach-exynos/firmware.c

diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung-boards.txt
index 0bf68be..f447059 100644
--- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
@@ -6,3 +6,11 @@ Required root node properties:
     - compatible = should be one or more of the following.
         (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
         (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
+
+Optional:
+    - firmware node, specifying presence and type of secure firmware, currently
+        supported value of compatible property is "samsung,secure-firmware":
+
+	firmware {
+		compatible = "samsung,secure-firmware";
+	};
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 997864b..9451637 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= exynos-smc.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= firmware.o
 
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index d7f28ca..358f6a5 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -21,6 +21,8 @@ void exynos4_restart(char mode, const char *cmd);
 void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
 
+void exynos_firmware_init(void);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS
 int exynos_pm_late_initcall(void);
 #else
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
new file mode 100644
index 0000000..3f3641d
--- /dev/null
+++ b/arch/arm/mach-exynos/firmware.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2012 Samsung Electronics.
+ * Kyungmin Park <kyungmin.park@samsung.com>
+ * Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+#include <asm/firmware.h>
+
+#include <mach/map.h>
+
+#include "smc.h"
+
+static int exynos_do_idle(void)
+{
+        exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+        return 0;
+}
+
+static void exynos_cpu_boot(int cpu)
+{
+	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
+}
+
+static void __iomem *exynos_cpu_boot_reg(int cpu)
+{
+	return S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
+}
+
+static const struct firmware_ops exynos_firmware_ops __initdata = {
+	.do_idle	= exynos_do_idle,
+	.cpu_boot	= exynos_cpu_boot,
+	.cpu_boot_reg	= exynos_cpu_boot_reg,
+};
+
+void __init exynos_firmware_init(void)
+{
+	if (of_have_populated_dt() &&
+	    !of_find_compatible_node(NULL, NULL, "samsung,secure-firmware"))
+		return;
+
+	pr_info("Running under secure firmware.\n");
+
+	register_firmware_ops(&exynos_firmware_ops);
+}
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 5c48c82..e0827b3 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -116,6 +116,7 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.init_irq	= exynos4_init_irq,
 	.map_io		= exynos4_dt_map_io,
 	.handle_irq	= gic_handle_irq,
+	.init_early	= exynos_firmware_init,
 	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
 	.timer		= &exynos4_timer,
-- 
1.7.12
