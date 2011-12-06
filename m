From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 06 Dec 2011 15:31:39 +0900
Subject: [PATCH v2 1/3] ARM: EXYNOS: Add USB OHCI device
In-Reply-To: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
References: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
Message-ID: <001301ccb3e0$b5fec280$21fc4780$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds USB ohci device definition for Exynos SoCs.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos/Kconfig              |    5 +++
 arch/arm/mach-exynos/Makefile             |    1 +
 arch/arm/mach-exynos/dev-ohci.c           |   52 +++++++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/include/mach/ohci.h  |   21 +++++++++++
 arch/arm/mach-exynos/setup-usb-phy.c      |   15 ++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 7 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/dev-ohci.c
 create mode 100644 arch/arm/mach-exynos/include/mach/ohci.h

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 0afcc3b..dec3ee3 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -87,6 +87,11 @@ config EXYNOS4_DEV_DWMCI
 	help
 	  Compile in platform device definitions for DWMCI
 
+config EXYNOS4_DEV_USB_OHCI
+	bool
+	help
+	  Compile in platform device definition for USB OHCI
+
 config EXYNOS4_SETUP_I2C1
 	bool
 	help
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 57e5296..a81a1c1 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-ahci.o
 obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
 obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
 obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
+obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
 obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
 
 obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
diff --git a/arch/arm/mach-exynos/dev-ohci.c b/arch/arm/mach-exynos/dev-ohci.c
new file mode 100644
index 0000000..b8e7530
--- /dev/null
+++ b/arch/arm/mach-exynos/dev-ohci.c
@@ -0,0 +1,52 @@
+/* linux/arch/arm/mach-exynos/dev-ohci.c
+ *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * EXYNOS - OHCI support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+#include <mach/ohci.h>
+
+#include <plat/devs.h>
+#include <plat/usb-phy.h>
+
+static struct resource exynos4_ohci_resource[] = {
+	[0] = DEFINE_RES_MEM(EXYNOS4_PA_OHCI, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_USB_HOST),
+};
+
+static u64 exynos4_ohci_dma_mask = DMA_BIT_MASK(32);
+
+struct platform_device exynos4_device_ohci = {
+	.name		= "exynos-ohci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(exynos4_ohci_resource),
+	.resource	= exynos4_ohci_resource,
+	.dev		= {
+		.dma_mask		= &exynos4_ohci_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
+};
+
+void __init exynos4_ohci_set_platdata(struct exynos4_ohci_platdata *pd)
+{
+	struct exynos4_ohci_platdata *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct exynos4_ohci_platdata),
+			&exynos4_device_ohci);
+
+	if (!npd->phy_init)
+		npd->phy_init = s5p_usb_phy_init;
+	if (!npd->phy_exit)
+		npd->phy_exit = s5p_usb_phy_exit;
+}
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 03e2c99..a9897b4 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -108,6 +108,7 @@
 #define EXYNOS4_PA_SROMC		0x12570000
 
 #define EXYNOS4_PA_EHCI			0x12580000
+#define EXYNOS4_PA_OHCI			0x12590000
 #define EXYNOS4_PA_HSPHY		0x125B0000
 #define EXYNOS4_PA_MFC			0x13400000
 
diff --git a/arch/arm/mach-exynos/include/mach/ohci.h b/arch/arm/mach-exynos/include/mach/ohci.h
new file mode 100644
index 0000000..c256c59
--- /dev/null
+++ b/arch/arm/mach-exynos/include/mach/ohci.h
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
+#ifndef __MACH_EXYNOS_OHCI_H
+#define __MACH_EXYNOS_OHCI_H
+
+struct exynos4_ohci_platdata {
+	int (*phy_init)(struct platform_device *pdev, int type);
+	int (*phy_exit)(struct platform_device *pdev, int type);
+};
+
+extern void exynos4_ohci_set_platdata(struct exynos4_ohci_platdata *pd);
+
+#endif /* __MACH_EXYNOS_OHCI_H */
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index 39aca04..41743d2 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -19,6 +19,13 @@
 #include <plat/cpu.h>
 #include <plat/usb-phy.h>
 
+static atomic_t host_usage;
+
+static int exynos4_usb_host_phy_is_on(void)
+{
+	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
+}
+
 static int exynos4_usb_phy1_init(struct platform_device *pdev)
 {
 	struct clk *otg_clk;
@@ -27,6 +34,8 @@ static int exynos4_usb_phy1_init(struct platform_device *pdev)
 	u32 rstcon;
 	int err;
 
+	atomic_inc(&host_usage);
+
 	otg_clk = clk_get(&pdev->dev, "otg");
 	if (IS_ERR(otg_clk)) {
 		dev_err(&pdev->dev, "Failed to get otg clock\n");
@@ -39,6 +48,9 @@ static int exynos4_usb_phy1_init(struct platform_device *pdev)
 		return err;
 	}
 
+	if (exynos4_usb_host_phy_is_on())
+		return 0;
+
 	writel(readl(S5P_USBHOST_PHY_CONTROL) | S5P_USBHOST_PHY_ENABLE,
 			S5P_USBHOST_PHY_CONTROL);
 
@@ -95,6 +107,9 @@ static int exynos4_usb_phy1_exit(struct platform_device *pdev)
 	struct clk *otg_clk;
 	int err;
 
+	if (atomic_dec_return(&host_usage) > 0)
+		return 0;
+
 	otg_clk = clk_get(&pdev->dev, "otg");
 	if (IS_ERR(otg_clk)) {
 		dev_err(&pdev->dev, "Failed to get otg clock\n");
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index ab633c9..a2ff27e 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -129,6 +129,7 @@ extern struct platform_device exynos4_device_dwmci;
 extern struct platform_device exynos4_device_i2s0;
 extern struct platform_device exynos4_device_i2s1;
 extern struct platform_device exynos4_device_i2s2;
+extern struct platform_device exynos4_device_ohci;
 extern struct platform_device exynos4_device_pcm0;
 extern struct platform_device exynos4_device_pcm1;
 extern struct platform_device exynos4_device_pcm2;
-- 
1.7.1
