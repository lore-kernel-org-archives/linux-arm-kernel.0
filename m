From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:44 -0500
Subject: [PATCH v2 11/11] usb: musb: da8xx: Remove mach code
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-12-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new phy-da8xx-usb driver to take the place of the mach code that
pokes CFGCHIP2 in the da8xx musb glue driver.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: This is part of a previous patch that was split. This version uses
the new phy driver instead of a second clock. It also gets rid of more mach
code.


 drivers/usb/musb/da8xx.c | 126 ++++++++++++-----------------------------------
 1 file changed, 31 insertions(+), 95 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 50f07a5..1d51711 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -30,13 +30,11 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/usb_phy_generic.h>
 
-#include <mach/da8xx.h>
-#include <linux/platform_data/usb-davinci.h>
-
 #include "musb_core.h"
 
 /*
@@ -80,61 +78,15 @@
 
 #define DA8XX_MENTOR_CORE_OFFSET 0x400
 
-#define CFGCHIP2	IO_ADDRESS(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG)
-
 struct da8xx_glue {
 	struct device		*dev;
 	struct platform_device	*musb;
-	struct platform_device	*phy;
+	struct platform_device	*usb_phy;
 	struct clk		*clk;
+	struct phy		*phy;
 };
 
 /*
- * REVISIT (PM): we should be able to keep the PHY in low power mode most
- * of the time (24 MHz oscillator and PLL off, etc.) by setting POWER.D0
- * and, when in host mode, autosuspending idle root ports... PHY_PLLON
- * (overriding SUSPENDM?) then likely needs to stay off.
- */
-
-static inline void phy_on(void)
-{
-	u32 cfgchip2 = __raw_readl(CFGCHIP2);
-
-	/*
-	 * Start the on-chip PHY and its PLL.
-	 */
-	cfgchip2 &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN | CFGCHIP2_OTGPWRDN);
-	cfgchip2 |= CFGCHIP2_PHY_PLLON;
-	__raw_writel(cfgchip2, CFGCHIP2);
-
-	pr_info("Waiting for USB PHY clock good...\n");
-	while (!(__raw_readl(CFGCHIP2) & CFGCHIP2_PHYCLKGD))
-		cpu_relax();
-}
-
-static inline void phy_off(void)
-{
-	u32 cfgchip2 = __raw_readl(CFGCHIP2);
-
-	/*
-	 * Ensure that USB 1.1 reference clock is not being sourced from
-	 * USB 2.0 PHY.  Otherwise do not power down the PHY.
-	 */
-	if (!(cfgchip2 & CFGCHIP2_USB1PHYCLKMUX) &&
-	     (cfgchip2 & CFGCHIP2_USB1SUSPENDM)) {
-		pr_warning("USB 1.1 clocked from USB 2.0 PHY -- "
-			   "can't power it down\n");
-		return;
-	}
-
-	/*
-	 * Power down the on-chip PHY.
-	 */
-	cfgchip2 |= CFGCHIP2_PHYPWRDN | CFGCHIP2_OTGPWRDN;
-	__raw_writel(cfgchip2, CFGCHIP2);
-}
-
-/*
  * Because we don't set CTRL.UINT, it's "important" to:
  *	- not read/write INTRUSB/INTRUSBE (except during
  *	  initial setup, as a workaround);
@@ -383,31 +335,18 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 	return ret;
 }
 
+extern int da8xx_usb20_phy_set_mode(struct phy *phy, enum musb_mode mode);
+
 static int da8xx_musb_set_mode(struct musb *musb, u8 musb_mode)
 {
-	u32 cfgchip2 = __raw_readl(CFGCHIP2);
+	struct da8xx_glue *glue = dev_get_drvdata(musb->controller->parent);
 
-	cfgchip2 &= ~CFGCHIP2_OTGMODE;
-	switch (musb_mode) {
-	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
-		cfgchip2 |= CFGCHIP2_FORCE_HOST;
-		break;
-	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
-		cfgchip2 |= CFGCHIP2_FORCE_DEVICE;
-		break;
-	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
-		cfgchip2 |= CFGCHIP2_NO_OVERRIDE;
-		break;
-	default:
-		dev_dbg(musb->controller, "Trying to set unsupported mode %u\n", musb_mode);
-	}
-
-	__raw_writel(cfgchip2, CFGCHIP2);
-	return 0;
+	return da8xx_usb20_phy_set_mode(glue->phy, musb_mode);
 }
 
 static int da8xx_musb_init(struct musb *musb)
 {
+	struct da8xx_glue *glue = dev_get_drvdata(musb->controller->parent);
 	void __iomem *reg_base = musb->ctrl_base;
 	u32 rev;
 	int ret = -ENODEV;
@@ -425,19 +364,24 @@ static int da8xx_musb_init(struct musb *musb)
 		goto fail;
 	}
 
+	ret = clk_prepare_enable(glue->clk);
+	if (ret) {
+		dev_err(glue->dev, "failed to enable clock\n");
+		goto fail;
+	}
+
 	setup_timer(&otg_workaround, otg_timer, (unsigned long)musb);
 
 	/* Reset the controller */
 	musb_writel(reg_base, DA8XX_USB_CTRL_REG, DA8XX_SOFT_RESET_MASK);
 
 	/* Start the on-chip PHY and its PLL. */
-	phy_on();
+	phy_power_on(glue->phy);
 
 	msleep(5);
 
 	/* NOTE: IRQs are in mixed mode, not bypass to pure MUSB */
-	pr_debug("DA8xx OTG revision %08x, PHY %03x, control %02x\n",
-		 rev, __raw_readl(CFGCHIP2),
+	pr_debug("DA8xx OTG revision %08x, control %02x\n", rev,
 		 musb_readb(reg_base, DA8XX_USB_CTRL_REG));
 
 	musb->isr = da8xx_musb_interrupt;
@@ -448,9 +392,12 @@ fail:
 
 static int da8xx_musb_exit(struct musb *musb)
 {
+	struct da8xx_glue *glue = dev_get_drvdata(musb->controller->parent);
+
 	del_timer_sync(&otg_workaround);
 
-	phy_off();
+	phy_power_off(glue->phy);
+	clk_disable_unprepare(glue->clk);
 
 	usb_put_phy(musb->xceiv);
 
@@ -503,19 +450,19 @@ static int da8xx_probe(struct platform_device *pdev)
 		return PTR_ERR(glue->clk);
 	}
 
-	ret = clk_enable(glue->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err4;
+	glue->phy = devm_phy_get(&pdev->dev, "usbphy");
+	if (IS_ERR(glue->phy)) {
+		dev_err(&pdev->dev, "failed to get phy\n");
+		return PTR_ERR(glue->phy);
 	}
 
 	glue->dev			= &pdev->dev;
 	pdata->platform_ops		= &da8xx_ops;
 
-	glue->phy = usb_phy_generic_register();
-	if (IS_ERR(glue->phy)) {
-		ret = PTR_ERR(glue->phy);
-		goto err5;
+	glue->usb_phy = usb_phy_generic_register();
+	if (IS_ERR(glue->usb_phy)) {
+		dev_err(&pdev->dev, "failed to register usb_phy\n");
+		return PTR_ERR(glue->usb_phy);
 	}
 	platform_set_drvdata(pdev, glue);
 
@@ -541,22 +488,12 @@ static int da8xx_probe(struct platform_device *pdev)
 
 	glue->musb = musb = platform_device_register_full(&pinfo);
 	if (IS_ERR(musb)) {
-		ret = PTR_ERR(musb);
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		goto err6;
+		usb_phy_generic_unregister(glue->usb_phy);
+		return PTR_ERR(musb);
 	}
 
 	return 0;
-
-err6:
-	usb_phy_generic_unregister(glue->phy);
-
-err5:
-	clk_disable(glue->clk);
-
-err4:
-
-	return ret;
 }
 
 static int da8xx_remove(struct platform_device *pdev)
@@ -564,8 +501,7 @@ static int da8xx_remove(struct platform_device *pdev)
 	struct da8xx_glue		*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	usb_phy_generic_unregister(glue->phy);
-	clk_disable(glue->clk);
+	usb_phy_generic_unregister(glue->usb_phy);
 
 	return 0;
 }
-- 
1.9.1
