From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:31 +0200
Subject: [PATCH 35/61] ARM: imx: Change the way nand devices are registered
	(generic part)
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-36-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having a platform device defined in a devices.c and register
it in the machine file allocate it dynamically.  This reduces the size
of needed memory as the new function is discarded after init and only
the existing devices are created.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig                       |    2 +
 arch/arm/plat-mxc/Makefile                      |    2 +
 arch/arm/plat-mxc/devices/Kconfig               |    2 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   44 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 +++
 6 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/Kconfig
 create mode 100644 arch/arm/plat-mxc/devices/Makefile
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_nand.c

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index d80de4e..cf053d7 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -1,5 +1,7 @@
 if ARCH_MXC
 
+source "arch/arm/plat-mxc/devices/Kconfig"
+
 menu "Freescale MXC Implementations"
 
 choice
diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
index f134d14..c7506a8 100644
--- a/arch/arm/plat-mxc/Makefile
+++ b/arch/arm/plat-mxc/Makefile
@@ -19,3 +19,5 @@ ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
 obj-y += ssi-fiq-ksym.o
 endif
+
+obj-y += devices/
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
new file mode 100644
index 0000000..09e91dd
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -0,0 +1,2 @@
+config IMX_HAVE_PLATFORM_MXC_NAND
+	bool
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
new file mode 100644
index 0000000..e314533
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
new file mode 100644
index 0000000..1c28641
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/devices-common.h>
+
+static struct platform_device *__init imx_add_mxc_nand(resource_size_t iobase,
+		int irq, const struct mxc_nand_platform_data *pdata,
+		resource_size_t iosize)
+{
+	static int id = 0;
+	
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
+	return imx_add_platform_device("mxc_nand", id++, res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata));
+}
+
+struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
+		int irq, const struct mxc_nand_platform_data *pdata)
+{
+	return imx_add_mxc_nand(iobase, irq, pdata, SZ_4K);
+}
+
+struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
+		int irq, const struct mxc_nand_platform_data *pdata)
+{
+	return imx_add_mxc_nand(iobase, irq, pdata, SZ_8K);
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 849d8ff..d5f121a 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -13,3 +13,9 @@
 struct platform_device *imx_add_platform_device(const char *name, int id,
 		const struct resource *res, unsigned int num_resources,
 		const void *data, size_t size_data);
+
+#include <mach/mxc_nand.h>
+struct platform_device *__init imx_add_mxc_nand_v1(resource_size_t iobase,
+		int irq, const struct mxc_nand_platform_data *pdata);
+struct platform_device *__init imx_add_mxc_nand_v21(resource_size_t iobase,
+		int irq, const struct mxc_nand_platform_data *pdata);
-- 
1.7.1
