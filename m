From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sat, 21 Jul 2012 16:02:02 +0530
Subject: [PATCH 1/8 v2] EXYNOS4: USB: Generalising setup-usb-phy driver for
 exynos
In-Reply-To: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1342866729-30460-2-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the setup-usb-phy in order to accomodate
exynos5 support later.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/mach-exynos/setup-usb-phy.c |   54 +++++++++++++++++----------------
 1 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index b81cc56..1a4ea07 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -26,10 +26,29 @@ static int exynos4_usb_host_phy_is_on(void)
 	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
 }
 
-static void exynos4210_usb_phy_clkset(struct platform_device *pdev)
+static struct clk *exynos_usb_clock_enable(struct platform_device *pdev)
+{
+	struct clk *usb_clk = NULL;
+	int err = 0;
+
+	usb_clk = clk_get(&pdev->dev, "otg");
+	if (IS_ERR(usb_clk)) {
+		dev_err(&pdev->dev, "Failed to get otg clock\n");
+		return NULL;
+	}
+
+	err = clk_enable(usb_clk);
+	if (err) {
+		clk_put(usb_clk);
+		return NULL;
+	}
+	return usb_clk;
+}
+
+static int exynos4210_usb_phy_clkset(struct platform_device *pdev)
 {
 	struct clk *xusbxti_clk;
-	u32 phyclk;
+	u32 phyclk = 0;
 
 	xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
 	if (xusbxti_clk && !IS_ERR(xusbxti_clk)) {
@@ -80,6 +99,7 @@ static void exynos4210_usb_phy_clkset(struct platform_device *pdev)
 		}
 		clk_put(xusbxti_clk);
 	}
+	return phyclk;
 }
 
 static int exynos4210_usb_phy0_init(struct platform_device *pdev)
@@ -120,21 +140,12 @@ static int exynos4210_usb_phy1_init(struct platform_device *pdev)
 {
 	struct clk *otg_clk;
 	u32 rstcon;
-	int err;
 
 	atomic_inc(&host_usage);
 
-	otg_clk = clk_get(&pdev->dev, "otg");
-	if (IS_ERR(otg_clk)) {
-		dev_err(&pdev->dev, "Failed to get otg clock\n");
-		return PTR_ERR(otg_clk);
-	}
-
-	err = clk_enable(otg_clk);
-	if (err) {
-		clk_put(otg_clk);
-		return err;
-	}
+	otg_clk = exynos_usb_clock_enable(pdev);
+	if (otg_clk == NULL)
+		dev_err(&pdev->dev, "Failed to enable otg clock\n");
 
 	if (exynos4_usb_host_phy_is_on())
 		return 0;
@@ -173,22 +184,13 @@ static int exynos4210_usb_phy1_init(struct platform_device *pdev)
 static int exynos4210_usb_phy1_exit(struct platform_device *pdev)
 {
 	struct clk *otg_clk;
-	int err;
 
 	if (atomic_dec_return(&host_usage) > 0)
 		return 0;
 
-	otg_clk = clk_get(&pdev->dev, "otg");
-	if (IS_ERR(otg_clk)) {
-		dev_err(&pdev->dev, "Failed to get otg clock\n");
-		return PTR_ERR(otg_clk);
-	}
-
-	err = clk_enable(otg_clk);
-	if (err) {
-		clk_put(otg_clk);
-		return err;
-	}
+	otg_clk = exynos_usb_clock_enable(pdev);
+	if (otg_clk == NULL)
+		dev_err(&pdev->dev, "Failed to enable otg clock\n");
 
 	writel((readl(EXYNOS4_PHYPWR) | PHY1_STD_ANALOG_POWERDOWN),
 			EXYNOS4_PHYPWR);
-- 
1.7.0.4
