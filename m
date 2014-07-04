From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri,  4 Jul 2014 10:30:43 +0200
Subject: [PATCH 2/5] of: Decrement refcount of previous endpoint in
 of_graph_get_next_endpoint
In-Reply-To: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
References: <1404462646-1769-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1404462646-1769-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Decreasing the reference count of the previous endpoint node allows to use
the of_graph_get_next_endpoint function in a for_each_... style macro.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/of/base.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8368d96..9480e10 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2262,8 +2262,7 @@ EXPORT_SYMBOL(of_graph_parse_endpoint);
  * @prev: previous endpoint node, or NULL to get first
  *
  * Return: An 'endpoint' node pointer with refcount incremented. Refcount
- * of the passed @prev node is not decremented, the caller have to use
- * of_node_put() on it when done.
+ * of the passed @prev node is decremented.
  */
 struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 					struct device_node *prev)
@@ -2299,12 +2298,6 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
 		if (WARN_ONCE(!port, "%s(): endpoint %s has no parent node\n",
 			      __func__, prev->full_name))
 			return NULL;
-
-		/*
-		 * Avoid dropping prev node refcount to 0 when getting the next
-		 * child below.
-		 */
-		of_node_get(prev);
 	}
 
 	while (1) {
-- 
2.0.0
