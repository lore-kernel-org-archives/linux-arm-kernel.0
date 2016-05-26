From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 May 2016 11:38:10 +0200
Subject: [RFC PATCH 1/2] firmware: Add a SCPI framework to handle multiple
 vendors implementation
In-Reply-To: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
References: <1464255491-18503-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464255491-18503-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a thin "register" interface for SCPI driver in order to register their
ops along their node.

Since nodes using the SCPI ops are currently sub-nodes, does not implement
phandle xlate stuff.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/Makefile |   1 +
 drivers/firmware/scpi.c   | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 drivers/firmware/scpi.c

diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 474bada..701a791 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the linux kernel.
 #
 obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= scpi.o
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
diff --git a/drivers/firmware/scpi.c b/drivers/firmware/scpi.c
new file mode 100644
index 0000000..ba94ac4
--- /dev/null
+++ b/drivers/firmware/scpi.c
@@ -0,0 +1,110 @@
+/*
+ * System Control and Power Interface (SCPI) Message Protocol framework
+ *
+ * SCPI Message Protocol is used between the System Control Processor(SCP)
+ * and the Application Processors(AP). The Message Handling Unit(MHU)
+ * provides a mechanism for inter-processor communication between SCP's
+ * Cortex M3 and AP.
+ *
+ * SCP offers control and management of the core/cluster power states,
+ * various power domain DVFS including the core/cluster, certain system
+ * clocks configuration, thermal sensors and many others.
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ * Copyright (C) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/scpi_protocol.h>
+#include <linux/spinlock.h>
+
+static DEFINE_MUTEX(scpi_list_mutex);
+static LIST_HEAD(scpi_drivers_list);
+
+struct scpi_ops *of_scpi_ops_get(struct device_node *node)
+{
+	struct scpi_ops *ops = NULL;
+	struct scpi_driver *r;
+
+	if (!node)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&scpi_list_mutex);
+	list_for_each_entry(r, &scpi_drivers_list, list) {
+		if (node == r->node) {
+			ops = r->ops;
+			break;
+		}
+	}
+	mutex_unlock(&scpi_list_mutex);
+
+	if (!ops)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return ops;
+}
+EXPORT_SYMBOL_GPL(of_scpi_ops_get);
+
+int scpi_driver_register(struct scpi_driver *drv)
+{
+	mutex_lock(&scpi_list_mutex);
+	list_add(&drv->list, &scpi_drivers_list);
+	mutex_unlock(&scpi_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scpi_driver_register);
+
+void scpi_driver_unregister(struct scpi_driver *drv)
+{
+	mutex_lock(&scpi_list_mutex);
+	list_del(&drv->list);
+	mutex_unlock(&scpi_list_mutex);
+}
+EXPORT_SYMBOL_GPL(scpi_driver_unregister);
+
+static void devm_scpi_driver_unregister(struct device *dev, void *res)
+{
+	scpi_driver_unregister(*(struct scpi_driver **)res);
+}
+
+int devm_scpi_driver_register(struct device *dev,
+				struct scpi_driver *drv)
+{
+	struct scpi_driver **rcdrv;
+	int ret;
+
+	rcdrv = devres_alloc(devm_scpi_driver_unregister, sizeof(*drv),
+			     GFP_KERNEL);
+	if (!rcdrv)
+		return -ENOMEM;
+
+	ret = scpi_driver_register(drv);
+	if (!ret) {
+		*rcdrv = drv;
+		devres_add(dev, rcdrv);
+	} else
+		devres_free(rcdrv);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_scpi_driver_register);
-- 
2.7.0
