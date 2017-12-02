From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  1 Dec 2017 23:27:41 -0500
Subject: [PATCH V5 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1512188864-773-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a get_match_data() callback as part of the firmware node,
implement the OF specific piece for it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/of/property.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 264c355..adcde1a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -981,6 +981,22 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
+			       const struct device_driver *drv)
+{
+	const struct device_node *node = to_of_node(fwnode);
+	const struct of_device_id *match;
+
+	if (!node)
+		return NULL;
+
+	match = of_match_node(drv->of_match_table, node);
+	if (!match)
+		return NULL;
+
+	return (void *)match->data;
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
@@ -996,5 +1012,6 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
 	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
 	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
+	.get_match_data = of_fwnode_get_match_data,
 };
 EXPORT_SYMBOL_GPL(of_fwnode_ops);
-- 
1.9.1
