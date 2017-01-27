From: shailendra.v@samsung.com (Shailendra Verma)
Date: Fri, 27 Jan 2017 16:41:50 +0530
Subject: [PATCH] Gpu: drm: rockchip - Fix possible NULL derefrence.
References: <CGME20170127111200epcas3p34bf747c6c3c0da798ddaf34788d1a324@epcas3p3.samsung.com>
Message-ID: <1485515510-3129-1-git-send-email-shailendra.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index ca22e5e..dbb99cf 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1082,15 +1082,22 @@ static enum drm_mode_status rk3288_mipi_dsi_mode_valid(
 static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 			     void *data)
 {
-	const struct of_device_id *of_id =
-			of_match_device(dw_mipi_dsi_dt_ids, dev);
-	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
+	const struct of_device_id *of_id;
+	const struct dw_mipi_dsi_plat_data *pdata;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = data;
 	struct dw_mipi_dsi *dsi;
 	struct resource *res;
 	int ret;
 
+	of_id = of_match_device(dw_mipi_dsi_dt_ids, dev);
+	if (!of_id) {
+		dev_err(dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
+
+	pdata = of_id->data;
+
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
 		return -ENOMEM;
-- 
1.7.9.5
