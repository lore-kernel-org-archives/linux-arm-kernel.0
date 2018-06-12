From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:16 +0200
Subject: [PATCH v2 07/27] drm/sun4i: Split out code for enumerating endpoints
 in output port
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-8-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, each node has one input port and one output port. However,
with TCON TOP this is no longer true. It has 3 input and 3 output ports.

In order to prepare to this situation, split out the code which checks
all endpoints in input port and adds available components to fifo.

This patch doesn't do any functional change.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 84 +++++++++++++++++--------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e15fa2389e3f..20193d6f33ba 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -231,12 +231,55 @@ struct endpoint_list {
 	DECLARE_KFIFO(fifo, struct device_node *, 16);
 };
 
+static void sun4i_drv_traverse_endpoints(struct endpoint_list *list,
+					 struct device_node *node,
+					 int port_id)
+{
+	struct device_node *ep, *remote, *port;
+
+	port = of_graph_get_port_by_id(node, port_id);
+	if (!port) {
+		DRM_DEBUG_DRIVER("No output to bind on port %d\n", port_id);
+		return;
+	}
+
+	for_each_available_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote) {
+			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
+			continue;
+		}
+
+		/*
+		 * If the node is our TCON, the first port is used for
+		 * panel or bridges, and will not be part of the
+		 * component framework.
+		 */
+		if (sun4i_drv_node_is_tcon(node)) {
+			struct of_endpoint endpoint;
+
+			if (of_graph_parse_endpoint(ep, &endpoint)) {
+				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
+				of_node_put(remote);
+				continue;
+			}
+
+			if (!endpoint.id) {
+				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
+				of_node_put(remote);
+				continue;
+			}
+		}
+
+		kfifo_put(&list->fifo, remote);
+	}
+}
+
 static int sun4i_drv_add_endpoints(struct device *dev,
 				   struct endpoint_list *list,
 				   struct component_match **match,
 				   struct device_node *node)
 {
-	struct device_node *port, *ep, *remote;
 	int count = 0;
 
 	/*
@@ -272,43 +315,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		count++;
 	}
 
-	/* Inputs are listed first, then outputs */
-	port = of_graph_get_port_by_id(node, 1);
-	if (!port) {
-		DRM_DEBUG_DRIVER("No output to bind\n");
-		return count;
-	}
-
-	for_each_available_child_of_node(port, ep) {
-		remote = of_graph_get_remote_port_parent(ep);
-		if (!remote) {
-			DRM_DEBUG_DRIVER("Error retrieving the output node\n");
-			continue;
-		}
-
-		/*
-		 * If the node is our TCON, the first port is used for
-		 * panel or bridges, and will not be part of the
-		 * component framework.
-		 */
-		if (sun4i_drv_node_is_tcon(node)) {
-			struct of_endpoint endpoint;
-
-			if (of_graph_parse_endpoint(ep, &endpoint)) {
-				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
-				of_node_put(remote);
-				continue;
-			}
-
-			if (!endpoint.id) {
-				DRM_DEBUG_DRIVER("Endpoint is our panel... skipping\n");
-				of_node_put(remote);
-				continue;
-			}
-		}
-
-		kfifo_put(&list->fifo, remote);
-	}
+	/* each node has at least one output */
+	sun4i_drv_traverse_endpoints(list, node, 1);
 
 	return count;
 }
-- 
2.17.1
