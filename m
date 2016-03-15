From: david@lechnology.com (David Lechner)
Date: Tue, 15 Mar 2016 17:37:53 -0500
Subject: [PATCH 5/5] usb: musb-da8xx: remove board-specific clock handling
In-Reply-To: <1458081473-8223-1-git-send-email-david@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
Message-ID: <1458081473-8223-5-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver should not have to worry about how the clocks are configured
on a system. Added a usb20_phy clock to handle the USB 2.0 PLL clock
externally.

Also changed to using devm_ to simplify code a bit.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/usb/musb/da8xx.c | 93 +++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index b03d3b8..4e4c872 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -87,50 +87,29 @@ struct da8xx_glue {
 	struct platform_device	*musb;
 	struct platform_device	*phy;
 	struct clk		*clk;
+	struct clk		*phy_clk;
 };
 
-/*
- * REVISIT (PM): we should be able to keep the PHY in low power mode most
- * of the time (24 MHz oscillator and PLL off, etc.) by setting POWER.D0
- * and, when in host mode, autosuspending idle root ports... PHY_PLLON
- * (overriding SUSPENDM?) then likely needs to stay off.
- */
-
 static inline void phy_on(void)
 {
 	u32 cfgchip2 = __raw_readl(CFGCHIP2);
 
 	/*
-	 * Start the on-chip PHY and its PLL.
+	 * Most of the configuration is already done by the usb20_phy clock.
+	 * We just need to enable the OTG PHY here.
 	 */
-	cfgchip2 &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN | CFGCHIP2_OTGPWRDN);
-	cfgchip2 |= CFGCHIP2_PHY_PLLON;
+	cfgchip2 &= ~CFGCHIP2_OTGPWRDN;
 	__raw_writel(cfgchip2, CFGCHIP2);
-
-	pr_info("Waiting for USB PHY clock good...\n");
-	while (!(__raw_readl(CFGCHIP2) & CFGCHIP2_PHYCLKGD))
-		cpu_relax();
 }
 
 static inline void phy_off(void)
 {
 	u32 cfgchip2 = __raw_readl(CFGCHIP2);
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
 	/*
-	 * Power down the on-chip PHY.
+	 * Just turn off the OTG PHY. The usb20_phy clock takes care of
+	 * everything else.
 	 */
-	cfgchip2 |= CFGCHIP2_PHYPWRDN | CFGCHIP2_OTGPWRDN;
+	cfgchip2 |= CFGCHIP2_OTGPWRDN;
 	__raw_writel(cfgchip2, CFGCHIP2);
 }
 
@@ -489,38 +468,45 @@ static int da8xx_probe(struct platform_device *pdev)
 	struct platform_device		*musb;
 	struct da8xx_glue		*glue;
 	struct platform_device_info	pinfo;
-	struct clk			*clk;
-
-	int				ret = -ENOMEM;
+	int				ret;
 
-	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
 		dev_err(&pdev->dev, "failed to allocate glue context\n");
-		goto err0;
+		return -ENOMEM;
 	}
 
-	clk = clk_get(&pdev->dev, "usb20");
-	if (IS_ERR(clk)) {
+	glue->clk = devm_clk_get(&pdev->dev, "usb20");
+	if (IS_ERR(glue->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-		ret = PTR_ERR(clk);
-		goto err3;
+		return PTR_ERR(glue->clk);
 	}
 
-	ret = clk_enable(clk);
+	ret = clk_prepare_enable(glue->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err4;
+		return ret;
 	}
 
-	glue->dev			= &pdev->dev;
-	glue->clk			= clk;
+	glue->phy_clk = devm_clk_get(&pdev->dev, "usb20_phy");
+	if (IS_ERR(glue->phy_clk)) {
+		dev_err(&pdev->dev, "failed to get phy clock\n");
+		return PTR_ERR(glue->phy_clk);
+	}
+
+	ret = clk_prepare_enable(glue->phy_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable phy clock\n");
+		goto err0;
+	}
 
+	glue->dev			= &pdev->dev;
 	pdata->platform_ops		= &da8xx_ops;
 
 	glue->phy = usb_phy_generic_register();
 	if (IS_ERR(glue->phy)) {
 		ret = PTR_ERR(glue->phy);
-		goto err5;
+		goto err1;
 	}
 	platform_set_drvdata(pdev, glue);
 
@@ -548,24 +534,18 @@ static int da8xx_probe(struct platform_device *pdev)
 	if (IS_ERR(musb)) {
 		ret = PTR_ERR(musb);
 		dev_err(&pdev->dev, "failed to register musb device: %d\n", ret);
-		goto err6;
+		goto err2;
 	}
 
 	return 0;
 
-err6:
+err2:
 	usb_phy_generic_unregister(glue->phy);
-
-err5:
-	clk_disable(clk);
-
-err4:
-	clk_put(clk);
-
-err3:
-	kfree(glue);
-
+err1:
+	clk_disable_unprepare(glue->phy_clk);
 err0:
+	clk_disable_unprepare(glue->clk);
+
 	return ret;
 }
 
@@ -575,9 +555,8 @@ static int da8xx_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	usb_phy_generic_unregister(glue->phy);
-	clk_disable(glue->clk);
-	clk_put(glue->clk);
-	kfree(glue);
+	clk_disable_unprepare(glue->phy_clk);
+	clk_disable_unprepare(glue->clk);
 
 	return 0;
 }
-- 
1.9.1
