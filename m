From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 27 Sep 2017 20:26:42 +0800
Subject: [PATCH] drm/rockchip: Fix memory leak in rockchip_drm_sys_resume()
Message-ID: <20170927122642.18628-1-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free the drm_atomic_state allocated by drm_atomic_helper_suspend().

Fixes: 5a5873830972 ("drm/rockchip: Use atomic PM helpers")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 76d63de5921d..80235b672deb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -15,6 +15,7 @@
  */
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
@@ -299,6 +300,7 @@ static int rockchip_drm_sys_resume(struct device *dev)
 
 	priv = drm->dev_private;
 	drm_atomic_helper_resume(drm, priv->state);
+	drm_atomic_state_put(priv->state);
 	rockchip_drm_fb_resume(drm);
 	drm_kms_helper_poll_enable(drm);
 
-- 
2.11.0
