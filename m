From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  9 Aug 2017 16:07:24 -0700
Subject: [PATCH] drm/rockchip: Skip suspend/resume if no display is attached
Message-ID: <20170809230724.113819-1-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip_drm_sys_suspend/resume() obains a struct drm_device pointer
from drvdata, the pointer is then dereferenced to obtain private data.
drvdata is set when a display is bound, on systems without a
(successfully probed) display drvdata is NULL and the PM functions
try to dereference a NULL pointer.

The suspend/resume code relies on a valid drm_device object, skip it if
the pointer is NULL.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index c6b1b7f3a2a3..6228145d9496 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -275,11 +275,16 @@ static void rockchip_drm_fb_resume(struct drm_device *drm)
 static int rockchip_drm_sys_suspend(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct rockchip_drm_private *priv = drm->dev_private;
+	struct rockchip_drm_private *priv;
+
+	if (!drm)
+		/* no display attached */
+		return 0;
 
 	drm_kms_helper_poll_disable(drm);
 	rockchip_drm_fb_suspend(drm);
 
+	priv = drm->dev_private;
 	priv->state = drm_atomic_helper_suspend(drm);
 	if (IS_ERR(priv->state)) {
 		rockchip_drm_fb_resume(drm);
@@ -293,8 +298,13 @@ static int rockchip_drm_sys_suspend(struct device *dev)
 static int rockchip_drm_sys_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
-	struct rockchip_drm_private *priv = drm->dev_private;
+	struct rockchip_drm_private *priv;
+
+	if (!drm)
+		/* no display attached */
+		return 0;
 
+	priv = drm->dev_private;
 	drm_atomic_helper_resume(drm, priv->state);
 	rockchip_drm_fb_resume(drm);
 	drm_kms_helper_poll_enable(drm);
-- 
2.14.0.434.g98096fd7a8-goog
