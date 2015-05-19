From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 May 2015 10:48:00 +0200
Subject: [PATCH v2] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <555AE192.8010700@denx.de>
References: <1431334974-27531-1-git-send-email-hs@denx.de>
 <20150518113135.GD1071@dragon> <555AE192.8010700@denx.de>
Message-ID: <1432025280.3182.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko, Shawn,

Am Dienstag, den 19.05.2015, 09:09 +0200 schrieb Heiko Schocher:
[...]
> > What is this?  I failed to find it in Documentation/devicetree/bindings/
> 
> Ah, this is not documentated, see commit:
> 
> commit 628f435be4359e6ae8ecfdda9b492053be76a057
> Author: Philipp Zabel <p.zabel@pengutronix.de>
> Date:   Tue Feb 25 11:55:04 2014 +0100
> 
>      imx-drm: parallel-display: Add drm_panel support
> 
> added Philipp to cc ...

This was meant to be a temporary solution to connect a drm_panel to the
parallel-display when the of-graph bindings were not yet available.
I'd very much prefer to switch to the common of-graph bindings similarly
to the LDB driver instead. Could you check if this would work for you:

-----8<-----
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] drm/imx: parallel-display: fix drm_panel support

The parallel-display driver used an undocumented, non-standard property
"fsl,panel" to optionally associate with a drm_panel device. This patch
fixes the driver to use the OF graph bindings, just as the LDB driver:

    parallel-display {
            compatible = "fsl,imx-parallel-display";
            ...

            port at 1 {
                    reg = <1>;

                    parallel_out: endpoint {
                            remote_endpoint = <&panel_in>;
                    };
            };
    };

    panel {
            ...

            port {
                    panel_in: endpoint {
                            remote-endpoint = <&parallel_out>;
                    };
            };
    };

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/drm/imx/fsl-imx-drm.txt    | 26 ++++++++++++++++++++--
 drivers/gpu/drm/imx/parallel-display.c             | 21 ++++++++++++-----
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/drm/imx/fsl-imx-drm.txt b/Documentation/devicetree/bindings/drm/imx/fsl-imx-drm.txt
index e75f0e5..971c3ee 100644
--- a/Documentation/devicetree/bindings/drm/imx/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/drm/imx/fsl-imx-drm.txt
@@ -65,8 +65,10 @@ Optional properties:
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
-- port: A port node with endpoint definitions as defined in
+- port@[0-1]: Port nodes with endpoint definitions as defined in
   Documentation/devicetree/bindings/media/video-interfaces.txt.
+  Port 0 is the input port connected to the IPU display interface,
+  port 1 is the output port connected to a panel.
 
 example:
 
@@ -75,9 +77,29 @@ display at di0 {
 	edid = [edid-data];
 	interface-pix-fmt = "rgb24";
 
-	port {
+	port at 0 {
+		reg = <0>;
+
 		display_in: endpoint {
 			remote-endpoint = <&ipu_di0_disp0>;
 		};
 	};
+
+	port at 1 {
+		reg = <1>;
+
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+panel {
+	...
+
+	port {
+		panel_in: endpoint {
+			remote-endpoint = <&display_out>;
+		};
+	};
 };
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index 74a9ce4..b4deb9c 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -21,6 +21,7 @@
 #include <drm/drm_panel.h>
 #include <linux/videodev2.h>
 #include <video/of_display_timing.h>
+#include <linux/of_graph.h>
 
 #include "imx-drm.h"
 
@@ -208,7 +209,7 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 {
 	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
-	struct device_node *panel_node;
+	struct device_node *port;
 	const u8 *edidp;
 	struct imx_parallel_display *imxpd;
 	int ret;
@@ -234,11 +235,19 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
 			imxpd->bus_format = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
 	}
 
-	panel_node = of_parse_phandle(np, "fsl,panel", 0);
-	if (panel_node) {
-		imxpd->panel = of_drm_find_panel(panel_node);
-		if (!imxpd->panel)
-			return -EPROBE_DEFER;
+	/* port at 1 is the output port */
+	port = of_graph_get_port_by_id(np, 1);
+	if (port) {
+		struct device_node *endpoint, *remote;
+
+		endpoint = of_get_child_by_name(port, "endpoint");
+		if (endpoint) {
+			remote = of_graph_get_remote_port_parent(endpoint);
+			if (remote)
+				imxpd->panel = of_drm_find_panel(remote);
+			if (!imxpd->panel)
+				return -EPROBE_DEFER;
+		}
 	}
 
 	imxpd->dev = dev;
-- 
2.1.4
----->8-----

regards
Philipp
