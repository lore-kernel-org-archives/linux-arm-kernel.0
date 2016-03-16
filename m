From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Mar 2016 14:57:36 +0100
Subject: [PATCH v2 2/9] drm: atmel-hlcdc: support asynchronous atomic commit
 operations
In-Reply-To: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1458136663-21396-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1458136663-21396-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_atomic_helper_commit() does not support asynchronous commits.
Replace it by a specific commit function supporting these kind of requests.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 94 +++++++++++++++++++++++++++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h |  5 ++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 3d8d164..851b4a0 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -427,11 +427,102 @@ static void atmel_hlcdc_fb_output_poll_changed(struct drm_device *dev)
 	}
 }
 
+struct atmel_hlcdc_dc_commit {
+	struct work_struct work;
+	struct drm_device *dev;
+	struct drm_atomic_state *state;
+};
+
+static void
+atmel_hlcdc_dc_atomic_complete(struct atmel_hlcdc_dc_commit *commit)
+{
+	struct drm_device *dev = commit->dev;
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct drm_atomic_state *old_state = commit->state;
+
+	/* Apply the atomic update. */
+	drm_atomic_helper_commit_modeset_disables(dev, old_state);
+	drm_atomic_helper_commit_planes(dev, old_state, false);
+	drm_atomic_helper_commit_modeset_enables(dev, old_state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, old_state);
+
+	drm_atomic_helper_cleanup_planes(dev, old_state);
+
+	drm_atomic_state_free(old_state);
+
+	/* Complete the commit, wake up any waiter. */
+	spin_lock(&dc->commit.wait.lock);
+	dc->commit.pending = false;
+	wake_up_all_locked(&dc->commit.wait);
+	spin_unlock(&dc->commit.wait.lock);
+
+	kfree(commit);
+}
+
+static void atmel_hlcdc_dc_atomic_work(struct work_struct *work)
+{
+	struct atmel_hlcdc_dc_commit *commit =
+		container_of(work, struct atmel_hlcdc_dc_commit, work);
+
+	atmel_hlcdc_dc_atomic_complete(commit);
+}
+
+static int atmel_hlcdc_dc_atomic_commit(struct drm_device *dev,
+					struct drm_atomic_state *state,
+					bool async)
+{
+	struct atmel_hlcdc_dc *dc = dev->dev_private;
+	struct atmel_hlcdc_dc_commit *commit;
+	int ret;
+
+	ret = drm_atomic_helper_prepare_planes(dev, state);
+	if (ret)
+		return ret;
+
+	/* Allocate the commit object. */
+	commit = kzalloc(sizeof(*commit), GFP_KERNEL);
+	if (!commit) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	INIT_WORK(&commit->work, atmel_hlcdc_dc_atomic_work);
+	commit->dev = dev;
+	commit->state = state;
+
+	spin_lock(&dc->commit.wait.lock);
+	ret = wait_event_interruptible_locked(dc->commit.wait,
+					      !dc->commit.pending);
+	if (ret == 0)
+		dc->commit.pending = true;
+	spin_unlock(&dc->commit.wait.lock);
+
+	if (ret) {
+		kfree(commit);
+		goto error;
+	}
+
+	/* Swap the state, this is the point of no return. */
+	drm_atomic_helper_swap_state(dev, state);
+
+	if (async)
+		queue_work(dc->wq, &commit->work);
+	else
+		atmel_hlcdc_dc_atomic_complete(commit);
+
+	return 0;
+
+error:
+	drm_atomic_helper_cleanup_planes(dev, state);
+	return ret;
+}
+
 static const struct drm_mode_config_funcs mode_config_funcs = {
 	.fb_create = atmel_hlcdc_fb_create,
 	.output_poll_changed = atmel_hlcdc_fb_output_poll_changed,
 	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_commit = atmel_hlcdc_dc_atomic_commit,
 };
 
 static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
@@ -509,6 +600,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
 	if (!dc->wq)
 		return -ENOMEM;
 
+	init_waitqueue_head(&dc->commit.wait);
 	dc->desc = match->data;
 	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
 	dev->dev_private = dc;
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
index ec64140..53b4488 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -130,6 +130,7 @@ struct atmel_hlcdc_planes {
  * @planes: instantiated planes
  * @layers: active HLCDC layer
  * @wq: display controller workqueue
+ * @commit: used for async commit handling
  */
 struct atmel_hlcdc_dc {
 	const struct atmel_hlcdc_dc_desc *desc;
@@ -139,6 +140,10 @@ struct atmel_hlcdc_dc {
 	struct atmel_hlcdc_planes *planes;
 	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
 	struct workqueue_struct *wq;
+	struct {
+		wait_queue_head_t wait;
+		bool pending;
+	} commit;
 };
 
 extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
-- 
2.5.0
