From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat,  1 Apr 2017 19:35:29 +0800
Subject: [PATCH v2 9/9] drm/rockchip: cdn-dp: Don't unregister audio dev when
 unbinding
In-Reply-To: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491046529-4310-10-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current sound framework, there's no way to unbind dai link after
unregister codec.

So move unregister codec to driver remove for now.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a97f3f4..1deab9f 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1091,8 +1091,6 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 		goto err_free_connector;
 	}
 
-	cdn_dp_audio_codec_init(dp, dev);
-
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
@@ -1127,7 +1125,6 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 	struct drm_connector *connector = &dp->connector;
 
 	cancel_work_sync(&dp->event_work);
-	platform_device_unregister(dp->audio_pdev);
 	cdn_dp_encoder_disable(encoder);
 	encoder->funcs->destroy(encoder);
 	connector->funcs->destroy(connector);
@@ -1220,6 +1217,8 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
+	cdn_dp_audio_codec_init(dp, dev);
+
 	return component_add(dev, &cdn_dp_component_ops);
 }
 
@@ -1227,6 +1226,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
+	platform_device_unregister(dp->audio_pdev);
 	cdn_dp_suspend(dp->dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
-- 
2.1.4
