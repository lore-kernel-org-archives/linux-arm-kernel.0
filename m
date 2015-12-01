From: mark.yao@rock-chips.com (Mark Yao)
Date: Tue,  1 Dec 2015 11:35:53 +0800
Subject: [RFC PATCH 8/9] drm: bridge/dw_hdmi: Covert to support atomic API
In-Reply-To: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1448940953-23604-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fill atomic needed funcs with default atomic helper library.

Rockchip use dw_hdmi, and drm/rockchip will covert to atomic api,
we need dw_hdmi support atomic funcs.

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/bridge/dw_hdmi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 56de9f1..587065a 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -22,6 +22,7 @@
 
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
@@ -1515,11 +1516,14 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 }
 
 static struct drm_connector_funcs dw_hdmi_connector_funcs = {
-	.dpms = drm_helper_connector_dpms,
+	.dpms = drm_atomic_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = dw_hdmi_connector_detect,
 	.destroy = dw_hdmi_connector_destroy,
 	.force = dw_hdmi_connector_force,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
-- 
1.7.9.5
