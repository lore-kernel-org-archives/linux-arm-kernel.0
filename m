From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 Feb 2015 09:53:40 +0100
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabrelite: add supported LVDS
 displays
In-Reply-To: <1424390002-8726-1-git-send-email-eric.nelson@boundarydevices.com>
References: <1424390002-8726-1-git-send-email-eric.nelson@boundarydevices.com>
Message-ID: <1424422420.3137.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Am Donnerstag, den 19.02.2015, 16:53 -0700 schrieb Eric Nelson:
> The BD-SL-i.MX6 (SABRE Lite board) supports three companion displays:
> 	Okaya 1024x600
> 	Hannstar 1024x768
> 	LG 1280x800
> 
> This patch adds timing entries into the LDB device tree and aliases
> for them and HDMI to make it easy for the boot loader to configure them.
>
> Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>

Could you please have a look at the simple-panel driver and add these
panels there instead? This allows to handle enable/disable timings,
backlights and regulators or enable GPIOs properly.

I have a patch to add drm_panel support to the imx-ldb driver (see
below). It depends on this of-graph series:

    https://lkml.org/lkml/2015/1/22/104

regards
Philipp

-----8<-----
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 6 Mar 2014 14:54:39 +0100
Subject: [PATCH] drm/imx: imx-ldb: add drm_panel support

This patch allows to optionally attach the lvds-channel to a panel
supported by a drm_panel driver using of-graph bindings, instead of
supplying the modes via display-timings in the device tree.

This depends on of_graph_get_port_by_id and uses the OF graph to
link the optional DRM panel to the LDB lvds-channel. The output
port number is 2 on devices without the external 4-port input
multiplexer (i.MX5) and 4 on devices with the mux (i.MX6).

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
			...

			port at 4 {
				reg = <4>;

				lvds_out: endpoint {
					remote_endpoint = <&panel_in>;
				};
			};
		};
	};

	panel {
		compatible = "edt,etm0700g0dh6", "simple-panel";
		...

		port {
			panel_in: endpoint {
				remote-endpoint = <&lvds_out>;
			};
		};
	};

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[Fixed build error due to missing select on DRM_PANEL --rmk]
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/imx/Kconfig   |  1 +
 drivers/gpu/drm/imx/imx-ldb.c | 45 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
index ab31848..1a5dbdb 100644
--- a/drivers/gpu/drm/imx/Kconfig
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -36,6 +36,7 @@ config DRM_IMX_TVE
 config DRM_IMX_LDB
 	tristate "Support for LVDS displays"
 	depends on DRM_IMX && MFD_SYSCON
+	select DRM_PANEL
 	help
 	  Choose this to enable the internal LVDS Display Bridge (LDB)
 	  found on i.MX53 and i.MX6 processors.
diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index c604600..e3cd148 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -19,10 +19,11 @@
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <video/of_videomode.h>
 #include <linux/regmap.h>
 #include <linux/videodev2.h>
@@ -55,6 +56,7 @@ struct imx_ldb_channel {
 	struct imx_ldb *ldb;
 	struct drm_connector connector;
 	struct drm_encoder encoder;
+	struct drm_panel *panel;
 	struct device_node *child;
 	int chno;
 	void *edid;
@@ -91,6 +93,13 @@ static int imx_ldb_connector_get_modes(struct drm_connector *connector)
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
@@ -205,6 +214,8 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
 	int mux = imx_drm_encoder_get_mux_id(imx_ldb_ch->child, encoder);
 
+	drm_panel_prepare(imx_ldb_ch->panel);
+
 	if (dual) {
 		clk_prepare_enable(ldb->clk[0]);
 		clk_prepare_enable(ldb->clk[1]);
@@ -238,6 +249,8 @@ static void imx_ldb_encoder_commit(struct drm_encoder *encoder)
 	}
 
 	regmap_write(ldb->regmap, IOMUXC_GPR2, ldb->ldb_ctrl);
+
+	drm_panel_enable(imx_ldb_ch->panel);
 }
 
 static void imx_ldb_encoder_mode_set(struct drm_encoder *encoder,
@@ -289,6 +302,8 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 		 (ldb->ldb_ctrl & LDB_CH1_MODE_EN_MASK) == 0)
 		return;
 
+	drm_panel_disable(imx_ldb_ch->panel);
+
 	if (imx_ldb_ch == &ldb->channel[0])
 		ldb->ldb_ctrl &= ~LDB_CH0_MODE_EN_MASK;
 	else if (imx_ldb_ch == &ldb->channel[1])
@@ -300,6 +315,8 @@ static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
 		clk_disable_unprepare(ldb->clk[0]);
 		clk_disable_unprepare(ldb->clk[1]);
 	}
+
+	drm_panel_unprepare(imx_ldb_ch->panel);
 }
 
 static struct drm_connector_funcs imx_ldb_connector_funcs = {
@@ -373,6 +390,9 @@ static int imx_ldb_register(struct drm_device *drm,
 	drm_connector_init(drm, &imx_ldb_ch->connector,
 			   &imx_ldb_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
 
+	if (imx_ldb_ch->panel)
+		drm_panel_attach(imx_ldb_ch->panel, &imx_ldb_ch->connector);
+
 	drm_mode_connector_attach_encoder(&imx_ldb_ch->connector,
 			&imx_ldb_ch->encoder);
 
@@ -487,6 +507,7 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 
 	for_each_child_of_node(np, child) {
 		struct imx_ldb_channel *channel;
+		struct device_node *port;
 
 		ret = of_property_read_u32(child, "reg", &i);
 		if (ret || i < 0 || i > 1)
@@ -505,11 +526,31 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
 		channel->chno = i;
 		channel->child = child;
 
+		/* The output port is port at 4 on i.MX6 or port at 2 on i.MX53 */
+		port = of_graph_get_port_by_id(child, imx_ldb->lvds_mux ? 4 : 2);
+		if (port) {
+			struct device_node *endpoint, *remote;
+
+			endpoint = of_get_child_by_name(port, "endpoint");
+			if (endpoint) {
+				remote = of_graph_get_remote_port_parent(endpoint);
+				if (remote)
+					channel->panel = of_drm_find_panel(remote);
+				else
+					return -EPROBE_DEFER;
+				if (!channel->panel) {
+					dev_err(dev, "panel not found: %s\n",
+						remote->full_name);
+					return -EPROBE_DEFER;
+				}
+			}
+		}
+
 		edidp = of_get_property(child, "edid", &channel->edid_len);
 		if (edidp) {
 			channel->edid = kmemdup(edidp, channel->edid_len,
 						GFP_KERNEL);
-		} else {
+		} else if (!channel->panel) {
 			ret = of_get_drm_display_mode(child, &channel->mode, 0);
 			if (!ret)
 				channel->mode_valid = 1;
-- 
2.1.4
