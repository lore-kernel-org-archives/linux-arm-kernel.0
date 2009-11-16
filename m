From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:59 +0100
Subject: [PATCH 16/25] imx: generalize nand device registration
In-Reply-To: <1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-15-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-16-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

create mxc_nand platform_devices dynamically.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.h                     |    2 +
 arch/arm/mach-mx3/devices.h                     |    1 +
 arch/arm/mach-mxc91231/devices.h                |    2 +
 arch/arm/plat-mxc/Makefile                      |    2 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   54 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   20 ++++++++
 7 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/Makefile
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_nand.c
 create mode 100644 arch/arm/plat-mxc/include/mach/devices-common.h

diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index d315406..7f5ee56 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -1,3 +1,5 @@
+#include <mach/devices-common.h>
+
 extern struct platform_device mxc_gpt1;
 extern struct platform_device mxc_gpt2;
 extern struct platform_device mxc_gpt3;
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index ab87419..9ce9ea8 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -1,3 +1,4 @@
+#include <mach/devices-common.h>
 
 extern struct platform_device mxc_uart_device0;
 extern struct platform_device mxc_uart_device1;
diff --git a/arch/arm/mach-mxc91231/devices.h b/arch/arm/mach-mxc91231/devices.h
index 72a2136..37217df 100644
--- a/arch/arm/mach-mxc91231/devices.h
+++ b/arch/arm/mach-mxc91231/devices.h
@@ -1,3 +1,5 @@
+#include <mach/devices-common.h>
+
 extern struct platform_device mxc_uart_device0;
 extern struct platform_device mxc_uart_device1;
 extern struct platform_device mxc_uart_device2;
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index e3212c8..41a0d25 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -9,3 +9,5 @@ obj-$(CONFIG_ARCH_MX1) += iomux-mx1-mx2.o dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MX2) += iomux-mx1-mx2.o dma-mx1-mx2.o
 obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_PWM)  += pwm.o
+
+obj-y += devices/
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
new file mode 100644
index 0000000..e444c6c
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -0,0 +1 @@
+obj-y += platform-mxc_nand.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
new file mode 100644
index 0000000..9d5450f
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2009 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/devices-common.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME "mxc_nand"
+
+int __init imx_add_mxc_nand(resource_size_t base, int irq,
+		const struct mxc_nand_platform_data *pdata)
+{
+	static int id = 0;
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	struct resource res[] = {
+		{
+			.start = base,
+			.end = base + 0xfff,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irq,
+			.end = irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	pdev = platform_device_alloc(DRIVER_NAME, id++);
+	if (!pdev)
+		goto err;
+
+	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (ret)
+		goto err;
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+err:
+		platform_device_put(pdev);
+		pr_warning("Could not add %s (errno=%d)\n",
+				DRIVER_NAME, ret);
+	}
+
+	return ret;
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
new file mode 100644
index 0000000..d17c2b2
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2009 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <mach/mxc_nand.h>
+
+int __init imx_add_mxc_nand(resource_size_t base, int irq,
+		const struct mxc_nand_platform_data *pdata);
+
+#define imx21_add_mxc_nand(pdata) imx_add_mxc_nand(MX21_NFC_BASE_ADDR, MX21_INT_NFC, pdata)
+#define imx25_add_mxc_nand(pdata) imx_add_mxc_nand(MX25_NFC_BASE_ADDR, MX25_INT_NFC, pdata)
+#define imx27_add_mxc_nand(pdata) imx_add_mxc_nand(MX27_NFC_BASE_ADDR, MX27_INT_NFC, pdata)
+#define imx31_add_mxc_nand(pdata) imx_add_mxc_nand(MX31_NFC_BASE_ADDR, MX31_INT_NFC, pdata)
+#define imx35_add_mxc_nand(pdata) imx_add_mxc_nand(MX35_NFC_BASE_ADDR, MX35_INT_NFC, pdata)
-- 
1.6.5.2
