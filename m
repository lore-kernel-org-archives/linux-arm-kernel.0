From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  9 Mar 2018 23:23:04 +0100
Subject: [PATCH v5 13/36] drm/bridge: analogix_dp: Ensure edp is disabled when
 shutting down the panel
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Message-ID: <20180309222327.18689-14-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lin Huang <hl@rock-chips.com>

When panel is shut down, we should make sure edp can be disabled to avoid
undefined behavior.

Cc: St?phane Marchesin <marcheu@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 92fb9a072cb6..3a222e7e46ee 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1160,6 +1160,12 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 
 	pm_runtime_get_sync(dp->dev);
 
+	ret = clk_prepare_enable(dp->clock);
+	if (ret < 0) {
+		DRM_ERROR("Failed to prepare_enable the clock clk [%d]\n", ret);
+		goto out_dp_clk_pre;
+	}
+
 	if (dp->plat_data->power_on)
 		dp->plat_data->power_on(dp->plat_data);
 
@@ -1191,6 +1197,8 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 	phy_power_off(dp->phy);
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
+	clk_disable_unprepare(dp->clock);
+out_dp_clk_pre:
 	pm_runtime_put_sync(dp->dev);
 
 	return ret;
@@ -1233,11 +1241,14 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	}
 
 	disable_irq(dp->irq);
+	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 	phy_power_off(dp->phy);
 
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
 
+	clk_disable_unprepare(dp->clock);
+
 	pm_runtime_put_sync(dp->dev);
 
 	ret = analogix_dp_prepare_panel(dp, false, true);
-- 
2.16.1
