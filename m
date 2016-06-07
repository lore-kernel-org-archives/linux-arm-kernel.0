From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jun 2016 13:47:58 +0200
Subject: [PATCH v2 03/20] drm: atmel-hlcdc: Rely on the default
 ->best_encoder() behavior
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465300095-16971-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder() and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
index 3d34fc4..6119b50 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
@@ -113,21 +113,9 @@ static int atmel_hlcdc_rgb_mode_valid(struct drm_connector *connector,
 	return atmel_hlcdc_dc_mode_valid(rgb->dc, mode);
 }
 
-
-
-static struct drm_encoder *
-atmel_hlcdc_rgb_best_encoder(struct drm_connector *connector)
-{
-	struct atmel_hlcdc_rgb_output *rgb =
-			drm_connector_to_atmel_hlcdc_rgb_output(connector);
-
-	return &rgb->encoder;
-}
-
 static const struct drm_connector_helper_funcs atmel_hlcdc_panel_connector_helper_funcs = {
 	.get_modes = atmel_hlcdc_panel_get_modes,
 	.mode_valid = atmel_hlcdc_rgb_mode_valid,
-	.best_encoder = atmel_hlcdc_rgb_best_encoder,
 };
 
 static enum drm_connector_status
-- 
2.7.4
