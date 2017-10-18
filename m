From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 18 Oct 2017 20:09:44 +0800
Subject: [PATCH v5 9/9] drm/rockchip: dw_hdmi: Fix error handling path
In-Reply-To: <20171018120944.7819-1-jeffy.chen@rock-chips.com>
References: <20171018120944.7819-1-jeffy.chen@rock-chips.com>
Message-ID: <20171018120944.7819-10-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clk_disable_unprepare() in bind()'s error handling path and
unbind().

Also inline clk_prepare_enable() with bind().

Fixes: 12b9f204e804 ("drm: bridge/dw_hdmi: add rockchip rk3288 support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5:
Add disable to unbind(), and inline clk_prepare_enable() with bind().

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 791ab938f998..e936dfe6c03d 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -193,13 +193,6 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 		return PTR_ERR(hdmi->grf_clk);
 	}
 
-	ret = clk_prepare_enable(hdmi->vpll_clk);
-	if (ret) {
-		DRM_DEV_ERROR(hdmi->dev,
-			      "Failed to enable HDMI vpll: %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -374,6 +367,13 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	ret = clk_prepare_enable(hdmi->vpll_clk);
+	if (ret) {
+		DRM_DEV_ERROR(hdmi->dev,
+			      "Failed to enable HDMI vpll: %d\n", ret);
+		return ret;
+	}
+
 	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
@@ -381,6 +381,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
 	if (IS_ERR(hdmi->hdmi)) {
 		encoder->funcs->destroy(encoder);
+		clk_disable_unprepare(hdmi->vpll_clk);
 		return PTR_ERR(hdmi->hdmi);
 	}
 
@@ -396,6 +397,7 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 
 	dw_hdmi_unbind(hdmi->hdmi);
 	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+	clk_disable_unprepare(hdmi->vpll_clk);
 }
 
 static const struct component_ops dw_hdmi_rockchip_ops = {
-- 
2.11.0
