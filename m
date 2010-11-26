From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Nov 2010 14:49:10 +0800
Subject: [PATCH 11/15] ARM: mxs: Dynamically allocate duart devices
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1290754154-9428-12-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dynamically allocate duart devices for MX23 and MX28.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/devices-mx23.h                |   16 +++++
 arch/arm/mach-mxs/devices-mx28.h                |   16 +++++
 arch/arm/mach-mxs/devices.c                     |   75 +++++++++++++++++++++++
 arch/arm/mach-mxs/devices/platform-duart.c      |   47 ++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   34 ++++++++++
 5 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices-mx23.h
 create mode 100644 arch/arm/mach-mxs/devices-mx28.h
 create mode 100644 arch/arm/mach-mxs/devices.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-duart.c
 create mode 100644 arch/arm/mach-mxs/include/mach/devices-common.h

diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
new file mode 100644
index 0000000..d0f49fc
--- /dev/null
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx23.h>
+#include <mach/devices-common.h>
+
+extern const struct mxs_duart_data mx23_duart_data __initconst;
+#define mx23_add_duart() \
+	mxs_add_duart(&mx23_duart_data)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
new file mode 100644
index 0000000..47c2f04
--- /dev/null
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+extern const struct mxs_duart_data mx28_duart_data __initconst;
+#define mx28_add_duart() \
+	mxs_add_duart(&mx28_duart_data)
diff --git a/arch/arm/mach-mxs/devices.c b/arch/arm/mach-mxs/devices.c
new file mode 100644
index 0000000..6b60f02
--- /dev/null
+++ b/arch/arm/mach-mxs/devices.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2008 Sascha Hauer, kernel at pengutronix.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <mach/common.h>
+
+struct platform_device *__init mxs_add_platform_device_dmamask(
+		const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data, u64 dmamask)
+{
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		goto err;
+
+	if (dmamask) {
+		/*
+		 * This memory isn't freed when the device is put,
+		 * I don't have a nice idea for that though.  Conceptually
+		 * dma_mask in struct device should not be a pointer.
+		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
+		 */
+		pdev->dev.dma_mask =
+			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+		if (!pdev->dev.dma_mask)
+			/* ret is still -ENOMEM; */
+			goto err;
+
+		*pdev->dev.dma_mask = dmamask;
+		pdev->dev.coherent_dma_mask = dmamask;
+	}
+
+	if (res) {
+		ret = platform_device_add_resources(pdev, res, num_resources);
+		if (ret)
+			goto err;
+	}
+
+	if (data) {
+		ret = platform_device_add_data(pdev, data, size_data);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+err:
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	return pdev;
+}
diff --git a/arch/arm/mach-mxs/devices/platform-duart.c b/arch/arm/mach-mxs/devices/platform-duart.c
new file mode 100644
index 0000000..7760caf
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-duart.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define mxs_duart_data_entry(soc)					\
+	{								\
+		.iobase = soc ## _DUART_BASE_ADDR,			\
+		.irq = soc ## _INT_DUART,				\
+	}
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_duart_data mx23_duart_data __initconst =
+	mxs_duart_data_entry(MX23);
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_duart_data mx28_duart_data __initconst =
+	mxs_duart_data_entry(MX28);
+#endif
+
+struct platform_device *__init mxs_add_duart(
+		const struct mxs_duart_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device("mxs-duart", 0, res, ARRAY_SIZE(res),
+					NULL, 0);
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
new file mode 100644
index 0000000..07b4439
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+
+struct platform_device *mxs_add_platform_device_dmamask(
+		const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data, u64 dmamask);
+
+static inline struct platform_device *mxs_add_platform_device(
+		const char *name, int id,
+		const struct resource *res, unsigned int num_resources,
+		const void *data, size_t size_data)
+{
+	return mxs_add_platform_device_dmamask(
+			name, id, res, num_resources, data, size_data, 0);
+}
+
+/* duart */
+struct mxs_duart_data {
+	resource_size_t iobase;
+	resource_size_t iosize;
+	resource_size_t irq;
+};
+struct platform_device *__init mxs_add_duart(
+		const struct mxs_duart_data *data);
-- 
1.7.1
