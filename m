From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:22:56 +0800
Subject: [PATCH v3 04/14] drm/sun4i: tcon: Add support for demuxing TCON
 output on A31
In-Reply-To: <20170929082306.16193-1-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
Message-ID: <20170929082306.16193-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On systems with 2 TCONs such as the A31, it is possible to demux the
output of the TCONs to one encoder.

Add support for this for the A31.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 7bf51abaee97..c949309d4285 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -112,6 +112,21 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
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
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			struct drm_encoder *encoder)
 {
@@ -777,6 +792,28 @@ static int sun5i_a13_tcon_set_mux(struct sun4i_tcon *tcon,
 	return regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
 }
 
+static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
+			      struct drm_encoder *encoder)
+{
+	struct sun4i_tcon *tcon0 = sun4i_get_first_tcon(encoder->dev);
+	u32 shift;
+
+	switch (encoder->encoder_type) {
+	case DRM_MODE_ENCODER_TMDS:
+		/* HDMI */
+		shift = 8;
+		break;
+	default:
+		/* TODO A31 has MIPI DSI but A31s does not */
+		return -EINVAL;
+	}
+
+	regmap_update_bits(tcon0->regs, SUN4I_TCON_MUX_CTRL_REG,
+			   0x3 << shift, tcon->id << shift);
+
+	return 0;
+}
+
 static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 	.has_unknown_mux	= true,
 	.has_channel_1		= true,
@@ -786,6 +823,7 @@ static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
 	.has_channel_1		= true,
 	.needs_de_be_mux	= true,
+	.set_mux		= sun6i_tcon_set_mux,
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
-- 
2.14.2
