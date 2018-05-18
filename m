From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:30 +0530
Subject: [PATCH v2 20/26] drm: sun4i: add support for HVCC regulator for DWC
 HDMI glue
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-21-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner SoCs with DWC HDMI controller have a "HVCC" power pin for the
HDMI part, and on some boards it's connected to a dedicated regulator
rather than the main 3.3v.

Add support for optional HVCC regulator. For boards that doesn't use a
dedicated regulator to power it, the default dummy regulator is used.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 9f40a44b456b..7c33faff7ad4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -73,6 +73,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (encoder->possible_crtcs == 0)
 		return -EPROBE_DEFER;
 
+	hdmi->vcc_hdmi = devm_regulator_get(dev, "hvcc");
+	if (IS_ERR(hdmi->vcc_hdmi)) {
+		dev_err(dev, "Could not get HDMI power supply\n");
+		return PTR_ERR(hdmi->vcc_hdmi);
+	}
+
 	hdmi->rst_ctrl = devm_reset_control_get(dev, "ctrl");
 	if (IS_ERR(hdmi->rst_ctrl)) {
 		dev_err(dev, "Could not get ctrl reset control\n");
@@ -91,6 +97,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	ret = regulator_enable(hdmi->vcc_hdmi);
+	if (ret) {
+		dev_err(dev, "Cannot enable HDMI power supply\n");
+		goto err_disable_vcc;
+	}
+
 	ret = clk_prepare_enable(hdmi->clk_tmds);
 	if (ret) {
 		dev_err(dev, "Could not enable tmds clock\n");
@@ -143,6 +155,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
 	reset_control_assert(hdmi->rst_ctrl);
+err_disable_vcc:
+	regulator_disable(hdmi->vcc_hdmi);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 303189d6602c..65366eeb38d8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -10,6 +10,7 @@
 #include <drm/drm_encoder.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #define SUN8I_HDMI_PHY_DBG_CTRL_REG	0x0000
@@ -175,6 +176,7 @@ struct sun8i_dw_hdmi {
 	struct drm_encoder		encoder;
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
+	struct regulator		*vcc_hdmi;
 	struct reset_control		*rst_ctrl;
 };
 
-- 
2.14.3
