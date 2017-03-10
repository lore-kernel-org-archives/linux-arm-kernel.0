From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:50 -0500
Subject: [PATCH 35/41] drm/rockchip: analogix_dp: Fix invalid implementation
 of unbind
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-36-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

Current implementation of unbind dereferences the drvdata pointer
assuming that it's its own data, however the ownership belongs to the
analogix code, which means that the pointer is dereferenced with wrong
type. Fix this by using the recently added platform data .cleanup()
callback to do Rockchip-specific things at unbind.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index de23cc6fd05d..0a92d9e3ffac 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -179,6 +179,13 @@ static int rockchip_dp_get_modes(struct analogix_dp_plat_data *plat_data,
 	return 0;
 }
 
+static void rockchip_dp_cleanup(struct analogix_dp_plat_data *plat_data)
+{
+	struct rockchip_dp_device *dp = to_dp(plat_data);
+
+	rockchip_drm_psr_unregister(&dp->encoder);
+}
+
 static bool
 rockchip_dp_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 				   const struct drm_display_mode *mode,
@@ -395,25 +402,16 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	dp->plat_data.power_on = rockchip_dp_poweron;
 	dp->plat_data.power_off = rockchip_dp_powerdown;
 	dp->plat_data.get_modes = rockchip_dp_get_modes;
+	dp->plat_data.cleanup = rockchip_dp_cleanup;
 
 	rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
 
 	return analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
 }
 
-static void rockchip_dp_unbind(struct device *dev, struct device *master,
-			       void *data)
-{
-	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
-
-	rockchip_drm_psr_unregister(&dp->encoder);
-
-	return analogix_dp_unbind(dev, master, data);
-}
-
 static const struct component_ops rockchip_dp_component_ops = {
 	.bind = rockchip_dp_bind,
-	.unbind = rockchip_dp_unbind,
+	.unbind = analogix_dp_unbind,
 };
 
 static int rockchip_dp_probe(struct platform_device *pdev)
-- 
2.12.0.246.ga2ecc84866-goog
