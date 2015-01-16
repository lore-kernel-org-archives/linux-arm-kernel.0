From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:07 +0900
Subject: [PATCH 4/4] drivers: bus: Add Simple Power-Managed Bus Driver
In-Reply-To: <cover.1421371868.git.horms+renesas@verge.net.au>
References: <cover.1421371868.git.horms+renesas@verge.net.au>
Message-ID: <ab9ff6fe6fdd225a92ae740eceb05e12daf00ce1.1421371868.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a driver for transparent busses that don't need a real driver (think
"simple-bus"), where the bus controller is part of a PM domain, or under
the control of a functional clock.  Typically, the bus controller's
PM domain and/or clock must be enabled for child devices connected to
the bus (either on-SoC or externally) to function.

Hence the sole purpose of this driver is to enable its clock and PM
domain (if exist(s)), which are specified in the DT and managed from
platform and PM domain code.

Due to the child-parent relationship with devices connected to the bus,
PM domain and clock state transitions are handled in the correct order.

Currently this driver handles the Renesas Bus State Controller (BSC,
sometimes called "LBSC within Bus Bridge", or "External Bus Interface")
found on several Renesas ARM SoCs. Support for other bus controllers can
easily be added by adding more compatible values.

Note that this driver cannot just bind against "simple-bus", as that
may prevent a device-specific driver from taking precedence.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/bus/Kconfig         | 13 ++++++++++++
 drivers/bus/Makefile        |  1 +
 drivers/bus/simple-pm-bus.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/bus/simple-pm-bus.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6269608..1addb70 100644
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
+	  Driver for transparent busses that don't need a real driver (think
+	  "simple-bus"), where the bus controller is part of a PM domain, or
+	  under the control of a functional clock, and thus relies on runtime
+	  PM for managing this PM domain and/or clock.
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
index 0000000..e55872d
--- /dev/null
+++ b/drivers/bus/simple-pm-bus.c
@@ -0,0 +1,51 @@
+/*
+ * Simple Power-Managed Bus Driver
+ *
+ * Copyright (C) 2014 Glider bvba
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+
+static int simple_pm_bus_probe(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	pm_runtime_enable(&pdev->dev);
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
+	{ .compatible = "renesas,bsc", },
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
