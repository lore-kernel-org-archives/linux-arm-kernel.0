From: you@example.com (Your Name)
Date: Thu,  6 Apr 2017 20:22:21 +0800
Subject: [PATCH v4 10/12] drm/rockchip: Reoder drm bind/unbind sequence
In-Reply-To: <1491481343-11025-1-git-send-email-you@example.com>
References: <1491481343-11025-1-git-send-email-you@example.com>
Message-ID: <1491481343-11025-11-git-send-email-you@example.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Current drm bind/unbind sequence would cause some memory issues.
For example we should not cleanup iommu before cleanup mode config.

Reorder bind/unbind sequence, follow exynos drm.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Your Name <you@example.com>
---

Changes in v4: None
Changes in v3:
Address Sean Paul <seanpaul@chromium.org>'s comments.
Update commit message.

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 49 +++++++++++++++--------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index cd7d02e1..f24968f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -136,21 +136,24 @@ static int rockchip_drm_bind(struct device *dev)
 	INIT_LIST_HEAD(&private->psr_list);
 	spin_lock_init(&private->psr_list_lock);
 
+	ret = rockchip_drm_init_iommu(drm_dev);
+	if (ret)
+		goto err_free;
+
 	drm_mode_config_init(drm_dev);
 
 	rockchip_drm_mode_config_init(drm_dev);
 
-	ret = rockchip_drm_init_iommu(drm_dev);
-	if (ret)
-		goto err_config_cleanup;
-
 	/* Try to bind all sub drivers. */
 	ret = component_bind_all(dev, drm_dev);
 	if (ret)
-		goto err_iommu_cleanup;
+		goto err_mode_config_cleanup;
 
-	/* init kms poll for handling hpd */
-	drm_kms_helper_poll_init(drm_dev);
+	ret = drm_vblank_init(drm_dev, drm_dev->mode_config.num_crtc);
+	if (ret)
+		goto err_unbind_all;
+
+	drm_mode_config_reset(drm_dev);
 
 	/*
 	 * enable drm irq mode.
@@ -158,15 +161,12 @@ static int rockchip_drm_bind(struct device *dev)
 	 */
 	drm_dev->irq_enabled = true;
 
-	ret = drm_vblank_init(drm_dev, ROCKCHIP_MAX_CRTC);
-	if (ret)
-		goto err_kms_helper_poll_fini;
-
-	drm_mode_config_reset(drm_dev);
+	/* init kms poll for handling hpd */
+	drm_kms_helper_poll_init(drm_dev);
 
 	ret = rockchip_drm_fbdev_init(drm_dev);
 	if (ret)
-		goto err_vblank_cleanup;
+		goto err_kms_helper_poll_fini;
 
 	ret = drm_dev_register(drm_dev, 0);
 	if (ret)
@@ -175,17 +175,17 @@ static int rockchip_drm_bind(struct device *dev)
 	return 0;
 err_fbdev_fini:
 	rockchip_drm_fbdev_fini(drm_dev);
-err_vblank_cleanup:
-	drm_vblank_cleanup(drm_dev);
 err_kms_helper_poll_fini:
 	drm_kms_helper_poll_fini(drm_dev);
+	drm_vblank_cleanup(drm_dev);
+err_unbind_all:
 	component_unbind_all(dev, drm_dev);
-err_iommu_cleanup:
-	rockchip_iommu_cleanup(drm_dev);
-err_config_cleanup:
+err_mode_config_cleanup:
 	drm_mode_config_cleanup(drm_dev);
-	drm_dev->dev_private = NULL;
+	rockchip_iommu_cleanup(drm_dev);
 err_free:
+	drm_dev->dev_private = NULL;
+	dev_set_drvdata(dev, NULL);
 	drm_dev_unref(drm_dev);
 	return ret;
 }
@@ -194,16 +194,19 @@ static void rockchip_drm_unbind(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
+	drm_dev_unregister(drm_dev);
+
 	rockchip_drm_fbdev_fini(drm_dev);
-	drm_vblank_cleanup(drm_dev);
 	drm_kms_helper_poll_fini(drm_dev);
+
+	drm_vblank_cleanup(drm_dev);
 	component_unbind_all(dev, drm_dev);
-	rockchip_iommu_cleanup(drm_dev);
 	drm_mode_config_cleanup(drm_dev);
+	rockchip_iommu_cleanup(drm_dev);
+
 	drm_dev->dev_private = NULL;
-	drm_dev_unregister(drm_dev);
-	drm_dev_unref(drm_dev);
 	dev_set_drvdata(dev, NULL);
+	drm_dev_unref(drm_dev);
 }
 
 static void rockchip_drm_lastclose(struct drm_device *dev)
-- 
2.1.4
