From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 12 Mar 2015 21:45:19 +0100
Subject: [PATCH v3 1/2] drm/bridge: dw-hdmi: support optional supply regulators
Message-ID: <4184159.j0iXe39dFB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least the Rockchip variant of the dw_hdmi can have controllable power supplies
providing 1.0 and 1.8V. Therefore add the possibility for the generic bridge
driver to enable supplies provided by the hw-specific drivers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v2:
- rename supplies to the names found in the hdmi IP databook
changes since v1:
- follow suggestion from Russell King to keep regulator handling local
  to the rockchip implementation for the time being and only generalize
  when a real second implementation needs regulator handling

 .../devicetree/bindings/drm/bridge/dw_hdmi.txt     |  5 ++++
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 32 +++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
index a905c14..bb74640 100644
--- a/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
+++ b/Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt
@@ -22,6 +22,11 @@ Optional properties
 - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
 - clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
 
+Optional supplies:
+rockchip,rk3288-dw-hdmi handles two optional power supplies:
+- vp-supply: 1.0V power supply
+- vph-supply: 1.8V power supply
+
 Example:
 	hdmi: hdmi at 0120000 {
 		compatible = "fsl,imx6q-hdmi";
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index d236faa..647a240 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <drm/drm_of.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -28,6 +29,9 @@ struct rockchip_hdmi {
 	struct device *dev;
 	struct regmap *regmap;
 	struct drm_encoder encoder;
+	struct regulator_bulk_data supplies[2];
+	int nsupplies;
+	bool supplies_enabled;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
@@ -179,6 +183,12 @@ static struct drm_encoder_funcs dw_hdmi_rockchip_encoder_funcs = {
 
 static void dw_hdmi_rockchip_encoder_disable(struct drm_encoder *encoder)
 {
+	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
+
+	if (hdmi->nsupplies > 0 && hdmi->supplies_enabled) {
+		regulator_bulk_disable(hdmi->nsupplies, hdmi->supplies);
+		hdmi->supplies_enabled = false;
+	}
 }
 
 static bool
@@ -199,7 +209,16 @@ static void dw_hdmi_rockchip_encoder_commit(struct drm_encoder *encoder)
 {
 	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
 	u32 val;
-	int mux;
+	int mux, ret;
+
+	if (hdmi->nsupplies > 0 && !hdmi->supplies_enabled) {
+		ret = regulator_bulk_enable(hdmi->nsupplies, hdmi->supplies);
+		if (ret) {
+			dev_err(hdmi->dev, "could not enable hdmi analog supplies\n");
+			return;
+		}
+		hdmi->supplies_enabled = true;
+	}
 
 	mux = rockchip_drm_encoder_get_mux_id(hdmi->dev->of_node, encoder);
 	if (mux)
@@ -275,6 +294,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	if (!iores)
 		return -ENXIO;
 
+	hdmi->supplies[0].supply = "vp";
+	hdmi->supplies[1].supply = "vph";
+	hdmi->nsupplies = 2;
+
+	ret = devm_regulator_bulk_get(hdmi->dev,
+				      hdmi->nsupplies, hdmi->supplies);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret)
+		hdmi->nsupplies = 0;
+
 	platform_set_drvdata(pdev, hdmi);
 
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
-- 
2.1.4
