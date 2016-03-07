From: dianders@chromium.org (Douglas Anderson)
Date: Mon,  7 Mar 2016 14:00:50 -0800
Subject: [PATCH v2 1/5] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup() in
 error path
Message-ID: <1457388054-23077-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drm_encoder_cleanup() was missing both from the error path of
dw_hdmi_rockchip_bind().  This caused a crash when slub_debug was
enabled and we ended up deferring probe of HDMI at boot.

This call isn't needed from unbind() because if dw_hdmi_bind() returns
no error then it takes over the job of freeing the encoder (in
dw_hdmi_unbind).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2: None

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 3d3cf2f8891e..88776aba984e 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -293,7 +293,16 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
+	ret = dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
+
+	/*
+	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
+	 * which would have called the encoder cleanup.  Do it manually.
+	 */
+	if (ret)
+		drm_encoder_cleanup(encoder);
+
+	return ret;
 }
 
 static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
-- 
2.7.0.rc3.207.g0ac5344
