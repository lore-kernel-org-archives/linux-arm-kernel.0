From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:37 +0200
Subject: [PATCH 41/61] ARM: imx: dynamically register imx-i2c devices (generic
	part)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-42-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/devices/Kconfig               |    3 ++
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c    |   29 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    5 ++++
 4 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-i2c.c

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index 09e91dd..c50a7d6 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -1,2 +1,5 @@
+config IMX_HAVE_PLATFORM_IMX_I2C
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_NAND
 	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index e314533..4a2b2de 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_I2C) += platform-imx-i2c.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
new file mode 100644
index 0000000..d0af9f7
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/devices-common.h>
+
+struct platform_device *__init imx_add_imx_i2c(int id,
+		resource_size_t iobase, resource_size_t iosize, int irq,
+		const struct imxi2c_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = iobase,
+			.end = iobase + iosize - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = irq,
+			.end = irq,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return imx_add_platform_device("imx-i2c", id, res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index d5f121a..8388f90 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -14,6 +14,11 @@ struct platform_device *imx_add_platform_device(const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data);
 
+#include <mach/i2c.h>
+struct platform_device *__init imx_add_imx_i2c(int id,
+		resource_size_t iobase, resource_size_t iosize, int irq,
+		const struct imxi2c_platform_data *pdata);
+
 #include <mach/mxc_nand.h>
 struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
 		int irq, const struct mxc_nand_platform_data *pdata);
-- 
1.7.1
