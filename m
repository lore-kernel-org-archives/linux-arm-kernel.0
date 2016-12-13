From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 13 Dec 2016 16:07:36 +0100
Subject: [PATCH] drm: tilcdc: simplify the recovery from sync lost error on
 rev1
Message-ID: <1481641656-25227-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Revision 2 of LCDC suffers from an issue where a SYNC_LOST error
caused by limited memory bandwidth may leave the picture shifted a
couple pixels to the right.

This issue has not been observed on revision 1, while the recovery
mechanism introduces a different issue, where the END_OF_FRAME
interrupt doesn't fire while drm is waiting for vblanks.

On rev1: recover from sync lost errors by simply clearing the
RASTER_ENABLE bit in the RASTER_CTRL register and re-enabling it
again as is suggested by the datasheet.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 9942b05..70e57a7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -921,17 +921,23 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
 		dev_err_ratelimited(dev->dev, "%s(0x%08x): Sync lost",
 				    __func__, stat);
 		tilcdc_crtc->frame_intact = false;
-		if (tilcdc_crtc->sync_lost_count++ >
-		    SYNC_LOST_COUNT_LIMIT) {
-			dev_err(dev->dev, "%s(0x%08x): Sync lost flood detected, recovering", __func__, stat);
-			queue_work(system_wq, &tilcdc_crtc->recover_work);
-			if (priv->rev == 1)
-				tilcdc_clear(dev, LCDC_RASTER_CTRL_REG,
-					     LCDC_V1_SYNC_LOST_INT_ENA);
-			else
+		if (priv->rev == 1) {
+			tilcdc_clear(dev,
+				     LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
+			tilcdc_set(dev,
+				   LCDC_RASTER_CTRL_REG, LCDC_RASTER_ENABLE);
+		} else {
+			if (tilcdc_crtc->sync_lost_count++ >
+			    SYNC_LOST_COUNT_LIMIT) {
+				dev_err(dev->dev,
+					"%s(0x%08x): Sync lost flood detected, recovering",
+					__func__, stat);
+				queue_work(system_wq,
+					   &tilcdc_crtc->recover_work);
 				tilcdc_write(dev, LCDC_INT_ENABLE_CLR_REG,
 					     LCDC_SYNC_LOST);
-			tilcdc_crtc->sync_lost_count = 0;
+				tilcdc_crtc->sync_lost_count = 0;
+			}
 		}
 	}
 
-- 
2.9.3
