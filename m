From: jolly.shah@xilinx.com (Jolly Shah)
Date: Tue, 27 Feb 2018 15:24:26 -0800
Subject: [PATCH 2/2] drivers: soc: xilinx: Add ZynqMP PM driver
In-Reply-To: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
References: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
Message-ID: <1519773866-18196-3-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 drivers/soc/Makefile                    |   1 +
 drivers/soc/xilinx/Kconfig              |   2 +
 drivers/soc/xilinx/Makefile             |   2 +
 drivers/soc/xilinx/zynqmp/Kconfig       |  20 +++
 drivers/soc/xilinx/zynqmp/Makefile      |   4 +
 drivers/soc/xilinx/zynqmp/power.c       | 249 ++++++++++++++++++++++++++++++++
 include/linux/soc/xilinx/zynqmp/power.h |  18 +++
 7 files changed, 296 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/power.c
 create mode 100644 include/linux/soc/xilinx/zynqmp/power.h

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 4052357..4d3c099 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
+obj-$(CONFIG_ARCH_ZYNQMP)	+= xilinx/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..1c98d7f 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,6 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+source "drivers/soc/xilinx/zynqmp/Kconfig"
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..e132897 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+
+obj-$(CONFIG_ARCH_ZYNQMP)	+= zynqmp/
diff --git a/drivers/soc/xilinx/zynqmp/Kconfig b/drivers/soc/xilinx/zynqmp/Kconfig
new file mode 100644
index 0000000..0313764
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Kconfig for Xilinx zynqmp SoC
+
+menu "Zynq MPSoC SoC Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM
+	default y
+	select MAILBOX
+	select ZYNQMP_IPI_MBOX
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers mailbox client
+	  to handle power management callbacks from firmware.
+	  In doubt, say N.
+
+endmenu
diff --git a/drivers/soc/xilinx/zynqmp/Makefile b/drivers/soc/xilinx/zynqmp/Makefile
new file mode 100644
index 0000000..b1cea09
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Makefile for Xilinx zynqmp SoC
+
+obj-$(CONFIG_ZYNQMP_POWER)	+= power.o
diff --git a/drivers/soc/xilinx/zynqmp/power.c b/drivers/soc/xilinx/zynqmp/power.c
new file mode 100644
index 0000000..8864341
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp/power.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/uaccess.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
+
+/**
+ * struct zynqmp_pm_work_struct - Wrapper for struct work_struct
+ * @callback_work:	Work structure
+ * @args:		Callback arguments
+ */
+struct zynqmp_pm_work_struct {
+	struct work_struct callback_work;
+	u32 args[CB_ARG_CNT];
+};
+
+static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
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
+static void ipi_receive_callback(struct mbox_client *cl, void *data)
+{
+	struct zynqmp_ipi_message *msg = (struct zynqmp_ipi_message *)data;
+	u32 payload[msg->len];
+
+	memcpy(payload, msg->data, sizeof(msg->len));
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
+			return;
+
+		/* Copy callback arguments into work's structure */
+		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
+		       sizeof(zynqmp_pm_init_suspend_work->args));
+
+		queue_work(system_unbound_wq,
+			   &zynqmp_pm_init_suspend_work->callback_work);
+	}
+}
+
+/**
+ * zynqmp_pm_init_suspend_work_fn - Initialize suspend
+ * @work:	Pointer to work_struct
+ *
+ * Bottom-half of PM callback IRQ handler.
+ */
+static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
+{
+	struct zynqmp_pm_work_struct *pm_work =
+		container_of(work, struct zynqmp_pm_work_struct, callback_work);
+
+	if (pm_work->args[0] == ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
+		orderly_poweroff(true);
+	} else if (pm_work->args[0] ==
+		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
+		pm_suspend(PM_SUSPEND_MEM);
+	} else {
+		pr_err("%s Unsupported InitSuspendCb reason code %d.\n",
+		       __func__, pm_work->args[0]);
+	}
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
+/**
+ * zynqmp_pm_sysfs_init - Initialize PM driver sysfs interface
+ * @dev:	Pointer to device structure
+ *
+ * Return:	0 on success, negative error code otherwise
+ */
+static int zynqmp_pm_sysfs_init(struct device *dev)
+{
+	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr);
+}
+
+/**
+ * zynqmp_pm_probe - Probe existence of the PMU Firmware
+ *			and initialize debugfs interface
+ *
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * Return:	Returns 0 on success
+ *		Negative error code otherwise
+ */
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 pm_api_version;
+	struct mbox_client *client;
+	struct mbox_chan *rx_chan;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version)
+		return -ENXIO;
+
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version <= ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	zynqmp_pm_init_suspend_work =
+		devm_kzalloc(&pdev->dev, sizeof(struct zynqmp_pm_work_struct),
+			     GFP_KERNEL);
+	if (!zynqmp_pm_init_suspend_work)
+		return -ENOMEM;
+
+	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
+		  zynqmp_pm_init_suspend_work_fn);
+
+	ret = zynqmp_pm_sysfs_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
+		return ret;
+	}
+
+	client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->dev = &pdev->dev;
+	client->rx_callback = ipi_receive_callback;
+
+	rx_chan = mbox_request_channel_byname(client, "rx");
+	if (IS_ERR(rx_chan)) {
+		dev_err(&pdev->dev, "Failed to request rx channel\n");
+		return IS_ERR(rx_chan);
+	}
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
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+
+builtin_platform_driver(zynqmp_pm_platform_driver);
+
+/**
+ * zynqmp_pm_init - Notify PM firmware that initialization is completed
+ *
+ * Return:	Status returned from the PM firmware
+ */
+static int __init zynqmp_pm_init(void)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	return eemi_ops->init_finalize();
+}
+
+late_initcall_sync(zynqmp_pm_init);
diff --git a/include/linux/soc/xilinx/zynqmp/power.h b/include/linux/soc/xilinx/zynqmp/power.h
new file mode 100644
index 0000000..001d832
--- /dev/null
+++ b/include/linux/soc/xilinx/zynqmp/power.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __SOC_XILINX_ZYNQMP_PM_H__
+#define __SOC_XILINX_ZYNQMP_PM_H__
+
+#define ZYNQMP_PM_MAX_LATENCY	(~0U)
+#define ZYNQMP_PM_MAX_QOS	100U
+
+#endif /* __SOC_XILINX_ZYNQMP_PM_H__ */
-- 
2.7.4
