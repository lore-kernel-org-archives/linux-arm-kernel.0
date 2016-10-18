From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 10:29:37 +0200
Subject: [PATCH 4/5] drm/sun4i: Compute TCON1 mode from tv mode
In-Reply-To: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
Message-ID: <c2736e784c776479a251d3ddea5dd330eeb7e896.1476779323.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the mode passed in mode_set is probably going to be a scaled down
version of the TV mode, we cannot just use it.

Instead, try to retrieve the actual mode we want to set, and generate a drm
mode from that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 6f8077013be3..f99886462cb8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -401,8 +401,13 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	struct sun4i_drv *drv = tv->drv;
 	struct sun4i_tcon *tcon = drv->tcon;
 	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
+	struct drm_display_mode tv_drm_mode = { 0 };
 
-	sun4i_tcon1_mode_set(tcon, mode);
+	strcpy(tv_drm_mode.name, "TV");
+	sun4i_tv_mode_to_drm_mode(tv_mode, &tv_drm_mode);
+	drm_mode_set_crtcinfo(&tv_drm_mode, CRTC_INTERLACE_HALVE_V);
+
+	sun4i_tcon1_mode_set(tcon, &tv_drm_mode);
 
 	/* Enable and map the DAC to the output */
 	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
-- 
git-series 0.8.10
