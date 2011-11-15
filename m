From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 15 Nov 2011 15:31:41 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Add USB OHCI device
Message-ID: <1321338701-15531-1-git-send-email-jg1.han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB ohci device definition for S5P SoCs.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h   |    2 +
 arch/arm/plat-s5p/Kconfig                 |    5 ++++
 arch/arm/plat-samsung/devs.c              |   34 +++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 arch/arm/plat-samsung/include/plat/ohci.h |   21 +++++++++++++++++
 5 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/ohci.h

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 058541d..2d07e39 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -107,6 +107,7 @@
 #define EXYNOS4_PA_SROMC		0x12570000
 
 #define EXYNOS4_PA_EHCI			0x12580000
+#define EXYNOS4_PA_OHCI			0x12590000
 #define EXYNOS4_PA_HSPHY		0x125B0000
 #define EXYNOS4_PA_MFC			0x13400000
 
@@ -151,6 +152,7 @@
 
 #define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
 #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
+#define S5P_PA_OHCI			EXYNOS4_PA_OHCI
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
 #define S5P_PA_FIMC1			EXYNOS4_PA_FIMC1
 #define S5P_PA_FIMC2			EXYNOS4_PA_FIMC2
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 9b9968f..a0bf611 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -119,6 +119,11 @@ config S5P_DEV_USB_EHCI
 	help
 	  Compile in platform device definition for USB EHCI
 
+config S5P_DEV_USB_OHCI
+	bool
+	help
+	  Compile in platform device definition for USB OHCI
+
 config S5P_SETUP_MIPIPHY
 	bool
 	help
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 4ca8b57..4245ed0 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -46,6 +46,7 @@
 #include <plat/adc.h>
 #include <plat/ata.h>
 #include <plat/ehci.h>
+#include <plat/ohci.h>
 #include <plat/fb.h>
 #include <plat/fb-s3c2410.h>
 #include <plat/hwmon.h>
@@ -1401,6 +1402,39 @@ void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
 }
 #endif /* CONFIG_S5P_DEV_USB_EHCI */
 
+/* USB OHCI Host Controller */
+
+#ifdef CONFIG_S5P_DEV_USB_OHCI
+static struct resource s5p_ohci_resource[] = {
+	[0] = DEFINE_RES_MEM(S5P_PA_OHCI, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_USB_HOST),
+};
+
+struct platform_device s5p_device_ohci = {
+	.name		= "s5p-ohci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5p_ohci_resource),
+	.resource	= s5p_ohci_resource,
+	.dev		= {
+		.dma_mask		= &samsung_device_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+void __init s5p_ohci_set_platdata(struct s5p_ohci_platdata *pd)
+{
+	struct s5p_ohci_platdata *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s5p_ohci_platdata),
+			&s5p_device_ohci);
+
+	if (!npd->phy_init)
+		npd->phy_init = s5p_usb_phy_init;
+	if (!npd->phy_exit)
+		npd->phy_exit = s5p_usb_phy_exit;
+}
+#endif /* CONFIG_S5P_DEV_USB_OHCI */
+
 /* USB HSOTG */
 
 #ifdef CONFIG_S3C_DEV_USB_HSOTG
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index ab633c9..c02e84c 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -73,6 +73,7 @@ extern struct platform_device s3c_device_usb_hsudc;
 extern struct platform_device s3c_device_wdt;
 
 extern struct platform_device s5p_device_ehci;
+extern struct platform_device s5p_device_ohci;
 extern struct platform_device s5p_device_fimc0;
 extern struct platform_device s5p_device_fimc1;
 extern struct platform_device s5p_device_fimc2;
diff --git a/arch/arm/plat-samsung/include/plat/ohci.h b/arch/arm/plat-samsung/include/plat/ohci.h
new file mode 100644
index 0000000..da46f67
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/ohci.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2011 Samsung Electronics Co.Ltd
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __PLAT_SAMSUNG_OHCI_H
+#define __PLAT_SAMSUNG_OHCI_H __FILE__
+
+struct s5p_ohci_platdata {
+	int (*phy_init)(struct platform_device *pdev, int type);
+	int (*phy_exit)(struct platform_device *pdev, int type);
+};
+
+extern void s5p_ohci_set_platdata(struct s5p_ohci_platdata *pd);
+
+#endif /* __PLAT_SAMSUNG_OHCI_H */
-- 
1.7.1
