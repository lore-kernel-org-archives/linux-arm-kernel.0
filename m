From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 17 Dec 2015 11:06:14 +0800
Subject: [PATCH v3 5/8] drm/rockchip: support atomic asynchronous commit
In-Reply-To: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
References: <1450321275-31154-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1450321574-31346-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If drm core requests a async commit, rockchip_drm_atomic_commit
will schedule a work task to update later.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3: None
Changes in v2:
- serialize outstanding asynchronous commits
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |    3 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   10 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   54 ++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 13 deletions(-)

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
index 4468f98..bb8b076 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -42,6 +42,13 @@ struct rockchip_crtc_funcs {
 	void (*wait_for_update)(struct drm_crtc *crtc);
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
@@ -52,8 +59,11 @@ struct rockchip_drm_private {
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
index 7c974a4..0bc1d5e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -210,20 +210,11 @@ rockchip_atomic_wait_for_complete(struct drm_atomic_state *old_state)
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
@@ -255,6 +246,43 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
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
