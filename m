From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:34 +0200
Subject: [PATCH v2 25/27] drm/sun4i: DW HDMI: Expand algorithm for possible
 crtcs
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-26-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_of_find_possible_crtcs() doesn't work when DW HDMI encoder is
connected to TCON (crtc) through mux in TCON TOP.

In that case TCON TOP HDMI mux input port has to be manually traversed
and checked if it matches any known crtc.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 46 ++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 9f40a44b456b..d443886e055b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -12,6 +12,7 @@
 #include <drm/drm_crtc_helper.h>
 
 #include "sun8i_dw_hdmi.h"
+#include "sun8i_tcon_top.h"
 
 static void sun8i_dw_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 					   struct drm_display_mode *mode,
@@ -41,6 +42,48 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
+static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
+{
+	return !!of_match_node(sun8i_tcon_top_of_table, node);
+}
+
+static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
+					     struct device_node *node)
+{
+	struct device_node *port, *ep, *remote, *remote_port;
+	u32 crtcs = 0;
+
+	port = of_graph_get_port_by_id(node, 0);
+	if (!port)
+		return 0;
+
+	ep = of_get_next_available_child(port, NULL);
+	if (!ep)
+		return 0;
+
+	remote = of_graph_get_remote_port_parent(ep);
+	if (!remote)
+		return 0;
+
+	if (sun8i_dw_hdmi_node_is_tcon_top(remote)) {
+		port = of_graph_get_port_by_id(remote, 4);
+		if (!port)
+			return 0;
+
+		for_each_child_of_node(port, ep) {
+			remote_port = of_graph_get_remote_port(ep);
+			if (remote_port) {
+				crtcs |= drm_crtc_port_mask(drm, remote_port);
+				of_node_put(remote_port);
+			}
+		}
+	} else {
+		crtcs = drm_of_find_possible_crtcs(drm, node);
+	}
+
+	return crtcs;
+}
+
 static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 			      void *data)
 {
@@ -63,7 +106,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs =
+		sun8i_dw_hdmi_find_possible_crtcs(drm, dev->of_node);
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
 	 * supposed to be connected to, it's because the CRTC has
-- 
2.17.1
