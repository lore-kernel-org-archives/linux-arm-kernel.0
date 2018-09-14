From: jolly.shah@xilinx.com (Jolly Shah)
Date: Fri, 14 Sep 2018 12:39:50 -0700
Subject: [PATCH v4 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
Message-ID: <1536953990-12755-4-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig        |  11 +++
 drivers/soc/xilinx/Makefile       |   1 +
 drivers/soc/xilinx/zynqmp_power.c | 178 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..5025e0e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,15 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM && ARCH_ZYNQMP
+	default y
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers isr to handle
+	  power management callbacks from firmware.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..428b9db 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
new file mode 100644
index 0000000..771cb59
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void zynqmp_pm_get_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t zynqmp_pm_isr(int irq, void *data)
+{
+	u32 payload[CB_PAYLOAD_SIZE];
+
+	zynqmp_pm_get_callback_data(payload);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		switch (payload[1]) {
+		case SUSPEND_SYSTEM_SHUTDOWN:
+			orderly_poweroff(true);
+			break;
+		case SUSPEND_POWER_REQUEST:
+			pm_suspend(PM_SUSPEND_MEM);
+			break;
+		default:
+			pr_err("%s Unsupported InitSuspendCb reason "
+				"code %d\n", __func__, payload[1]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret, irq;
+	u32 pm_api_version;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	eemi_ops->init_finalize();
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version < ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, zynqmp_pm_isr,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
+					dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed "
+			"with %d\n", irq, ret);
+		return ret;
+	}
+
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to create sysfs interface\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int zynqmp_pm_remove(struct platform_device *pdev)
+{
+	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
+
+	return 0;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.remove = zynqmp_pm_remove,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+module_platform_driver(zynqmp_pm_platform_driver);
-- 
2.7.4
