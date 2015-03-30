From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 30 Mar 2015 13:26:37 +0800
Subject: [PATCH v3] cpufreq: hisilicon: add acpu driver
Message-ID: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add acpu driver for hisilicon SoC, acpu is application processor
subsystem. Currently the acpu has the coupled clock domain for two
clusters, so this driver will directly use cpufreq-dt driver as
backend.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpufreq/Kconfig.arm         |  9 ++++++++
 drivers/cpufreq/Makefile            |  1 +
 drivers/cpufreq/hisi-acpu-cpufreq.c | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1b06fc4..4f3dbc8 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -108,6 +108,15 @@ config ARM_HIGHBANK_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_HISI_ACPU_CPUFREQ
+	tristate "Hisilicon ACPU CPUfreq driver"
+	depends on ARCH_HISI && CPUFREQ_DT
+	select PM_OPP
+	help
+	  This enables the hisilicon ACPU CPUfreq driver.
+
+	  If in doubt, say N.
+
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 82a1821..6b7a3f0 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -59,6 +59,7 @@ arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 arm-exynos-cpufreq-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
+obj-$(CONFIG_ARM_HISI_ACPU_CPUFREQ)	+= hisi-acpu-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
diff --git a/drivers/cpufreq/hisi-acpu-cpufreq.c b/drivers/cpufreq/hisi-acpu-cpufreq.c
new file mode 100644
index 0000000..026d5b2
--- /dev/null
+++ b/drivers/cpufreq/hisi-acpu-cpufreq.c
@@ -0,0 +1,42 @@
+/*
+ * Hisilicon Platforms Using ACPU CPUFreq Support
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 Linaro Limited.
+ *
+ * Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static int __init hisi_acpu_cpufreq_driver_init(void)
+{
+	struct platform_device *pdev;
+
+	if (!of_machine_is_compatible("hisilicon,hi6220"))
+		return -ENODEV;
+
+	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	return PTR_ERR_OR_ZERO(pdev);
+}
+module_init(hisi_acpu_cpufreq_driver_init);
+
+MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
+MODULE_DESCRIPTION("Hisilicon acpu cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
