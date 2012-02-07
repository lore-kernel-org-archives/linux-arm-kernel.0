From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue,  7 Feb 2012 05:13:48 +0100
Subject: [PATCH 1/1] of: introduce helper to manage boolean
Message-ID: <1328588028-24766-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_property_read_bool

Search for a property in a device node and read a 32-bit value from
it. Returns 0 if <0> or if the property does not exist, 1 if <1> or none.

this will allow to disable a boolean

is-ok;          => true
is-ok = <1>;    => true
is-ok = <0>;    => false

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
Hi,

	if this is ok I'll rebase my mtd and i2c patch to use it

Best Regards,
J.
 drivers/of/base.c  |   30 ++++++++++++++++++++++++++++++
 include/linux/of.h |    8 ++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 133908a..a0eaf08 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -686,6 +686,36 @@ int of_property_read_u64(const struct device_node *np, const char *propname,
 EXPORT_SYMBOL_GPL(of_property_read_u64);
 
 /**
+ * of_property_read_bool - Find and read a boolean from a property
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ *
+ * Search for a property in a device node and read a 32-bit value from
+ * it. Returns 0 if <0> or if the property does not exist, 1 if <1> or none.
+ *
+ * is-ok;	=> true
+ * is-ok = <1>;	=> true
+ * is-ok = <0>;	=> false
+ */
+int of_property_read_bool(const struct device_node *np, const char *propname)
+{
+	u32 reg;
+	int ret = of_property_read_u32(np, propname, &reg);
+
+	switch (ret) {
+	case -EINVAL:
+		return false;
+	case -ENODATA:
+		return true;
+	case 0:
+		return reg == 1;
+	default:
+		return ret;
+	}
+}
+EXPORT_SYMBOL_GPL(of_property_read_bool);
+
+/**
  * of_property_read_string - Find and read a string from a property
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
diff --git a/include/linux/of.h b/include/linux/of.h
index a75a831..2e5f77b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -210,6 +210,8 @@ extern int of_property_read_u32_array(const struct device_node *np,
 				      size_t sz);
 extern int of_property_read_u64(const struct device_node *np,
 				const char *propname, u64 *out_value);
+extern int of_property_read_bool(const struct device_node *np,
+				const char *propname);
 
 extern int of_property_read_string(struct device_node *np,
 				   const char *propname,
@@ -288,6 +290,12 @@ static inline int of_property_read_u32_array(const struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_property_read_bool(const struct device_node *np,
+				const char *propname)
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_string(struct device_node *np,
 					  const char *propname,
 					  const char **out_string)
-- 
1.7.7
