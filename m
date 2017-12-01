From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Fri,  1 Dec 2017 07:05:38 +0100
Subject: [PATCH v2 15/27] drm/sun4i: Move interlace related code in DE2
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171201060550.10392-16-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point having code which sets interlace mode of mixer in
channel related function. Interlace mode will only change when CRTC
state will change, so let's move it to the block which is executed only
when primary plane state is changed.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 00c0cc6440e2..f35a08dc260b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -104,6 +104,9 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 	size = SUN8I_MIXER_SIZE(width, height);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
+		bool interlaced = false;
+		u32 val;
+
 		DRM_DEBUG_DRIVER("Primary layer, updating global size W: %u H: %u\n",
 				 width, height);
 		regmap_write(mixer->engine.regs,
@@ -111,6 +114,23 @@ int sun8i_mixer_update_layer_coord(struct sun8i_mixer *mixer, int channel,
 			     size);
 		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
 			     size);
+
+		if (state->crtc)
+			interlaced = state->crtc->state->adjusted_mode.flags
+				& DRM_MODE_FLAG_INTERLACE;
+
+		if (interlaced)
+			val = SUN8I_MIXER_BLEND_OUTCTL_INTERLACED;
+		else
+			val = 0;
+
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_BLEND_OUTCTL,
+				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
+				   val);
+
+		DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
+				 interlaced ? "on" : "off");
 	}
 
 	/* Set height and width */
@@ -140,22 +160,9 @@ int sun8i_mixer_update_layer_formats(struct sun8i_mixer *mixer, int channel,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
-	bool interlaced = false;
 	u32 val;
 	int ret;
 
-	if (plane->state->crtc)
-		interlaced = plane->state->crtc->state->adjusted_mode.flags
-			& DRM_MODE_FLAG_INTERLACE;
-
-	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTCTL,
-			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
-			   interlaced ?
-			   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED : 0);
-
-	DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
-			 interlaced ? "on" : "off");
-
 	ret = sun8i_mixer_drm_format_to_layer(plane, fb->format->format,
 						&val);
 	if (ret) {
-- 
2.15.1
