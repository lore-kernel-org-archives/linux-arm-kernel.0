From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  4 Jul 2014 10:30:44 +0200
Subject: [PATCH 3/5] of: Add for_each_endpoint_of_node helper macro
In-Reply-To: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
References: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1404462646-1769-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that while of_graph_get_next_endpoint decrements the reference count
of the child node passed to it, of_node_put(child) still has to be called
manually when breaking out of the loop.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/of_graph.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/of_graph.h b/include/linux/of_graph.h
index befef42..c5ef5fa 100644
--- a/include/linux/of_graph.h
+++ b/include/linux/of_graph.h
@@ -26,6 +26,10 @@ struct of_endpoint {
 	const struct device_node *local_node;
 };
 
+#define for_each_endpoint_of_node(parent, child) \
+	for (child = of_graph_get_next_endpoint(parent, NULL); child != NULL; \
+	     child = of_graph_get_next_endpoint(parent, child))
+
 #ifdef CONFIG_OF
 int of_graph_parse_endpoint(const struct device_node *node,
 				struct of_endpoint *endpoint);
-- 
2.0.0
