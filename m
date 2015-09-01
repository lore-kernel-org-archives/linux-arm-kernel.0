From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 14:17:40 +0800
Subject: [PATCH v4 15/16] drm: bridge: analogix/dp: move hpd detect to
 connector detect function
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441088260-25867-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change just make a little clean to make code more like
drm core expect, move hdp detect code from bridge->enable(),
and place them into connector->detect().

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4:
- Take Jingoo suggest, add commit messages.

Changes in v3:
- move dp hpd detect to connector detect function.

Changes in v2: None

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e6b328a..499ec57 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -908,12 +908,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
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
@@ -949,6 +943,12 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 static enum drm_connector_status
 analogix_dp_detect(struct drm_connector *connector, bool force)
 {
+	struct analogix_dp_device *dp = connector_to_dp(connector);
+
+	if (analogix_dp_detect_hpd(dp))
+		/* Cable has been disconnected, we're done */
+		return connector_status_disconnected;
+
 	return connector_status_connected;
 }
 
-- 
2.1.2
