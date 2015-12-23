From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 23 Dec 2015 20:53:13 +0800
Subject: [PATCH v12 17/18] drm: bridge: analogix/dp: add panel
 prepare/unprepare in suspend/resume time
In-Reply-To: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
References: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1450875193-19674-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn off the panel power in suspend time would help to reduce
power waste.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
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

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a86a283..1e98489 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1400,6 +1400,12 @@ int analogix_dp_suspend(struct device *dev)
 	struct analogix_dp_device *dp = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(dp->clock);
+
+	if (dp->plat_data->panel) {
+		if (drm_panel_unprepare(dp->plat_data->panel))
+			DRM_ERROR("failed to turnoff the panel\n");
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_suspend);
@@ -1415,6 +1421,13 @@ int analogix_dp_resume(struct device *dev)
 		return ret;
 	}
 
+	if (dp->plat_data->panel) {
+		if (drm_panel_prepare(dp->plat_data->panel)) {
+			DRM_ERROR("failed to setup the panel\n");
+			return -EBUSY;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(analogix_dp_resume);
-- 
1.9.1
