From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Dec 2012 16:49:27 +0000
Subject: [RFCv2 1/2] of: add of_property_read_u32_index
In-Reply-To: <1355417368-6861-1-git-send-email-mark.rutland@arm.com>
References: <1355417368-6861-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1355417368-6861-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we have to pre-allocate an array when reading multiple u32
values from a property using of_property_read_u32_array. This isn't very
good for times when we want to iterate over elements of a list of
arbitrary size.

This patch adds a function to read a single u32 value from an arbitrary
index in a list, making this case easier.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/of/base.c  |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/of.h |   11 +++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index af3b22a..5ad6830 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -707,6 +707,42 @@ int of_property_read_u32_array(const struct device_node *np,
 EXPORT_SYMBOL_GPL(of_property_read_u32_array);
 
 /**
+ * of_property_read_u32_index - Find and read a 32 bit integer from a multiple
+ * integer property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_value:	pointer to return value, modified only if return value is 0.
+ * @index:	index of the integer in the list of integers.
+ *
+ * Search for a property in a device node and read a 32-bit value from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * index is beyond the range of data.
+ *
+ * The out_value is modified only if a valid u32 value can be decoded.
+ */
+int of_property_read_u32_index(const struct device_node *np,
+			       const char *propname, u32 *out_value,
+			       int idx)
+{
+	struct property *prop = of_find_property(np, propname, NULL);
+	const __be32 *val;
+
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -ENODATA;
+	if ((idx+1) * sizeof(*out_value) > prop->length)
+		return -EOVERFLOW;
+
+	val = prop->value;
+	*out_value = be32_to_cpup(val + idx);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u32_index);
+
+/**
  * of_property_read_u64 - Find and read a 64 bit integer from a property
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
diff --git a/include/linux/of.h b/include/linux/of.h
index b4e50d5..37f6f67 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -227,6 +227,10 @@ extern int of_property_read_u32_array(const struct device_node *np,
 				      const char *propname,
 				      u32 *out_values,
 				      size_t sz);
+extern int of_property_read_u32_index(const struct device_node *np,
+				      const char *propname,
+				      u32 *out_value,
+				      int idx);
 extern int of_property_read_u64(const struct device_node *np,
 				const char *propname, u64 *out_value);
 
@@ -371,6 +375,13 @@ static inline int of_property_read_u32_array(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_u32_index(const struct device_node *np,
+					     const char *propname,
+					     u32 *out_value, int idx)
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_string(struct device_node *np,
 					  const char *propname,
 					  const char **out_string)
-- 
1.7.0.4
