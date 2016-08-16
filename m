From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Tue, 16 Aug 2016 10:38:58 +0800
Subject: [PATCH v1 2/3] of: Add support for reading a s32 from a multi-value
 property.
In-Reply-To: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

This patch adds an of_property_read_s32_index() function to allow
reading a single indexed s32 value from a property containing multiple
s32 values.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/of/base.c  | 23 +++++++++++++++++++++++
 include/linux/of.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7792266..346457d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1200,6 +1200,29 @@ int of_property_read_u32_index(const struct device_node *np,
 EXPORT_SYMBOL_GPL(of_property_read_u32_index);
 
 /**
+ * of_property_read_s32_index - Find and read a s32 from a multi-value property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u32 in the list of values
+ * @out_value:	pointer to return value, modified only if no error.
+ *
+ * Search for a property in a device node and read nth 32-bit value from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_value is modified only if a valid s32 value can be decoded.
+ */
+int of_property_read_s32_index(const struct device_node *np,
+			       const char *propname, u32 index, s32 *out_value)
+{
+	return of_property_read_u32_index(np, propname, index,
+		(u32 *)out_value);
+}
+EXPORT_SYMBOL_GPL(of_property_read_s32_index);
+
+/**
  * of_property_read_u8_array - Find and read an array of u8 from a property.
  *
  * @np:		device node from which the property value is to be read.
diff --git a/include/linux/of.h b/include/linux/of.h
index 3d9ff8e..cb9a627 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -291,6 +291,9 @@ extern int of_property_count_elems_of_size(const struct device_node *np,
 extern int of_property_read_u32_index(const struct device_node *np,
 				       const char *propname,
 				       u32 index, u32 *out_value);
+extern int of_property_read_s32_index(const struct device_node *np,
+				      const char *propname,
+				      u32 index, s32 *out_value);
 extern int of_property_read_u8_array(const struct device_node *np,
 			const char *propname, u8 *out_values, size_t sz);
 extern int of_property_read_u16_array(const struct device_node *np,
@@ -536,6 +539,13 @@ static inline int of_property_read_u32_index(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_s32_index(const struct device_node *np,
+					     const char *propname,
+					     u32 index, s32 *out_value)
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_u8_array(const struct device_node *np,
 			const char *propname, u8 *out_values, size_t sz)
 {
-- 
1.9.1
