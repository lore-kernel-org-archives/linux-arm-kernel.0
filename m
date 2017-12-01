From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:36 +0100
Subject: [PATCH v2 13/27] drm/sun4i: Move line width setting in DE2
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-14-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Line width is a property of a framebuffer and it belongs to
sun8i_mixer_update_layer_buffer(). This will became even more obvious
when support for multi-plane formats will be added.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 37fcc5ed18c5..9635c30651d6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -91,7 +91,6 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 				   int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
-	struct drm_framebuffer *fb = state->fb;
 	u32 width, height, size;
 
 	DRM_DEBUG_DRIVER("Updating channel %d overlay %d\n", channel, overlay);
@@ -122,12 +121,6 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 			     size);
 	}
 
-	/* Set the line width */
-	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
-	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(channel, overlay),
-		     fb->pitches[0]);
-
 	/* Set height and width */
 	DRM_DEBUG_DRIVER("Layer size W: %u H: %u\n", width, height);
 	regmap_write(mixer->engine.regs,
@@ -202,6 +195,12 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer *mixer, int channel,
 	paddr += (state->src.x1 >> 16) * bpp;
 	paddr += (state->src.y1 >> 16) * fb->pitches[0];
 
+	/* Set the line width */
+	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(channel, overlay),
+		     fb->pitches[0]);
+
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
 
 	regmap_write(mixer->engine.regs,
-- 
2.15.1
