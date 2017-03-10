From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:42 -0500
Subject: [PATCH 27/41] drm/rockchip: Restore psr->state when enable/disable
 psr failed
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-28-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

If we failed disable psr, it would hang the display until next psr
cycle coming. So we should restore psr->state when it failed.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 +++-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 12 ++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        | 20 +++++++++++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |  2 +-
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index dcf39ea0d14b..35ea04ff4078 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -156,8 +156,10 @@ int analogix_dp_disable_psr(struct device *dev)
 	psr_vsc.DB1 = 0;
 
 	ret = drm_dp_dpcd_writeb(&dp->aux, DP_SET_POWER, DP_SET_POWER_D0);
-	if (ret != 1)
+	if (ret != 1) {
 		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
+		return ret;
+	}
 
 	return analogix_dp_send_psr_spd(dp, &psr_vsc, false);
 }
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index b6c6d6d09d7e..0614d32c5435 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -76,7 +76,7 @@ struct rockchip_dp_device {
 	struct analogix_dp_plat_data plat_data;
 };
 
-static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
+static int analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 {
 	struct rockchip_dp_device *dp = to_dp(encoder);
 	struct drm_crtc *crtc = dp->encoder.crtc;
@@ -84,12 +84,12 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 	int ret;
 
 	if (!analogix_dp_psr_enabled(dp->dev))
-		return;
+		return 0;
 
 	dev_dbg(dp->dev, "%s PSR...\n", enabled ? "enable" : "disable");
 
 	if (!crtc)
-		return;
+		return -EINVAL;
 
 	vact_end = crtc->mode.vtotal - crtc->mode.vsync_start + crtc->mode.vdisplay;
 
@@ -97,13 +97,13 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 					  PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
 	if (ret) {
 		dev_err(dp->dev, "line flag interrupt did not arrive\n");
-		return;
+		return -ETIMEDOUT;
 	}
 
 	if (enabled)
-		analogix_dp_enable_psr(dp->dev);
+		return analogix_dp_enable_psr(dp->dev);
 	else
-		analogix_dp_disable_psr(dp->dev);
+		return analogix_dp_disable_psr(dp->dev);
 }
 
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index b339ca943139..9376f4396b6b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -36,7 +36,7 @@ struct psr_drv {
 
 	struct delayed_work	flush_work;
 
-	void (*set)(struct drm_encoder *encoder, bool enable);
+	int (*set)(struct drm_encoder *encoder, bool enable);
 };
 
 static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
@@ -93,19 +93,25 @@ static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
 		return;
 	}
 
-	psr->state = state;
-
 	/* Actually commit the state change to hardware */
-	switch (psr->state) {
+	switch (state) {
 	case PSR_ENABLE:
-		psr->set(psr->encoder, true);
+		if (psr->set(psr->encoder, true))
+			return;
 		break;
 
 	case PSR_DISABLE:
 	case PSR_FLUSH:
-		psr->set(psr->encoder, false);
+		if (psr->set(psr->encoder, false))
+			return;
 		break;
+
+	default:
+		pr_err("%s: Unknown state %d\n", __func__, state);
+		return;
 	}
+
+	psr->state = state;
 }
 
 static void psr_set_state(struct psr_drv *psr, enum psr_state state)
@@ -229,7 +235,7 @@ EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
  * Zero on success, negative errno on failure.
  */
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
-			void (*psr_set)(struct drm_encoder *, bool enable))
+			int (*psr_set)(struct drm_encoder *, bool enable))
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index b1ea0155e57c..06537ee27565 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -22,7 +22,7 @@ int rockchip_drm_psr_activate(struct drm_encoder *encoder);
 int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
 
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
-			void (*psr_set)(struct drm_encoder *, bool enable));
+			int (*psr_set)(struct drm_encoder *, bool enable));
 void rockchip_drm_psr_unregister(struct drm_encoder *encoder);
 
 #endif /* __ROCKCHIP_DRM_PSR__ */
-- 
2.12.0.246.ga2ecc84866-goog
