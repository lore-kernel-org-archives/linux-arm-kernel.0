From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Nov 2014 14:11:15 +0100
Subject: [PATCH 2/5] drm/exynos/ipp: fix error return code
In-Reply-To: <1416748278-22881-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1416748278-22881-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1416748278-22881-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Propagate the returned error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index 00d74b1..d5ad17d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -426,18 +426,21 @@ int exynos_drm_ipp_set_property(struct drm_device *drm_dev, void *data,
 	c_node->start_work = ipp_create_cmd_work();
 	if (IS_ERR(c_node->start_work)) {
 		DRM_ERROR("failed to create start work.\n");
+		ret = PTR_ERR(c_node->start_work);
 		goto err_remove_id;
 	}
 
 	c_node->stop_work = ipp_create_cmd_work();
 	if (IS_ERR(c_node->stop_work)) {
 		DRM_ERROR("failed to create stop work.\n");
+		ret = PTR_ERR(c_node->stop_work);
 		goto err_free_start;
 	}
 
 	c_node->event_work = ipp_create_event_work();
 	if (IS_ERR(c_node->event_work)) {
 		DRM_ERROR("failed to create event work.\n");
+		ret = PTR_ERR(c_node->event_work);
 		goto err_free_stop;
 	}
 
