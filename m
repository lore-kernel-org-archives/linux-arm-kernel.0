From: zyw@rock-chips.com (Chris Zhong)
Date: Mon,  5 Sep 2016 21:48:54 -0700
Subject: [PATCH 1/2] drm/rockchip: cdn-dp: support audio hot-plug
In-Reply-To: <1473137335-14541-1-git-send-email-zyw@rock-chips.com>
References: <1473137335-14541-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1473137335-14541-2-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Issue hot-plug detection, EDID update, and ELD update notifications
from DP drivers.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 530b7ba..e0055a9 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -23,6 +23,7 @@
 #include <linux/component.h>
 #include <linux/extcon.h>
 #include <linux/firmware.h>
+#include <linux/hdmi-notifier.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/mfd/syscon.h>
@@ -185,6 +186,7 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 			drm_mode_connector_update_edid_property(connector,
 								edid);
 			drm_edid_to_eld(connector, edid);
+			hdmi_event_new_eld(dp->dev, connector->eld);
 		}
 		kfree(edid);
 	}
@@ -345,6 +347,7 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 
 	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
 		cdn_dp_commit(encoder);
+	hdmi_event_connect(dp->dev);
 }
 
 static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
@@ -352,6 +355,7 @@ static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
 
 	dp->dpms_mode = DRM_MODE_DPMS_OFF;
+	hdmi_event_disconnect(dp->dev);
 }
 
 static int cdn_dp_encoder_atomic_check(struct drm_encoder *encoder,
-- 
1.9.1
