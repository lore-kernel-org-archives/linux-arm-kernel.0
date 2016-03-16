From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:35 +0100
Subject: [PATCH v2 1/9] drm: atmel-hlcdc: add a ->cleanup_fb() operation
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a ->cleanup_fb() operation to avoid memory leaks when the atomic
operation is interrupted after the ->prepare_fb() call.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes 2389fc1 ("drm: atmel-hlcdc: Atomic mode-setting conversion")
Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |  2 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 22 +++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index fed517f..ec64140 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -81,11 +81,13 @@ struct atmel_hlcdc_plane_properties {
  * @layer: HLCDC layer structure
  * @properties: pointer to the property definitions structure
  * @rotation: current rotation status
+ * @prepared: flagging the plane has prepared for an atomic update
  */
 struct atmel_hlcdc_plane {
 	struct drm_plane base;
 	struct atmel_hlcdc_layer layer;
 	struct atmel_hlcdc_plane_properties *properties;
+	bool prepared;
 };
 
 static inline struct atmel_hlcdc_plane *
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 1ffe9c3..35027d0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -715,11 +715,25 @@ static int atmel_hlcdc_plane_prepare_fb(struct drm_plane *p,
 					const struct drm_plane_state *new_state)
 {
 	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
+	int ret;
 
-	if (!new_state->fb)
-		return 0;
+	ret = atmel_hlcdc_layer_update_start(&plane->layer);
+	if (!ret)
+		plane->prepared = true;
+
+	return ret;
+}
+
+static void atmel_hlcdc_plane_cleanup_fb(struct drm_plane *p,
+				const struct drm_plane_state *old_state)
+{
+	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
+
+	if (!plane->prepared)
+		return;
 
-	return atmel_hlcdc_layer_update_start(&plane->layer);
+	atmel_hlcdc_layer_update_rollback(&plane->layer);
+	plane->prepared = false;
 }
 
 static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
@@ -739,6 +753,7 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
 	atmel_hlcdc_plane_update_disc_area(plane, state);
 
 	atmel_hlcdc_layer_update_commit(&plane->layer);
+	plane->prepared = false;
 }
 
 static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
@@ -844,6 +859,7 @@ static void atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
 
 static struct drm_plane_helper_funcs atmel_hlcdc_layer_plane_helper_funcs = {
 	.prepare_fb = atmel_hlcdc_plane_prepare_fb,
+	.cleanup_fb = atmel_hlcdc_plane_cleanup_fb,
 	.atomic_check = atmel_hlcdc_plane_atomic_check,
 	.atomic_update = atmel_hlcdc_plane_atomic_update,
 	.atomic_disable = atmel_hlcdc_plane_atomic_disable,
-- 
2.5.0
