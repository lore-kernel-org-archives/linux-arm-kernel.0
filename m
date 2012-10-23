From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:57 +0800
Subject: [PATCH 08/10] ARM: imx: move imx6q_cpuidle_driver into a separate file
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-9-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move imx6q_cpuidle_driver into a separate file as more codes will
be added when WAIT mode gets implemented as cpuidle.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile        |    6 +++++-
 arch/arm/mach-imx/cpuidle-imx6q.c |   26 ++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h       |    5 +++++
 arch/arm/mach-imx/mach-imx6q.c    |   12 +-----------
 4 files changed, 37 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fe47b71..a29ed49 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -28,7 +28,11 @@ obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
-obj-$(CONFIG_CPU_IDLE) += cpuidle.o
+
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-y += cpuidle.o
+obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
+endif
 
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
new file mode 100644
index 0000000..83facc9
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+
+#include "cpuidle.h"
+
+static struct cpuidle_driver imx6q_cpuidle_driver = {
+	.name = "imx6q_cpuidle",
+	.owner = THIS_MODULE,
+	.en_core_tk_irqen = 1,
+	.states[0] = ARM_CPUIDLE_WFI_STATE,
+	.state_count = 1,
+};
+
+int __init imx6q_cpuidle_init(void)
+{
+	return imx_cpuidle_init(&imx6q_cpuidle_driver);
+}
diff --git a/arch/arm/mach-imx/cpuidle.h b/arch/arm/mach-imx/cpuidle.h
index bc932d1..e092d13 100644
--- a/arch/arm/mach-imx/cpuidle.h
+++ b/arch/arm/mach-imx/cpuidle.h
@@ -14,9 +14,14 @@
 
 #ifdef CONFIG_CPU_IDLE
 extern int imx_cpuidle_init(struct cpuidle_driver *drv);
+extern int imx6q_cpuidle_init(void);
 #else
 static inline int imx_cpuidle_init(struct cpuidle_driver *drv)
 {
 	return -ENODEV;
 }
+static inline int imx6q_cpuidle_init(void)
+{
+	return -ENODEV;
+}
 #endif
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 1c5acf8..8ecdeb5 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -12,7 +12,6 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/cpuidle.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -26,7 +25,6 @@
 #include <linux/regmap.h>
 #include <linux/micrel_phy.h>
 #include <linux/mfd/syscon.h>
-#include <asm/cpuidle.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
@@ -182,17 +180,9 @@ static void __init imx6q_init_machine(void)
 	imx6q_usb_init();
 }
 
-static struct cpuidle_driver imx6q_cpuidle_driver = {
-	.name			= "imx6q_cpuidle",
-	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.state_count		= 1,
-};
-
 static void __init imx6q_init_late(void)
 {
-	imx_cpuidle_init(&imx6q_cpuidle_driver);
+	imx6q_cpuidle_init();
 }
 
 static void __init imx6q_map_io(void)
-- 
1.7.9.5
