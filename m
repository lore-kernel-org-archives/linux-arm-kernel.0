From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Wed, 15 Jun 2016 13:17:54 +0100
Subject: [PATCH 09/44] drm/mediatek: Remove redundant calls to
 drm_connector_register_all()
In-Reply-To: <1465993109-19523-1-git-send-email-chris@chris-wilson.co.uk>
References: <1465993109-19523-1-git-send-email-chris@chris-wilson.co.uk>
Message-ID: <1465993109-19523-10-git-send-email-chris@chris-wilson.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Up to now, the recommendation was for drivers to call drm_dev_register()
followed by drm_connector_register_all(). Now that
drm_connector_register() is safe against multiple invocations, we can
move drm_connector_register_all() to drm_dev_register() and not suffer
from any backwards compatibility issues with drivers not following the
more rigorous init ordering.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c33bf98c5d5e..7ab91f4a200f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -293,14 +293,8 @@ static int mtk_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto err_deinit;
 
-	ret = drm_connector_register_all(drm);
-	if (ret < 0)
-		goto err_unregister;
-
 	return 0;
 
-err_unregister:
-	drm_dev_unregister(drm);
 err_deinit:
 	mtk_drm_kms_deinit(drm);
 err_free:
@@ -455,7 +449,6 @@ static int mtk_drm_remove(struct platform_device *pdev)
 	struct drm_device *drm = private->drm;
 	int i;
 
-	drm_connector_unregister_all(drm);
 	drm_dev_unregister(drm);
 	mtk_drm_kms_deinit(drm);
 	drm_dev_unref(drm);
-- 
2.8.1
