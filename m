From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 12 Aug 2011 16:54:46 -0600
Subject: [RFC PATCH 01/12] dt: Add of_find_child_node_by_name()
In-Reply-To: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313189697-21287-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function retrieves a named child node of a given parent node.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/of/base.c  |   18 ++++++++++++++++++
 include/linux/of.h |    2 ++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3ff22e3..7eea9e3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -388,6 +388,24 @@ struct device_node *of_find_node_by_name(struct device_node *from,
 }
 EXPORT_SYMBOL(of_find_node_by_name);
 
+struct device_node *of_find_child_node_by_name(
+	const struct device_node *parent, const char *name)
+{
+	struct device_node *child;
+
+	read_lock(&devtree_lock);
+
+	for_each_child_of_node(parent, child) {
+		if (!strcmp(child->name, name))
+			break;
+	}
+
+	read_unlock(&devtree_lock);
+
+	return child;
+}
+EXPORT_SYMBOL(of_find_child_node_by_name);
+
 /**
  *	of_find_node_by_type - Find a node by its "device_type" property
  *	@from:	The node to start searching from, or NULL to start searching
diff --git a/include/linux/of.h b/include/linux/of.h
index 9180dc5..032c71b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -161,6 +161,8 @@ extern struct device_node *of_find_node_by_name(struct device_node *from,
 #define for_each_node_by_name(dn, name) \
 	for (dn = of_find_node_by_name(NULL, name); dn; \
 	     dn = of_find_node_by_name(dn, name))
+extern struct device_node *of_find_child_node_by_name(
+	const struct device_node *node, const char *name);
 extern struct device_node *of_find_node_by_type(struct device_node *from,
 	const char *type);
 #define for_each_node_by_type(dn, type) \
-- 
1.7.0.4
