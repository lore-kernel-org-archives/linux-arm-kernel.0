From: eric.auger@linaro.org (Eric Auger)
Date: Fri,  5 Jun 2015 17:06:32 +0200
Subject: [PATCH v2 4/4] VFIO: platform: Calxeda xgmac reset module
In-Reply-To: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>
References: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1433516792-16397-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a module that registers and implements a basic
reset function for the Calxeda xgmac device. This latter basically disables
interrupts and stops DMA transfers.

The reset function code is inherited from the native calxeda xgmac driver.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v1 -> v2:
- remove registration mechanism. The module mainly exports the reset
  function. module_init and module_exit now are void.
---
 drivers/vfio/platform/Kconfig                      |  2 +
 drivers/vfio/platform/Makefile                     |  2 +
 drivers/vfio/platform/reset/Kconfig                |  7 ++
 drivers/vfio/platform/reset/Makefile               |  5 ++
 .../platform/reset/vfio_platform_calxedaxgmac.c    | 98 ++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_common.c       |  6 ++
 drivers/vfio/platform/vfio_platform_private.h      |  1 +
 7 files changed, 121 insertions(+)
 create mode 100644 drivers/vfio/platform/reset/Kconfig
 create mode 100644 drivers/vfio/platform/reset/Makefile
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c

diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
index 9a4403e..1df7477 100644
--- a/drivers/vfio/platform/Kconfig
+++ b/drivers/vfio/platform/Kconfig
@@ -18,3 +18,5 @@ config VFIO_AMBA
 	  framework.
 
 	  If you don't know what to do here, say N.
+
+source "drivers/vfio/platform/reset/Kconfig"
diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
index 81de144..9ce8afe 100644
--- a/drivers/vfio/platform/Makefile
+++ b/drivers/vfio/platform/Makefile
@@ -2,7 +2,9 @@
 vfio-platform-y := vfio_platform.o vfio_platform_common.o vfio_platform_irq.o
 
 obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
+obj-$(CONFIG_VFIO_PLATFORM) += reset/
 
 vfio-amba-y := vfio_amba.o
 
 obj-$(CONFIG_VFIO_AMBA) += vfio-amba.o
+obj-$(CONFIG_VFIO_AMBA) += reset/
diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
new file mode 100644
index 0000000..746b96b
--- /dev/null
+++ b/drivers/vfio/platform/reset/Kconfig
@@ -0,0 +1,7 @@
+config VFIO_PLATFORM_CALXEDAXGMAC_RESET
+	tristate "VFIO support for calxeda xgmac reset"
+	depends on VFIO_PLATFORM
+	help
+	  Enables the VFIO platform driver to handle reset for Calxeda xgmac
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
new file mode 100644
index 0000000..2a486af
--- /dev/null
+++ b/drivers/vfio/platform/reset/Makefile
@@ -0,0 +1,5 @@
+vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
+
+ccflags-y += -Idrivers/vfio/platform
+
+obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
new file mode 100644
index 0000000..bdf4c7b
--- /dev/null
+++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
@@ -0,0 +1,98 @@
+/*
+ * VFIO platform driver specialized for Calxeda xgmac reset
+ * reset code is inherited from calxeda xgmac native driver
+ *
+ * Copyright 2010-2011 Calxeda, Inc.
+ * Copyright (c) 2015 Linaro Ltd.
+ *              www.linaro.org
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include "vfio_platform_private.h"
+
+#define DRIVER_VERSION  "0.1"
+#define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
+#define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
+
+#define CALXEDAXGMAC_COMPAT "calxeda,hb-xgmac"
+
+/* XGMAC Register definitions */
+#define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
+
+/* DMA Control and Status Registers */
+#define XGMAC_DMA_CONTROL       0x00000f18      /* Ctrl (Operational Mode) */
+#define XGMAC_DMA_INTR_ENA      0x00000f1c      /* Interrupt Enable */
+
+/* DMA Control registe defines */
+#define DMA_CONTROL_ST          0x00002000      /* Start/Stop Transmission */
+#define DMA_CONTROL_SR          0x00000002      /* Start/Stop Receive */
+
+/* Common MAC defines */
+#define MAC_ENABLE_TX           0x00000008      /* Transmitter Enable */
+#define MAC_ENABLE_RX           0x00000004      /* Receiver Enable */
+
+static inline void xgmac_mac_disable(void __iomem *ioaddr)
+{
+	u32 value = readl(ioaddr + XGMAC_DMA_CONTROL);
+
+	value &= ~(DMA_CONTROL_ST | DMA_CONTROL_SR);
+	writel(value, ioaddr + XGMAC_DMA_CONTROL);
+
+	value = readl(ioaddr + XGMAC_CONTROL);
+	value &= ~(MAC_ENABLE_TX | MAC_ENABLE_RX);
+	writel(value, ioaddr + XGMAC_CONTROL);
+}
+
+int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
+{
+	struct vfio_platform_region reg = vdev->regions[0];
+
+	if (!reg.ioaddr) {
+		reg.ioaddr =
+			ioremap_nocache(reg.addr, reg.size);
+		if (!reg.ioaddr)
+			return -ENOMEM;
+	}
+
+	/* disable IRQ */
+	writel(0, reg.ioaddr + XGMAC_DMA_INTR_ENA);
+
+	/* Disable the MAC core */
+	xgmac_mac_disable(reg.ioaddr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_platform_calxedaxgmac_reset);
+
+static int __init vfio_platform_calxedaxgmac_init(void)
+{
+	return 0;
+}
+
+static void __exit vfio_platform_calxedaxgmac_exit(void)
+{
+}
+
+module_init(vfio_platform_calxedaxgmac_init);
+module_exit(vfio_platform_calxedaxgmac_exit);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index d474d6a..ffd76d2 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -27,6 +27,12 @@ static DEFINE_MUTEX(driver_lock);
 
 static const struct vfio_platform_reset_combo reset_lookup_table[] = {
 	{
+		.type = VFIO_PLATFORM_RESET_CALXEDA_XGMAC,
+		.compat = "calxeda,hb-xgmac",
+		.reset_function_name = "vfio_platform_calxedaxgmac_reset",
+		.module_name = "vfio-platform-calxedaxgmac",
+	},
+	{
 		.type = VFIO_PLATFORM_RESET_TYPE_MAX
 	},
 };
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index cccb3ba..31f15c7 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -50,6 +50,7 @@ struct vfio_platform_region {
 };
 
 enum vfio_platform_reset_type {
+	VFIO_PLATFORM_RESET_CALXEDA_XGMAC,
 	VFIO_PLATFORM_RESET_TYPE_MAX /* last element */,
 };
 
-- 
1.9.1
