From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 24 Oct 2015 11:21:48 +0800
Subject: [PATCH v7 16/17] drm: bridge: analogix/dp: move hpd detect to
 connector detect function
In-Reply-To: <1445599415-30856-1-git-send-email-ykk@rock-chips.com>
References: <1445599415-30856-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1445656909-15477-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change just make a little clean to make code more like
drm core expect, move hdp detect code from bridge->enable(),
and place them into connector->detect().

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- Take Jingoo suggest, add commit messages.

Changes in v3:
- move dp hpd detect to connector detect function.

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 3842dbd..216d33d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -901,12 +901,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 			DRM_ERROR("failed to disable the panel\n");
 	}
 
-	ret = analogix_dp_detect_hpd(dp);
-	if (ret) {
-		/* Cable has been disconnected, we're done */
-		return;
-	}
-
 	ret = analogix_dp_handle_edid(dp);
 	if (ret) {
 		dev_err(dp->dev, "unable to handle edid\n");
@@ -941,6 +935,11 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 
 enum drm_connector_status analogix_dp_detect(struct device *dev, bool force)
 {
+	struct analogix_dp_device *dp = dev_get_drvdata(dev);
+
+	if (analogix_dp_detect_hpd(dp))
+		return connector_status_disconnected;
+
 	return connector_status_connected;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_detect);
-- 
2.1.2
