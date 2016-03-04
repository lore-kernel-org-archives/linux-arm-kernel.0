From: dianders@chromium.org (Douglas Anderson)
Date: Fri,  4 Mar 2016 15:22:02 -0800
Subject: [PATCH 2/2] drm/rockchip: vop: Fix vop crtc cleanup
In-Reply-To: <1457133723-24869-1-git-send-email-dianders@chromium.org>
References: <1457133723-24869-1-git-send-email-dianders@chromium.org>
Message-ID: <1457133723-24869-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a few problems in the vop crtc cleanup (handling error
paths and cleanup upon exit):

* The vop_create_crtc() error path had an unsafe version of the
  iterator used for iterating over all planes (though it was
  destroying planes in the iterator so should have used the safe
  version)

* vop_destroy_crtc() - wasn't calling vop_plane_destroy(), which made
  slub_debug unhappy, at least if we ended up running this due to a
  deferred probe.

* In vop_create_crtc() if we were missing the "port" device tree node
  we would fail but not return an error (found by code inspection).

Fix these problems.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fd370548d7d7..f86f797f10fd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1108,7 +1108,7 @@ static int vop_create_crtc(struct vop *vop)
 	const struct vop_data *vop_data = vop->data;
 	struct device *dev = vop->dev;
 	struct drm_device *drm_dev = vop->drm_dev;
-	struct drm_plane *primary = NULL, *cursor = NULL, *plane;
+	struct drm_plane *primary = NULL, *cursor = NULL, *plane, *tmp;
 	struct drm_crtc *crtc = &vop->crtc;
 	struct device_node *port;
 	int ret;
@@ -1148,7 +1148,7 @@ static int vop_create_crtc(struct vop *vop)
 	ret = drm_crtc_init_with_planes(drm_dev, crtc, primary, cursor,
 					&vop_crtc_funcs, NULL);
 	if (ret)
-		return ret;
+		goto err_cleanup_planes;
 
 	drm_crtc_helper_add(crtc, &vop_crtc_helper_funcs);
 
@@ -1181,6 +1181,7 @@ static int vop_create_crtc(struct vop *vop)
 	if (!port) {
 		DRM_ERROR("no port node found in %s\n",
 			  dev->of_node->full_name);
+		ret = -ENOENT;
 		goto err_cleanup_crtc;
 	}
 
@@ -1194,7 +1195,8 @@ static int vop_create_crtc(struct vop *vop)
 err_cleanup_crtc:
 	drm_crtc_cleanup(crtc);
 err_cleanup_planes:
-	list_for_each_entry(plane, &drm_dev->mode_config.plane_list, head)
+	list_for_each_entry_safe(plane, tmp, &drm_dev->mode_config.plane_list,
+				 head)
 		drm_plane_cleanup(plane);
 	return ret;
 }
@@ -1202,9 +1204,28 @@ err_cleanup_planes:
 static void vop_destroy_crtc(struct vop *vop)
 {
 	struct drm_crtc *crtc = &vop->crtc;
+	struct drm_device *drm_dev = vop->drm_dev;
+	struct drm_plane *plane, *tmp;
 
 	rockchip_unregister_crtc_funcs(crtc);
 	of_node_put(crtc->port);
+
+	/*
+	 * We need to cleanup the planes now.  Why?
+	 *
+	 * The planes are "&vop->win[i].base".  That means the memory is
+	 * all part of the big "struct vop" chunk of memory.  That memory
+	 * was devm allocated and associated with this component.  We need to
+	 * free it ourselves before vop_unbind() finishes.
+	 */
+	list_for_each_entry_safe(plane, tmp, &drm_dev->mode_config.plane_list,
+				 head)
+		vop_plane_destroy(plane);
+
+	/*
+	 * Destroy CRTC after vop_plane_destroy() since vop_disable_plane()
+	 * references the CRTC.
+	 */
 	drm_crtc_cleanup(crtc);
 }
 
-- 
2.7.0.rc3.207.g0ac5344
