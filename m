From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:51 +0200
Subject: [PATCH v2 14/20] drm/sun4i: tcon: multiply the vtotal when not in
 interlace
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <59bdbadc4d3adc6d75c2cef38df0af332bd313db.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears that the total vertical resolution needs to be doubled when
we're not in interlaced. Make sure that is the case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0f91ec8a4b26..efa079c1a3f5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -272,9 +272,9 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	/* Set vertical display timings */
 	bp = mode->crtc_vtotal - mode->crtc_vsync_start;
 	DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
-			 mode->vtotal, bp);
+			 mode->crtc_vtotal, bp);
 	regmap_write(tcon->regs, SUN4I_TCON1_BASIC4_REG,
-		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->vtotal) |
+		     SUN4I_TCON1_BASIC4_V_TOTAL(mode->crtc_vtotal * 2) |
 		     SUN4I_TCON1_BASIC4_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
-- 
git-series 0.8.11
