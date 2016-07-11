From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 11 Jul 2016 19:05:52 +0800
Subject: [PATCH v1 6/6] drm/rockchip: dw_hdmi: introduce the pclk for grf
In-Reply-To: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
References: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1468235152-29683-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For RK3399's GRF module, if we want to operate the graphic related grf
registers, we need to enable the pclk_vio_grf which supply power for VIO
GRF IOs, so it's better to introduce an optional grf clock in driver.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 .../bindings/display/rockchip/dw_hdmi-rockchip.txt   |  3 ++-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c          | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
index 4e23ca4..e22d70f 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
@@ -18,7 +18,8 @@ Required properties:
 Optional properties
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
 - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec",
-		       phandle to the VPLL clock, name should be "vpll".
+		       phandle to the VPLL clock, name should be "vpll",
+		       phandle to the GRF clock, name should be "grf".
 
 Example:
 hdmi: hdmi at ff980000 {
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 701bb73..69e6efb 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -36,6 +36,7 @@ struct rockchip_hdmi {
 	struct drm_encoder encoder;
 	enum dw_hdmi_devtype dev_type;
 	struct clk *vpll_clk;
+	struct clk *grf_clk;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -166,6 +167,16 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
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
@@ -225,6 +236,7 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 	u32 lcdsel_grf_reg, lcdsel_mask;
 	u32 val;
 	int mux;
+	int ret;
 
 	switch (hdmi->dev_type) {
 	case RK3288_HDMI:
@@ -245,9 +257,17 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 	else
 		val = HIWORD_UPDATE(0, lcdsel_mask);
 
+	ret = clk_prepare_enable(hdmi->grf_clk);
+	if (ret < 0) {
+		dev_err(hdmi->dev, "failed to enable grfclk %d\n", ret);
+		return;
+	}
+
 	regmap_write(hdmi->regmap, lcdsel_grf_reg, val);
 	dev_dbg(hdmi->dev, "vop %s output to hdmi\n",
 		(mux) ? "LIT" : "BIG");
+
+	clk_disable_unprepare(hdmi->grf_clk);
 }
 
 static int
-- 
1.9.1
