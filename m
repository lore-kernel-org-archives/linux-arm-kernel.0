From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 16 Mar 2017 11:31:46 +0800
Subject: [PATCH v2 3/4] drm/rockchip/dsi: enable the grf clk before writing
 grf registers
In-Reply-To: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
References: <1489635107-21327-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1489635107-21327-4-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For RK3399, the grf clk should be enabled before writing grf registers,
otherwise the register value can not be changed.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v2:
- check the grf_clk only for RK3399

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 11c4166..a4c74c7 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -291,6 +291,7 @@ struct dw_mipi_dsi {
 	struct regmap *grf_regmap;
 	void __iomem *base;
 
+	struct clk *grf_clk;
 	struct clk *pllref_clk;
 	struct clk *pclk;
 	struct clk *phy_cfg_clk;
@@ -979,6 +980,17 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	dw_mipi_dsi_dphy_interface_config(dsi);
 	dw_mipi_dsi_clear_err(dsi);
 
+	/*
+	 * For the RK3399, the clk of grf must be enabled before writing grf
+	 * register. And for RK3288 or other soc, this grf_clk must be NULL,
+	 * the clk_prepare_enable return true directly.
+	 */
+	ret = clk_prepare_enable(dsi->grf_clk);
+	if (ret) {
+		dev_err(dsi->dev, "Failed to enable grf_clk\n");
+		return;
+	}
+
 	if (pdata->grf_dsi0_mode_reg)
 		regmap_write(dsi->grf_regmap, pdata->grf_dsi0_mode_reg,
 			     pdata->grf_dsi0_mode);
@@ -1003,6 +1015,8 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	regmap_write(dsi->grf_regmap, pdata->grf_switch_reg, val);
 	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
 	dsi->dpms_mode = DRM_MODE_DPMS_ON;
+
+	clk_disable_unprepare(dsi->grf_clk);
 }
 
 static int
@@ -1234,6 +1248,13 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 			dev_err(dev, "Unable to get phy_cfg_clk: %d\n", ret);
 			return ret;
 		}
+
+		dsi->grf_clk = devm_clk_get(dev, "grf");
+		if (IS_ERR(dsi->grf_clk)) {
+			ret = PTR_ERR(dsi->grf_clk);
+			dev_err(dev, "Unable to get grf_clk: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = clk_prepare_enable(dsi->pllref_clk);
-- 
2.6.3
