From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  5 Apr 2017 16:29:27 +0800
Subject: [PATCH v3 9/9] drm/rockchip: cdn-dp: Don't unregister audio dev when
 unbinding
In-Reply-To: <1491380967-28570-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1491380967-28570-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1491380967-28570-10-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After snd_soc_unregister_codec, the dai link would remain bound to
the invalid codec. That would cause crashes after unbind dp driver.

Let's unregister audio codec when removing dp driver to prevent that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3:
Update commit message.

Changes in v2: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index ee4195d..a2169dd 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1092,8 +1092,6 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 		goto err_free_connector;
 	}
 
-	cdn_dp_audio_codec_init(dp, dev);
-
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
@@ -1128,7 +1126,6 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 	struct drm_connector *connector = &dp->connector;
 
 	cancel_work_sync(&dp->event_work);
-	platform_device_unregister(dp->audio_pdev);
 	cdn_dp_encoder_disable(encoder);
 	encoder->funcs->destroy(encoder);
 	connector->funcs->destroy(connector);
@@ -1221,6 +1218,8 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
+	cdn_dp_audio_codec_init(dp, dev);
+
 	return component_add(dev, &cdn_dp_component_ops);
 }
 
@@ -1228,6 +1227,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
+	platform_device_unregister(dp->audio_pdev);
 	cdn_dp_suspend(dp->dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
-- 
2.1.4
