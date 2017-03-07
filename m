From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Mar 2017 09:56:31 +0100
Subject: [PATCH 12/15] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <0b3b516527c42e745ed8a35736948a383411bd50.1488876832.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that the total vertical resolution needs to be doubled when
we're not in interlaced. Make sure that is the case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e44217fb4f6f..515fa56c1e6a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -248,10 +248,13 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
 		     SUN4I_TCON1_BASIC3_H_BACKPORCH(bp));
 
 	bp = mode->crtc_vtotal - mode->crtc_vsync_start;
+	val = mode->crtc_vtotal;
+	if (!(mode->flags & DRM_MODE_FLAG_INTERLACE))
+		val = val * 2;
 	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
 			 mode->vtotal, bp);
 	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
-		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
+		     SUN4I_TCON1_BASIC4_V_TOTAL(val) |
 		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
-- 
git-series 0.8.11
