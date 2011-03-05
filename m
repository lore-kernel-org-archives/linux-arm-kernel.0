From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:18:51 +0800
Subject: [PATCH 3/3] video: mxsfb: add DOTCLK polarity configuration support
In-Reply-To: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
References: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299341931-30241-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation provides configuration for HSYNC_POL,
VSYNC_POL and ENABLE_POL via 'sync' of fb_videomode, but DOTCLK_POL
is missing there.  It's assuming that data sampling at rising/positive
edge is always the case.  However, it's not true.  For example, the
panel on mx28evk board (Seiko 43WVF1G) samples data at
failing/negative edge.  The patch is to add this configuration.

Also, to unify the naming schema of all these polarity configurations
and match them with the bits name in Reference Manual, a couple of
definitions are renamed.

Lastly, to reduce the chance of defining customized 'FB_SYNC_' flag
by incrementing the preceeding value, the definitions are changed to
bit shifting way.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/mxsfb.h |    3 ++-
 drivers/video/mxsfb.c                  |    8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mxsfb.h b/arch/arm/mach-mxs/include/mach/mxsfb.h
index 923f397..e4d7979 100644
--- a/arch/arm/mach-mxs/include/mach/mxsfb.h
+++ b/arch/arm/mach-mxs/include/mach/mxsfb.h
@@ -24,7 +24,8 @@
 #define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit width */
 #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
 
-#define FB_SYNC_DATA_ENABLE_HIGH_ACT	64
+#define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
+#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
 
 struct mxsfb_platform_data {
 	struct fb_videomode *mode_list;
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 927a682..0555671 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -103,8 +103,8 @@
 #define VDCTRL0_ENABLE_PRESENT		(1 << 28)
 #define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
 #define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
-#define VDCTRL0_DOTCLK_ACTIVE_HIGH	(1 << 25)
-#define VDCTRL0_POL_ACTIVE_HIGH		(1 << 24)
+#define VDCTRL0_DOTCLK_ACT_FAILING	(1 << 25)
+#define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
 #define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
 #define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
 #define VDCTRL0_HALF_LINE		(1 << 19)
@@ -452,7 +452,9 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 	if (fb_info->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		vdctrl0 |= VDCTRL0_VSYNC_ACT_HIGH;
 	if (fb_info->var.sync & FB_SYNC_DATA_ENABLE_HIGH_ACT)
-		vdctrl0 |= VDCTRL0_POL_ACTIVE_HIGH;
+		vdctrl0 |= VDCTRL0_ENABLE_ACT_HIGH;
+	if (fb_info->var.sync & FB_SYNC_DOTCLK_FAILING_ACT)
+		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FAILING;
 
 	writel(vdctrl0, host->base + LCDC_VDCTRL0);
 
-- 
1.7.1
