From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 09 Apr 2014 13:55:14 +0100
Subject: [PATCH 5/8] imx-drm: imx-ldb: Add drm_panel support
In-Reply-To: <20140409125354.GP16119@n2100.arm.linux.org.uk>
References: <20140409125354.GP16119@n2100.arm.linux.org.uk>
Message-ID: <E1WXs26-0002b2-QD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-arm-kernel at lists.infradead.org

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
[Fixed build error due to missing select on DRM_PANEL --rmk]
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/Kconfig   |  1 +
 drivers/staging/imx-drm/imx-ldb.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
index 78319ad176cd..bb54c450e077 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -34,6 +34,7 @@ config DRM_IMX_TVE
 config DRM_IMX_LDB
 	tristate "Support for LVDS displays"
 	depends on DRM_IMX && MFD_SYSCON
+	select DRM_PANEL
 	help
 	  Choose this to enable the internal LVDS Display Bridge (LDB)
 	  found on i.MX53 and i.MX6 processors.
diff --git a/drivers/staging/imx-drm/imx-ldb.c b/drivers/staging/imx-drm/imx-ldb.c
index 0518a32520b4..4c77904976cc 100644
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
@@ -238,6 +247,8 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	}
 
 	regmap_write(ldb->regmap, IOMUXC_GPR2, ldb->ldb_ctrl);
+
+	drm_panel_enable(imx_ldb_ch->panel);
 }
 
 static void imx_ldb_encoder_mode_set(struct drm_encoder *encoder,
@@ -289,6 +300,8 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 		 (ldb->ldb_ctrl & LDB_CH1_MODE_EN_MASK) == 0)
 		return;
 
+	drm_panel_disable(imx_ldb_ch->panel);
+
 	if (imx_ldb_ch == &ldb->channel[0])
 		ldb->ldb_ctrl &= ~LDB_CH0_MODE_EN_MASK;
 	else if (imx_ldb_ch == &ldb->channel[1])
@@ -374,6 +387,9 @@ static int imx_ldb_register(struct drm_device *drm,
 	drm_connector_init(drm, &imx_ldb_ch->connector,
 			   &imx_ldb_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 
+	if (imx_ldb_ch->panel)
+		drm_panel_attach(imx_ldb_ch->panel, &imx_ldb_ch->connector);
+
 	drm_mode_connector_attach_encoder(&imx_ldb_ch->connector,
 			&imx_ldb_ch->encoder);
 
@@ -488,6 +504,7 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 
 	for_each_child_of_node(np, child) {
 		struct imx_ldb_channel *channel;
+		struct device_node *panel_node;
 
 		ret = of_property_read_u32(child, "reg", &i);
 		if (ret || i < 0 || i > 1)
@@ -547,6 +564,10 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
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
1.8.3.1
