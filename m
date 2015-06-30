From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Tue, 30 Jun 2015 18:15:07 +0300
Subject: [PATCH v2 5/5] cpuidle: ARM: Add cpuidle driver for K1879XB1YA
In-Reply-To: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <1435677307-6526-6-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
---
 drivers/cpuidle/Kconfig.arm            |  6 +++++
 drivers/cpuidle/Makefile               |  1 +
 drivers/cpuidle/cpuidle-rcm-k1879xb1.c | 48 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-rcm-k1879xb1.c

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..988bfa3 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -74,3 +74,9 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_RCM_K1879XB1_CPUIDLE
+	bool "CPU Idle Driver for RC Module's K1879XB1YA SoC"
+	depends on ARCH_RCM_K1879XB1 && !ARM64
+	help
+	  Select this to enable cpuidle on K1879XB1YA SoC.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 3ba81b1..71b7e16 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
+obj-$(CONFIG_ARM_RCM_K1879XB1_CPUIDLE)  += cpuidle-rcm-k1879xb1.o
 obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
 
 ###############################################################################
diff --git a/drivers/cpuidle/cpuidle-rcm-k1879xb1.c b/drivers/cpuidle/cpuidle-rcm-k1879xb1.c
new file mode 100644
index 0000000..7c621b6
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-rcm-k1879xb1.c
@@ -0,0 +1,48 @@
+/*
+ * CPU idle for RC Module K1879XB1YA SoC
+ *
+ * Copyright (C) 2015 RC Module.
+ * http://www.module.ru/
+ *
+ * Andrew Andrianov <andrew@ncrmnt.org>
+ *
+ * Based on Davinci CPU idle code
+ * (arch/arm/mach-davinci/cpuidle.c)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/cpuidle.h>
+#include <asm/cpuidle.h>
+
+/*
+ * We only enable WFI here, since DDR will enter self-refresh
+ * on it's own when it can (bootloader takes care to configure that)
+ */
+
+static struct cpuidle_driver rcm_idle_driver = {
+	.name			= "rcm_k1879xb1_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.state_count		= 1,
+};
+
+static int __init rcm_cpuidle_probe(struct platform_device *pdev)
+{
+	return cpuidle_register(&rcm_idle_driver, NULL);
+}
+
+static struct platform_driver rcm_cpuidle_driver = {
+	.driver = {
+		.name	= "cpuidle-rcm-k1879xb1",
+	},
+};
+
+static int __init rcm_cpuidle_init(void)
+{
+	return platform_driver_probe(&rcm_cpuidle_driver, rcm_cpuidle_probe);
+}
+device_initcall(rcm_cpuidle_init);
-- 
2.1.4
