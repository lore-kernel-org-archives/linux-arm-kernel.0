From: seanpaul@chromium.org (Sean Paul)
Date: Thu,  9 Mar 2017 23:32:52 -0500
Subject: [PATCH 37/41] drm/rockchip: analogix_dp: Wire the shutdown callback
 to disable PSR
In-Reply-To: <20170310043305.17216-1-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
Message-ID: <20170310043305.17216-38-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Figa <tfiga@chromium.org>

We have to disable PSR before shutdown to avoid any asynchronous PSR
code to interfere with Rockchip DRM device shutdown. We use the recently
added analogix_dp_shutdown() function and rockchip_dp_cleanup() we
already use for unregistering PSR at unbind time.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 0a92d9e3ffac..14f68e792e6f 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -468,6 +468,11 @@ static int rockchip_dp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void rockchip_dp_shutdown(struct platform_device *pdev)
+{
+	analogix_dp_shutdown(&pdev->dev);
+}
+
 static const struct dev_pm_ops rockchip_dp_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
 	.suspend = analogix_dp_suspend,
@@ -499,6 +504,7 @@ MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
 static struct platform_driver rockchip_dp_driver = {
 	.probe = rockchip_dp_probe,
 	.remove = rockchip_dp_remove,
+	.shutdown = rockchip_dp_shutdown,
 	.driver = {
 		   .name = "rockchip-dp",
 		   .pm = &rockchip_dp_pm_ops,
-- 
2.12.0.246.ga2ecc84866-goog
