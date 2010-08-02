From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  2 Aug 2010 09:39:55 +0200
Subject: [PATCH] video/imxfb.c: allow usage without BACKLIGHT_CLASS_DEVICE
In-Reply-To: <20100729150147.GA6331@pengutronix.de>
References: <20100729150147.GA6331@pengutronix.de>
Message-ID: <1280734795-25452-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>

This fixes the following build failure:

	drivers/built-in.o: In function `imxfb_probe': mxcmmc.c:(.init.text+0xd04): undefined reference to `backlight_device_register'
	drivers/built-in.o: In function `imxfb_remove': mxcmmc.c:(.devexit.text+0x44): undefined reference to `backlight_device_unregister'

that was introduced by

	7a2bb23 (imxfb: add pwmr controlled backlight support)

Signed-off-by: Eric B?nard <eric@eukrea.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
KernelVersion: v2.6.35-rc1-118-g7a2bb23

 drivers/video/imxfb.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 43f0639..5c363d0 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -40,6 +40,12 @@
  */
 #define DEBUG_VAR 1
 
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
+	(defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE) && \
+		defined(CONFIG_FB_IMX_MODULE))
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
1.7.1
