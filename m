From: net147@gmail.com (Jonathan Liu)
Date: Tue, 17 Oct 2017 22:09:46 +1100
Subject: [PATCH] drm/sun4i: tcon: Add dithering support for RGB565/RGB666 LCD
 panels
Message-ID: <20171017110946.18961-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dithering is supported on TCON channel 0 which is used for LCD panels.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 18 +++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 68751b999877..cf313ca858b3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -12,11 +12,13 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -168,7 +170,9 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 			  struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
+	u32 bus_format = 0;
 	u8 clk_delay;
+	struct drm_connector *connector = tcon->panel->connector;
 	u32 val = 0;
 
 	/* Configure the dot clock */
@@ -230,6 +234,39 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
 
+	if (connector->display_info.num_bus_formats)
+		bus_format = connector->display_info.bus_formats[0];
+
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_RGB565_1X16:
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		/* Enable dithering */
+		/* FIXME: Undocumented bits */
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED0_REG, 0x11111111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED1_REG, 0x11111111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED2_REG, 0x11111111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED3_REG, 0x11111111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED4_REG, 0x11111111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED5_REG, 0x11111111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB0_REG, 0x01010000);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB1_REG, 0x15151111);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB2_REG, 0x57575555);
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB3_REG, 0x7f7f7777);
+		val = SUN4I_TCON0_FRM_CTL_ENABLE;
+
+		if (bus_format == MEDIA_BUS_FMT_RGB565_1X16) {
+			val |= SUN4I_TCON0_FRM_CTL_MODE_R;
+			val |= SUN4I_TCON0_FRM_CTL_MODE_B;
+		}
+
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_CTL_REG, val);
+		break;
+	default:
+		/* Disable dithering */
+		regmap_write(tcon->regs, SUN4I_TCON0_FRM_CTL_REG, 0);
+		break;
+	}
+
 	/* Map output pins to channel 0 */
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index d9e1357cc8ae..d64d45144c91 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -31,7 +31,23 @@
 #define SUN4I_TCON_GINT0_VBLANK_INT(pipe)		BIT(15 - (pipe))
 
 #define SUN4I_TCON_GINT1_REG			0x8
-#define SUN4I_TCON_FRM_CTL_REG			0x10
+
+#define SUN4I_TCON0_FRM_CTL_REG			0x10
+#define SUN4I_TCON0_FRM_CTL_ENABLE			BIT(31)
+#define SUN4I_TCON0_FRM_CTL_MODE_R			BIT(6)
+#define SUN4I_TCON0_FRM_CTL_MODE_G			BIT(5)
+#define SUN4I_TCON0_FRM_CTL_MODE_B			BIT(4)
+
+#define SUN4I_TCON0_FRM_SEED0_REG		0x14
+#define SUN4I_TCON0_FRM_SEED1_REG		0x18
+#define SUN4I_TCON0_FRM_SEED2_REG		0x1c
+#define SUN4I_TCON0_FRM_SEED3_REG		0x20
+#define SUN4I_TCON0_FRM_SEED4_REG		0x24
+#define SUN4I_TCON0_FRM_SEED5_REG		0x28
+#define SUN4I_TCON0_FRM_TAB0_REG		0x2c
+#define SUN4I_TCON0_FRM_TAB1_REG		0x30
+#define SUN4I_TCON0_FRM_TAB2_REG		0x34
+#define SUN4I_TCON0_FRM_TAB3_REG		0x38
 
 #define SUN4I_TCON0_CTL_REG			0x40
 #define SUN4I_TCON0_CTL_TCON_ENABLE			BIT(31)
-- 
2.14.2
