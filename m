From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Apr 2014 16:42:18 +0200
Subject: [PATCH 1/4] drm/fb-helper: Fix hpd vs. initial config races
Message-ID: <1398177741-28482-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

Some drivers need to be able to have a perfect race-free fbcon setup.
Current drivers only enable hotplug processing after the call to
drm_fb_helper_initial_config which leaves a tiny but important race.

This race is especially noticable on embedded platforms where the
driver itself enables the voltage for the hdmi output, since only then
will monitors (after a bit of delay, as usual) respond by asserting
the hpd pin.

Most of the infrastructure is already there with the split-out
drm_fb_helper_init. And drm_fb_helper_initial_config already has all
the required locking to handle concurrent hpd events since

commit 53f1904bced78d7c00f5d874c662ec3ac85d0f9f
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Mar 20 14:26:35 2014 +0100

    drm/fb-helper: improve drm_fb_helper_initial_config locking

The only missing bit is making drm_fb_helper_hotplug_event save
against concurrent calls of drm_fb_helper_initial_config. The only
unprotected bit is the check for fb_helper->fb.

With that drivers can first initialize the fb helper, then enabel
hotplug processing and then set up the initial config all in a
completely race-free manner. Update kerneldoc and convert i915 as a
proof of concept.

Feature requested by Thierry since his tegra driver atm reliably boots
slowly enough to misses the hotplug event for an external hdmi screen,
but also reliably boots to quickly for the hpd pin to be asserted when
the fb helper calls into the hdmi ->detect function.

Cc: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 11 +++++------
 drivers/gpu/drm/i915/i915_dma.c |  3 ---
 drivers/gpu/drm/i915/i915_drv.c |  2 --
 drivers/gpu/drm/i915/i915_drv.h |  1 -
 drivers/gpu/drm/i915/i915_irq.c |  4 ----
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index e95ed5805f07..80ce92ab91f9 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1587,8 +1587,10 @@ EXPORT_SYMBOL(drm_fb_helper_initial_config);
  * either the output polling work or a work item launched from the driver's
  * hotplug interrupt).
  *
- * Note that the driver must ensure that this is only called _after_ the fb has
- * been fully set up, i.e. after the call to drm_fb_helper_initial_config.
+ * Note that drivers may call this even before calling
+ * drm_fb_helper_initial_config but only aftert drm_fb_helper_init. This allows
+ * for a race-free fbcon setup and will make sure that the fbdev emulation will
+ * not miss any hotplug events.
  *
  * RETURNS:
  * 0 on success and a non-zero error code otherwise.
@@ -1598,11 +1600,8 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
 	struct drm_device *dev = fb_helper->dev;
 	u32 max_width, max_height;
 
-	if (!fb_helper->fb)
-		return 0;
-
 	mutex_lock(&fb_helper->dev->mode_config.mutex);
-	if (!drm_fb_helper_is_bound(fb_helper)) {
+	if (!fb_helper->fb || !drm_fb_helper_is_bound(fb_helper)) {
 		fb_helper->delayed_hotplug = true;
 		mutex_unlock(&fb_helper->dev->mode_config.mutex);
 		return 0;
diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
index cc0c6eded51c..89ba88d37ae1 100644
--- a/drivers/gpu/drm/i915/i915_dma.c
+++ b/drivers/gpu/drm/i915/i915_dma.c
@@ -1375,9 +1375,6 @@ static int i915_load_modeset_init(struct drm_device *dev)
 	 */
 	intel_fbdev_initial_config(dev);
 
-	/* Only enable hotplug handling once the fbdev is fully set up. */
-	dev_priv->enable_hotplug_processing = true;
-
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 254b3236200b..dee36a5b7fae 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -448,7 +448,6 @@ static int i915_drm_freeze(struct drm_device *dev)
 		cancel_delayed_work_sync(&dev_priv->rps.delayed_resume_work);
 
 		drm_irq_uninstall(dev);
-		dev_priv->enable_hotplug_processing = false;
 		/*
 		 * Disable CRTCs directly since we want to preserve sw state
 		 * for _thaw.
@@ -589,7 +588,6 @@ static int __i915_drm_thaw(struct drm_device *dev, bool restore_gtt_mappings)
 		 * notifications.
 		 * */
 		intel_hpd_init(dev);
-		dev_priv->enable_hotplug_processing = true;
 		/* Config may have changed between suspend and resume */
 		intel_resume_hotplug(dev);
 	}
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 7d6acb401fd9..41094d6357b1 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1321,7 +1321,6 @@ struct drm_i915_private {
 	u32 pipestat_irq_mask[I915_MAX_PIPES];
 
 	struct work_struct hotplug_work;
-	bool enable_hotplug_processing;
 	struct {
 		unsigned long hpd_last_jiffies;
 		int hpd_cnt;
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index c828f5b78250..179588b2368f 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -1003,10 +1003,6 @@ static void i915_hotplug_work_func(struct work_struct *work)
 	bool changed = false;
 	u32 hpd_event_bits;
 
-	/* HPD irq before everything is fully set up. */
-	if (!dev_priv->enable_hotplug_processing)
-		return;
-
 	mutex_lock(&mode_config->mutex);
 	DRM_DEBUG_KMS("running encoder hotplug functions\n");
 
-- 
1.9.2
