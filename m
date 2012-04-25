From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:27:53 +0200
Subject: [PATCH 03/33] video imxfb: do not depend on grouped clocks
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the current i.MX clock support groups together unrelated clocks
to a single clock which is then used by the driver. This can't
be accomplished with the generic clock framework so we instead
request the individual clocks in the driver. For i.MX there are
generally three different clocks:

ipg: bus clock (needed to access registers)
ahb: dma relevant clock, sometimes referred to as hclk in the datasheet
per: bit clock, pixel clock

This patch changes the driver to request the individual clocks.
Currently all clk_get will get the same clock until the SoCs
are converted to the generic clock framework

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/imxfb.c |   50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index f135dbe..caad368 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -131,7 +131,9 @@ struct imxfb_rgb {
 struct imxfb_info {
 	struct platform_device  *pdev;
 	void __iomem		*regs;
-	struct clk		*clk;
+	struct clk		*clk_ipg;
+	struct clk		*clk_ahb;
+	struct clk		*clk_per;
 
 	/*
 	 * These are the addresses we mapped
@@ -340,7 +342,7 @@ static int imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	pr_debug("var->bits_per_pixel=%d\n", var->bits_per_pixel);
 
-	lcd_clk = clk_get_rate(fbi->clk);
+	lcd_clk = clk_get_rate(fbi->clk_per);
 
 	tmp = var->pixclock * (unsigned long long)lcd_clk;
 
@@ -455,11 +457,17 @@ static int imxfb_bl_update_status(struct backlight_device *bl)
 
 	fbi->pwmr = (fbi->pwmr & ~0xFF) | brightness;
 
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
-		clk_enable(fbi->clk);
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK) {
+		clk_prepare_enable(fbi->clk_ipg);
+		clk_prepare_enable(fbi->clk_ahb);
+		clk_prepare_enable(fbi->clk_per);
+	}
 	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
-	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
-		clk_disable(fbi->clk);
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK) {
+		clk_disable_unprepare(fbi->clk_per);
+		clk_disable_unprepare(fbi->clk_ahb);
+		clk_disable_unprepare(fbi->clk_ipg);
+	}
 
 	return 0;
 }
@@ -522,7 +530,9 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 	 */
 	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
 
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk_ipg);
+	clk_prepare_enable(fbi->clk_ahb);
+	clk_prepare_enable(fbi->clk_per);
 
 	if (fbi->backlight_power)
 		fbi->backlight_power(1);
@@ -539,7 +549,9 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
 	if (fbi->lcd_power)
 		fbi->lcd_power(0);
 
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk_per);
+	clk_disable_unprepare(fbi->clk_ipg);
+	clk_disable_unprepare(fbi->clk_ahb);
 
 	writel(0, fbi->regs + LCDC_RMCR);
 }
@@ -770,10 +782,21 @@ static int __init imxfb_probe(struct platform_device *pdev)
 		goto failed_req;
 	}
 
-	fbi->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(fbi->clk)) {
-		ret = PTR_ERR(fbi->clk);
-		dev_err(&pdev->dev, "unable to get clock: %d\n", ret);
+	fbi->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fbi->clk_ipg)) {
+		ret = PTR_ERR(fbi->clk_ipg);
+		goto failed_getclock;
+	}
+
+	fbi->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(fbi->clk_ahb)) {
+		ret = PTR_ERR(fbi->clk_ahb);
+		goto failed_getclock;
+	}
+
+	fbi->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(fbi->clk_per)) {
+		ret = PTR_ERR(fbi->clk_per);
 		goto failed_getclock;
 	}
 
@@ -858,7 +881,6 @@ failed_platform_init:
 failed_map:
 	iounmap(fbi->regs);
 failed_ioremap:
-	clk_put(fbi->clk);
 failed_getclock:
 	release_mem_region(res->start, resource_size(res));
 failed_req:
@@ -895,8 +917,6 @@ static int __devexit imxfb_remove(struct platform_device *pdev)
 
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
-	clk_disable(fbi->clk);
-	clk_put(fbi->clk);
 
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.10
