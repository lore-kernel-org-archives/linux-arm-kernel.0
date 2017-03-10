From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:20 -0500
Subject: [PATCH 05/41] drm/bridge: analogix_dp: set psr activate/deactivate
 when enable/disable bridge
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-6-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

There's a race between when bridge_disable and when vop_crtc_disable
are called. If the flush timer triggers a new psr work between these,
we will operate eDP without power shutdowned by bridge_disable. In this
case, moving activate/deactivate to enable/disable bridge to avoid it.

Cc: St?phane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  7 +++++-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c     | 30 ++++++++++++++++++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h     |  4 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |  4 ----
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 8548e8271639..28c0d4406454 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -159,12 +159,17 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 		return ret;
 	}
 
-	return 0;
+	return rockchip_drm_psr_activate(&dp->encoder);
 }
 
 static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
 {
 	struct rockchip_dp_device *dp = to_dp(plat_data);
+	int ret;
+
+	ret = rockchip_drm_psr_deactivate(&dp->encoder);
+	if (ret != 0)
+		return ret;
 
 	clk_disable_unprepare(dp->pclk);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index a553e182ff53..4c379e90b178 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -57,6 +57,24 @@ static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
 	return psr;
 }
 
+static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
+{
+	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
+	struct psr_drv *psr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	list_for_each_entry(psr, &drm_drv->psr_list, list) {
+		if (psr->encoder == encoder)
+			goto out;
+	}
+	psr = ERR_PTR(-ENODEV);
+
+out:
+	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	return psr;
+}
+
 static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
 {
 	/*
@@ -115,14 +133,14 @@ static void psr_flush_handler(unsigned long data)
 
 /**
  * rockchip_drm_psr_activate - activate PSR on the given pipe
- * @crtc: CRTC to obtain the PSR encoder
+ * @encoder: encoder to obtain the PSR encoder
  *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_psr_activate(struct drm_crtc *crtc)
+int rockchip_drm_psr_activate(struct drm_encoder *encoder)
 {
-	struct psr_drv *psr = find_psr_by_crtc(crtc);
+	struct psr_drv *psr = find_psr_by_encoder(encoder);
 	unsigned long flags;
 
 	if (IS_ERR(psr))
@@ -138,14 +156,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_activate);
 
 /**
  * rockchip_drm_psr_deactivate - deactivate PSR on the given pipe
- * @crtc: CRTC to obtain the PSR encoder
+ * @encoder: encoder to obtain the PSR encoder
  *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_psr_deactivate(struct drm_crtc *crtc)
+int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 {
-	struct psr_drv *psr = find_psr_by_crtc(crtc);
+	struct psr_drv *psr = find_psr_by_encoder(encoder);
 	unsigned long flags;
 
 	if (IS_ERR(psr))
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index b420cf1bf902..b1ea0155e57c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -18,8 +18,8 @@
 void rockchip_drm_psr_flush_all(struct drm_device *dev);
 int rockchip_drm_psr_flush(struct drm_crtc *crtc);
 
-int rockchip_drm_psr_activate(struct drm_crtc *crtc);
-int rockchip_drm_psr_deactivate(struct drm_crtc *crtc);
+int rockchip_drm_psr_activate(struct drm_encoder *encoder);
+int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
 
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			void (*psr_set)(struct drm_encoder *, bool enable));
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 0539afb6b7c8..1c1e8535ad28 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -568,8 +568,6 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
 
 	WARN_ON(vop->event);
 
-	rockchip_drm_psr_deactivate(&vop->crtc);
-
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * disable that crtc. Otherwise we might try to scan from a destroyed
@@ -981,8 +979,6 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
 	clk_set_rate(vop->dclk, adjusted_mode->clock * 1000);
 
 	VOP_CTRL_SET(vop, standby, 0);
-
-	rockchip_drm_psr_activate(&vop->crtc);
 }
 
 static bool vop_fs_irq_is_pending(struct vop *vop)
-- 
2.12.0.246.ga2ecc84866-goog
