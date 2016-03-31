From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 31 Mar 2016 10:08:00 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending flip
 event v2
Message-ID: <1459411680-6176-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
updated is requested and there is an earlier updated pending".

v2: Use the status of the workqueue instead of vop->event, and don't add
a superfluous wait on the workqueue.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 3b8f652698f8..285f8cd5afe1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -282,6 +282,9 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
 	struct rockchip_atomic_commit *commit = &private->commit;
 	int ret;
 
+	if (async && work_busy(&commit->work))
+		return -EBUSY;
+
 	ret = drm_atomic_helper_prepare_planes(dev, state);
 	if (ret)
 		return ret;
-- 
2.5.5
