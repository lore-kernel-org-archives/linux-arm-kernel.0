From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat,  1 Apr 2017 19:35:28 +0800
Subject: [PATCH v2 8/9] drm/rockchip: gem: Don't alloc/free gem buf before drm
 dev registered
In-Reply-To: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491046529-4310-9-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index df9e570..2bf8024 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -184,6 +184,9 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
 	struct drm_device *drm = obj->dev;
 	struct rockchip_drm_private *private = drm->dev_private;
 
+	if (!drm->registered)
+		return -ENODEV;
+
 	if (private->domain)
 		return rockchip_gem_alloc_iommu(rk_obj, alloc_kmap);
 	else
@@ -208,6 +211,11 @@ static void rockchip_gem_free_dma(struct rockchip_gem_object *rk_obj)
 
 static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
 {
+	struct drm_device *drm = rk_obj->base.dev;
+
+	if (!drm->registered)
+		return;
+
 	if (rk_obj->pages)
 		rockchip_gem_free_iommu(rk_obj);
 	else
-- 
2.1.4
