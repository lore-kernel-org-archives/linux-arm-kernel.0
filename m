From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 21 Jul 2012 16:02:09 +0530
Subject: [PATCH 8/8 v2] ARM: EXYNOS5: Add PHY initialization code for usb 3.0
In-Reply-To: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342866729-30460-9-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PHY setup functions for usb 3.0 support on exynos5

Signed-off-by: Yulgon Kim <yulgon.kim@samsung.com>
Signed-off-by: Anton Tikhomirov <av.tikhomirov@samsung.com>
Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/mach-exynos/setup-usb-phy.c               |  127 ++++++++++++++++++++
 .../include/plat/regs-usb3-exynos-drd-phy.h        |   75 ++++++++++++
 arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
 3 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-usb3-exynos-drd-phy.h

diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index e6f2f84..b90871d 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -18,12 +18,14 @@
 #include <mach/regs-usb-phy.h>
 #include <plat/cpu.h>
 #include <plat/usb-phy.h>
+#include <plat/regs-usb3-exynos-drd-phy.h>
 
 #define PHY_ENABLE	1
 #define PHY_DISABLE	0
 
 enum usb_phy_type {
 	USB_PHY		= (0x1 << 0),
+	USB_PHY_DRD	= (0x1 << 1),
 };
 
 static atomic_t host_usage;
@@ -161,11 +163,44 @@ static int exynos4210_usb_phy_clkset(struct platform_device *pdev)
 	return phyclk;
 }
 
+static u32 exynos_usb_phy30_set_clock(struct platform_device *pdev)
+{
+	u32 reg, refclk;
+
+	refclk = exynos4210_usb_phy_clkset(pdev);
+	reg = EXYNOS_USB3_PHYCLKRST_REFCLKSEL(3) |
+	      EXYNOS_USB3_PHYCLKRST_FSEL(refclk);
+
+	switch (refclk) {
+	case EXYNOS5_CLKSEL_50M:
+		reg |= (EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER(0x02) |
+			EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL(0x00));
+		break;
+	case EXYNOS5_CLKSEL_20M:
+		reg |= (EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER(0x7d) |
+			EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL(0x00));
+		break;
+	case EXYNOS5_CLKSEL_19200K:
+		reg |= (EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER(0x02) |
+			EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL(0x88));
+		break;
+	case EXYNOS5_CLKSEL_24M:
+	default:
+		reg |= (EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER(0x68) |
+			EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL(0x88));
+		break;
+	}
+
+	return reg;
+}
+
 static void exynos_usb_phy_control(enum usb_phy_type phy_type , int on)
 {
 	if (soc_is_exynos5250()) {
 		if (phy_type & USB_PHY)
 			writel(on, S5P_USBHOST_PHY_CONTROL);
+		if (phy_type & USB_PHY_DRD)
+			writel(on, S5P_USBDRD_PHY_CONTROL);
 	}
 }
 
@@ -413,6 +448,88 @@ static int exynos5_usb_phy20_exit(struct platform_device *pdev)
 	return 0;
 }
 
+static int exynos5_usb_phy30_init(struct platform_device *pdev)
+{
+	struct clk *host_clk;
+	u32 reg;
+
+	host_clk = exynos_usb_clock_enable(pdev);
+	if (host_clk == NULL) {
+		dev_err(&pdev->dev, "Failed to enable USB3.0 host clock this time\n");
+		return -1;
+	}
+
+	exynos_usb_phy_control(USB_PHY_DRD, PHY_ENABLE);
+
+	/* Reset USB 3.0 PHY */
+	writel(0x00000000, EXYNOS_USB3_PHYREG0);
+	writel(0x24d4e6e4, EXYNOS_USB3_PHYPARAM0);
+	writel(0x03fff81c, EXYNOS_USB3_PHYPARAM1);
+	writel(0x00000000, EXYNOS_USB3_PHYRESUME);
+
+	writel(0x08000040, EXYNOS_USB3_LINKSYSTEM);
+	writel(0x00000004, EXYNOS_USB3_PHYBATCHG);
+
+	/* PHYTEST POWERDOWN Control */
+	reg = readl(EXYNOS_USB3_PHYTEST);
+	reg &= ~(EXYNOS_USB3_PHYTEST_POWERDOWN_SSP |
+		 EXYNOS_USB3_PHYTEST_POWERDOWN_HSP);
+	writel(reg, EXYNOS_USB3_PHYTEST);
+
+	/* UTMI Power Control */
+	writel(EXYNOS_USB3_PHYUTMI_OTGDISABLE, EXYNOS_USB3_PHYUTMI);
+
+	reg = exynos_usb_phy30_set_clock(pdev);
+
+	reg |= (EXYNOS_USB3_PHYCLKRST_PORTRESET |
+		/* Digital power supply in normal operating mode */
+		EXYNOS_USB3_PHYCLKRST_RETENABLEN |
+		/* Enable ref clock for SS function */
+		EXYNOS_USB3_PHYCLKRST_REF_SSP_EN |
+		/* Enable spread spectrum */
+		EXYNOS_USB3_PHYCLKRST_SSC_EN) |
+		EXYNOS_USB3_PHYCLKRST_COMMONONN;
+	writel(reg, EXYNOS_USB3_PHYCLKRST);
+
+	udelay(10);
+
+	reg &= ~(EXYNOS_USB3_PHYCLKRST_PORTRESET);
+	writel(reg, EXYNOS_USB3_PHYCLKRST);
+
+	clk_disable(host_clk);
+	clk_put(host_clk);
+	return 0;
+}
+
+static int exynos5_usb_phy30_exit(struct platform_device *pdev)
+{
+	struct clk *host_clk;
+	u32 reg;
+
+	host_clk = exynos_usb_clock_enable(pdev);
+	if (host_clk == NULL) {
+		dev_err(&pdev->dev, "Failed to enable USB3.0 host clock this time\n");
+		return -1;
+	}
+
+	reg = EXYNOS_USB3_PHYUTMI_OTGDISABLE |
+		EXYNOS_USB3_PHYUTMI_FORCESUSPEND |
+		EXYNOS_USB3_PHYUTMI_FORCESLEEP;
+	writel(reg, EXYNOS_USB3_PHYUTMI);
+
+	/* Control PHYTEST to remove leakage current */
+	reg = readl(EXYNOS_USB3_PHYTEST);
+	reg |= (EXYNOS_USB3_PHYTEST_POWERDOWN_SSP |
+		 EXYNOS_USB3_PHYTEST_POWERDOWN_HSP);
+	writel(reg, EXYNOS_USB3_PHYTEST);
+
+	exynos_usb_phy_control(USB_PHY_DRD, PHY_DISABLE);
+
+	clk_disable(host_clk);
+	clk_put(host_clk);
+	return 0;
+}
+
 int s5p_usb_phy_init(struct platform_device *pdev, int type)
 {
 	if (type == S5P_USB_PHY_DEVICE)
@@ -422,6 +539,11 @@ int s5p_usb_phy_init(struct platform_device *pdev, int type)
 			return exynos5_usb_phy20_init(pdev);
 		else
 			return exynos4210_usb_phy1_init(pdev);
+	} else if (type == S5P_USB_PHY_DRD) {
+		if (soc_is_exynos5250())
+			return exynos5_usb_phy30_init(pdev);
+		else
+			dev_err(&pdev->dev, "USB 3.0 DRD not present\n");
 	}
 
 	return -EINVAL;
@@ -436,6 +558,11 @@ int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 			return exynos5_usb_phy20_exit(pdev);
 		else
 			return exynos4210_usb_phy1_exit(pdev);
+	} else if (type == S5P_USB_PHY_DRD) {
+		if (soc_is_exynos5250())
+			return exynos5_usb_phy30_exit(pdev);
+		else
+			dev_err(&pdev->dev, "USB 3.0 DRD not present\n");
 	}
 	return -EINVAL;
 }
diff --git a/arch/arm/plat-samsung/include/plat/regs-usb3-exynos-drd-phy.h b/arch/arm/plat-samsung/include/plat/regs-usb3-exynos-drd-phy.h
new file mode 100644
index 0000000..8efd5c7
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-usb3-exynos-drd-phy.h
@@ -0,0 +1,75 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co. Ltd
+ *
+ * Exynos SuperSpeed USB 3.0 DRD Controller PHY registers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __PLAT_SAMSUNG_REGS_USB3_EXYNOS_DRD_PHY_H
+#define __PLAT_SAMSUNG_REGS_USB3_EXYNOS_DRD_PHY_H __FILE__
+
+#define EXYNOS_USB3_PHYREG(x) ((x) + S5P_VA_DRD_PHY)
+
+#define EXYNOS_USB3_LINKSYSTEM		EXYNOS_USB3_PHYREG(0x04)
+#define EXYNOS_USB3_PHYUTMI		EXYNOS_USB3_PHYREG(0x08)
+
+#define EXYNOS_USB3_PHYUTMI_OTGDISABLE			(1 << 6)
+#define EXYNOS_USB3_PHYUTMI_FORCESUSPEND		(1 << 1)
+#define EXYNOS_USB3_PHYUTMI_FORCESLEEP			(1 << 0)
+
+#define EXYNOS_USB3_PHYPIPE		EXYNOS_USB3_PHYREG(0x0C)
+#define EXYNOS_USB3_PHYCLKRST		EXYNOS_USB3_PHYREG(0x10)
+
+#define EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL_MASK	(0xff << 23)
+#define EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL_SHIFT	(23)
+#define EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL_LIMIT	(0xff)
+#define EXYNOS_USB3_PHYCLKRST_SSC_REF_CLK_SEL(_x)	((_x) << 23)
+
+#define EXYNOS_USB3_PHYCLKRST_SSC_RANGE_MASK		(0x03 << 21)
+#define EXYNOS_USB3_PHYCLKRST_SSC_RANGE_SHIFT		(21)
+#define EXYNOS_USB3_PHYCLKRST_SSC_RANGE_LIMIT		(0x03)
+#define EXYNOS_USB3_PHYCLKRST_SSC_RANGE(_x)		((_x) << 21)
+
+#define EXYNOS_USB3_PHYCLKRST_SSC_EN			(1 << 20)
+#define EXYNOS_USB3_PHYCLKRST_REF_SSP_EN		(1 << 19)
+#define EXYNOS_USB3_PHYCLKRST_REF_CLKDIV2		(1 << 18)
+
+#define EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER_MASK	(0x7f << 11)
+#define EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER_SHIFT	(11)
+#define EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER_LIMIT	(0x7f)
+#define EXYNOS_USB3_PHYCLKRST_MPLL_MULTIPLIER(_x)	((_x) << 11)
+
+#define EXYNOS_USB3_PHYCLKRST_FSEL_MASK			(0x3f << 5)
+#define EXYNOS_USB3_PHYCLKRST_FSEL_SHIFT		(5)
+#define EXYNOS_USB3_PHYCLKRST_FSEL_LIMIT		(0x3f)
+#define EXYNOS_USB3_PHYCLKRST_FSEL(_x)			((_x) << 5)
+
+#define EXYNOS_USB3_PHYCLKRST_RETENABLEN		(1 << 4)
+
+#define EXYNOS_USB3_PHYCLKRST_REFCLKSEL_MASK		(0x03 << 2)
+#define EXYNOS_USB3_PHYCLKRST_REFCLKSEL_SHIFT		(2)
+#define EXYNOS_USB3_PHYCLKRST_REFCLKSEL_LIMIT		(0x03)
+#define EXYNOS_USB3_PHYCLKRST_REFCLKSEL(_x)		((_x) << 2)
+
+#define EXYNOS_USB3_PHYCLKRST_PORTRESET			(1 << 1)
+#define EXYNOS_USB3_PHYCLKRST_COMMONONN			(1 << 0)
+
+#define EXYNOS_USB3_PHYREG0		EXYNOS_USB3_PHYREG(0x14)
+#define EXYNOS_USB3_PHYREG1		EXYNOS_USB3_PHYREG(0x18)
+#define EXYNOS_USB3_PHYPARAM0		EXYNOS_USB3_PHYREG(0x1C)
+#define EXYNOS_USB3_PHYPARAM1		EXYNOS_USB3_PHYREG(0x20)
+#define EXYNOS_USB3_PHYTERM		EXYNOS_USB3_PHYREG(0x24)
+
+#define EXYNOS_USB3_PHYTEST		EXYNOS_USB3_PHYREG(0x28)
+
+#define EXYNOS_USB3_PHYTEST_POWERDOWN_SSP		(1 << 3)
+#define EXYNOS_USB3_PHYTEST_POWERDOWN_HSP		(1 << 3)
+
+#define EXYNOS_USB3_PHYADP		EXYNOS_USB3_PHYREG(0x2C)
+#define EXYNOS_USB3_PHYBATCHG		EXYNOS_USB3_PHYREG(0x30)
+#define EXYNOS_USB3_PHYRESUME		EXYNOS_USB3_PHYREG(0x34)
+#define EXYNOS_USB3_LINKPORT		EXYNOS_USB3_PHYREG(0x44)
+#endif /* __PLAT_SAMSUNG_REGS_USB3_EXYNOS_DRD_PHY_H */
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
index 959bcdb..f784101 100644
--- a/arch/arm/plat-samsung/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -14,6 +14,7 @@
 enum s5p_usb_phy_type {
 	S5P_USB_PHY_DEVICE,
 	S5P_USB_PHY_HOST,
+	S5P_USB_PHY_DRD,
 };
 
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
-- 
1.7.0.4
