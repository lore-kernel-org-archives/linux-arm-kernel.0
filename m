From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 May 2017 18:09:28 +0200
Subject: [PATCH v4 03/11] drm/sun4i: tcon: Switch mux on only for composite
In-Reply-To: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d12b0f7bec6b806a936a146532f74726effac024.1495900658.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though that mux is undocumented, it seems like it needs to be set to 1
when using composite, and 0 when using HDMI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 36e25f417dc3..28da61ac9bab 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -112,16 +112,23 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			struct drm_encoder *encoder)
 {
+	u32 val;
+
 	if (!tcon->quirks->has_unknown_mux)
 		return;
 
 	if (channel != 1)
 		return;
 
+	if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
+		val = 1;
+	else
+		val = 0;
+
 	/*
 	 * FIXME: Undocumented bits
 	 */
-	regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
+	regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
 }
 EXPORT_SYMBOL(sun4i_tcon_set_mux);
 
-- 
git-series 0.9.1
