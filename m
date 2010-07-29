From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 29 Jul 2010 15:03:38 +0200
Subject: [PATCH v3] video/imxfb.c: allow usage without BACKLIGHT_CLASS_DEVICE
In-Reply-To: <20100729124534.GB6268@pengutronix.de>
References: <20100729124534.GB6268@pengutronix.de>
Message-ID: <1280408618-21364-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v3:	handle CONFIG_BACKLIGHT_CLASS_DEVICE=m & CONFIG_FB_IMX=y case as per
	suggested by Uwe
v2:	handle CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE

 drivers/video/imxfb.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 43f0639..2f9b7e3 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -40,6 +40,12 @@
  */
 #define DEBUG_VAR 1
 
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
+	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
+		defined(CONFIG_FB_IMX__MODULE))
+#define PWMR_BACKLIGHT_AVAILABLE
+#endif
+
 #define DRIVER_NAME "imx-fb"
 
 #define LCDC_SSA	0x00
@@ -175,7 +181,9 @@ struct imxfb_info {
 
 	struct imx_fb_videomode *mode;
 	int			num_modes;
+#ifdef PWMR_BACKLIGHT_AVAILABLE
 	struct backlight_device *bl;
+#endif
 
 	void (*lcd_power)(int);
 	void (*backlight_power)(int);
@@ -450,8 +458,7 @@ static int imxfb_set_par(struct fb_info *info)
 	return 0;
 }
 
-
-
+#ifdef PWMR_BACKLIGHT_AVAILABLE
 static int imxfb_bl_get_brightness(struct backlight_device *bl)
 {
 	struct imxfb_info *fbi = bl_get_data(bl);
@@ -516,6 +523,7 @@ static void imxfb_exit_backlight(struct imxfb_info *fbi)
 	if (fbi->bl)
 		backlight_device_unregister(fbi->bl);
 }
+#endif
 
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
@@ -647,6 +655,9 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 			fbi->regs + LCDC_SIZE);
 
 	writel(fbi->pcr, fbi->regs + LCDC_PCR);
+#ifndef PWMR_BACKLIGHT_AVAILABLE
+	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
+#endif
 	writel(fbi->lscr1, fbi->regs + LCDC_LSCR1);
 	writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
 
@@ -847,7 +858,9 @@ static int __init imxfb_probe(struct platform_device *pdev)
 
 	imxfb_enable_controller(fbi);
 	fbi->pdev = pdev;
+#ifdef PWMR_BACKLIGHT_AVAILABLE
 	imxfb_init_backlight(fbi);
+#endif
 
 	return 0;
 
@@ -885,7 +898,9 @@ static int __devexit imxfb_remove(struct platform_device *pdev)
 
 	imxfb_disable_controller(fbi);
 
+#ifdef PWMR_BACKLIGHT_AVAILABLE
 	imxfb_exit_backlight(fbi);
+#endif
 	unregister_framebuffer(info);
 
 	pdata = pdev->dev.platform_data;
-- 
1.6.3.3
