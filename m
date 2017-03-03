From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  3 Mar 2017 23:18:44 +0000
Subject: [PATCH V10 1/6] of: base: Implement read function for s32 array
In-Reply-To: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
References: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1488583129-4159-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to read signed thermal coefficients from DT we need a proper
function.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 include/linux/of.h |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 21e6323..98a046a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -474,6 +474,34 @@ static inline int of_property_read_u32_array(const struct device_node *np,
 }
 
 /**
+ * of_property_read_s32_array - Find and read an array of 32 bit signed integers
+ * from a property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ *
+ * Search for a property in a device node and read 32-bit value(s) from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_values is modified only if a valid s32 value can be decoded.
+ */
+static inline int of_property_read_s32_array(const struct device_node *np,
+					     const char *propname,
+					     s32 *out_values, size_t sz)
+{
+	int ret = of_property_read_variable_u32_array(np, propname, out_values,
+						      sz, 0);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+/**
  * of_property_read_u64_array - Find and read an array of 64 bit integers
  * from a property.
  *
@@ -676,6 +704,13 @@ static inline int of_property_read_u32_array(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_s32_array(const struct device_node *np,
+					     const char *propname,
+					     s32 *out_values, size_t sz)
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_u64_array(const struct device_node *np,
 					     const char *propname,
 					     u64 *out_values, size_t sz)
-- 
1.7.9.5
