From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Mar 2017 09:56:29 +0100
Subject: [PATCH 10/15] drm/sun4i: tcon: Switch mux on only for composite
In-Reply-To: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <3f70bcfe2ec03188c06d54a262d49ad91963a510.1488876832.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though that mux is undocumented, it seems like it needs to be set to 1
when using composite, and 0 when using HDMI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index d2335f109601..93249c5ab1e4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -268,11 +268,16 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
 			   SUN4I_TCON_GCTL_IOMAP_TCON1);
 
+	if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
+		val = 1;
+	else
+		val = 0;
+
 	/*
 	 * FIXME: Undocumented bits
 	 */
 	if (tcon->quirks->has_unknown_mux)
-		regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
+		regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
 }
 EXPORT_SYMBOL(sun4i_tcon1_mode_set);
 
-- 
git-series 0.8.11
