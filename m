From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  4 Jul 2014 10:30:42 +0200
Subject: [PATCH 1/5] imx-drm: Drop imx_drm_of_get_next_endpoint wrapper
In-Reply-To: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
References: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1404462646-1769-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will decrease the prev node reference count in of_graph_get_next_endpoint
instead.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/imx-drm-core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index a5d05b4..e6663dd 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -408,14 +408,6 @@ int imx_drm_remove_crtc(struct imx_drm_crtc *imx_drm_crtc)
 }
 EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
 
-static struct device_node *imx_drm_of_get_next_endpoint(
-		const struct device_node *parent, struct device_node *prev)
-{
-	struct device_node *node = of_graph_get_next_endpoint(parent, prev);
-	of_node_put(prev);
-	return node;
-}
-
 int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np)
 {
@@ -456,7 +448,7 @@ int imx_drm_encoder_get_mux_id(struct device_node *node,
 		return -EINVAL;
 
 	do {
-		ep = imx_drm_of_get_next_endpoint(node, ep);
+		ep = of_graph_get_next_endpoint(node, ep);
 		if (!ep)
 			break;
 
-- 
2.0.0
