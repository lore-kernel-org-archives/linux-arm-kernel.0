From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  4 Jul 2014 10:30:46 +0200
Subject: [PATCH 5/5] imx-drm: use for_each_endpoint_of_node macro in
 imx_drm_encoder_get_mux_id
In-Reply-To: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
References: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1404462646-1769-6-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the for_each_... macro should make the code bit shorter and
easier to read. This patch also properly decrements the endpoint node
reference count before returning out of the loop.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index e6663dd..4881fd9 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -447,18 +447,15 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 	if (!node || !imx_crtc)
 		return -EINVAL;
 
-	do {
-		ep = of_graph_get_next_endpoint(node, ep);
-		if (!ep)
-			break;
-
+	for_each_endpoint_of_node(node, ep) {
 		port = of_graph_get_remote_port(ep);
 		of_node_put(port);
 		if (port == imx_crtc->crtc->port) {
 			ret = of_graph_parse_endpoint(ep, &endpoint);
+			of_node_put(ep);
 			return ret ? ret : endpoint.port;
 		}
-	} while (ep);
+	}
 
 	return -EINVAL;
 }
-- 
2.0.0
