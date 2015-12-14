From: mark.yao@rock-chips.com (Mark Yao)
Date: Mon, 14 Dec 2015 16:35:20 +0800
Subject: [PATCH v2 5/8] drm/rockchip: support atomic asynchronous commit
In-Reply-To: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
References: <1450081931-9709-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450082120-10026-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If drm core requests a async commit, rockchip_drm_atomic_commit
will schedule a work task to update later.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---

Changes in v2:
- serialize outstanding asynchronous commits

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    3 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   10 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   83 +++++++++++++++++++--------
 3 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index ab3e0f6..5edd5ccb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -140,6 +140,9 @@ static int rockchip_drm_load(struct drm_device *drm_dev, unsigned long flags)
 	if (!private)
 		return -ENOMEM;
 
+	mutex_init(&private->commit.lock);
+	INIT_WORK(&private->commit.work, rockchip_drm_atomic_work);
+
 	drm_dev->dev_private = private;
 
 	drm_mode_config_init(drm_dev);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 513ff98..a2f7aca 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -41,6 +41,13 @@ struct rockchip_crtc_funcs {
 	void (*disable_vblank)(struct drm_crtc *crtc);
 };
 
+struct rockchip_atomic_commit {
+	struct work_struct	work;
+	struct drm_atomic_state *state;
+	struct drm_device *dev;
+	struct mutex lock;
+};
+
 /*
  * Rockchip drm private structure.
  *
@@ -51,8 +58,11 @@ struct rockchip_drm_private {
 	struct drm_fb_helper fbdev_helper;
 	struct drm_gem_object *fbdev_bo;
 	const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
+
+	struct rockchip_atomic_commit commit;
 };
 
+void rockchip_drm_atomic_work(struct work_struct *work);
 int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
 				 const struct rockchip_crtc_funcs *crtc_funcs);
 void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 9aca778..1753bee 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -167,48 +167,44 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
 		drm_fb_helper_hotplug_event(fb_helper);
 }
 
-static void rockchip_atomic_wait_for_complete(struct drm_atomic_state *state)
+static void
+rockchip_atomic_wait_for_complete(struct drm_atomic_state *old_state)
 {
-	struct drm_crtc_state *crtc_state;
+	struct drm_crtc_state *old_crtc_state;
 	struct drm_crtc *crtc;
-	int i;
+	int i, ret;
+
+	for_each_crtc_in_state(old_state, crtc, old_crtc_state, i) {
+		/* No one cares about the old state, so abuse it for tracking
+		 * and store whether we hold a vblank reference (and should do a
+		 * vblank wait) in the ->enable boolean.
+		 */
+		old_crtc_state->enable = false;
 
-	for_each_crtc_in_state(state, crtc, crtc_state, i) {
 		if (!crtc->state->active)
 			continue;
 
-		WARN_ON(drm_crtc_vblank_get(crtc));
-	}
-
-	for_each_crtc_in_state(state, crtc, crtc_state, i) {
-		if (!crtc->state->active)
+		ret = drm_crtc_vblank_get(crtc);
+		if (ret != 0)
 			continue;
 
-		rockchip_crtc_wait_for_update(crtc);
+		old_crtc_state->enable = true;
 	}
 
-	for_each_crtc_in_state(state, crtc, crtc_state, i) {
-		if (!crtc->state->active)
+	for_each_crtc_in_state(old_state, crtc, old_crtc_state, i) {
+		if (!old_crtc_state->enable)
 			continue;
 
+		rockchip_crtc_wait_for_update(crtc);
 		drm_crtc_vblank_put(crtc);
 	}
 }
 
-int rockchip_drm_atomic_commit(struct drm_device *dev,
-			       struct drm_atomic_state *state,
-			       bool async)
+static void
+rockchip_atomic_commit_complete(struct rockchip_atomic_commit *commit)
 {
-	int ret;
-
-	if (async)
-		return -EBUSY;
-
-	ret = drm_atomic_helper_prepare_planes(dev, state);
-	if (ret)
-		return ret;
-
-	drm_atomic_helper_swap_state(dev, state);
+	struct drm_atomic_state *state = commit->state;
+	struct drm_device *dev = commit->dev;
 
 	/*
 	 * TODO: do fence wait here.
@@ -240,6 +236,43 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
 	drm_atomic_helper_cleanup_planes(dev, state);
 
 	drm_atomic_state_free(state);
+}
+
+void rockchip_drm_atomic_work(struct work_struct *work)
+{
+	struct rockchip_atomic_commit *commit = container_of(work,
+					struct rockchip_atomic_commit, work);
+
+	rockchip_atomic_commit_complete(commit);
+}
+
+int rockchip_drm_atomic_commit(struct drm_device *dev,
+			       struct drm_atomic_state *state,
+			       bool async)
+{
+	struct rockchip_drm_private *private = dev->dev_private;
+	struct rockchip_atomic_commit *commit = &private->commit;
+	int ret;
+
+	ret = drm_atomic_helper_prepare_planes(dev, state);
+	if (ret)
+		return ret;
+
+	/* serialize outstanding asynchronous commits */
+	mutex_lock(&commit->lock);
+	flush_work(&commit->work);
+
+	drm_atomic_helper_swap_state(dev, state);
+
+	commit->dev = dev;
+	commit->state = state;
+
+	if (async)
+		schedule_work(&commit->work);
+	else
+		rockchip_atomic_commit_complete(commit);
+
+	mutex_unlock(&commit->lock);
 
 	return 0;
 }
-- 
1.7.9.5
