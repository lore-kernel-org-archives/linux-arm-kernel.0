From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Oct 2012 15:48:44 +0100
Subject: [PATCH 1/2] of: add of_property_count_phandles
In-Reply-To: <1351262925-10306-1-git-send-email-mark.rutland@arm.com>
References: <1351262925-10306-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1351262925-10306-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though of_parse_phandle handles lists of phandles, and takes an index
parameter, there is no standard way of discovering how many phandles are
present on a node. This patch adds a function to count how many phandles
are in a phandle list.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/of/base.c  |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |    8 ++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index af3b22a..30ae562 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -884,6 +884,45 @@ int of_property_count_strings(struct device_node *np, const char *propname)
 EXPORT_SYMBOL_GPL(of_property_count_strings);
 
 /**
+ * of_property_count_phandles - find and return the number of phandles from a
+ * multiple phandles property.
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ *
+ * Search for a property in a device tree node and retrieve the number of
+ * phandles contained in it. Returns the number of phandles on success, -ENOENT
+ * if the property does not exist, -ENODATA if there are no phandles, and
+ * -EINVAL if the property is not correctly sized for an array of phandles.
+ */
+int of_property_count_phandles(struct device_node *np, const char *propname)
+{
+	int size, count, i;
+	const __be32 *phandle;
+
+	phandle = of_get_property(np, propname, &size);
+
+	if (!phandle)
+		return -ENOENT;
+	if (size == 0)
+		return -ENODATA;
+	if (size % (sizeof *phandle))
+		return -EINVAL;
+
+	count = size / (sizeof(*phandle));
+
+	/* Check the phandle targets actually exist */
+	for (i = 0; i < count; i++) {
+		struct device_node *node = of_parse_phandle(np, propname, i);
+		if (!node)
+			return -EINVAL;
+		of_node_put(node);
+	}
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(of_property_count_phandles);
+
+/**
  * of_parse_phandle - Resolve a phandle property to a device_node pointer
  * @np: Pointer to device node holding phandle property
  * @phandle_name: Name of property holding a phandle value
diff --git a/include/linux/of.h b/include/linux/of.h
index b4e50d5..1f03f46 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -258,6 +258,8 @@ extern int of_modalias_node(struct device_node *node, char *modalias, int len);
 extern struct device_node *of_parse_phandle(struct device_node *np,
 					    const char *phandle_name,
 					    int index);
+extern int of_property_count_phandles(struct device_node *np,
+				      const char *propname);
 extern int of_parse_phandle_with_args(struct device_node *np,
 	const char *list_name, const char *cells_name, int index,
 	struct of_phandle_args *out_args);
@@ -411,6 +413,12 @@ static inline int of_property_match_string(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_count_phandles(struct device_node *np,
+					     const char *propname)
+{
+	return -ENOSYS;
+}
+
 static inline struct device_node *of_parse_phandle(struct device_node *np,
 						   const char *phandle_name,
 						   int index)
-- 
1.7.0.4
