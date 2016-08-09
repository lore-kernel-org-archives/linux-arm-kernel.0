From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 12:29:15 +0200
Subject: [RFC PATCH v3 1/8] firmware: Add a SCPI registry to handle multiple
 implementations
In-Reply-To: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
References: <1470738562-20026-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470738562-20026-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/Kconfig      |  4 ++
 drivers/firmware/Makefile     |  1 +
 drivers/firmware/scpi.c       | 94 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/scpi_protocol.h | 15 ++++++-
 4 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/scpi.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 0e22f24..ff85511 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -8,9 +8,13 @@ menu "Firmware Drivers"
 config ARM_PSCI_FW
 	bool
 
+config SCPI_FW
+	bool
+
 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
 	depends on MAILBOX
+	select SCPI_FW
 	help
 	  System Control and Power Interface (SCPI) Message Protocol is
 	  defined for the purpose of communication between the Application
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 44a59dc..968197f 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the linux kernel.
 #
 obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_SCPI_FW)		+= scpi.o
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
 obj-$(CONFIG_DMI)		+= dmi_scan.o
diff --git a/drivers/firmware/scpi.c b/drivers/firmware/scpi.c
new file mode 100644
index 0000000..87a559a
--- /dev/null
+++ b/drivers/firmware/scpi.c
@@ -0,0 +1,94 @@
+/*
+ * System Control and Power Interface (SCPI) Message Protocol registry
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
+static struct scpi_ops *g_ops;
+
+struct scpi_ops *get_scpi_ops(void)
+{
+	return g_ops;
+}
+EXPORT_SYMBOL_GPL(get_scpi_ops);
+
+int scpi_ops_register(struct scpi_ops *ops)
+{
+	if (!ops)
+		return -EINVAL;
+
+	if (g_ops)
+		return -EEXIST;
+
+	g_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scpi_ops_register);
+
+void scpi_ops_unregister(struct scpi_ops *ops)
+{
+	if (g_ops == ops)
+		g_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(scpi_ops_unregister);
+
+static void devm_scpi_ops_unregister(struct device *dev, void *res)
+{
+	scpi_ops_unregister(*(struct scpi_ops **)res);
+}
+
+int devm_scpi_ops_register(struct device *dev,
+				struct scpi_ops *ops)
+{
+	struct scpi_ops **rcops;
+	int ret;
+
+	rcops = devres_alloc(devm_scpi_ops_unregister, sizeof(*ops),
+			     GFP_KERNEL);
+	if (!rcops)
+		return -ENOMEM;
+
+	ret = scpi_ops_register(ops);
+	if (!ret) {
+		*rcops = ops;
+		devres_add(dev, rcops);
+	} else
+		devres_free(rcops);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_scpi_ops_register);
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index dc5f989..8e21e3a 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -74,8 +74,21 @@ struct scpi_ops {
 	int (*device_set_power_state)(u16, u8);
 };
 
-#if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
+#if IS_REACHABLE(CONFIG_SCPI_FW)
 struct scpi_ops *get_scpi_ops(void);
+int scpi_ops_register(struct scpi_ops *drv);
+void scpi_ops_unregister(struct scpi_ops *drv);
+int devm_scpi_ops_register(struct device *dev, struct scpi_ops *drv);
 #else
 static inline struct scpi_ops *get_scpi_ops(void) { return NULL; }
+
+static inline int scpi_ops_register(struct scpi_ops *drv) { return -ENOTSUPP; }
+
+static inline void scpi_ops_unregister(struct scpi_ops *drv) { }
+
+static inline int devm_scpi_ops_register(struct device *dev,
+					 struct scpi_ops *drv)
+{
+	return -ENOTSUPP;
+}
 #endif
-- 
2.7.0
