From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:33 +0100
Subject: [PATCH 7/9] drm/rockchip: dw_hdmi: allow including external phys
In-Reply-To: <20180205143435.4723-1-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
Message-ID: <20180205143435.4723-8-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some variants of the dw-hdmi on Rockchip socs use a separate phy block
accessed via the generic phy framework, so allow them to be included
if such a phy reference is found.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 304f61bd2eec..512f8556e7c0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/regmap.h>
 
 #include <drm/drm_of.h>
@@ -48,6 +49,7 @@ struct rockchip_hdmi {
 	const struct rockchip_hdmi_chip_data *chip_data;
 	struct clk *vpll_clk;
 	struct clk *grf_clk;
+	struct phy *phy;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -376,6 +378,14 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	hdmi->phy = devm_phy_optional_get(dev, "hdmi");
+	if (IS_ERR(hdmi->phy)) {
+		ret = PTR_ERR(hdmi->phy);
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(hdmi->dev, "failed to get phy\n");
+		return ret;
+	}
+
 	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
-- 
2.15.1
