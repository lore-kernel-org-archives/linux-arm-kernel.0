From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 28 Dec 2011 16:03:26 +0900
Subject: [PATCH 5/6] USB: s3c-hsotg: Add platform data callbacks for phy
 control
In-Reply-To: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
References: <1325055807-29347-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1325055807-29347-5-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c-hsotg driver controls S3C64XX specific registers directly but
this driver can be to EXYNOS also. This removes arch specific parts from
driver using platform data callbacks.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/gadget/s3c-hsotg.c |   94 ++++++----------------------------------
 1 files changed, 14 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index b314482..2665bf5 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -35,9 +35,9 @@
 
 #include <plat/regs-usb-hsotg-phy.h>
 #include <plat/regs-usb-hsotg.h>
-#include <mach/regs-sys.h>
 #include <plat/udc-hs.h>
 #include <plat/cpu.h>
+#include <plat/usb-phy.h>
 
 #define DMA_ADDR_INVALID (~((dma_addr_t)0))
 
@@ -2843,51 +2843,6 @@ static void __devinit s3c_hsotg_initep(struct s3c_hsotg *hsotg,
 	}
 }
 
-/**
- * s3c_hsotg_otgreset - reset the OtG phy block
- * @hsotg: The host state.
- *
- * Power up the phy, set the basic configuration and start the PHY.
- */
-static void s3c_hsotg_otgreset(struct s3c_hsotg *hsotg)
-{
-	struct clk *xusbxti;
-	u32 pwr, osc;
-
-	pwr = readl(S3C_PHYPWR);
-	pwr &= ~0x19;
-	writel(pwr, S3C_PHYPWR);
-	mdelay(1);
-
-	osc = hsotg->plat->is_osc ? S3C_PHYCLK_EXT_OSC : 0;
-
-	xusbxti = clk_get(hsotg->dev, "xusbxti");
-	if (xusbxti && !IS_ERR(xusbxti)) {
-		switch (clk_get_rate(xusbxti)) {
-		case 12*MHZ:
-			osc |= S3C_PHYCLK_CLKSEL_12M;
-			break;
-		case 24*MHZ:
-			osc |= S3C_PHYCLK_CLKSEL_24M;
-			break;
-		default:
-		case 48*MHZ:
-			/* default reference clock */
-			break;
-		}
-		clk_put(xusbxti);
-	}
-
-	writel(osc | 0x10, S3C_PHYCLK);
-
-	/* issue a full set of resets to the otg and core */
-
-	writel(S3C_RSTCON_PHY, S3C_RSTCON);
-	udelay(20);	/* at-least 10uS */
-	writel(0, S3C_RSTCON);
-}
-
-
 static void s3c_hsotg_init(struct s3c_hsotg *hsotg)
 {
 	u32 cfg4;
@@ -3260,34 +3215,6 @@ static void __devexit s3c_hsotg_delete_debug(struct s3c_hsotg *hsotg)
 	debugfs_remove(hsotg->debug_root);
 }
 
-/**
- * s3c_hsotg_gate - set the hardware gate for the block
- * @pdev: The device we bound to
- * @on: On or off.
- *
- * Set the hardware gate setting into the block. If we end up on
- * something other than an S3C64XX, then we might need to change this
- * to using a platform data callback, or some other mechanism.
- */
-static void s3c_hsotg_gate(struct platform_device *pdev, bool on)
-{
-	unsigned long flags;
-	u32 others;
-
-	local_irq_save(flags);
-
-	others = __raw_readl(S3C64XX_OTHERS);
-	if (on)
-		others |= S3C64XX_OTHERS_USBMASK;
-	else
-		others &= ~S3C64XX_OTHERS_USBMASK;
-	__raw_writel(others, S3C64XX_OTHERS);
-
-	local_irq_restore(flags);
-}
-
-static struct s3c_hsotg_plat s3c_hsotg_default_pdata;
-
 static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 {
 	struct s3c_hsotg_plat *plat = pdev->dev.platform_data;
@@ -3297,8 +3224,11 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	int epnum;
 	int ret;
 
-	if (!plat)
-		plat = &s3c_hsotg_default_pdata;
+	plat = pdev->dev.platform_data;
+	if (!plat) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
 
 	hsotg = kzalloc(sizeof(struct s3c_hsotg) +
 			sizeof(struct s3c_hsotg_ep) * S3C_HSOTG_EPS,
@@ -3387,9 +3317,9 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 
 	clk_enable(hsotg->clk);
 
-	s3c_hsotg_gate(pdev, true);
+	if (plat->phy_init)
+		plat->phy_init(pdev, S5P_USB_PHY_DEVICE);
 
-	s3c_hsotg_otgreset(hsotg);
 	s3c_hsotg_corereset(hsotg);
 	s3c_hsotg_init(hsotg);
 
@@ -3409,7 +3339,9 @@ static int __devinit s3c_hsotg_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_udc:
-	s3c_hsotg_gate(pdev, false);
+	if (plat->phy_exit)
+		plat->phy_exit(pdev, S5P_USB_PHY_DEVICE);
+
 	clk_disable(hsotg->clk);
 	clk_put(hsotg->clk);
 
@@ -3429,6 +3361,7 @@ err_mem:
 static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
 {
 	struct s3c_hsotg *hsotg = platform_get_drvdata(pdev);
+	struct s3c_hsotg_plat *plat = hsotg->plat;
 
 	usb_del_gadget_udc(&hsotg->gadget);
 
@@ -3442,7 +3375,8 @@ static int __devexit s3c_hsotg_remove(struct platform_device *pdev)
 	release_resource(hsotg->regs_res);
 	kfree(hsotg->regs_res);
 
-	s3c_hsotg_gate(pdev, false);
+	if (plat->phy_exit)
+		plat->phy_exit(pdev, S5P_USB_PHY_DEVICE);
 
 	clk_disable(hsotg->clk);
 	clk_put(hsotg->clk);
-- 
1.7.5.4
