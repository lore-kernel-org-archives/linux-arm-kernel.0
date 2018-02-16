From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Feb 2018 21:41:57 +0100
Subject: [PATCH v2 7/8] drm/rockchip: dw_hdmi: store rockchip_hdmi reference
 in phy_data object
In-Reply-To: <20180216204158.29839-1-heiko@sntech.de>
References: <20180216204158.29839-1-heiko@sntech.de>
Message-ID: <20180216204158.29839-8-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using special phy handling operations we'll often need access to
the rockchip_hdmi struct. As the chip-data that occupies the phy_data
pointer initially gets assigned to the rockchip_hdmi struct we can not
re-use this phy_data pointer to hold the reference to the rockchip_hdmi
struct, similar to how meson-hdmi does it for example.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 305b68d223d7..8595638d4990 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -343,7 +343,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	const struct dw_hdmi_plat_data *plat_data;
+	struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
@@ -358,9 +358,14 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
-	plat_data = match->data;
+	plat_data = devm_kmemdup(&pdev->dev, match->data,
+					     sizeof(*plat_data), GFP_KERNEL);
+	if (!plat_data)
+		return -ENOMEM;
+
 	hdmi->dev = &pdev->dev;
 	hdmi->chip_data = plat_data->phy_data;
+	plat_data->phy_data = hdmi;
 	encoder = &hdmi->encoder;
 
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
-- 
2.15.1
