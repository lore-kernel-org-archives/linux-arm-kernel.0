From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  2 Sep 2018 09:26:32 +0200
Subject: [PATCH 16/27] drm/sun4i: dw-hdmi: Make mode_valid function
 configurable
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Message-ID: <20180902072643.4917-17-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it is not possible to access sun8i-dw-hdmi driver private data
inside mode_valid function, make it configurable. That way different
versions of HDMI controllers can set different function, depending on
it's limitations.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 18 ++++++++++++++----
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 31875b636434..a5020fe8bd69 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -5,6 +5,7 @@
 
 #include <linux/component.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <drm/drm_of.h>
@@ -33,8 +34,8 @@ static const struct drm_encoder_funcs sun8i_dw_hdmi_encoder_funcs = {
 };
 
 static enum drm_mode_status
-sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
-			 const struct drm_display_mode *mode)
+sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *connector,
+			      const struct drm_display_mode *mode)
 {
 	if (mode->clock > 297000)
 		return MODE_CLOCK_HIGH;
@@ -102,6 +103,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
+	hdmi->quirks = of_device_get_match_data(dev);
+
 	encoder->possible_crtcs =
 		sun8i_dw_hdmi_find_possible_crtcs(drm, dev->of_node);
 	/*
@@ -156,7 +159,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	sun8i_hdmi_phy_init(hdmi->phy);
 
-	plat_data->mode_valid = &sun8i_dw_hdmi_mode_valid;
+	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->phy_ops = sun8i_hdmi_phy_get_ops();
 	plat_data->phy_name = "sun8i_dw_hdmi_phy";
 	plat_data->phy_data = hdmi->phy;
@@ -215,8 +218,15 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
+	.mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
+};
+
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
-	{ .compatible = "allwinner,sun8i-a83t-dw-hdmi" },
+	{
+		.compatible = "allwinner,sun8i-a83t-dw-hdmi",
+		.data = &sun8i_a83t_quirks,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index aadbe0a10b0c..b718c47e00be 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -169,6 +169,11 @@ struct sun8i_hdmi_phy {
 	struct sun8i_hdmi_phy_variant	*variant;
 };
 
+struct sun8i_dw_hdmi_quirks {
+	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
+					   const struct drm_display_mode *mode);
+};
+
 struct sun8i_dw_hdmi {
 	struct clk			*clk_tmds;
 	struct device			*dev;
@@ -176,6 +181,7 @@ struct sun8i_dw_hdmi {
 	struct drm_encoder		encoder;
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
+	const struct sun8i_dw_hdmi_quirks *quirks;
 	struct reset_control		*rst_ctrl;
 };
 
-- 
2.18.0
