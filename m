From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 May 2017 09:40:39 +0200
Subject: [PATCH v3 10/21] drm/sun4i: tcon: Move the muxing out of the mode set
 function
In-Reply-To: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
References: <cover.463df61c38224ecbfb5bf1cf192deeb63718b693.1495006350.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9633e1c870bba38b34323705134c1e7d00f8c747.1495006350.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The muxing can actually happen on both channels on some SoCs, so it makes
more sense to just move it out of the sun4i_tcon1_mode_set function and
create a separate function that needs to be called by the encoders.

Let's do that and convert the existing drivers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c  |  1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
 drivers/gpu/drm/sun4i/sun4i_tv.c   |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index c9bbb3b560a5..422b191faa77 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -175,6 +175,7 @@ static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
 	struct sun4i_tcon *tcon = rgb->tcon;
 
 	sun4i_tcon0_mode_set(tcon, mode);
+	sun4i_tcon_set_mux(tcon, 0, encoder);
 
 	/* FIXME: This seems to be board specific */
 	clk_set_phase(tcon->dclk, 120);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 48fadd188d65..a3fc6ab3c14b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -109,6 +109,22 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
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
@@ -273,12 +289,6 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
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
index d37e1e2ed60e..f60e0b4c6db8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -196,6 +196,8 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 /* Mode Related Controls */
 void sun4i_tcon_switch_interlace(struct sun4i_tcon *tcon,
 				 bool enable);
+void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
+			struct drm_encoder *encoder);
 void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 			  struct drm_display_mode *mode);
 void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 542da220818b..1177edaa8094 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -393,6 +393,7 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
 
 	sun4i_tcon1_mode_set(tcon, mode);
+	sun4i_tcon_set_mux(tcon, 1, encoder);
 
 	/* Enable and map the DAC to the output */
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
-- 
git-series 0.9.1
