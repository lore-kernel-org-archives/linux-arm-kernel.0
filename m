From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  7 Jun 2016 13:48:00 +0200
Subject: [PATCH v2 05/20] drm: fsl-dcu: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1465300095-16971-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a 1:1 relationship between connectors and encoders and the
driver is relying on the atomic helpers: we can drop the custom
->best_encoder() and let the core call drm_atomic_helper_best_encoder()
for us.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 98c998d..0b0989e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -102,14 +102,6 @@ static const struct drm_connector_funcs fsl_dcu_drm_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 };
 
-static struct drm_encoder *
-fsl_dcu_drm_connector_best_encoder(struct drm_connector *connector)
-{
-	struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
-
-	return fsl_con->encoder;
-}
-
 static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
 {
 	struct fsl_dcu_drm_connector *fsl_connector;
@@ -136,7 +128,6 @@ static int fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
 }
 
 static const struct drm_connector_helper_funcs connector_helper_funcs = {
-	.best_encoder = fsl_dcu_drm_connector_best_encoder,
 	.get_modes = fsl_dcu_drm_connector_get_modes,
 	.mode_valid = fsl_dcu_drm_connector_mode_valid,
 };
-- 
2.7.4
