From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:07 +0800
Subject: [PATCH 02/19] drm/sun4i: add components in two passes with encoders
 added in second pass
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The encoder drivers use drm_of_find_possible_crtcs to get upstream
crtcs from the device tree using of_graph. For the results to be
correct, encoders must be probed/bound after _all_ crtcs have been
created. The existing code uses a depth first recursive traversal
of the of_graph, which means the encoders downstream of the TCON
get add right after the first TCON. The second TCON or CRTC will
never be properly associated with encoders connected to it.

Other platforms, such as Rockchip, deal with this by probing all
crtcs first, then all subsequent components. This is easy to do
since the crtcs correspond to just one device node, and are the
first nodes in the pipeline.

However with Allwinner SoCs, the function of the CRTC is split between
the display backend (DE 1.0) or mixer (DE 2.0), which does scan-out
and compositing, and the TCON, which generating the display timing
signals. Further complicating the process, there may be a Dynamic Range
Controller between the backend and the TCON. Also, the backend is
preceded by the frontend, with a Display Enhancement Unit possibly
in between.

One solution would be, instead of a depth first traversal of the
component of_graph, we do a breadth first traversal, so that components
at the same depth are grouped together. This however requires us to
implement extra code for a queue structure that is only used here.

Instead, since we can identify TCON device nodes, and since the
component system can gracefully deal with duplicate entries, we can add
components in two passes, using the existing recursive depth code. The
first pass stops right after the TCON is added. The second pass will
re-add all components up to the TCON, but these will be skipped since
they will have already been bound with the entries from the first pass.
The encoders added in the second pass will be the last entries in the
list.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index ed75a779ae4b..bc13dcf06783 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -198,7 +198,8 @@ static int compare_of(struct device *dev, void *data)
 
 static int sun4i_drv_add_endpoints(struct device *dev,
 				   struct component_match **match,
-				   struct device_node *node)
+				   struct device_node *node,
+				   bool add_encoders)
 {
 	struct device_node *port, *ep, *remote;
 	int count = 0;
@@ -227,13 +228,16 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		count++;
 	}
 
+	/* Skip downstream encoders during the first pass */
+	if (sun4i_drv_node_is_tcon(node) && !add_encoders)
+		return count;
+
 	/* Inputs are listed first, then outputs */
 	port = of_graph_get_port_by_id(node, 1);
 	if (!port) {
 		DRM_DEBUG_DRIVER("No output to bind\n");
 		return count;
 	}
-
 	for_each_available_child_of_node(port, ep) {
 		remote = of_graph_get_remote_port_parent(ep);
 		if (!remote) {
@@ -262,7 +266,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 		}
 
 		/* Walk down our tree */
-		count += sun4i_drv_add_endpoints(dev, match, remote);
+		count += sun4i_drv_add_endpoints(dev, match, remote,
+						 add_encoders);
 
 		of_node_put(remote);
 	}
@@ -283,8 +288,19 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 		if (!pipeline)
 			break;
 
+		sun4i_drv_add_endpoints(&pdev->dev, &match, pipeline, false);
+		of_node_put(pipeline);
+	}
+
+	for (i = 0;; i++) {
+		struct device_node *pipeline = of_parse_phandle(np,
+								"allwinner,pipelines",
+								i);
+		if (!pipeline)
+			break;
+
 		count += sun4i_drv_add_endpoints(&pdev->dev, &match,
-						pipeline);
+						 pipeline, true);
 		of_node_put(pipeline);
 
 		DRM_DEBUG_DRIVER("Queued %d outputs on pipeline %d\n",
-- 
2.11.0
