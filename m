From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 29 Jul 2010 10:42:58 +0200
Subject: [PATCH] video/imxfb.c: allow usage without BACKLIGHT_CLASS_DEVICE
In-Reply-To: <20100729051647.GA11268@pengutronix.de>
References: <20100729051647.GA11268@pengutronix.de>
Message-ID: <1280392978-25405-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 drivers/video/imxfb.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 43f0639..0c2fb4d 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -175,7 +175,9 @@ struct imxfb_info {
 
 	struct imx_fb_videomode *mode;
 	int			num_modes;
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	struct backlight_device *bl;
+#endif
 
 	void (*lcd_power)(int);
 	void (*backlight_power)(int);
@@ -450,8 +452,7 @@ static int imxfb_set_par(struct fb_info *info)
 	return 0;
 }
 
-
-
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 static int imxfb_bl_get_brightness(struct backlight_device *bl)
 {
 	struct imxfb_info *fbi = bl_get_data(bl);
@@ -516,6 +517,7 @@ static void imxfb_exit_backlight(struct imxfb_info *fbi)
 	if (fbi->bl)
 		backlight_device_unregister(fbi->bl);
 }
+#endif
 
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
@@ -647,6 +649,9 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 			fbi->regs + LCDC_SIZE);
 
 	writel(fbi->pcr, fbi->regs + LCDC_PCR);
+#ifndef CONFIG_BACKLIGHT_CLASS_DEVICE
+	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
+#endif
 	writel(fbi->lscr1, fbi->regs + LCDC_LSCR1);
 	writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
 
@@ -847,7 +852,9 @@ static int __init imxfb_probe(struct platform_device *pdev)
 
 	imxfb_enable_controller(fbi);
 	fbi->pdev = pdev;
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	imxfb_init_backlight(fbi);
+#endif
 
 	return 0;
 
@@ -885,7 +892,9 @@ static int __devexit imxfb_remove(struct platform_device *pdev)
 
 	imxfb_disable_controller(fbi);
 
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	imxfb_exit_backlight(fbi);
+#endif
 	unregister_framebuffer(info);
 
 	pdata = pdev->dev.platform_data;
-- 
1.6.3.3
