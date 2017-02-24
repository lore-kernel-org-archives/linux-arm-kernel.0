From: john@metanate.com (John Keeping)
Date: Fri, 24 Feb 2017 12:55:06 +0000
Subject: [PATCH v4 23/23] drm/rockchip: dw-mipi-dsi: add reset control
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <20170224125506.21533-24-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to fully reset the state of the MIPI controller we must assert
this reset.

This is slightly more complicated than it could be in order to maintain
compatibility with device trees that do not specify the reset property.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Chris Zhong <zyw@rock-chips.com>
---
v4:
- Fix error check for devm_reset_control_get() to use ENOENT
v3:
- Add Chris' Reviewed-by
Unchanged in v2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 0c4bae711e84..30da75667334 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/mfd/syscon.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
@@ -1144,6 +1145,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 			of_match_device(dw_mipi_dsi_dt_ids, dev);
 	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct reset_control *apb_rst;
 	struct drm_device *drm = data;
 	struct dw_mipi_dsi *dsi;
 	struct resource *res;
@@ -1182,6 +1184,35 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	/*
+	 * Note that the reset was not defined in the initial device tree, so
+	 * we have to be prepared for it not being found.
+	 */
+	apb_rst = devm_reset_control_get(dev, "apb");
+	if (IS_ERR(apb_rst)) {
+		ret = PTR_ERR(apb_rst);
+		if (ret == -ENOENT) {
+			apb_rst = NULL;
+		} else {
+			dev_err(dev, "Unable to get reset control: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (apb_rst) {
+		ret = clk_prepare_enable(dsi->pclk);
+		if (ret) {
+			dev_err(dev, "%s: Failed to enable pclk\n", __func__);
+			return ret;
+		}
+
+		reset_control_assert(apb_rst);
+		usleep_range(10, 20);
+		reset_control_deassert(apb_rst);
+
+		clk_disable_unprepare(dsi->pclk);
+	}
+
 	ret = clk_prepare_enable(dsi->pllref_clk);
 	if (ret) {
 		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
-- 
2.12.0.rc0.230.gf625d4cdb9.dirty
