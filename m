From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed, 20 Dec 2017 19:20:44 +0100
Subject: [PATCH 2/2] drm/rockchip: Remove analogix psr worker.
In-Reply-To: <20171220182044.20331-1-enric.balletbo@collabora.com>
References: <20171220182044.20331-1-enric.balletbo@collabora.com>
Message-ID: <20171220182044.20331-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Paul <seanpaul@chromium.org>

Now that the spinlocks and timers are gone, we can remove the psr
worker located in rockchip's analogix driver and do the enable/disable
directly. This should simplify the code and remove races on disable.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 30 ++-----------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 93b7102..d32c9b3 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -71,10 +71,6 @@ struct rockchip_dp_device {
 	struct regmap            *grf;
 	struct reset_control     *rst;
 
-	struct work_struct	 psr_work;
-	struct mutex             psr_lock;
-	unsigned int             psr_state;
-
 	const struct rockchip_dp_chip_data *data;
 
 	struct analogix_dp_plat_data plat_data;
@@ -83,27 +79,13 @@ struct rockchip_dp_device {
 static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 {
 	struct rockchip_dp_device *dp = to_dp(encoder);
+	int ret;
 
 	if (!analogix_dp_psr_supported(dp->dev))
 		return;
 
 	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
 
-	mutex_lock(&dp->psr_lock);
-	if (enabled)
-		dp->psr_state = EDP_VSC_PSR_STATE_ACTIVE;
-	else
-		dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
-
-	schedule_work(&dp->psr_work);
-	mutex_unlock(&dp->psr_lock);
-}
-
-static void analogix_dp_psr_work(struct work_struct *work)
-{
-	struct rockchip_dp_device *dp =
-				container_of(work, typeof(*dp), psr_work);
-	int ret;
 
 	ret = rockchip_drm_wait_vact_end(dp->encoder.crtc,
 					 PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
@@ -112,12 +94,10 @@ static void analogix_dp_psr_work(struct work_struct *work)
 		return;
 	}
 
-	mutex_lock(&dp->psr_lock);
-	if (dp->psr_state == EDP_VSC_PSR_STATE_ACTIVE)
+	if (enabled)
 		analogix_dp_enable_psr(dp->dev);
 	else
 		analogix_dp_disable_psr(dp->dev);
-	mutex_unlock(&dp->psr_lock);
 }
 
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
@@ -134,8 +114,6 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 	struct rockchip_dp_device *dp = to_dp(plat_data);
 	int ret;
 
-	cancel_work_sync(&dp->psr_work);
-
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dp->dev, "failed to enable pclk %d\n", ret);
@@ -379,10 +357,6 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	dp->plat_data.power_off = rockchip_dp_powerdown;
 	dp->plat_data.get_modes = rockchip_dp_get_modes;
 
-	mutex_init(&dp->psr_lock);
-	dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
-	INIT_WORK(&dp->psr_work, analogix_dp_psr_work);
-
 	rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
 
 	return analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
-- 
2.9.3
