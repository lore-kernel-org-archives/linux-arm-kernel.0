From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  9 Sep 2016 19:15:47 -0700
Subject: [PATCH v15 4/5] drm/rockchip: cdn-dp: support audio hot-plug
In-Reply-To: <1473473748-22331-1-git-send-email-zyw@rock-chips.com>
References: <1473473748-22331-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1473473748-22331-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Issue hot-plug detection, EDID update, and ELD update notifications
from DP drivers.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v15: None
Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 8d708d3..de1cf3e 100644
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
@@ -233,6 +234,7 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 			drm_mode_connector_update_edid_property(connector,
 								edid);
 			drm_edid_to_eld(connector, edid);
+			hdmi_event_new_eld(dp->dev, connector->eld);
 		}
 		kfree(edid);
 	}
@@ -631,6 +633,7 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 
 out:
 	mutex_unlock(&dp->lock);
+	hdmi_event_connect(dp->dev);
 }
 
 static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
@@ -647,6 +650,7 @@ static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
 		}
 	}
 	mutex_unlock(&dp->lock);
+	hdmi_event_disconnect(dp->dev);
 }
 
 static int cdn_dp_encoder_atomic_check(struct drm_encoder *encoder,
-- 
1.9.1
