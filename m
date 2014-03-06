From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu,  6 Mar 2014 14:54:39 +0100
Subject: [PATCH 1/2] imx-drm: imx-ldb: Add drm_panel support
Message-ID: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows to optionally attach the lvds-channel to a panel
supported by a drm_panel driver instead of supplying the modes via
device tree.

Before:

	ldb {
		...

		lvds-channel at 0 {
			...

			display-timings {
				native-timing = <&timing1>;
				timing1: etm0700g0dh6 {
					hactive = <800>;
					vactive = <480>;
					clock-frequency = <33260000>;
					hsync-len = <128>;
					hback-porch = <88>;
					hfront-porch = <40>;
					vsync-len = <2>;
					vback-porch = <33>;
					vfront-porch = <10>;
					hsync-active = <0>;
					vsync-active = <0>;
					...
				};
			};
			...
		};
	};

After:
	ldb {
		...

		lvds-channel at 0 {
			fsl,panel = <&panel>;
			...
		};
	};

	panel: panel {
		compatible = "edt,etm0700g0dh6", "simple-panel";
	};

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-ldb.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 4576830..38a0795 100644
--- a/drivers/staging/imx-drm/imx-ldb.c
+++ b/drivers/staging/imx-drm/imx-ldb.c
@@ -24,6 +24,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/of_address.h>
@@ -60,6 +61,7 @@ struct imx_ldb_channel {
 	struct imx_ldb *ldb;
 	struct drm_connector connector;
 	struct drm_encoder encoder;
+	struct drm_panel *panel;
 	struct device_node *child;
 	int chno;
 	void *edid;
@@ -96,6 +98,13 @@ static int imx_ldb_connector_get_modes(struct drm_connector *connector)
 	struct imx_ldb_channel *imx_ldb_ch = con_to_imx_ldb_ch(connector);
 	int num_modes = 0;
 
+	if (imx_ldb_ch->panel && imx_ldb_ch->panel->funcs &&
+	    imx_ldb_ch->panel->funcs->get_modes) {
+		num_modes = imx_ldb_ch->panel->funcs->get_modes(imx_ldb_ch->panel);
+		if (num_modes > 0)
+			return num_modes;
+	}
+
 	if (imx_ldb_ch->edid) {
 		drm_mode_connector_update_edid_property(connector,
 							imx_ldb_ch->edid);
@@ -240,6 +249,8 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	}
 
 	regmap_write(ldb->regmap, IOMUXC_GPR2, ldb->ldb_ctrl);
+
+	drm_panel_enable(imx_ldb_ch->panel);
 }
 
 static void imx_ldb_encoder_mode_set(struct drm_encoder *encoder,
@@ -291,6 +302,8 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 		 (ldb->ldb_ctrl & LDB_CH1_MODE_EN_MASK) == 0)
 		return;
 
+	drm_panel_disable(imx_ldb_ch->panel);
+
 	if (imx_ldb_ch == &ldb->channel[0])
 		ldb->ldb_ctrl &= ~LDB_CH0_MODE_EN_MASK;
 	else if (imx_ldb_ch == &ldb->channel[1])
@@ -376,6 +389,9 @@ static int imx_ldb_register(struct drm_device *drm,
 	drm_connector_init(drm, &imx_ldb_ch->connector,
 			   &imx_ldb_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 
+	if (imx_ldb_ch->panel)
+		drm_panel_attach(imx_ldb_ch->panel, &imx_ldb_ch->connector);
+
 	drm_mode_connector_attach_encoder(&imx_ldb_ch->connector,
 			&imx_ldb_ch->encoder);
 
@@ -490,6 +506,7 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 
 	for_each_child_of_node(np, child) {
 		struct imx_ldb_channel *channel;
+		struct device_node *panel_node;
 
 		ret = of_property_read_u32(child, "reg", &i);
 		if (ret || i < 0 || i > 1)
@@ -549,6 +566,10 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 			return -EINVAL;
 		}
 
+		panel_node = of_parse_phandle(child, "fsl,panel", 0);
+		if (panel_node)
+			channel->panel = of_drm_find_panel(panel_node);
+
 		ret = imx_ldb_register(drm, channel);
 		if (ret)
 			return ret;
-- 
1.9.0
