From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  1 Dec 2015 11:26:26 +0800
Subject: [RFC PATCH 4/9] drm/rockchip: support atomic asynchronous commit
In-Reply-To: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1448940391-23333-5-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If drm core requests a async commit, rockchip_drm_atomic_commit
will schedule a work task to update later.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c |   60 ++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index c86d93a..30ddf4a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -29,6 +29,12 @@ struct rockchip_drm_fb {
 	struct drm_gem_object *obj[ROCKCHIP_MAX_FB_BUFFER];
 };
 
+struct rockchip_atomic_commit {
+	struct work_struct	work;
+	struct drm_device	*dev;
+	struct drm_atomic_state *state;
+};
+
 struct drm_gem_object *rockchip_fb_get_gem_obj(struct drm_framebuffer *fb,
 					       unsigned int plane)
 {
@@ -195,20 +201,11 @@ static void rockchip_atomic_wait_for_complete(struct drm_atomic_state *state)
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
+	struct drm_device *dev = commit->dev;
+	struct drm_atomic_state *state = commit->state;
 
 	/*
 	 * TODO: do fence wait here.
@@ -226,6 +223,43 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
 
 	drm_atomic_state_free(state);
 
+	kfree(commit);
+}
+
+static void rockchip_drm_atomic_work(struct work_struct *work)
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
+	int ret;
+	struct rockchip_atomic_commit *commit;
+
+	ret = drm_atomic_helper_prepare_planes(dev, state);
+	if (ret)
+		return ret;
+
+	drm_atomic_helper_swap_state(dev, state);
+
+	commit = kzalloc(sizeof(*commit), GFP_KERNEL);
+	if (!commit)
+		return -ENOMEM;
+
+	INIT_WORK(&commit->work, rockchip_drm_atomic_work);
+	commit->dev = dev;
+	commit->state = state;
+
+	if (async)
+		schedule_work(&commit->work);
+	else
+		rockchip_atomic_commit_complete(commit);
+
 	return 0;
 }
 
-- 
1.7.9.5
