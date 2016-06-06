From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon,  6 Jun 2016 16:53:33 +0200
Subject: [PATCH 2/2] drm/rockchip: Resume DP early
In-Reply-To: <1465224813-7359-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1465224813-7359-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1465224813-7359-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DP needs to have resumed once the DRM driver calls
drm_atomic_helper_resume, otherwise the DP clock is still disabled when
the DRM core enables the DP bridge.

Would be nice to use device_pm_wait_for_dev to synchronize these
devices, but the DRM device doesn't know what specific implementation
this bridge has.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Caesar Wang <wxt@rock-chips.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 7f6a55cae27a..c120172add5c 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -349,20 +349,11 @@ static int rockchip_dp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops rockchip_dp_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
-static int rockchip_dp_suspend(struct device *dev)
-{
-	return analogix_dp_suspend(dev);
-}
-
-static int rockchip_dp_resume(struct device *dev)
-{
-	return analogix_dp_resume(dev);
-}
+	.suspend = analogix_dp_suspend,
+	.resume_early = analogix_dp_resume,
 #endif
-
-static const struct dev_pm_ops rockchip_dp_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(rockchip_dp_suspend, rockchip_dp_resume)
 };
 
 static const struct of_device_id rockchip_dp_dt_ids[] = {
-- 
2.5.5
