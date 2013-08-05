From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:27 -0400
Subject: [PATCH 8/8] ARM: keystone: add PM bus support for clock management
In-Reply-To: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375719147-7578-9-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add runtime PM core support to Keystone SOCs by using the pm_clk
infrastructure of the PM core. Patch is based on Kevin's pm_domain
work on DaVinci SOCs.

Keystone SOC doesn't have depedency to enable clocks in early
in the boot and hence the clock and PM bus initialisation is done
at subsystem_init() level at least for now.

Cc: Kevin Hilman <khilman@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/bus/Makefile          |    2 ++
 drivers/bus/keystone_pm_bus.c |   68 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 drivers/bus/keystone_pm_bus.c

diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 8947bdd..cb7f304 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 # CCI cache coherent interconnect for ARM platforms
 obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
+# PM bus driver for Keystone SOCs
+obj-$(CONFIG_ARCH_KEYSTONE)	+= keystone_pm_bus.o
diff --git a/drivers/bus/keystone_pm_bus.c b/drivers/bus/keystone_pm_bus.c
new file mode 100644
index 0000000..cbb4000
--- /dev/null
+++ b/drivers/bus/keystone_pm_bus.c
@@ -0,0 +1,68 @@
+/*
+ * PM Bus driver for Keystone2 devices
+ *
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * Based on Kevins work on DAVINCI SOCs
+ *	Kevin Hilman <khilman@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_clock.h>
+#include <linux/platform_device.h>
+
+#ifdef CONFIG_PM_RUNTIME
+static int keystone_pm_runtime_suspend(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_clk_suspend(dev);
+	if (ret) {
+		pm_generic_runtime_resume(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int keystone_pm_runtime_resume(struct device *dev)
+{
+	dev_dbg(dev, "%s\n", __func__);
+
+	pm_clk_resume(dev);
+
+	return pm_generic_runtime_resume(dev);
+}
+#endif
+
+static struct dev_pm_domain keystone_pm_bus = {
+	.ops = {
+		SET_RUNTIME_PM_OPS(keystone_pm_runtime_suspend,
+				   keystone_pm_runtime_resume, NULL)
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+static struct pm_clk_notifier_block platform_bus_notifier = {
+	.pm_domain = &keystone_pm_bus,
+};
+
+int __init keystone_pm_runtime_init(void)
+{
+	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
+
+	return 0;
+}
+subsystem_init(keystone_pm_runtime_init);
-- 
1.7.9.5
