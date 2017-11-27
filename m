From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 16:41:31 +0100
Subject: [PATCH v2 07/18] drm/sun4i: sun8i: Rework the UI channels code
In-Reply-To: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
Message-ID: <38e9e5efac848777c59b4662b2b5440d275f3bb4.1511797218.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code makes the assumption that the only channel we want to use
for the first (and only) UI channel is the number of VI channels (so last
VI + 1), which is accurate.

However, it does so in pretty much every plane-related function using a
local variable that makes it quite difficult to rework when we'll have to
deal with multiple UI channels.

Refactor the current code a bit to associate the ID of the channel to the
sun8i_ui structure directly, and have all our callbacks use that instead.

As the current code registers only one UI channel, we'll fill that field
with the same value that was there before (ie number of VI channels), but
this time we'll only have to change it where the planes are instatiated,
and not in the whole code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 43 +++++++++++++-----------------
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 12 ++++----
 drivers/gpu/drm/sun4i/sun8i_ui.c    | 12 ++++----
 drivers/gpu/drm/sun4i/sun8i_ui.h    |  1 +-
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index f503bd000893..648a6ad3104a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -37,14 +37,12 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine)
 		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
 }
 
-void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
-				int layer, bool enable)
+void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer, struct sun8i_ui *ui,
+			      bool enable)
 {
 	u32 val;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 
-	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", layer, chan);
+	DRM_DEBUG_DRIVER("Enabling layer %d in channel %d\n", ui->id, ui->chan);
 
 	if (enable)
 		val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
@@ -52,16 +50,16 @@ void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
 		val = 0;
 
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ui->chan, ui->id),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
 
 	/* Set the alpha configuration */
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ui->chan, ui->id),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF);
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ui->chan, ui->id),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF);
 }
@@ -90,14 +88,13 @@ static int sun8i_mixer_drm_format_to_layer(struct drm_plane *plane,
 }
 
 int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
-				     int layer, struct drm_plane *plane)
+				   struct sun8i_ui *ui)
 {
+	struct drm_plane *plane = &ui->plane;
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 
-	DRM_DEBUG_DRIVER("Updating layer %d\n", layer);
+	DRM_DEBUG_DRIVER("Updating layer %d\n", ui->id);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
@@ -115,7 +112,7 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 					      state->crtc_h));
 		DRM_DEBUG_DRIVER("Updating channel size\n");
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(chan),
+			     SUN8I_MIXER_CHAN_UI_OVL_SIZE(ui->chan),
 			     SUN8I_MIXER_SIZE(state->crtc_w,
 					      state->crtc_h));
 	}
@@ -123,35 +120,34 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ui->chan, ui->id),
 		     fb->pitches[0]);
 
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n",
 			 state->crtc_w, state->crtc_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ui->chan, ui->id),
 		     SUN8I_MIXER_SIZE(state->crtc_w, state->crtc_h));
 
 	/* Set base coordinates */
 	DRM_DEBUG_DRIVER("Layer coordinates X: %d Y: %d\n",
 			 state->crtc_x, state->crtc_y);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_COORD(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_COORD(ui->chan, ui->id),
 		     SUN8I_MIXER_COORD(state->crtc_x, state->crtc_y));
 
 	return 0;
 }
 
 int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
-				       int layer, struct drm_plane *plane)
+				     struct sun8i_ui *ui)
 {
+	struct drm_plane *plane = &ui->plane;
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	bool interlaced = false;
 	u32 val;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 	int ret;
 
 	if (plane->state->crtc)
@@ -174,21 +170,20 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
 	}
 
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(chan, layer),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ui->chan, ui->id),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
 
 	return 0;
 }
 
 int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
-				      int layer, struct drm_plane *plane)
+				    struct sun8i_ui *ui)
 {
+	struct drm_plane *plane = &ui->plane;
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
 	struct drm_gem_cma_object *gem;
 	dma_addr_t paddr;
-	/* Currently the first UI channel is used */
-	int chan = mixer->cfg->vi_num;
 	int bpp;
 
 	/* Get the physical address of the buffer in memory */
@@ -220,7 +215,7 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(chan, layer),
+		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ui->chan, ui->id),
 		     lower_32_bits(paddr));
 
 	return 0;
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 4785ac090b8c..ce984c436246 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -104,6 +104,8 @@
 #define SUN8I_MIXER_FCC_EN			0xaa000
 #define SUN8I_MIXER_DCSC_EN			0xb0000
 
+struct sun8i_ui;
+
 struct sun8i_mixer_cfg {
 	int		vi_num;
 	int		ui_num;
@@ -126,12 +128,12 @@ engine_to_sun8i_mixer(struct sunxi_engine *engine)
 	return container_of(engine, struct sun8i_mixer, engine);
 }
 
-void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
-				int layer, bool enable);
+void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer, struct sun8i_ui *ui,
+			      bool enable);
 int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer,
-				     int layer, struct drm_plane *plane);
+				   struct sun8i_ui *ui);
 int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer,
-				       int layer, struct drm_plane *plane);
+				     struct sun8i_ui *ui);
 int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer,
-				      int layer, struct drm_plane *plane);
+				    struct sun8i_ui *ui);
 #endif /* _SUN8I_MIXER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui.c b/drivers/gpu/drm/sun4i/sun8i_ui.c
index 3986cb08509c..edc65d9df598 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui.c
@@ -32,7 +32,7 @@ static void sun8i_mixer_ui_atomic_disable(struct drm_plane *plane,
 	struct sun8i_ui *ui = plane_to_sun8i_ui(plane);
 	struct sun8i_mixer *mixer = ui->mixer;
 
-	sun8i_mixer_layer_enable(mixer, ui->id, false);
+	sun8i_mixer_layer_enable(mixer, ui, false);
 }
 
 static void sun8i_mixer_ui_atomic_update(struct drm_plane *plane,
@@ -41,10 +41,10 @@ static void sun8i_mixer_ui_atomic_update(struct drm_plane *plane,
 	struct sun8i_ui *ui = plane_to_sun8i_ui(plane);
 	struct sun8i_mixer *mixer = ui->mixer;
 
-	sun8i_mixer_update_layer_coord(mixer, ui->id, plane);
-	sun8i_mixer_update_layer_formats(mixer, ui->id, plane);
-	sun8i_mixer_update_layer_buffer(mixer, ui->id, plane);
-	sun8i_mixer_layer_enable(mixer, ui->id, true);
+	sun8i_mixer_update_layer_coord(mixer, ui);
+	sun8i_mixer_update_layer_formats(mixer, ui);
+	sun8i_mixer_update_layer_buffer(mixer, ui);
+	sun8i_mixer_layer_enable(mixer, ui, true);
 }
 
 static struct drm_plane_helper_funcs sun8i_mixer_ui_helper_funcs = {
@@ -126,6 +126,8 @@ struct drm_plane **sun8i_ui_init(struct drm_device *drm,
 			return ERR_CAST(ui);
 		};
 
+		/* TODO: Support several UI channels */
+		ui->chan = mixer->cfg->vi_num;
 		ui->id = i;
 		planes[i] = &ui->plane;
 	};
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui.h b/drivers/gpu/drm/sun4i/sun8i_ui.h
index 17dfc92ccc9f..3c3185878ad1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui.h
@@ -22,6 +22,7 @@ struct sun8i_ui {
 	struct drm_plane	plane;
 	struct sun4i_drv	*drv;
 	struct sun8i_mixer	*mixer;
+	u8			chan;
 	int			id;
 };
 
-- 
git-series 0.9.1
