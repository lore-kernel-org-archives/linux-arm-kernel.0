From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 08 Apr 2011 13:22:09 +0900
Subject: [PATCH 1/4] ARM: S5P: Add usb ehci device
Message-ID: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds usb ehci device definition for samsung s5p cpus.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/map.h  |    3 ++
 arch/arm/plat-s5p/Kconfig                 |    5 +++
 arch/arm/plat-s5p/Makefile                |    1 +
 arch/arm/plat-s5p/dev-ehci.c              |   50 +++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/ehci.h     |   21 ++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    2 +
 6 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s5p/dev-ehci.c
 create mode 100644 arch/arm/plat-s5p/include/plat/ehci.h

diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 6330b73..213c2a2 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -101,6 +101,8 @@
 
 #define EXYNOS4_PA_SROMC		0x12570000
 
+#define EXYNOS4_PA_EHCI			0x12580000
+
 #define EXYNOS4_PA_UART			0x13800000
 
 #define EXYNOS4_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
@@ -143,6 +145,7 @@
 #define S5P_PA_SROMC			EXYNOS4_PA_SROMC
 #define S5P_PA_SYSCON			EXYNOS4_PA_SYSCON
 #define S5P_PA_TIMER			EXYNOS4_PA_TIMER
+#define S5P_PA_EHCI			EXYNOS4_PA_EHCI
 
 #define SAMSUNG_PA_KEYPAD		EXYNOS4_PA_KEYPAD
 
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 8492297..6751bcf 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -85,6 +85,11 @@ config S5P_DEV_CSIS1
 	help
 	  Compile in platform device definitions for MIPI-CSIS channel 1
 
+config S5P_DEV_USB_EHCI
+	bool
+	help
+	  Compile in platform device definition for USB EHCI
+
 config S5P_SETUP_MIPIPHY
 	bool
 	help
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 42afff7..e234cc4 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_S5P_DEV_FIMC3)	+= dev-fimc3.o
 obj-$(CONFIG_S5P_DEV_ONENAND)	+= dev-onenand.o
 obj-$(CONFIG_S5P_DEV_CSIS0)	+= dev-csis0.o
 obj-$(CONFIG_S5P_DEV_CSIS1)	+= dev-csis1.o
+obj-$(CONFIG_S5P_DEV_USB_EHCI)	+= dev-ehci.o
 obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
diff --git a/arch/arm/plat-s5p/dev-ehci.c b/arch/arm/plat-s5p/dev-ehci.c
new file mode 100644
index 0000000..a610e5c
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-ehci.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <mach/irqs.h>
+#include <mach/map.h>
+#include <plat/devs.h>
+#include <plat/ehci.h>
+#include <plat/usb-phy.h>
+
+/* USB EHCI Host Controller registration */
+static struct resource s5p_ehci_resource[] = {
+	[0] = {
+		.start	= S5P_PA_EHCI,
+		.end	= S5P_PA_EHCI + SZ_256 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USB_HOST,
+		.end	= IRQ_USB_HOST,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 s5p_device_ehci_dmamask = 0xffffffffUL;
+
+struct platform_device s5p_device_ehci = {
+	.name		= "s5p-ehci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_ehci_resource),
+	.resource	= s5p_ehci_resource,
+	.dev		= {
+		.dma_mask = &s5p_device_ehci_dmamask,
+		.coherent_dma_mask = 0xffffffffUL
+	}
+};
+
+void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
+{
+	s3c_set_platdata(pd, sizeof(struct s5p_ehci_platdata),
+			&s5p_device_ehci);
+}
diff --git a/arch/arm/plat-s5p/include/plat/ehci.h b/arch/arm/plat-s5p/include/plat/ehci.h
new file mode 100644
index 0000000..6ae6810
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/ehci.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __PLAT_S5P_EHCI_H
+#define __PLAT_S5P_EHCI_H
+
+struct s5p_ehci_platdata {
+	int (*phy_init)(struct platform_device *pdev, int type);
+	int (*phy_exit)(struct platform_device *pdev, int type);
+};
+
+extern void s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd);
+
+#endif /* __PLAT_S5P_EHCI_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index f0da6b7..3f38deb 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -142,6 +142,8 @@ extern struct platform_device s5p_device_fimc3;
 extern struct platform_device s5p_device_mipi_csis0;
 extern struct platform_device s5p_device_mipi_csis1;
 
+extern struct platform_device s5p_device_ehci;
+
 extern struct platform_device exynos4_device_sysmmu;
 
 /* s3c2440 specific devices */
-- 
1.7.0.4
