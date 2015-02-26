From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:24 +0900
Subject: [PATCH 5/5] drivers: bus: Add Simple Power-Managed Bus Driver
In-Reply-To: <cover.1424931637.git.horms+renesas@verge.net.au>
References: <cover.1424931637.git.horms+renesas@verge.net.au>
Message-ID: <89d463ea106dba530786a2815fd174f9e6eab71f.1424931637.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a driver for transparent busses that don't need a real driver, but
where the bus controller is part of a PM domain, or under the control of
a functional clock.  Typically, the bus controller's PM domain and/or
clock must be enabled for child devices connected to the bus (either
on-SoC or externally) to function.

Hence the sole purpose of this driver is to enable its clock and PM
domain (if exist(s)), which are specified in the DT and managed from
platform and PM domain code, and to probe for child devices.

Due to the child-parent relationship with devices connected to the bus,
PM domain and clock state transitions are handled in the correct order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/bus/Kconfig         | 13 ++++++++++
 drivers/bus/Makefile        |  1 +
 drivers/bus/simple-pm-bus.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/bus/simple-pm-bus.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6269608..7e9c267 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -58,6 +58,19 @@ config OMAP_OCP2SCP
 	  OCP2SCP and in OMAP5, both USB PHY and SATA PHY is connected via
 	  OCP2SCP.
 
+config SIMPLE_PM_BUS
+	bool "Simple Power-Managed Bus Driver"
+	depends on OF && PM
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	help
+	  Driver for transparent busses that don't need a real driver, but
+	  where the bus controller is part of a PM domain, or under the control
+	  of a functional clock, and thus relies on runtime PM for managing
+	  this PM domain and/or clock.
+	  An example of such a bus controller is the Renesas Bus State
+	  Controller (BSC, sometimes called "LBSC within Bus Bridge", or
+	  "External Bus Interface") as found on several Renesas ARM SoCs.
+
 config VEXPRESS_CONFIG
 	bool "Versatile Express configuration bus"
 	default y if ARCH_VEXPRESS
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 3cfaf2c..e023a2b 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
 obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
+obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
new file mode 100644
index 0000000..c5eb46c
--- /dev/null
+++ b/drivers/bus/simple-pm-bus.c
@@ -0,0 +1,58 @@
+/*
+ * Simple Power-Managed Bus Driver
+ *
+ * Copyright (C) 2014-2015 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+
+static int simple_pm_bus_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	pm_runtime_enable(&pdev->dev);
+
+	if (np)
+		of_platform_populate(np, NULL, NULL, &pdev->dev);
+
+	return 0;
+}
+
+static int simple_pm_bus_remove(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id simple_pm_bus_of_match[] = {
+	{ .compatible = "simple-pm-bus", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
+
+static struct platform_driver simple_pm_bus_driver = {
+	.probe = simple_pm_bus_probe,
+	.remove = simple_pm_bus_remove,
+	.driver = {
+		.name = "simple-pm-bus",
+		.of_match_table = simple_pm_bus_of_match,
+	},
+};
+
+module_platform_driver(simple_pm_bus_driver);
+
+MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
