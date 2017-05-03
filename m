From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:47 +0200
Subject: [PATCH v2 10/20] drm/sun4i: tcon: Move the muxing out of the mode set
 function
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <ea29ffd2bc3c76203168d0fd1e969b045424b24c.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The muxing can actually happen on both channels on some SoCs, so it makes
more sense to just move it out of the sun4i_tcon1_mode_set function and
create a separate function that needs to be called by the encoders.

Let's do that and convert the existing drivers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  |  1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 drivers/gpu/drm/sun4i/sun4i_tv.c   |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 67f0b91a99de..3003d290c635 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -175,6 +175,7 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
 	struct sun4i_tcon *tcon = rgb->tcon;
 
 	sun4i_tcon0_mode_set(tcon, mode);
+	sun4i_tcon_set_mux(tcon, 0, encoder);
 
 	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 66a5bb9b85e9..0204d9fadb66 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -108,6 +108,22 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
 }
 EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
 
+void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
+			struct drm_encoder *encoder)
+{
+	if (!tcon->quirks->has_unknown_mux)
+		return;
+
+	if (channel != 1)
+		return;
+
+	/*
+	 * FIXME: Undocumented bits
+	 */
+	regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
+}
+EXPORT_SYMBOL(sun4i_tcon_set_mux);
+
 static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
 				    int channel)
 {
@@ -266,12 +282,6 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
 			   SUN4I_TCON_GCTL_IOMAP_TCON1);
-
-	/*
-	 * FIXME: Undocumented bits
-	 */
-	if (tcon->quirks->has_unknown_mux)
-		regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
 }
 EXPORT_SYMBOL(sun4i_tcon1_mode_set);
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f636343a935d..0350936b413c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -190,6 +190,8 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 /* Mode Related Controls */
 void sun4i_tcon_switch_interlace(struct sun4i_tcon *tcon,
 				 bool enable);
+void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
+			struct drm_encoder *encoder);
 void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 			  struct drm_display_mode *mode);
 void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 49c49431a053..03c494b8159c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -393,6 +393,7 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
 
 	sun4i_tcon1_mode_set(tcon, mode);
+	sun4i_tcon_set_mux(tcon, 1, encoder);
 
 	/* Enable and map the DAC to the output */
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
-- 
git-series 0.8.11
