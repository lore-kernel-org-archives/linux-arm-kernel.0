From: chenhui.zhao@nxp.com (Chenhui Zhao)
Date: Mon, 1 Aug 2016 17:49:03 +0800
Subject: [PATCH 2/2] soc: nxp: Add a RCPM driver
In-Reply-To: <1470044943-3814-1-git-send-email-chenhui.zhao@nxp.com>
References: <1470044943-3814-1-git-send-email-chenhui.zhao@nxp.com>
Message-ID: <1470044943-3814-2-git-send-email-chenhui.zhao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NXP's QorIQ Processors based on ARM Core have a RCPM module
(Run Control and Power Management), which performs all device-level
tasks associated with power management.

This patch mainly implements the wakeup sources configuration before
entering LPM20, a low power state of device-level. The devices can be
waked up by specified sources, such as Flextimer, GPIO and so on.

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 drivers/soc/fsl/Makefile     |   1 +
 drivers/soc/fsl/pm/Makefile  |   1 +
 drivers/soc/fsl/pm/ls-rcpm.c | 144 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/soc/fsl/pm/Makefile
 create mode 100644 drivers/soc/fsl/pm/ls-rcpm.c

diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 203307f..b5adbaf 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_SUSPEND)			+= pm/
diff --git a/drivers/soc/fsl/pm/Makefile b/drivers/soc/fsl/pm/Makefile
new file mode 100644
index 0000000..e275d63
--- /dev/null
+++ b/drivers/soc/fsl/pm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_LAYERSCAPE) += ls-rcpm.o
diff --git a/drivers/soc/fsl/pm/ls-rcpm.c b/drivers/soc/fsl/pm/ls-rcpm.c
new file mode 100644
index 0000000..c5f2b97
--- /dev/null
+++ b/drivers/soc/fsl/pm/ls-rcpm.c
@@ -0,0 +1,144 @@
+/*
+ * Run Control and Power Management (RCPM) driver
+ *
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#define pr_fmt(fmt) "RCPM: %s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/suspend.h>
+
+/* So far there are not more than two registers */
+#define RCPM_IPPDEXPCR0		0x140
+#define RCPM_IPPDEXPCR1		0x144
+#define RCPM_IPPDEXPCR(x)	(RCPM_IPPDEXPCR0 + 4 * x)
+#define RCPM_WAKEUP_CELL_MAX_SIZE	2
+
+/* it reprents the number of the registers RCPM_IPPDEXPCR */
+static unsigned int rcpm_wakeup_cells;
+static void __iomem *rcpm_reg_base;
+static u32 ippdexpcr[RCPM_WAKEUP_CELL_MAX_SIZE];
+
+static inline void rcpm_reg_write(u32 offset, u32 value)
+{
+	iowrite32be(value, rcpm_reg_base + offset);
+}
+
+static inline u32 rcpm_reg_read(u32 offset)
+{
+	return ioread32be(rcpm_reg_base + offset);
+}
+
+static void rcpm_wakeup_fixup(struct device *dev, void *data)
+{
+	struct device_node *node = dev ? dev->of_node : NULL;
+	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1];
+	int ret;
+	int i;
+
+	if (!dev || !node || !device_may_wakeup(dev))
+		return;
+
+	/*
+	 * Get the values in the "rcpm-wakeup" property.
+	 * Refer to Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+	 */
+	ret = of_property_read_u32_array(node, "rcpm-wakeup",
+					 value, rcpm_wakeup_cells + 1);
+	if (ret)
+		return;
+
+	pr_debug("wakeup source: the device %s\n", node->full_name);
+
+	for (i = 0; i < rcpm_wakeup_cells; i++)
+		ippdexpcr[i] |= value[i + 1];
+}
+
+static int rcpm_suspend_prepare(void)
+{
+	int i;
+
+	for (i = 0; i < rcpm_wakeup_cells; i++)
+		ippdexpcr[i] = 0;
+
+	dpm_for_each_dev(NULL, rcpm_wakeup_fixup);
+
+	for (i = 0; i < rcpm_wakeup_cells; i++) {
+		rcpm_reg_write(RCPM_IPPDEXPCR(i), ippdexpcr[i]);
+		pr_debug("ippdexpcr%d = 0x%x\n", i, ippdexpcr[i]);
+	}
+
+	return 0;
+}
+
+static int rcpm_suspend_notifier_call(struct notifier_block *bl,
+				      unsigned long state,
+				      void *unused)
+{
+	switch (state) {
+	case PM_SUSPEND_PREPARE:
+		rcpm_suspend_prepare();
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static const struct of_device_id rcpm_matches[] = {
+	{
+		.compatible = "fsl,qoriq-rcpm-2.1",
+	},
+	{}
+};
+
+static struct notifier_block rcpm_suspend_notifier = {
+	.notifier_call = rcpm_suspend_notifier_call,
+};
+
+static int __init layerscape_rcpm_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, rcpm_matches, NULL);
+	if (!np)
+		return -ENODEV;
+
+	ret = of_property_read_u32_index(np, "fsl,#rcpm-wakeup-cells", 0,
+					 &rcpm_wakeup_cells);
+	if (ret) {
+		pr_err("Fail to get \"fsl,#rcpm-wakeup-cells\".\n");
+		return -EINVAL;
+	}
+
+	if (rcpm_wakeup_cells > RCPM_WAKEUP_CELL_MAX_SIZE) {
+		pr_err("The value of \"fsl,#rcpm-wakeup-cells\" is wrong.\n");
+		return -EINVAL;
+	}
+
+	rcpm_reg_base = of_iomap(np, 0);
+	if (!rcpm_reg_base)
+		return -ENOMEM;
+
+	register_pm_notifier(&rcpm_suspend_notifier);
+
+	pr_info("The RCPM driver initialized.\n");
+
+	return 0;
+}
+
+subsys_initcall(layerscape_rcpm_init);
-- 
1.9.1
