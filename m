From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 16 Jul 2010 15:09:07 +0200
Subject: [PATCH 3/3] imxfb: add pwmr controlled backlight support
In-Reply-To: <1279285747-7860-2-git-send-email-eric@eukrea.com>
References: <1279285747-7860-1-git-send-email-eric@eukrea.com>
	<1279285747-7860-2-git-send-email-eric@eukrea.com>
Message-ID: <1279285747-7860-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : updated to use backlight infrastructure

 drivers/video/imxfb.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index b4b6dec..43f0639 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -175,6 +175,7 @@ struct imxfb_info {
 
 	struct imx_fb_videomode *mode;
 	int			num_modes;
+	struct backlight_device *bl;
 
 	void (*lcd_power)(int);
 	void (*backlight_power)(int);
@@ -449,6 +450,73 @@ static int imxfb_set_par(struct fb_info *info)
 	return 0;
 }
 
+
+
+static int imxfb_bl_get_brightness(struct backlight_device *bl)
+{
+	struct imxfb_info *fbi = bl_get_data(bl);
+
+	return readl(fbi->regs + LCDC_PWMR) & 0xFF;
+}
+
+static int imxfb_bl_update_status(struct backlight_device *bl)
+{
+	struct imxfb_info *fbi = bl_get_data(bl);
+	int brightness = bl->props.brightness;
+
+	if (bl->props.power != FB_BLANK_UNBLANK)
+		brightness = 0;
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
+		brightness = 0;
+
+	fbi->pwmr = (fbi->pwmr & ~0xFF) | brightness;
+
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
+		clk_enable(fbi->clk);
+	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
+	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
+		clk_disable(fbi->clk);
+
+	return 0;
+}
+
+static const struct backlight_ops imxfb_lcdc_bl_ops = {
+	.update_status = imxfb_bl_update_status,
+	.get_brightness = imxfb_bl_get_brightness,
+};
+
+static void imxfb_init_backlight(struct imxfb_info *fbi)
+{
+	struct backlight_properties props;
+	struct backlight_device	*bl;
+
+	if (fbi->bl)
+		return;
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.max_brightness = 0xff;
+	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
+
+	bl = backlight_device_register("imxfb-bl", &fbi->pdev->dev, fbi,
+				       &imxfb_lcdc_bl_ops, &props);
+	if (IS_ERR(bl)) {
+		dev_err(&fbi->pdev->dev, "error %ld on backlight register\n",
+				PTR_ERR(bl));
+		return;
+	}
+
+	fbi->bl = bl;
+	bl->props.power = FB_BLANK_UNBLANK;
+	bl->props.fb_blank = FB_BLANK_UNBLANK;
+	bl->props.brightness = imxfb_bl_get_brightness(bl);
+}
+
+static void imxfb_exit_backlight(struct imxfb_info *fbi)
+{
+	if (fbi->bl)
+		backlight_device_unregister(fbi->bl);
+}
+
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
 	pr_debug("Enabling LCD controller\n");
@@ -579,7 +647,6 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 			fbi->regs + LCDC_SIZE);
 
 	writel(fbi->pcr, fbi->regs + LCDC_PCR);
-	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
 	writel(fbi->lscr1, fbi->regs + LCDC_LSCR1);
 	writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
 
@@ -779,6 +846,8 @@ static int __init imxfb_probe(struct platform_device *pdev)
 	}
 
 	imxfb_enable_controller(fbi);
+	fbi->pdev = pdev;
+	imxfb_init_backlight(fbi);
 
 	return 0;
 
@@ -816,6 +885,7 @@ static int __devexit imxfb_remove(struct platform_device *pdev)
 
 	imxfb_disable_controller(fbi);
 
+	imxfb_exit_backlight(fbi);
 	unregister_framebuffer(info);
 
 	pdata = pdev->dev.platform_data;
-- 
1.6.3.3
