From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 24 Mar 2017 14:27:36 +0000
Subject: [PATCH] drm: mali-dp: Enable power management for the device.
Message-ID: <20170324142736.32006-1-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable runtime and system Power Management. Clocks are now managed
from malidp_crtc_{enable,disable} functions. Suspend-to-RAM tested
as working on Juno.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/arm/malidp_crtc.c |  14 ++++-
 drivers/gpu/drm/arm/malidp_drv.c  | 128 +++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/arm/malidp_drv.h  |   1 +
 drivers/gpu/drm/arm/malidp_hw.h   |   5 ++
 4 files changed, 125 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index f9d665550d3e..fab776c37602 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -16,6 +16,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <video/videomode.h>
 
 #include "malidp_drv.h"
@@ -58,9 +59,14 @@ static void malidp_crtc_enable(struct drm_crtc *crtc)
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
 	struct videomode vm;
+	int err = pm_runtime_get_sync(crtc->dev->dev);
 
-	drm_display_mode_to_videomode(&crtc->state->adjusted_mode, &vm);
+	if (err < 0) {
+		DRM_DEBUG_DRIVER("Failed to enable runtime power management: %d\n", err);
+		return;
+	}
 
+	drm_display_mode_to_videomode(&crtc->state->adjusted_mode, &vm);
 	clk_prepare_enable(hwdev->pxlclk);
 
 	/* We rely on firmware to set mclk to a sensible level. */
@@ -75,10 +81,16 @@ static void malidp_crtc_disable(struct drm_crtc *crtc)
 {
 	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
 	struct malidp_hw_device *hwdev = malidp->dev;
+	int err;
 
 	drm_crtc_vblank_off(crtc);
 	hwdev->enter_config_mode(hwdev);
 	clk_disable_unprepare(hwdev->pxlclk);
+
+	err = pm_runtime_put(crtc->dev->dev);
+	if (err < 0) {
+		DRM_DEBUG_DRIVER("Failed to disable runtime power management: %d\n", err);
+	}
 }
 
 static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index f5cecdc3f14a..55fb086cd4b4 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -13,9 +13,11 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/console.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -91,6 +93,8 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 {
 	struct drm_device *drm = state->dev;
 
+	pm_runtime_get_sync(drm->dev);
+
 	drm_atomic_helper_commit_modeset_disables(drm, state);
 
 	drm_atomic_helper_commit_planes(drm, state, 0);
@@ -101,6 +105,8 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_wait_for_vblanks(drm, state);
 
+	pm_runtime_put(drm->dev);
+
 	drm_atomic_helper_cleanup_planes(drm, state);
 }
 
@@ -283,6 +289,37 @@ static bool malidp_has_sufficient_address_space(const struct resource *res,
 
 #define MAX_OUTPUT_CHANNELS	3
 
+static int malidp_runtime_pm_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct malidp_drm *malidp = drm->dev_private;
+	struct malidp_hw_device *hwdev = malidp->dev;
+
+	/* we can only suspend if the hardware is in config mode */
+	WARN_ON(!hwdev->in_config_mode(hwdev));
+
+	hwdev->pm_suspended = true;
+	clk_disable_unprepare(hwdev->mclk);
+	clk_disable_unprepare(hwdev->aclk);
+	clk_disable_unprepare(hwdev->pclk);
+
+	return 0;
+}
+
+static int malidp_runtime_pm_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct malidp_drm *malidp = drm->dev_private;
+	struct malidp_hw_device *hwdev = malidp->dev;
+
+	clk_prepare_enable(hwdev->pclk);
+	clk_prepare_enable(hwdev->aclk);
+	clk_prepare_enable(hwdev->mclk);
+	hwdev->pm_suspended = false;
+
+	return 0;
+}
+
 static int malidp_bind(struct device *dev)
 {
 	struct resource *res;
@@ -312,7 +349,6 @@ static int malidp_bind(struct device *dev)
 	memcpy(hwdev, of_device_get_match_data(dev), sizeof(*hwdev));
 	malidp->dev = hwdev;
 
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hwdev->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(hwdev->regs))
@@ -345,14 +381,17 @@ static int malidp_bind(struct device *dev)
 		goto alloc_fail;
 	}
 
-	/* Enable APB clock in order to get access to the registers */
-	clk_prepare_enable(hwdev->pclk);
-	/*
-	 * Enable AXI clock and main clock so that prefetch can start once
-	 * the registers are set
-	 */
-	clk_prepare_enable(hwdev->aclk);
-	clk_prepare_enable(hwdev->mclk);
+	drm->dev_private = malidp;
+	dev_set_drvdata(dev, drm);
+
+	/* Enable power management */
+	pm_runtime_enable(dev);
+
+	/* Resume device to enable the clocks */
+	if (pm_runtime_enabled(dev))
+		pm_runtime_get_sync(dev);
+	else
+		malidp_runtime_pm_resume(dev);
 
 	dev_id = of_match_device(malidp_drm_of_match, dev);
 	if (!dev_id) {
@@ -392,14 +431,12 @@ static int malidp_bind(struct device *dev)
 		out_depth = (out_depth << 8) | (output_width[i] & 0xf);
 	malidp_hw_write(hwdev, out_depth, hwdev->map.out_depth_base);
 
-	drm->dev_private = malidp;
-	dev_set_drvdata(dev, drm);
 	atomic_set(&malidp->config_valid, 0);
 	init_waitqueue_head(&malidp->wq);
 
 	ret = malidp_init(drm);
 	if (ret < 0)
-		goto init_fail;
+		goto query_hw_fail;
 
 	/* Set the CRTC's port so that the encoder component can find it */
 	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
@@ -426,6 +463,7 @@ static int malidp_bind(struct device *dev)
 		DRM_ERROR("failed to initialise vblank\n");
 		goto vblank_fail;
 	}
+	pm_runtime_put(dev);
 
 	drm_mode_config_reset(drm);
 
@@ -451,7 +489,9 @@ static int malidp_bind(struct device *dev)
 		drm_fbdev_cma_fini(malidp->fbdev);
 		malidp->fbdev = NULL;
 	}
+	drm_kms_helper_poll_fini(drm);
 fbdev_fail:
+	pm_runtime_get_sync(dev);
 	drm_vblank_cleanup(drm);
 vblank_fail:
 	malidp_se_irq_fini(drm);
@@ -464,13 +504,14 @@ static int malidp_bind(struct device *dev)
 	malidp->crtc.port = NULL;
 port_fail:
 	malidp_fini(drm);
-init_fail:
+query_hw_fail:
+	pm_runtime_put(dev);
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		malidp_runtime_pm_suspend(dev);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-query_hw_fail:
-	clk_disable_unprepare(hwdev->mclk);
-	clk_disable_unprepare(hwdev->aclk);
-	clk_disable_unprepare(hwdev->pclk);
 	drm_dev_unref(drm);
 alloc_fail:
 	of_reserved_mem_device_release(dev);
@@ -482,7 +523,6 @@ static void malidp_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
-	struct malidp_hw_device *hwdev = malidp->dev;
 
 	drm_dev_unregister(drm);
 	if (malidp->fbdev) {
@@ -490,18 +530,21 @@ static void malidp_unbind(struct device *dev)
 		malidp->fbdev = NULL;
 	}
 	drm_kms_helper_poll_fini(drm);
+	pm_runtime_get_sync(dev);
+	drm_vblank_cleanup(drm);
 	malidp_se_irq_fini(drm);
 	malidp_de_irq_fini(drm);
-	drm_vblank_cleanup(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;
 	malidp_fini(drm);
+	pm_runtime_put(dev);
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		malidp_runtime_pm_suspend(dev);
 	drm->dev_private = NULL;
 	dev_set_drvdata(dev, NULL);
-	clk_disable_unprepare(hwdev->mclk);
-	clk_disable_unprepare(hwdev->aclk);
-	clk_disable_unprepare(hwdev->pclk);
 	drm_dev_unref(drm);
 	of_reserved_mem_device_release(dev);
 }
@@ -557,11 +600,52 @@ static int malidp_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused malidp_pm_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct malidp_drm *malidp = drm->dev_private;
+
+	drm_kms_helper_poll_disable(drm);
+	console_lock();
+	drm_fbdev_cma_set_suspend(malidp->fbdev, 1);
+	console_unlock();
+	malidp->pm_state = drm_atomic_helper_suspend(drm);
+	if (IS_ERR(malidp->pm_state)) {
+		console_lock();
+		drm_fbdev_cma_set_suspend(malidp->fbdev, 0);
+		console_unlock();
+		drm_kms_helper_poll_enable(drm);
+		return PTR_ERR(malidp->pm_state);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused malidp_pm_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct malidp_drm *malidp = drm->dev_private;
+
+	drm_atomic_helper_resume(drm, malidp->pm_state);
+	console_lock();
+	drm_fbdev_cma_set_suspend(malidp->fbdev, 0);
+	console_unlock();
+	drm_kms_helper_poll_enable(drm);
+
+	return 0;
+}
+
+static const struct dev_pm_ops malidp_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
+	SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
+};
+
 static struct platform_driver malidp_platform_driver = {
 	.probe		= malidp_platform_probe,
 	.remove		= malidp_platform_remove,
 	.driver	= {
 		.name = "mali-dp",
+		.pm = &malidp_pm_ops,
 		.of_match_table	= malidp_drm_of_match,
 	},
 };
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index dbc617c6e4ef..cd4c04c65ead 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -24,6 +24,7 @@ struct malidp_drm {
 	struct drm_crtc crtc;
 	wait_queue_head_t wq;
 	atomic_t config_valid;
+	struct drm_atomic_state *pm_state;
 };
 
 #define crtc_to_malidp_device(x) container_of(x, struct malidp_drm, crtc)
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 00974b59407d..ea2dbae08990 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -156,6 +156,9 @@ struct malidp_hw_device {
 	u8 min_line_size;
 	u16 max_line_size;
 
+	/* track the device PM state */
+	bool pm_suspended;
+
 	/* size of memory used for rotating layers, up to two banks available */
 	u32 rotation_memory[2];
 };
@@ -173,12 +176,14 @@ extern const struct malidp_hw_device malidp_device[MALIDP_MAX_DEVICES];
 
 static inline u32 malidp_hw_read(struct malidp_hw_device *hwdev, u32 reg)
 {
+	WARN_ON(hwdev->pm_suspended);
 	return readl(hwdev->regs + reg);
 }
 
 static inline void malidp_hw_write(struct malidp_hw_device *hwdev,
 				   u32 value, u32 reg)
 {
+	WARN_ON(hwdev->pm_suspended);
 	writel(value, hwdev->regs + reg);
 }
 
-- 
2.12.0
