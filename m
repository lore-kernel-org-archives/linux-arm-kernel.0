From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 14:59:09 +0800
Subject: [PATCH v2 03/13] drm/sun4i: tcon: Add support for demuxing TCON
 output on A31
In-Reply-To: <20170926065919.24446-1-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
Message-ID: <20170926065919.24446-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems with 2 TCONs such as the A31, it is possible to demux the
output of the TCONs to one encoder.

Add support for this for the A31.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e853dfe51389..770b843a6fa9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -14,9 +14,12 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
 
+#include <uapi/drm/drm_mode.h>
+
 #include <linux/component.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
@@ -109,11 +112,69 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
 }
 EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
 
+static struct sun4i_tcon *sun4i_get_first_tcon(struct drm_device *drm)
+{
+	struct sun4i_drv *drv = drm->dev_private;
+	struct sun4i_tcon *tcon;
+
+	list_for_each_entry(tcon, &drv->tcon_list, list)
+		if (tcon->id == 0)
+			return tcon;
+
+	dev_warn(drm->dev,
+		 "TCON0 not found, display output muxing may not work\n");
+
+	return tcon;
+}
+
+static int _sun6i_tcon_set_mux(struct drm_encoder *encoder)
+{
+	struct sun4i_tcon *tcon = sun4i_get_first_tcon(encoder->dev);
+	int tcon_id = drm_crtc_to_sun4i_crtc(encoder->crtc)->tcon->id;
+	u32 shift;
+
+	DRM_DEBUG_DRIVER("Muxing encoder %s to CRTC %s (TCON %d)\n",
+			 encoder->name, encoder->crtc->name, tcon_id);
+
+	/* Only 2 TCONs */
+	if (tcon_id >= 2)
+		return -EINVAL;
+
+	switch (encoder->encoder_type) {
+	case DRM_MODE_ENCODER_TMDS:
+		/* HDMI */
+		shift = 8;
+		break;
+	case DRM_MODE_ENCODER_DSI:
+		/* No MIPI DSI on A31s */
+		if (of_device_is_compatible(tcon->dev->of_node,
+					    "allwinner,sun6i-a31s-tcon"))
+			return -EINVAL;
+		shift = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(tcon->regs, SUN4I_TCON_MUX_CTRL_REG,
+			   0x3 << shift, tcon_id << shift);
+
+	return 0;
+}
+
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			struct drm_encoder *encoder)
 {
+	/* Get the device node of the display engine */
+	struct device_node *node = encoder->dev->dev->of_node;
 	u32 val;
 
+	if (of_device_is_compatible(node, "allwinner,sun6i-a31-display-engine") ||
+	    of_device_is_compatible(node, "allwinner,sun6i-a31s-display-engine")) {
+		_sun6i_tcon_set_mux(encoder);
+		return;
+	}
+
 	if (!tcon->quirks->has_unknown_mux)
 		return;
 
-- 
2.14.1
