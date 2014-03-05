From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:53 +0100
Subject: [PATCH v5 02/11] staging: imx-drm-core: use of_graph_parse_endpoint
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using of_graph_parse_endpoint recovers the port id from an endpoint device
tree node. This just replaces an open coded read of the "reg" property.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index ecfc88b..4144a75 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -501,8 +501,9 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 {
 	struct imx_drm_crtc *imx_crtc = imx_drm_find_crtc(encoder->crtc);
 	struct device_node *ep = NULL;
+	struct of_endpoint endpoint;
 	struct device_node *port;
-	int id, ret;
+	int ret;
 
 	if (!node || !imx_crtc)
 		return -EINVAL;
@@ -515,9 +516,8 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 		port = of_graph_get_remote_port(ep);
 		of_node_put(port);
 		if (port == imx_crtc->port) {
-			ret = of_property_read_u32(ep->parent, "reg", &id);
-			of_node_put(ep);
-			return ret ? ret : id;
+			ret = of_graph_parse_endpoint(ep, &endpoint);
+			return ret ? ret : endpoint.id;
 		}
 	} while (ep);
 
-- 
1.9.0.rc3
