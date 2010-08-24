From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 24 Aug 2010 17:27:02 +0200
Subject: [PATCH 1/2] Separate display's pixel configuration from video mode
In-Reply-To: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282643200-13332-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1282663623-8404-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

Currently the pixel mapping to the display depends on the video mode. This
seems not true as the IPU transfers the data read from the video memory in an
internal 32 bit bus to the DI unit. The DI mapping only depends on the settings
the IPU should read the data from video memory. If all these settings do it in
the same byte order, only one DI mapping per display is required.

There are three locations where we can mix the colour components:
 - in the video mode description, colour offsets
 - in the IPU while reading pixel data from memory
 - in the DI unit while mapping it to the connected display

If one of these settings are incorrect, the displayed colours are broken.

With this patch the platform describes the display connection and the driver
uses this information independently from the selected video mode.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx3fb.h |    5 +++
 drivers/video/mx3fb.c                  |   62 +++++++++++++-------------------
 2 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx3fb.h b/arch/arm/plat-mxc/include/mach/mx3fb.h
index ac24c5c..93bd032 100644
--- a/arch/arm/plat-mxc/include/mach/mx3fb.h
+++ b/arch/arm/plat-mxc/include/mach/mx3fb.h
@@ -33,6 +33,11 @@ struct mx3fb_platform_data {
 	const char			*name;
 	const struct fb_videomode	*mode;
 	int				num_modes;
+
+	/* display's mapping description */
+	struct fb_bitfield red;
+	struct fb_bitfield green;
+	struct fb_bitfield blue;
 };
 
 #endif
diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 658f10a..c335a72 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -286,13 +286,6 @@ static void mx3fb_write_reg(struct mx3fb_data *mx3fb, u32 value, unsigned long r
 	__raw_writel(value, mx3fb->reg_base + reg);
 }
 
-static const uint32_t di_mappings[] = {
-	0x1600AAAA, 0x00E05555, 0x00070000, 3,	/* RGB888 */
-	0x0005000F, 0x000B000F, 0x0011000F, 1,	/* RGB666 */
-	0x0011000F, 0x000B000F, 0x0005000F, 1,	/* BGR666 */
-	0x0004003F, 0x000A000F, 0x000F003F, 1	/* RGB565 */
-};
-
 static void sdc_fb_init(struct mx3fb_info *fbi)
 {
 	struct mx3fb_data *mx3fb = fbi->mx3fb;
@@ -450,6 +443,9 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 	uint32_t div;
 	struct clk *ipu_clk;
 
+	struct device *dev = mx3fb->dev;
+	struct mx3fb_platform_data *mx3fb_pdata = dev->platform_data;
+
 	dev_dbg(mx3fb->dev, "panel size = %d x %d", width, height);
 
 	if (v_sync_width == 0 || h_sync_width == 0)
@@ -536,36 +532,28 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
 		sig.Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
 	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_SIG_POL);
 
-	switch (pixel_fmt) {
-	case IPU_PIX_FMT_RGB24:
-		mx3fb_write_reg(mx3fb, di_mappings[0], DI_DISP3_B0_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[1], DI_DISP3_B1_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[2], DI_DISP3_B2_MAP);
-		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
-			     ((di_mappings[3] - 1) << 12), DI_DISP_ACC_CC);
-		break;
-	case IPU_PIX_FMT_RGB666:
-		mx3fb_write_reg(mx3fb, di_mappings[4], DI_DISP3_B0_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[5], DI_DISP3_B1_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[6], DI_DISP3_B2_MAP);
-		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
-			     ((di_mappings[7] - 1) << 12), DI_DISP_ACC_CC);
-		break;
-	case IPU_PIX_FMT_BGR666:
-		mx3fb_write_reg(mx3fb, di_mappings[8], DI_DISP3_B0_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[9], DI_DISP3_B1_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[10], DI_DISP3_B2_MAP);
-		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
-			     ((di_mappings[11] - 1) << 12), DI_DISP_ACC_CC);
-		break;
-	default:
-		mx3fb_write_reg(mx3fb, di_mappings[12], DI_DISP3_B0_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[13], DI_DISP3_B1_MAP);
-		mx3fb_write_reg(mx3fb, di_mappings[14], DI_DISP3_B2_MAP);
-		mx3fb_write_reg(mx3fb, mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) |
-			     ((di_mappings[15] - 1) << 12), DI_DISP_ACC_CC);
-		break;
-	}
+	/* setup the pixel mapping to the display. This seems independent
+	 * from the internal video mode in use
+	 */
+	reg = 0xffff & ~(((1 << (mx3fb_pdata->blue.length * 2)) - 1) << (16 - (mx3fb_pdata->blue.length * 2)));
+	reg |= ((mx3fb_pdata->blue.offset + mx3fb_pdata->blue.length - 1)) << 16;
+	pr_debug("b: %d %d 0x%08x\n", mx3fb_pdata->blue.offset, mx3fb_pdata->blue.length, reg);
+	mx3fb_write_reg(mx3fb, reg, DI_DISP3_B0_MAP); /* blue */
+
+	reg = 0xffff & ~(((1 << (mx3fb_pdata->green.length * 2)) - 1) << (16 - (mx3fb_pdata->green.length * 2)));
+	reg |= ((mx3fb_pdata->green.offset + mx3fb_pdata->green.length - 1)) << 16;
+	pr_debug("g: %d %d 0x%08x\n", mx3fb_pdata->green.offset, mx3fb_pdata->green.length, reg);
+	mx3fb_write_reg(mx3fb, reg, DI_DISP3_B1_MAP); /* green */
+
+	reg = 0xffff & ~(((1 << (mx3fb_pdata->red.length * 2)) - 1) << (16 - (mx3fb_pdata->red.length * 2)));
+	reg |= ((mx3fb_pdata->red.offset + mx3fb_pdata->red.length - 1)) << 16;
+	pr_debug("r: %d %d 0x%08x\n", mx3fb_pdata->red.offset, mx3fb_pdata->red.length, reg);
+	mx3fb_write_reg(mx3fb, reg, DI_DISP3_B2_MAP); /* red */
+
+	/* the TFT displays expecting one pixel per clock */
+	reg = mx3fb_read_reg(mx3fb, DI_DISP_ACC_CC) & ~(3 << 12);
+	reg |= 0 << 12;	/* 0 means one clock */
+	mx3fb_write_reg(mx3fb, reg, DI_DISP_ACC_CC);
 
 	spin_unlock_irqrestore(&mx3fb->lock, lock_flags);
 
-- 
1.7.1
