From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:13 +0200
Subject: [PATCH 06/23] drm/sun4i: tcon: Don't rely on encoders to set the TCON
 mode
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <faa3a4d511039af1d116270dfef3a8b60ca3591e.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like we did for the TCON enable and disable, for historical reasons we
used to rely on the encoders calling the TCON mode_set function, while the
CRTC has a callback for that.

Let's implement it in order to reduce the boilerplate code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c          | 10 +++++++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  |  1 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c      |  7 +-----
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c |  1 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c           | 15 +-----------
 drivers/gpu/drm/sun4i/sun4i_tcon.c          | 31 +++++++++++++++++-----
 drivers/gpu/drm/sun4i/sun4i_tcon.h          | 11 ++------
 drivers/gpu/drm/sun4i/sun4i_tv.c            |  6 +----
 8 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index e86baa3746af..5decae0069d0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -115,11 +115,21 @@ static void sun4i_crtc_atomic_enable(struct drm_crtc *crtc,
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
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
 	.atomic_begin	= sun4i_crtc_atomic_begin,
 	.atomic_flush	= sun4i_crtc_atomic_flush,
 	.atomic_enable	= sun4i_crtc_atomic_enable,
 	.atomic_disable	= sun4i_crtc_atomic_disable,
+	.mode_set_nofb	= sun4i_crtc_mode_set_nofb,
 };
 
 static int sun4i_crtc_enable_vblank(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
index 04f85b1cf922..e826da34e919 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
@@ -13,7 +13,6 @@
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 
-#include "sun4i_tcon.h"
 #include "sun4i_hdmi.h"
 
 struct sun4i_ddc {
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 482bf03d55c1..d2eb0a60e568 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -30,7 +30,6 @@
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
 #include "sun4i_hdmi.h"
-#include "sun4i_tcon.h"
 
 static inline struct sun4i_hdmi *
 drm_encoder_to_sun4i_hdmi(struct drm_encoder *encoder)
@@ -120,15 +119,9 @@ static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
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
index 1b6b37aefc38..dc332ea56f6c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -12,7 +12,6 @@
 
 #include <linux/clk-provider.h>
 
-#include "sun4i_tcon.h"
 #include "sun4i_hdmi.h"
 
 struct sun4i_tmds {
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index a7f297ed40c1..832f8f9bc47f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -153,22 +153,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
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
index 964cf22a1ced..7ecd4f7c8411 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -139,7 +139,6 @@ void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 	DRM_DEBUG_DRIVER("Muxing encoder %s to CRTC %s: %d\n",
 			 encoder->name, encoder->crtc->name, ret);
 }
-EXPORT_SYMBOL(sun4i_tcon_set_mux);
 
 static int sun4i_tcon_get_clk_delay(const struct drm_display_mode *mode,
 				    int channel)
@@ -159,8 +158,8 @@ static int sun4i_tcon_get_clk_delay(const struct drm_display_mode *mode,
 	return delay;
 }
 
-void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode)
+static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
+				 struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
@@ -233,10 +232,9 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 	/* Enable the output on the pins */
 	regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0);
 }
-EXPORT_SYMBOL(sun4i_tcon0_mode_set);
 
-void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
-			  struct drm_display_mode *mode)
+static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
+				 const struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync, vtotal;
 	u8 clk_delay;
@@ -324,7 +322,26 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
 			   SUN4I_TCON_GCTL_IOMAP_TCON1);
 }
-EXPORT_SYMBOL(sun4i_tcon1_mode_set);
+
+void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
+			 const struct drm_encoder *encoder,
+			 const struct drm_display_mode *mode)
+{
+	switch (encoder->encoder_type) {
+	case DRM_MODE_ENCODER_NONE:
+		sun4i_tcon0_mode_set(tcon, mode);
+		sun4i_tcon_set_mux(tcon, 0, encoder);
+		break;
+	case DRM_MODE_ENCODER_TVDAC:
+	case DRM_MODE_ENCODER_TMDS:
+		sun4i_tcon1_mode_set(tcon, mode);
+		sun4i_tcon_set_mux(tcon, 1, encoder);
+		break;
+	default:
+		DRM_DEBUG_DRIVER("Unknown encoder type, doing nothing...\n");
+	}
+}
+EXPORT_SYMBOL(sun4i_tcon_mode_set);
 
 static void sun4i_tcon_finish_page_flip(struct drm_device *dev,
 					struct sun4i_crtc *scrtc)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 03f983927baa..f61bf6d83b4a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -191,15 +191,10 @@ struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
+void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
+			 const struct drm_encoder *encoder,
+			 const struct drm_display_mode *mode);
 void sun4i_tcon_set_status(struct sun4i_tcon *crtc,
 			   const struct drm_encoder *encoder, bool enable);
 
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
index 2e27ff9fc58f..b070d522ed8d 100644
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
