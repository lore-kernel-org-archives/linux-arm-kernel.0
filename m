From: mark.yao@rock-chips.com (Mark Yao)
Date: Fri,  9 Jun 2017 15:10:46 +0800
Subject: [PATCH v3 3/3] drm/rockchip: dw_hdmi: introduce the pclk for grf
In-Reply-To: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
References: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1496992247-10727-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For RK3399's GRF module, if we want to operate the graphic related grf
registers, we need to enable the pclk_vio_grf which supply power for VIO
GRF IOs, so it's better to introduce an optional grf clock in driver.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
Changes in v3: none
Changes in v2: describe grf on Documentation.

 .../bindings/display/rockchip/dw_hdmi-rockchip.txt     |  1 +
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c            | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
index 779e8ac..6bce639 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
@@ -31,6 +31,7 @@ Optional properties
   I2C master controller.
 - clock-names: See dw_hdmi.txt. The "cec" clock is optional.
 - clock-names: May contain "cec" as defined in dw_hdmi.txt.
+- clock-names: May contain "grf", power for grf io.
 - clock-names: May contain "vpll", external clock for some hdmi phy.
 
 Example:
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index aaa0f3e..2b9cb47 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -47,6 +47,7 @@ struct rockchip_hdmi {
 	struct drm_encoder encoder;
 	const struct rockchip_hdmi_chip_data *chip_data;
 	struct clk *vpll_clk;
+	struct clk *grf_clk;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -181,6 +182,16 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 		return PTR_ERR(hdmi->vpll_clk);
 	}
 
+	hdmi->grf_clk = devm_clk_get(hdmi->dev, "grf");
+	if (PTR_ERR(hdmi->grf_clk) == -ENOENT) {
+		hdmi->grf_clk = NULL;
+	} else if (PTR_ERR(hdmi->grf_clk) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(hdmi->grf_clk)) {
+		dev_err(hdmi->dev, "failed to get grf clock\n");
+		return PTR_ERR(hdmi->grf_clk);
+	}
+
 	ret = clk_prepare_enable(hdmi->vpll_clk);
 	if (ret) {
 		dev_err(hdmi->dev, "Failed to enable HDMI vpll: %d\n", ret);
@@ -246,10 +257,17 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 	else
 		val = hdmi->chip_data->lcdsel_big;
 
+	ret = clk_prepare_enable(hdmi->grf_clk);
+	if (ret < 0) {
+		dev_err(hdmi->dev, "failed to enable grfclk %d\n", ret);
+		return;
+	}
+
 	ret = regmap_write(hdmi->regmap, hdmi->chip_data->lcdsel_grf_reg, val);
 	if (ret != 0)
 		dev_err(hdmi->dev, "Could not write to GRF: %d\n", ret);
 
+	clk_disable_unprepare(hdmi->grf_clk);
 	dev_dbg(hdmi->dev, "vop %s output to hdmi\n",
 		ret ? "LIT" : "BIG");
 }
-- 
1.9.1
