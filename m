From: m.purski@samsung.com (Maciej Purski)
Date: Tue, 05 Sep 2017 14:23:02 +0200
Subject: [PATCH] drm/exynos/hdmi: Fix unsafe list iteration
References: <CGME20170905122309eucas1p15739d5191e6471e9bfc05aa32b334f2e@eucas1p1.samsung.com>
Message-ID: <1504614182-1509-1-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function hdmi_mode_fixup() used bare list_for_each entry, which was
unsafe and caused memory corruption detected by kasan.
It now uses drm_for_each_connector_iter macro, which is now recommended
by the documentation and safe.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 214fa5e..0109ff4 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -944,22 +944,27 @@ static bool hdmi_mode_fixup(struct drm_encoder *encoder,
 	struct drm_device *dev = encoder->dev;
 	struct drm_connector *connector;
 	struct drm_display_mode *m;
+	struct drm_connector_list_iter conn_iter;
 	int mode_ok;
 
 	drm_mode_set_crtcinfo(adjusted_mode, 0);
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
 		if (connector->encoder == encoder)
 			break;
 	}
+	if (connector)
+		drm_connector_get(connector);
+	drm_connector_list_iter_end(&conn_iter);
 
-	if (connector->encoder != encoder)
+	if (!connector)
 		return true;
 
 	mode_ok = hdmi_mode_valid(connector, adjusted_mode);
 
 	if (mode_ok == MODE_OK)
-		return true;
+		goto cleanup;
 
 	/*
 	 * Find the most suitable mode and copy it to adjusted_mode.
@@ -979,6 +984,9 @@ static bool hdmi_mode_fixup(struct drm_encoder *encoder,
 		}
 	}
 
+cleanup:
+	drm_connector_put(connector);
+
 	return true;
 }
 
-- 
2.7.4
