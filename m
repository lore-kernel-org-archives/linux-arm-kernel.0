From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  8 Mar 2016 10:33:23 -0500
Subject: [PATCH 2/2] vfio, platform: add QTI HIDMA reset driver
In-Reply-To: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1457451209-21462-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In situations where the userspace driver is stopped abnormally and the
VFIO platform device is released, the assigned HW device currently is
left running. As a consequence the HW device might continue issuing IRQs
and performing DMA accesses.

This patch is implementing a reset driver for HIDMA platform driver.
This gets called by the VFIO platform reset interface.

Reviewed-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/vfio/platform/reset/Kconfig                |   9 ++
 drivers/vfio/platform/reset/Makefile               |   2 +
 .../vfio/platform/reset/vfio_platform_qcomhidma.c  | 101 +++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_qcomhidma.c

diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
index 70cccc5..d02b3b5 100644
--- a/drivers/vfio/platform/reset/Kconfig
+++ b/drivers/vfio/platform/reset/Kconfig
@@ -13,3 +13,12 @@ config VFIO_PLATFORM_AMDXGBE_RESET
 	  Enables the VFIO platform driver to handle reset for AMD XGBE
 
 	  If you don't know what to do here, say N.
+
+config VFIO_PLATFORM_QCOMHIDMA_RESET
+	tristate "VFIO support for Qualcomm Technologies HIDMA reset"
+	depends on VFIO_PLATFORM
+	help
+	  Enables the VFIO platform driver to handle reset for Qualcomm Technologies
+	  HIDMA Channel.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
index 93f4e23..ec7748a 100644
--- a/drivers/vfio/platform/reset/Makefile
+++ b/drivers/vfio/platform/reset/Makefile
@@ -1,7 +1,9 @@
 vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
 vfio-platform-amdxgbe-y := vfio_platform_amdxgbe.o
+vfio-platform-qcomhidma-y := vfio_platform_qcomhidma.o
 
 ccflags-y += -Idrivers/vfio/platform
 
 obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
+obj-$(CONFIG_VFIO_PLATFORM_QCOMHIDMA_RESET) += vfio-platform-qcomhidma.o
 obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
diff --git a/drivers/vfio/platform/reset/vfio_platform_qcomhidma.c b/drivers/vfio/platform/reset/vfio_platform_qcomhidma.c
new file mode 100644
index 0000000..103d481
--- /dev/null
+++ b/drivers/vfio/platform/reset/vfio_platform_qcomhidma.c
@@ -0,0 +1,101 @@
+/*
+ * Qualcomm Technologies HIDMA VFIO Reset Driver
+ *
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+
+#include "vfio_platform_private.h"
+
+#define TRCA_CTRLSTS_OFFSET		0x000
+#define EVCA_CTRLSTS_OFFSET		0x000
+
+#define CH_CONTROL_MASK		GENMASK(7, 0)
+#define CH_STATE_MASK			GENMASK(7, 0)
+#define CH_STATE_BIT_POS		0x8
+
+#define HIDMA_CH_STATE(val)	\
+	((val >> CH_STATE_BIT_POS) & CH_STATE_MASK)
+
+#define EVCA_IRQ_EN_OFFSET		0x110
+
+#define CH_RESET			9
+#define CH_DISABLED			0
+
+int vfio_platform_qcomhidma_reset(struct vfio_platform_device *vdev)
+{
+	struct vfio_platform_region *trreg;
+	struct vfio_platform_region *evreg;
+	u32 val;
+	int ret;
+
+	if (vdev->num_regions != 2)
+		return -ENODEV;
+
+	trreg = &vdev->regions[0];
+	if (!trreg->ioaddr) {
+		trreg->ioaddr =
+			ioremap_nocache(trreg->addr, trreg->size);
+		if (!trreg->ioaddr)
+			return -ENOMEM;
+	}
+
+	evreg = &vdev->regions[1];
+	if (!evreg->ioaddr) {
+		evreg->ioaddr =
+			ioremap_nocache(evreg->addr, evreg->size);
+		if (!evreg->ioaddr)
+			return -ENOMEM;
+	}
+
+	/* disable IRQ */
+	writel(0, evreg->ioaddr + EVCA_IRQ_EN_OFFSET);
+
+	/* reset both transfer and event channels */
+	val = readl(trreg->ioaddr + TRCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_RESET << 16;
+	writel(val, trreg->ioaddr + TRCA_CTRLSTS_OFFSET);
+
+	ret = readl_poll_timeout(trreg->ioaddr + TRCA_CTRLSTS_OFFSET, val,
+				 HIDMA_CH_STATE(val) == CH_DISABLED, 1000,
+				 10000);
+	if (ret)
+		return ret;
+
+	val = readl(evreg->ioaddr + EVCA_CTRLSTS_OFFSET);
+	val &= ~(CH_CONTROL_MASK << 16);
+	val |= CH_RESET << 16;
+	writel(val, evreg->ioaddr + EVCA_CTRLSTS_OFFSET);
+
+	ret = readl_poll_timeout(evreg->ioaddr + EVCA_CTRLSTS_OFFSET, val,
+				 HIDMA_CH_STATE(val) == CH_DISABLED, 1000,
+				 10000);
+	if (ret)
+		return ret;
+
+	pr_info("HIDMA channel reset\n");
+	return 0;
+}
+module_vfio_reset_handler("qcom,hidma-1.0", "QCOM8061",
+			  vfio_platform_qcomhidma_reset);
+VFIO_PLATFORM_MODULE_ALIAS("qcom,hidma-1.0");
+VFIO_PLATFORM_MODULE_ALIAS("QCOM8061");
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Reset support for Qualcomm Technologies HIDMA device");
-- 
1.8.2.1
