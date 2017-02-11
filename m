From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:44:04 +0200
Subject: [PATCH 7/8] drm/sun4i: Add various bits and pieces to enable LVDS
 support on sun4i
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-8-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TODO: We still rely on u-boot for lvds reset bit setup :(

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 29 ++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 54 ++++++++++++++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 15 +++++++++++
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index 2ba4705..de738e5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -114,6 +114,35 @@ static void sun4i_lvds_encoder_enable(struct drm_encoder *encoder)
 	/* encoder->bridge can be NULL; drm_bridge_enable checks for it */
 	drm_bridge_enable(encoder->bridge);
 
+	/* Enable the LVDS */
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
+			   SUN4I_TCON0_LVDS_IF_ENABLE,
+			   SUN4I_TCON0_LVDS_IF_ENABLE);
+
+	/*
+	 * TODO: SUN4I_TCON0_LVDS_ANA0_REG_C and SUN4I_TCON0_LVDS_ANA0_PD
+	 * registers span 3 bits, but we only set upper 2 for both
+	 * of them based on values taken from Allwinner driver.
+	 */
+	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+		     SUN4I_TCON0_LVDS_ANA0_CK_EN |
+		     SUN4I_TCON0_LVDS_ANA0_REG_V |
+		     SUN4I_TCON0_LVDS_ANA0_REG_C |
+		     SUN4I_TCON0_LVDS_ANA0_EN_MB |
+		     SUN4I_TCON0_LVDS_ANA0_PD |
+		     SUN4I_TCON0_LVDS_ANA0_DCHS);
+
+	udelay(2000);
+
+	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA1_REG,
+		     SUN4I_TCON0_LVDS_ANA1_INIT);
+
+	udelay(1000);
+
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA1_REG,
+			   SUN4I_TCON0_LVDS_ANA1_UPDATE,
+		           SUN4I_TCON0_LVDS_ANA1_UPDATE);
+
 	sun4i_tcon_channel_enable(tcon, 0);
 }
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 71d0087..468a3ce 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -18,6 +18,7 @@
 #include <drm/drm_panel.h>
 
 #include <linux/component.h>
+#include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -29,6 +30,7 @@
 #include "sun4i_crtc.h"
 #include "sun4i_dotclock.h"
 #include "sun4i_drv.h"
+#include "sun4i_lvds.h"
 #include "sun4i_rgb.h"
 #include "sun4i_tcon.h"
 
@@ -169,12 +171,29 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 		     SUN4I_TCON0_BASIC2_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
-	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
-	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
-	DRM_DEBUG_DRIVER("Setting HSYNC %d, VSYNC %d\n", hsync, vsync);
-	regmap_write(tcon->regs, SUN4I_TCON0_BASIC3_REG,
-		     SUN4I_TCON0_BASIC3_V_SYNC(vsync) |
-		     SUN4I_TCON0_BASIC3_H_SYNC(hsync));
+	if (type != DRM_MODE_ENCODER_LVDS) {
+		// Not needed for LVDS?
+		hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+		vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+		DRM_DEBUG_DRIVER("Setting HSYNC %d, VSYNC %d\n", hsync, vsync);
+		regmap_write(tcon->regs, SUN4I_TCON0_BASIC3_REG,
+			     SUN4I_TCON0_BASIC3_V_SYNC(vsync) |
+			     SUN4I_TCON0_BASIC3_H_SYNC(hsync));
+	}
+
+	if (type == DRM_MODE_ENCODER_LVDS) {
+		/* Setup bit depth */
+		/* TODO: Figure out where to get display bit depth
+		 * val = (1: 18-bit, 0: 24-bit)
+		 * TODO: Should we set more registers:
+		 * BIT(28) - LVDS_DIRECTION
+		 * BIT(27) - LVDS_MODE
+		 * BIT(23) - LVDS_CORRECT_MODE
+		 */
+		regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
+				   SUN4I_TCON0_LVDS_IF_BITWIDTH,
+				   SUN4I_TCON0_LVDS_IF_BITWIDTH);
+	}
 
 	/* Setup the polarity of the various signals */
 	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
@@ -183,8 +202,15 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+
+	/* Set proper DCLK phase value */
+	if (type == DRM_MODE_ENCODER_LVDS)
+		val |= SUN4I_TCON0_IO_POL_DCLK_PHASE(1);
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DCLK_PHASE_MASK,
 			   val);
 
 	/* Map output pins to channel 0 */
@@ -480,6 +506,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
+	const char *mode;
 	int ret;
 
 	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
@@ -525,7 +552,18 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	ret = sun4i_rgb_init(drm);
+	/* Check which output mode is set, defaulting to RGB */
+	ret = of_property_read_string(dev->of_node, "mode", &mode);
+
+	if (ret || !strcmp(mode, "rgb"))
+		ret = sun4i_rgb_init(drm);
+	else if (!strcmp(mode, "lvds"))
+		ret = sun4i_lvds_init(drm);
+	else {
+		dev_err(dev, "Unknown TCON mode: %s\n", mode);
+		ret = -1;
+	}
+
 	if (ret < 0)
 		goto err_free_clocks;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index b040e10..dc4e350 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -69,8 +69,11 @@
 #define SUN4I_TCON0_TTL3_REG			0x7c
 #define SUN4I_TCON0_TTL4_REG			0x80
 #define SUN4I_TCON0_LVDS_IF_REG			0x84
+#define SUN4I_TCON0_LVDS_IF_ENABLE			BIT(31)
+#define SUN4I_TCON0_LVDS_IF_BITWIDTH			BIT(26)
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
+#define SUN4I_TCON0_IO_POL_DCLK_PHASE_MASK		(3 << 28)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
@@ -128,6 +131,18 @@
 #define SUN4I_TCON_CEU_RANGE_G_REG		0x144
 #define SUN4I_TCON_CEU_RANGE_B_REG		0x148
 #define SUN4I_TCON_MUX_CTRL_REG			0x200
+#define SUN4I_TCON0_LVDS_ANA0_REG		0x220
+#define SUN4I_TCON0_LVDS_ANA0_CK_EN			BIT(29) | BIT(28)
+#define SUN4I_TCON0_LVDS_ANA0_REG_V			BIT(27) | BIT(26)
+/* TODO: BIT(23) also belongs to ANA0_REG_C register set */
+#define SUN4I_TCON0_LVDS_ANA0_REG_C			BIT(25) | BIT(24)
+#define SUN4I_TCON0_LVDS_ANA0_EN_MB			BIT(22)
+/* TODO: BIT(19) also belongs to ANA0_PD register set */
+#define SUN4I_TCON0_LVDS_ANA0_PD			BIT(21) | BIT(20)
+#define SUN4I_TCON0_LVDS_ANA0_DCHS			BIT(16)
+#define SUN4I_TCON0_LVDS_ANA1_REG		0x224
+#define SUN4I_TCON0_LVDS_ANA1_INIT			(0x1f << 26 | 0x1f << 10)
+#define SUN4I_TCON0_LVDS_ANA1_UPDATE			(0x1f << 16 | 0x1f << 00)
 #define SUN4I_TCON1_FILL_CTL_REG		0x300
 #define SUN4I_TCON1_FILL_BEG0_REG		0x304
 #define SUN4I_TCON1_FILL_END0_REG		0x308
-- 
2.9.3
