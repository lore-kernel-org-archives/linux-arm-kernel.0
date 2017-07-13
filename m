From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:13:02 +0200
Subject: [PATCH 07/18] drm/sun4i: tcon: Don't rely on encoders to set the TCON
 mode
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <31e3fd8540d85c8f4637af1083c5c2a436403cd2.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like we did for the TCON enable and disable, for historical reasons we
used to rely on the encoders calling the TCON mode_set function, while the
CRTC has a callback for that.

Let's implement it in order to reduce the boilerplate code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c          | 11 ++++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  |  1 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c      |  7 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c |  1 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c           | 15 +------
 drivers/gpu/drm/sun4i/sun4i_tcon.c          | 56 ++++++++++------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h          | 10 +----
 drivers/gpu/drm/sun4i/sun4i_tv.c            |  6 +--
 8 files changed, 40 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 30c7568dde5c..886595f579ab 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -113,11 +113,22 @@ static void sun4i_crtc_enable(struct drm_crtc *crtc)
 	sun4i_tcon_set_status(scrtc->tcon, encoder, true);
 }
 
+static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
+{
+	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
+	struct drm_encoder *encoder = sun4i_crtc_get_encoder(crtc);
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+
+	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
+}
+
+
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
 	.atomic_begin	= sun4i_crtc_atomic_begin,
 	.atomic_flush	= sun4i_crtc_atomic_flush,
 	.disable	= sun4i_crtc_disable,
 	.enable		= sun4i_crtc_enable,
+	.mode_set_nofb	= sun4i_crtc_mode_set_nofb,
 };
 
 static int sun4i_crtc_enable_vblank(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index 4692e8c345ed..7348bdbaa803 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -12,7 +12,6 @@
 
 #include <linux/clk-provider.h>
 
-#include "sun4i_tcon.h"
 #include "sun4i_hdmi.h"
 
 struct sun4i_ddc {
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 06af2f6d0b31..67ef8acdb439 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -27,7 +27,6 @@
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_hdmi.h"
-#include "sun4i_tcon.h"
 
 #define DDC_SEGMENT_ADDR	0x30
 
@@ -119,15 +118,9 @@ static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *adjusted_mode)
 {
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
-	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
-	struct sun4i_tcon *tcon = crtc->tcon;
 	unsigned int x, y;
 	u32 val;
 
-	sun4i_tcon1_mode_set(tcon, mode);
-	sun4i_tcon_set_mux(tcon, 1, encoder);
-
-	clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
 	clk_set_rate(hdmi->mod_clk, mode->crtc_clock * 1000);
 	clk_set_rate(hdmi->tmds_clk, mode->crtc_clock * 1000);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 5cf2527bffc8..5b6727623037 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -12,7 +12,6 @@
 
 #include <linux/clk-provider.h>
 
-#include "sun4i_tcon.h"
 #include "sun4i_hdmi.h"
 
 struct sun4i_tmds {
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index ecce1f5b50ab..9061e16e3088 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -154,22 +154,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
-static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
-				       struct drm_display_mode *mode,
-				       struct drm_display_mode *adjusted_mode)
-{
-	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
-	struct sun4i_tcon *tcon = rgb->tcon;
-
-	sun4i_tcon0_mode_set(tcon, mode);
-	sun4i_tcon_set_mux(tcon, 0, encoder);
-
-	/* FIXME: This seems to be board specific */
-	clk_set_phase(tcon->dclk, 120);
-}
-
 static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
-	.mode_set	= sun4i_rgb_encoder_mode_set,
 	.disable	= sun4i_rgb_encoder_disable,
 	.enable		= sun4i_rgb_encoder_enable,
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index dc70bc2a42a5..c4407910dfaf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -106,29 +106,6 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
 }
 EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
 
-void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
-			struct drm_encoder *encoder)
-{
-	u32 val;
-
-	if (!tcon->quirks->has_unknown_mux)
-		return;
-
-	if (channel != 1)
-		return;
-
-	if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
-		val = 1;
-	else
-		val = 0;
-
-	/*
-	 * FIXME: Undocumented bits
-	 */
-	regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
-}
-EXPORT_SYMBOL(sun4i_tcon_set_mux);
-
 static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
 				    int channel)
 {
@@ -147,8 +124,8 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
 	return delay;
 }
 
-void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode)
+static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
+				 struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
@@ -221,10 +198,9 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 	/* Enable the output on the pins */
 	regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0);
 }
-EXPORT_SYMBOL(sun4i_tcon0_mode_set);
 
-void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode)
+static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
+				 struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync, vtotal;
 	u8 clk_delay;
@@ -312,7 +288,29 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
 			   SUN4I_TCON_GCTL_IOMAP_TCON1);
 }
-EXPORT_SYMBOL(sun4i_tcon1_mode_set);
+
+void sun4i_tcon_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
+			 struct drm_display_mode *mode)
+{
+	switch (encoder->encoder_type) {
+	case DRM_MODE_ENCODER_NONE:
+		sun4i_tcon0_mode_set(tcon, mode);
+		break;
+	case DRM_MODE_ENCODER_TVDAC:
+		/*
+		 * FIXME: Undocumented bits
+		 */
+		if (tcon->quirks->has_unknown_mux)
+			regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
+		/* Fallthrough */
+	case DRM_MODE_ENCODER_TMDS:
+		sun4i_tcon1_mode_set(tcon, mode);
+		break;
+	default:
+		DRM_DEBUG_DRIVER("Unknown encoder type, doing nothing...\n");
+	}
+}
+EXPORT_SYMBOL(sun4i_tcon_mode_set);
 
 static void sun4i_tcon_finish_page_flip(struct drm_device *dev,
 					struct sun4i_crtc *scrtc)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 824732c90a2a..a318e5ccb612 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -184,15 +184,9 @@ struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
+void sun4i_tcon_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
+			 struct drm_display_mode *mode);
 void sun4i_tcon_set_status(struct sun4i_tcon *crtc, struct drm_encoder *encoder,
 			   bool enable);
 
-/* Mode Related Controls */
-void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
-			struct drm_encoder *encoder);
-void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode);
-void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode);
-
 #endif /* __SUN4I_TCON_H__ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 78d6cf77fdd3..69b9f8d98a13 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -24,7 +24,6 @@
 
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
-#include "sun4i_tcon.h"
 #include "sunxi_engine.h"
 
 #define SUN4I_TVE_EN_REG		0x000
@@ -374,13 +373,8 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 			      struct drm_display_mode *adjusted_mode)
 {
 	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
-	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
-	struct sun4i_tcon *tcon = crtc->tcon;
 	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
 
-	sun4i_tcon1_mode_set(tcon, mode);
-	sun4i_tcon_set_mux(tcon, 1, encoder);
-
 	/* Enable and map the DAC to the output */
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
 			   SUN4I_TVE_EN_DAC_MAP_MASK,
-- 
git-series 0.9.1
