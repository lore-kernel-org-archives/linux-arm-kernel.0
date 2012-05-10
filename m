From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 10 May 2012 18:29:27 +0200
Subject: [PATCH RESEND 1/4] ARM: EXYNOS: Add usb otg phy control for EXYNOS4210
In-Reply-To: <1336667370-2039-1-git-send-email-l.majewski@samsung.com>
References: <1336667370-2039-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1336667370-2039-2-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports to control usb otg phy of EXYNOS4210.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
[Rebased on the newest git/kgene/linux-samsung #for-next]
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/mach-exynos/include/mach/irqs.h     |    1 +
 arch/arm/mach-exynos/include/mach/map.h      |    4 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    3 +
 arch/arm/mach-exynos/setup-usb-phy.c         |   95 +++++++++++++++++++-------
 4 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 1161675..ddde8f3 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -196,6 +196,7 @@
 #define IRQ_IIC7			EXYNOS4_IRQ_IIC7
 
 #define IRQ_USB_HOST			EXYNOS4_IRQ_USB_HOST
+#define IRQ_OTG				EXYNOS4_IRQ_USB_HSOTG
 
 #define IRQ_HSMMC0			EXYNOS4_IRQ_HSMMC0
 #define IRQ_HSMMC1			EXYNOS4_IRQ_HSMMC1
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 0e2292d..2196af2 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -168,6 +168,9 @@
 #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 #define EXYNOS4_PA_DWMCI		0x12550000
 
+#define EXYNOS4_PA_HSOTG		0x12480000
+#define EXYNOS4_PA_USB_HSPHY		0x125B0000
+
 #define EXYNOS4_PA_SATA			0x12560000
 #define EXYNOS4_PA_SATAPHY		0x125D0000
 #define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
@@ -224,6 +227,7 @@
 #define S3C_PA_SPI0			EXYNOS4_PA_SPI0
 #define S3C_PA_SPI1			EXYNOS4_PA_SPI1
 #define S3C_PA_SPI2			EXYNOS4_PA_SPI2
+#define S3C_PA_USB_HSOTG		EXYNOS4_PA_HSOTG
 
 #define S5P_PA_EHCI			EXYNOS4_PA_EHCI
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index 4c53f38..d457d05 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -163,6 +163,9 @@
 #define S5P_CHECK_SLEEP				0x00000BAD
 
 /* Only for EXYNOS4210 */
+#define S5P_USBDEVICE_PHY_CONTROL	S5P_PMUREG(0x0704)
+#define S5P_USBDEVICE_PHY_ENABLE	(1 << 0)
+
 #define S5P_USBHOST_PHY_CONTROL		S5P_PMUREG(0x0708)
 #define S5P_USBHOST_PHY_ENABLE		(1 << 0)
 
diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index 41743d2..6cf5d6a 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -26,11 +26,72 @@ static int exynos4_usb_host_phy_is_on(void)
 	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
 }
 
-static int exynos4_usb_phy1_init(struct platform_device *pdev)
+static void exynos4_usb_phy_clkset(struct platform_device *pdev)
 {
-	struct clk *otg_clk;
 	struct clk *xusbxti_clk;
 	u32 phyclk;
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
+}
+
+static int exynos4_usb_phy0_init(struct platform_device *pdev)
+{
+	u32 rstcon;
+
+	writel(readl(S5P_USBDEVICE_PHY_CONTROL) | S5P_USBDEVICE_PHY_ENABLE,
+			S5P_USBDEVICE_PHY_CONTROL);
+
+	exynos4_usb_phy_clkset(pdev);
+
+	/* set to normal PHY0 */
+	writel((readl(EXYNOS4_PHYPWR) & ~PHY0_NORMAL_MASK), EXYNOS4_PHYPWR);
+
+	/* reset PHY0 and Link */
+	rstcon = readl(EXYNOS4_RSTCON) | PHY0_SWRST_MASK;
+	writel(rstcon, EXYNOS4_RSTCON);
+	udelay(10);
+
+	rstcon &= ~PHY0_SWRST_MASK;
+	writel(rstcon, EXYNOS4_RSTCON);
+	udelay(80);
+
+	return 0;
+}
+
+static int exynos4_usb_phy0_exit(struct platform_device *pdev)
+{
+	writel((readl(EXYNOS4_PHYPWR) | PHY0_ANALOG_POWERDOWN |
+				PHY0_OTG_DISABLE), EXYNOS4_PHYPWR);
+
+	writel(readl(S5P_USBDEVICE_PHY_CONTROL) & ~S5P_USBDEVICE_PHY_ENABLE,
+			S5P_USBDEVICE_PHY_CONTROL);
+
+	return 0;
+}
+
+static int exynos4_usb_phy1_init(struct platform_device *pdev)
+{
+	struct clk *otg_clk;
 	u32 rstcon;
 	int err;
 
@@ -54,27 +115,7 @@ static int exynos4_usb_phy1_init(struct platform_device *pdev)
 	writel(readl(S5P_USBHOST_PHY_CONTROL) | S5P_USBHOST_PHY_ENABLE,
 			S5P_USBHOST_PHY_CONTROL);
 
-	/* set clock frequency for PLL */
-	phyclk = readl(EXYNOS4_PHYCLK) & ~CLKSEL_MASK;
-
-	xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
-	if (xusbxti_clk && !IS_ERR(xusbxti_clk)) {
-		switch (clk_get_rate(xusbxti_clk)) {
-		case 12 * MHZ:
-			phyclk |= CLKSEL_12M;
-			break;
-		case 24 * MHZ:
-			phyclk |= CLKSEL_24M;
-			break;
-		default:
-		case 48 * MHZ:
-			/* default reference clock */
-			break;
-		}
-		clk_put(xusbxti_clk);
-	}
-
-	writel(phyclk, EXYNOS4_PHYCLK);
+	exynos4_usb_phy_clkset(pdev);
 
 	/* floating prevention logic: disable */
 	writel((readl(EXYNOS4_PHY1CON) | FPENABLEN), EXYNOS4_PHY1CON);
@@ -136,7 +177,9 @@ static int exynos4_usb_phy1_exit(struct platform_device *pdev)
 
 int s5p_usb_phy_init(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_HOST)
+	if (type == S5P_USB_PHY_DEVICE)
+		return exynos4_usb_phy0_init(pdev);
+	else if (type == S5P_USB_PHY_HOST)
 		return exynos4_usb_phy1_init(pdev);
 
 	return -EINVAL;
@@ -144,7 +187,9 @@ int s5p_usb_phy_init(struct platform_device *pdev, int type)
 
 int s5p_usb_phy_exit(struct platform_device *pdev, int type)
 {
-	if (type == S5P_USB_PHY_HOST)
+	if (type == S5P_USB_PHY_DEVICE)
+		return exynos4_usb_phy0_exit(pdev);
+	else if (type == S5P_USB_PHY_HOST)
 		return exynos4_usb_phy1_exit(pdev);
 
 	return -EINVAL;
-- 
1.7.2.3
