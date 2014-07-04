From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  4 Jul 2014 10:30:45 +0200
Subject: [PATCH 4/5] drm: use for_each_endpoint_of_node macro in
 drm_of_find_possible_crtcs
In-Reply-To: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
References: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1404462646-1769-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the for_each_... macro should make the code a bit shorter and
easier to read.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/drm_of.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 46d9678..1b315b6 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -44,11 +44,7 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 	struct device_node *remote_port, *ep = NULL;
 	uint32_t possible_crtcs = 0;
 
-	do {
-		ep = of_graph_get_next_endpoint(port, ep);
-		if (!ep)
-			break;
-
+	for_each_endpoint_of_node(port, ep) {
 		remote_port = of_graph_get_remote_port(ep);
 		if (!remote_port) {
 			of_node_put(ep);
@@ -58,7 +54,7 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 		possible_crtcs |= drm_crtc_port_mask(dev, remote_port);
 
 		of_node_put(remote_port);
-	} while (1);
+	}
 
 	return possible_crtcs;
 }
-- 
2.0.0
