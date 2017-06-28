From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Wed, 28 Jun 2017 15:28:11 +0200
Subject: [PATCH 1/2] drm/atomic: Change drm_atomic_helper_swap_state to return
 an error.
Message-ID: <20170628132812.14927-1-maarten.lankhorst@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to change swap_state to wait indefinitely, but to do this
swap_state should wait interruptibly. This requires propagating
the error to each driver. All drivers have changes to deal with the
clean up. In order to allow easy reverting, the commit that changes
behavior is separate so someone only has to revert that for testing.

Nouveau has a small bugfix, if drm_atomic_helper_wait_for_fences
failed cleanup_planes was not called.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-kernel at vger.kernel.org
Cc: intel-gfx at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-arm-msm at vger.kernel.org
Cc: freedreno at lists.freedesktop.org
Cc: nouveau at lists.freedesktop.org
Cc: linux-tegra at vger.kernel.org
Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 14 ++++++++++++--
 drivers/gpu/drm/drm_atomic_helper.c          | 18 ++++++++++++------
 drivers/gpu/drm/i915/intel_display.c         | 10 +++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c       |  7 ++++++-
 drivers/gpu/drm/msm/msm_atomic.c             | 14 +++++++++-----
 drivers/gpu/drm/nouveau/nv50_display.c       | 10 ++++++++--
 drivers/gpu/drm/tegra/drm.c                  |  7 ++++++-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c          |  6 +++++-
 drivers/gpu/drm/vc4/vc4_kms.c                | 21 +++++++++++++--------
 include/drm/drm_atomic_helper.h              |  4 ++--
 10 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 516d9547d331..d4f787bf1d4a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -544,9 +544,11 @@ static int atmel_hlcdc_dc_atomic_commit(struct drm_device *dev,
 		goto error;
 	}
 
-	/* Swap the state, this is the point of no return. */
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret)
+		goto err_pending;
 
+	/* Swap state succeeded, this is the point of no return. */
 	drm_atomic_state_get(state);
 	if (async)
 		queue_work(dc->wq, &commit->work);
@@ -555,6 +557,14 @@ static int atmel_hlcdc_dc_atomic_commit(struct drm_device *dev,
 
 	return 0;
 
+err_pending:
+	/* Fail the commit, wake up any waiter. */
+	spin_lock(&dc->commit.wait.lock);
+	dc->commit.pending = false;
+	wake_up_all_locked(&dc->commit.wait);
+	spin_unlock(&dc->commit.wait.lock);
+err_free:
+	kfree(commit);
 error:
 	drm_atomic_helper_cleanup_planes(dev, state);
 	return ret;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index f1847d29ba3e..f66b6c45cdd0 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1387,10 +1387,8 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 
 	if (!nonblock) {
 		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
-		if (ret) {
-			drm_atomic_helper_cleanup_planes(dev, state);
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
 	/*
@@ -1399,7 +1397,9 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	 * the software side now.
 	 */
 
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret)
+		goto err;
 
 	/*
 	 * Everything below can be run asynchronously without the need to grab
@@ -1428,6 +1428,10 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 		commit_tail(state);
 
 	return 0;
+
+err:
+	drm_atomic_helper_cleanup_planes(dev, state);
+	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit);
 
@@ -2137,7 +2141,7 @@ EXPORT_SYMBOL(drm_atomic_helper_cleanup_planes);
  * the current atomic helpers this is almost always the case, since the helpers
  * don't pass the right state structures to the callbacks.
  */
-void drm_atomic_helper_swap_state(struct drm_atomic_state *state,
+int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 				  bool stall)
 {
 	int i;
@@ -2214,6 +2218,8 @@ void drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 
 	__for_each_private_obj(state, obj, obj_state, i, funcs)
 		funcs->swap_state(obj, &state->private_objs[i].obj_state);
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_helper_swap_state);
 
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 7d416428bdc1..e211d703fe2e 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -13183,7 +13183,15 @@ static int intel_atomic_commit(struct drm_device *dev,
 	if (INTEL_GEN(dev_priv) < 9)
 		state->legacy_cursor_update = false;
 
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret) {
+		i915_sw_fence_commit(&intel_state->commit_ready);
+
+		mutex_lock(&dev->struct_mutex);
+		drm_atomic_helper_cleanup_planes(dev, state);
+		mutex_unlock(&dev->struct_mutex);
+		return ret;
+	}
 	dev_priv->wm.distrust_bios_wm = false;
 	intel_shared_dpll_swap_state(state);
 	intel_atomic_track_fbs(state);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 56f802d0a51c..9a130c84c861 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -109,7 +109,12 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	mutex_lock(&private->commit.lock);
 	flush_work(&private->commit.work);
 
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret) {
+		mutex_unlock(&private->commit.lock);
+		drm_atomic_helper_cleanup_planes(drm, state);
+		return ret;
+	}
 
 	drm_atomic_state_get(state);
 	if (async)
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 9633a68b14d7..85dd485fdef4 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -232,8 +232,12 @@ int msm_atomic_commit(struct drm_device *dev,
 	 * mark our set of crtc's as busy:
 	 */
 	ret = start_atomic(dev->dev_private, c->crtc_mask);
+	if (ret)
+		goto err_free;
+
+	ret = drm_atomic_helper_swap_state(state, true);
 	if (ret) {
-		kfree(c);
+		commit_destroy(c);
 		goto error;
 	}
 
@@ -241,11 +245,9 @@ int msm_atomic_commit(struct drm_device *dev,
 	 * This is the point of no return - everything below never fails except
 	 * when the hw goes bonghits. Which means we can commit the new state on
 	 * the software side now.
+	 *
+	 * swap driver private state while still holding state_lock
 	 */
-
-	drm_atomic_helper_swap_state(state, true);
-
-	/* swap driver private state while still holding state_lock */
 	if (to_kms_state(state)->state)
 		priv->kms->funcs->swap_state(priv->kms, state);
 
@@ -275,6 +277,8 @@ int msm_atomic_commit(struct drm_device *dev,
 
 	return 0;
 
+err_free:
+	kfree(c);
 error:
 	drm_atomic_helper_cleanup_planes(dev, state);
 	return ret;
diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
index 42a85c14aea0..fb2c763c88a8 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -4119,9 +4119,13 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 	if (!nonblock) {
 		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
 		if (ret)
-			goto done;
+			goto err_cleanup;
 	}
 
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret)
+		goto err_cleanup;
+
 	for_each_plane_in_state(state, plane, plane_state, i) {
 		struct nv50_wndw_atom *asyw = nv50_wndw_atom(plane_state);
 		struct nv50_wndw *wndw = nv50_wndw(plane);
@@ -4135,7 +4139,6 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 		}
 	}
 
-	drm_atomic_helper_swap_state(state, true);
 	drm_atomic_state_get(state);
 
 	if (nonblock)
@@ -4158,7 +4161,10 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 		pm_runtime_put_autosuspend(dev->dev);
 		drm->have_disp_power_ref = false;
 	}
+	goto done;
 
+err_cleanup:
+	drm_atomic_helper_cleanup_planes(dev, state);
 done:
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index ad3d124a972d..3ba659a5940d 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -100,7 +100,12 @@ static int tegra_atomic_commit(struct drm_device *drm,
 	 * the software side now.
 	 */
 
-	drm_atomic_helper_swap_state(state, true);
+	err = drm_atomic_helper_swap_state(state, true);
+	if (err) {
+		mutex_unlock(&tegra->commit.lock);
+		drm_atomic_helper_cleanup_planes(drm, state);
+		return err;
+	}
 
 	drm_atomic_state_get(state);
 	if (nonblock)
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index d67e18983a7d..049d2f5a1ee4 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -108,7 +108,11 @@ static int tilcdc_commit(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret) {
+		drm_atomic_helper_cleanup_planes(dev, state);
+		return ret;
+	}
 
 	/*
 	 * Everything below can be run asynchronously without the need to grab
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 27edae427025..83952a4014a5 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -113,20 +113,20 @@ static int vc4_atomic_commit(struct drm_device *dev,
 
 	if (!nonblock) {
 		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
-		if (ret) {
-			drm_atomic_helper_cleanup_planes(dev, state);
-			up(&vc4->async_modeset);
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
 	/*
-	 * This is the point of no return - everything below never fails except
-	 * when the hw goes bonghits. Which means we can commit the new state on
+	 * If swap_state() succeeds, this is the point of no return -
+	 * everything below never fails except when the hw goes bonghits.
+	 * Which means we can commit the new state on
 	 * the software side now.
 	 */
 
-	drm_atomic_helper_swap_state(state, true);
+	ret = drm_atomic_helper_swap_state(state, true);
+	if (ret)
+		goto err;
 
 	/*
 	 * Everything below can be run asynchronously without the need to grab
@@ -151,6 +151,11 @@ static int vc4_atomic_commit(struct drm_device *dev,
 		vc4_atomic_complete_commit(state);
 
 	return 0;
+
+err:
+	drm_atomic_helper_cleanup_planes(dev, state);
+	up(&vc4->async_modeset);
+	return ret;
 }
 
 static struct drm_framebuffer *vc4_fb_create(struct drm_device *dev,
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 3bfeb2b2f746..4f3b6b5362ec 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -80,8 +80,8 @@ void
 drm_atomic_helper_disable_planes_on_crtc(struct drm_crtc_state *old_crtc_state,
 					 bool atomic);
 
-void drm_atomic_helper_swap_state(struct drm_atomic_state *state,
-				  bool stall);
+int __must_check drm_atomic_helper_swap_state(struct drm_atomic_state *state,
+					      bool stall);
 
 /* nonblocking commit helpers */
 int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
-- 
2.11.0
