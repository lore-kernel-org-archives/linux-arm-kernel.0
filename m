From: marex@denx.de (Marek Vasut)
Date: Sat, 16 Mar 2013 23:06:21 +0100
Subject: =?UTF-8?q?=5BPATCH=5D=20ARM=3A=20video=3A=20mxs=3A=20Fix=20mxsfb=20misconfiguring=20VDCTRL0?=
In-Reply-To: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
Message-ID: <1363471581-10132-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issue fixed by this patch manifests only then using X11
with mxsfb driver. The X11 will display either shifted image
or otherwise distorted image on the LCD.

The problem is that the X11 tries to reconfigure the framebuffer
and along the way call fb_ops.fb_set_par() with it's configuration
values. The field of particular interest is fb_info->var.sync which
contains non-standard values if configured by kernel. These are
FB_SYNC_DATA_ENABLE_HIGH_ACT and FB_SYNC_DOTCLK_FAILING_ACT defined
in include/linux/mxsfb.h . The driver interprets those and configures
the LCD controller accordingly. Yet X11 only has access to standard
values for this field defined in include/uapi/linux/fb.h and thus
omits these special values. This results in distorted image on the
LCD.

This patch moves these non-standard values into new field of the
mxsfb_platform_data structure so the driver can in turn check this
field instead of the video mode field for these specific portions.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estavem@freescale.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
Cc: Lothar Wa?mann <LW@karo-electronics.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |   22 +++++++++++-----------
 drivers/video/mxsfb.c        |    7 +++++--
 include/linux/mxsfb.h        |    7 +++++--
 3 files changed, 21 insertions(+), 15 deletions(-)

NOTE: We ought to get rid of this platform data goo, but we can't do
      it in here. This is a bugfix.

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index c66129b..ebf592c 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -41,8 +41,6 @@ static struct fb_videomode mx23evk_video_modes[] = {
 		.lower_margin	= 4,
 		.hsync_len	= 1,
 		.vsync_len	= 1,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
 	},
 };
 
@@ -59,8 +57,6 @@ static struct fb_videomode mx28evk_video_modes[] = {
 		.lower_margin	= 10,
 		.hsync_len	= 10,
 		.vsync_len	= 10,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
 	},
 };
 
@@ -77,7 +73,6 @@ static struct fb_videomode m28evk_video_modes[] = {
 		.lower_margin	= 45,
 		.hsync_len	= 1,
 		.vsync_len	= 1,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT,
 	},
 };
 
@@ -94,9 +89,7 @@ static struct fb_videomode apx4devkit_video_modes[] = {
 		.lower_margin	= 13,
 		.hsync_len	= 48,
 		.vsync_len	= 3,
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
-				  FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 };
 
@@ -113,9 +106,7 @@ static struct fb_videomode apf28dev_video_modes[] = {
 		.lower_margin = 0x15,
 		.hsync_len = 64,
 		.vsync_len = 4,
-		.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
-				FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				FB_SYNC_DOTCLK_FAILING_ACT,
+		.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 };
 
@@ -250,6 +241,8 @@ static void __init imx23_evk_init(void)
 	mxsfb_pdata.mode_count = ARRAY_SIZE(mx23evk_video_modes);
 	mxsfb_pdata.default_bpp = 32;
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
+	mxsfb_pdata.sync = MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 }
 
 static inline void enable_clk_enet_out(void)
@@ -269,6 +262,8 @@ static void __init imx28_evk_init(void)
 	mxsfb_pdata.mode_count = ARRAY_SIZE(mx28evk_video_modes);
 	mxsfb_pdata.default_bpp = 32;
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
+	mxsfb_pdata.sync = MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 
 	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
@@ -288,6 +283,7 @@ static void __init m28evk_init(void)
 	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
 	mxsfb_pdata.default_bpp = 16;
 	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
+	mxsfb_pdata.sync = MXSFB_SYNC_DATA_ENABLE_HIGH_ACT;
 }
 
 static void __init sc_sps1_init(void)
@@ -313,6 +309,8 @@ static void __init apx4devkit_init(void)
 	mxsfb_pdata.mode_count = ARRAY_SIZE(apx4devkit_video_modes);
 	mxsfb_pdata.default_bpp = 32;
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
+	mxsfb_pdata.sync = MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 }
 
 #define ENET0_MDC__GPIO_4_0	MXS_GPIO_NR(4, 0)
@@ -403,6 +401,8 @@ static void __init apf28_init(void)
 	mxsfb_pdata.mode_count = ARRAY_SIZE(apf28dev_video_modes);
 	mxsfb_pdata.default_bpp = 16;
 	mxsfb_pdata.ld_intf_width = STMLCDIF_16BIT;
+	mxsfb_pdata.sync = MXSFB_SYNC_DATA_ENABLE_HIGH_ACT |
+				MXSFB_SYNC_DOTCLK_FAILING_ACT;
 }
 
 static void __init mxs_machine_init(void)
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 755556c..45169cb 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -169,6 +169,7 @@ struct mxsfb_info {
 	unsigned dotclk_delay;
 	const struct mxsfb_devdata *devdata;
 	int mapped;
+	u32 sync;
 };
 
 #define mxsfb_is_v3(host) (host->devdata->ipversion == 3)
@@ -456,9 +457,9 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 		vdctrl0 |= VDCTRL0_HSYNC_ACT_HIGH;
 	if (fb_info->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		vdctrl0 |= VDCTRL0_VSYNC_ACT_HIGH;
-	if (fb_info->var.sync & FB_SYNC_DATA_ENABLE_HIGH_ACT)
+	if (host->sync & MXSFB_SYNC_DATA_ENABLE_HIGH_ACT)
 		vdctrl0 |= VDCTRL0_ENABLE_ACT_HIGH;
-	if (fb_info->var.sync & FB_SYNC_DOTCLK_FAILING_ACT)
+	if (host->sync & MXSFB_SYNC_DOTCLK_FAILING_ACT)
 		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FAILING;
 
 	writel(vdctrl0, host->base + LCDC_VDCTRL0);
@@ -861,6 +862,8 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&fb_info->modelist);
 
+	host->sync = pdata->sync;
+
 	ret = mxsfb_init_fbinfo(host);
 	if (ret != 0)
 		goto error_init_fb;
diff --git a/include/linux/mxsfb.h b/include/linux/mxsfb.h
index f14943d..f80af86 100644
--- a/include/linux/mxsfb.h
+++ b/include/linux/mxsfb.h
@@ -24,8 +24,8 @@
 #define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit width */
 #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
 
-#define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
+#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
+#define MXSFB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
 
 struct mxsfb_platform_data {
 	struct fb_videomode *mode_list;
@@ -44,6 +44,9 @@ struct mxsfb_platform_data {
 				 * allocated. If specified,fb_size must also be specified.
 				 * fb_phys must be unused by Linux.
 				 */
+	u32 sync;		/* sync mask, contains MXSFB specifics not
+				 * carried in fb_info->var.sync
+				 */
 };
 
 #endif /* __LINUX_MXSFB_H */
-- 
1.7.10.4
