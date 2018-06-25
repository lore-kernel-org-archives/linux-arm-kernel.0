From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Mon, 25 Jun 2018 14:02:46 +0200
Subject: [PATCH v3 06/24] drm/sun4i: Fix releasing node when enumerating
 enpoints
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Message-ID: <20180625120304.7543-7-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_drv_add_endpoints() has a memory leak since it uses of_node_put()
when remote is equal to NULL and does nothing when remote has a valid
pointer.

Invert the logic to fix memory leak.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 50d19605c38f..e15fa2389e3f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -283,7 +283,6 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote) {
 			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
-			of_node_put(remote);
 			continue;
 		}
 
@@ -297,11 +296,13 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 
 			if (of_graph_parse_endpoint(ep, &endpoint)) {
 				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				of_node_put(remote);
 				continue;
 			}
 
 			if (!endpoint.id) {
 				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+				of_node_put(remote);
 				continue;
 			}
 		}
-- 
2.18.0
