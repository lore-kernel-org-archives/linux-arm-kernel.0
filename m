From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 08 Apr 2011 13:22:10 +0900
Subject: [PATCH 2/4] ARM: EXYNOS4: Add usb host phy control
In-Reply-To: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
References: <1302236532-27636-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1302236532-27636-2-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXYNOS4 has 2 phys for usb host and usb device. This patch supports to
control usb host phy of EXYNOS4.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 arch/arm/mach-exynos4/Makefile                    |    2 +
 arch/arm/mach-exynos4/cpu.c                       |    7 +-
 arch/arm/mach-exynos4/include/mach/map.h          |    1 +
 arch/arm/mach-exynos4/include/mach/regs-pmu.h     |    3 +
 arch/arm/mach-exynos4/include/mach/regs-usb-phy.h |   64 ++++++++++
 arch/arm/mach-exynos4/usb-phy.c                   |  136 +++++++++++++++++++++
 arch/arm/plat-s5p/dev-ehci.c                      |    9 ++-
 arch/arm/plat-s5p/include/plat/map-s5p.h          |    2 +-
 arch/arm/plat-s5p/include/plat/usb-phy.h          |   22 ++++
 9 files changed, 243 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
 create mode 100644 arch/arm/mach-exynos4/usb-phy.c
 create mode 100644 arch/arm/plat-s5p/include/plat/usb-phy.h

diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index de197d6..683fc38 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -55,3 +55,5 @@ obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
 obj-$(CONFIG_EXYNOS4_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+
+obj-$(CONFIG_USB_SUPPORT)		+= usb-phy.o
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 7930113..08813a6 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -97,7 +97,12 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
-	},
+	}, {
+		.virtual	= (unsigned long)S5P_VA_USB_HSPHY,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_HSPHY),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}
 };
 
 static void exynos4_idle(void)
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 213c2a2..0009e77 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -102,6 +102,7 @@
 #define EXYNOS4_PA_SROMC		0x12570000
 
 #define EXYNOS4_PA_EHCI			0x12580000
+#define EXYNOS4_PA_HSPHY		0x125B0000
 
 #define EXYNOS4_PA_UART			0x13800000
 
diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
index 62b0014..a964337 100644
--- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
@@ -33,6 +33,9 @@
 #define S5P_EINT_WAKEUP_MASK			S5P_PMUREG(0x0604)
 #define S5P_WAKEUP_MASK				S5P_PMUREG(0x0608)
 
+#define S5P_USBHOST_PHY_CONTROL			S5P_PMUREG(0x0708)
+#define S5P_USBHOST_PHY_ENABLE			(1 << 0)
+
 #define S5P_MIPI_DPHY_CONTROL(n)		S5P_PMUREG(0x0710 + (n) * 4)
 #define S5P_MIPI_DPHY_ENABLE			(1 << 0)
 #define S5P_MIPI_DPHY_SRESETN			(1 << 1)
diff --git a/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h b/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
new file mode 100644
index 0000000..703118d
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/regs-usb-phy.h
@@ -0,0 +1,64 @@
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
+#ifndef __PLAT_S5P_REGS_USB_PHY_H
+#define __PLAT_S5P_REGS_USB_PHY_H
+
+#define EXYNOS4_HSOTG_PHYREG(x)		((x) + S5P_VA_USB_HSPHY)
+
+#define EXYNOS4_PHYPWR			EXYNOS4_HSOTG_PHYREG(0x00)
+#define PHY1_HSIC_NORMAL_MASK		(0xf << 9)
+#define PHY1_HSIC1_SLEEP		(1 << 12)
+#define PHY1_HSIC1_FORCE_SUSPEND	(1 << 11)
+#define PHY1_HSIC0_SLEEP		(1 << 10)
+#define PHY1_HSIC0_FORCE_SUSPEND	(1 << 9)
+
+#define PHY1_STD_NORMAL_MASK		(0x7 << 6)
+#define PHY1_STD_SLEEP			(1 << 8)
+#define PHY1_STD_ANALOG_POWERDOWN	(1 << 7)
+#define PHY1_STD_FORCE_SUSPEND		(1 << 6)
+
+#define PHY0_NORMAL_MASK		(0x39 << 0)
+#define PHY0_SLEEP			(1 << 5)
+#define PHY0_OTG_DISABLE		(1 << 4)
+#define PHY0_ANALOG_POWERDOWN		(1 << 3)
+#define PHY0_FORCE_SUSPEND		(1 << 0)
+
+#define EXYNOS4_PHYCLK			EXYNOS4_HSOTG_PHYREG(0x04)
+#define PHY1_COMMON_ON_N		(1 << 7)
+#define PHY0_COMMON_ON_N		(1 << 4)
+#define PHY0_ID_PULLUP			(1 << 2)
+#define CLKSEL_MASK			(0x3 << 0)
+#define CLKSEL_SHIFT			(0)
+#define CLKSEL_48M			(0x0 << 0)
+#define CLKSEL_12M			(0x2 << 0)
+#define CLKSEL_24M			(0x3 << 0)
+
+#define EXYNOS4_RSTCON			EXYNOS4_HSOTG_PHYREG(0x08)
+#define HOST_LINK_PORT_SWRST_MASK	(0xf << 6)
+#define HOST_LINK_PORT2_SWRST		(1 << 9)
+#define HOST_LINK_PORT1_SWRST		(1 << 8)
+#define HOST_LINK_PORT0_SWRST		(1 << 7)
+#define HOST_LINK_ALL_SWRST		(1 << 6)
+
+#define PHY1_SWRST_MASK			(0x7 << 3)
+#define PHY1_HSIC_SWRST			(1 << 5)
+#define PHY1_STD_SWRST			(1 << 4)
+#define PHY1_ALL_SWRST			(1 << 3)
+
+#define PHY0_SWRST_MASK			(0x7 << 0)
+#define PHY0_PHYLINK_SWRST		(1 << 2)
+#define PHY0_HLINK_SWRST		(1 << 1)
+#define PHY0_SWRST			(1 << 0)
+
+#define EXYNOS4_PHY1CON			EXYNOS4_HSOTG_PHYREG(0x34)
+#define FPENABLEN			(1 << 0)
+
+#endif /* __PLAT_S5P_REGS_USB_PHY_H */
diff --git a/arch/arm/mach-exynos4/usb-phy.c b/arch/arm/mach-exynos4/usb-phy.c
new file mode 100644
index 0000000..0883c1b
--- /dev/null
+++ b/arch/arm/mach-exynos4/usb-phy.c
@@ -0,0 +1,136 @@
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
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <mach/regs-pmu.h>
+#include <mach/regs-usb-phy.h>
+#include <plat/cpu.h>
+#include <plat/usb-phy.h>
+
+static int exynos4_usb_phy1_init(struct platform_device *pdev)
+{
+	struct clk *otg_clk;
+	struct clk *xusbxti_clk;
+	u32 phyclk;
+	u32 rstcon;
+	int err;
+
+	otg_clk = clk_get(&pdev->dev, "otg");
+	if (IS_ERR(otg_clk)) {
+		dev_err(&pdev->dev, "Failed to get otg clock\n");
+		return PTR_ERR(otg_clk);
+	}
+
+	err = clk_enable(otg_clk);
+	if (err) {
+		clk_put(otg_clk);
+		return err;
+	}
+
+	writel(readl(S5P_USBHOST_PHY_CONTROL) | S5P_USBHOST_PHY_ENABLE,
+			S5P_USBHOST_PHY_CONTROL);
+
+	/* set clock frequency for PLL */
+	phyclk = readl(EXYNOS4_PHYCLK) & ~CLKSEL_MASK;
+
+	xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
+	if (xusbxti_clk && !IS_ERR(xusbxti_clk)) {
+		switch (clk_get_rate(xusbxti_clk)) {
+		case 12 * MHZ:
+			phyclk |= CLKSEL_12M;
+			break;
+		case 24 * MHZ:
+			phyclk |= CLKSEL_24M;
+			break;
+		default:
+		case 48 * MHZ:
+			/* default reference clock */
+			break;
+		}
+		clk_put(xusbxti_clk);
+	}
+
+	writel(phyclk, EXYNOS4_PHYCLK);
+
+	/* floating prevention logic: disable */
+	writel((readl(EXYNOS4_PHY1CON) | FPENABLEN), EXYNOS4_PHY1CON);
+
+	/* set to normal HSIC 0 and 1 of PHY1 */
+	writel((readl(EXYNOS4_PHYPWR) & ~PHY1_HSIC_NORMAL_MASK),
+			EXYNOS4_PHYPWR);
+
+	/* set to normal standard USB of PHY1 */
+	writel((readl(EXYNOS4_PHYPWR) & ~PHY1_STD_NORMAL_MASK), EXYNOS4_PHYPWR);
+
+	/* reset all ports of both PHY and Link */
+	rstcon = readl(EXYNOS4_RSTCON) | HOST_LINK_PORT_SWRST_MASK |
+		PHY1_SWRST_MASK;
+	writel(rstcon, EXYNOS4_RSTCON);
+	udelay(10);
+
+	rstcon &= ~(HOST_LINK_PORT_SWRST_MASK | PHY1_SWRST_MASK);
+	writel(rstcon, EXYNOS4_RSTCON);
+	udelay(50);
+
+	clk_disable(otg_clk);
+	clk_put(otg_clk);
+
+	return 0;
+}
+
+static int exynos4_usb_phy1_exit(struct platform_device *pdev)
+{
+	struct clk *otg_clk;
+	int err;
+
+	otg_clk = clk_get(&pdev->dev, "otg");
+	if (IS_ERR(otg_clk)) {
+		dev_err(&pdev->dev, "Failed to get otg clock\n");
+		return PTR_ERR(otg_clk);
+	}
+
+	err = clk_enable(otg_clk);
+	if (err) {
+		clk_put(otg_clk);
+		return err;
+	}
+
+	writel((readl(EXYNOS4_PHYPWR) | PHY1_STD_ANALOG_POWERDOWN),
+			EXYNOS4_PHYPWR);
+
+	writel(readl(S5P_USBHOST_PHY_CONTROL) & ~S5P_USBHOST_PHY_ENABLE,
+			S5P_USBHOST_PHY_CONTROL);
+
+	clk_disable(otg_clk);
+	clk_put(otg_clk);
+
+	return 0;
+}
+
+int s5p_usb_phy_init(struct platform_device *pdev, int type)
+{
+	if (type == S5P_USB_PHY_HOST)
+		return exynos4_usb_phy1_init(pdev);
+
+	return -EINVAL;
+}
+
+int s5p_usb_phy_exit(struct platform_device *pdev, int type)
+{
+	if (type == S5P_USB_PHY_HOST)
+		return exynos4_usb_phy1_exit(pdev);
+
+	return -EINVAL;
+}
diff --git a/arch/arm/plat-s5p/dev-ehci.c b/arch/arm/plat-s5p/dev-ehci.c
index a610e5c..94080ff 100644
--- a/arch/arm/plat-s5p/dev-ehci.c
+++ b/arch/arm/plat-s5p/dev-ehci.c
@@ -45,6 +45,13 @@ struct platform_device s5p_device_ehci = {
 
 void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
 {
-	s3c_set_platdata(pd, sizeof(struct s5p_ehci_platdata),
+	struct s5p_ehci_platdata *npd;
+
+	npd = s3c_set_platdata(pd, sizeof(struct s5p_ehci_platdata),
 			&s5p_device_ehci);
+
+	if (!npd->phy_init)
+		npd->phy_init = s5p_usb_phy_init;
+	if (!npd->phy_exit)
+		npd->phy_exit = s5p_usb_phy_exit;
 }
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index d973d39..a6c3d32 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -39,7 +39,7 @@
 #define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
 #define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
 
-#define S3C_VA_USB_HSPHY	S3C_ADDR(0x02900000)
+#define S5P_VA_USB_HSPHY	S3C_ADDR(0x02900000)
 
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
diff --git a/arch/arm/plat-s5p/include/plat/usb-phy.h b/arch/arm/plat-s5p/include/plat/usb-phy.h
new file mode 100644
index 0000000..6dd6bcf
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/usb-phy.h
@@ -0,0 +1,22 @@
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
+#ifndef __PLAT_S5P_USB_PHY_H
+#define __PLAT_S5P_USB_PHY_H
+
+enum s5p_usb_phy_type {
+	S5P_USB_PHY_DEVICE,
+	S5P_USB_PHY_HOST,
+};
+
+extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
+extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
+
+#endif /* __PLAT_S5P_REGS_USB_PHY_H */
-- 
1.7.0.4
