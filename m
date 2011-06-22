From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 22 Jun 2011 21:52:23 +0530
Subject: [PATCH 2/6] serial: samsung: Add device tree support for s5pv210
	uart driver
In-Reply-To: <BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
References: <1308567752-13451-1-git-send-email-thomas.abraham@linaro.org>
	<1308567752-13451-3-git-send-email-thomas.abraham@linaro.org>
	<BANLkTi=+FKz-uPtSv572y5ORorMeGR8Anw@mail.gmail.com>
Message-ID: <BANLkTi=RxEpBrALEQbBD_z6ZiEW24-wsng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 20 June 2011 22:13, Grant Likely <grant.likely@secretlab.ca> wrote:
> Okay, this is getting ugly (not your fault, but this pattern has
> become too common. ?Can you craft and post a patch that adds the
> following functions to drivers/of/base.c and include/linux/of.h
>
> /* offset in cells, not bytes */
> int dt_decode_u32(struct *property, int offset, u32 *out_val)
> {
> ? ? ? ?if (!property || !property->value)
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?if ((offset + 1) * 4 > property->length)
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?*out_val = of_read_number(property->value + (offset * 4), 1);
> ? ? ? ?return 0;
> }
> int dt_decode_u64(struct *property, int offset, u64 *out_val)
> {
> ...
> }
> int dt_decode_string(struct *property, int index, char **out_string);
> {
> ...
> }
>
> Plus a set of companion functions:
> int dt_getprop_u32(struct device_node *np, char *propname, int offset,
> u32 *out_val)
> {
> ? ? ? ?return dt_decode_u32(of_find_property(np, propname, NULL),
> offset, out_val);
> }
> int dt_getprop_u64(struct *device_node, char *propname, int offset,
> u64 *out_val);
> {
> ...
> }
> int dt_getprop_string(struct *device_node, char *propname, int index,
> char **out_string);
> {
> ...
> }
>
> Then you'll be able to simply do the following to decode each
> property, with fifosize being left alone if the property cannot be
> found or decoded:
>
> dt_getprop_u32(pdev->dev.of_node, "samsung,fifosize", &fifosize);

I have added the functions as you have suggested and the diff is
listed below. Could you please review the diff and suggest any changes
required.


 drivers/of/base.c  |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |   10 ++++
 2 files changed, 139 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 632ebae..73f0144 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -596,6 +596,135 @@ struct device_node
*of_find_node_by_phandle(phandle handle)
 EXPORT_SYMBOL(of_find_node_by_phandle);

 /**
+ * of_read_property_u32 - Reads a indexed 32-bit property value
+ * @prop:	property to read from.
+ * @offset:	cell number to read.
+ * value:	returned cell value
+ *
+ * Returns a indexed 32-bit value of a property cell, -EINVAL in case the cell
+ * does not exist
+ */
+int of_read_property_u32(struct property *prop, u32 offset, u32 *value)
+{
+	if (!prop || !prop->value)
+		return -EINVAL;
+	if ((offset + 1) * 4 > prop->length)
+		return -EINVAL;
+
+	*value = of_read_ulong(prop->value + (offset * 4), 1);
+	return 0;
+}
+EXPORT_SYMBOL(of_read_property_u32);
+
+/**
+ * of_getprop_u32 - Find a property in a device node and read a 32-bit value
+ * @np:		device node from which the property value is to be read.
+ * @propname	name of the property to be searched.
+ * @offset:	cell number to read.
+ * @value:	returned value of the cell
+ *
+ * Search for a property in a device node and read a indexed 32-bit value of a
+ * property cell. Returns the 32-bit cell value, -EINVAL in case the
property or
+ * the indexed cell does not exist.
+ */
+int
+of_getprop_u32(struct device_node *np, char *propname, int offset, u32 *value)
+{
+	return of_read_property_u32(of_find_property(np, propname, NULL),
+					offset, value);
+}
+EXPORT_SYMBOL(of_getprop_u32);
+
+/**
+ * of_read_property_u64 - Reads a indexed 64-bit property value
+ * @prop:	property to read from.
+ * @offset:	cell number to read (each cell is 64-bits).
+ * @value:	returned cell value
+ *
+ * Returns a indexed 64-bit value of a property cell, -EINVAL in case the cell
+ * does not exist
+ */
+int of_read_property_u64(struct property *prop, int offset, u64 *value)
+{
+	if (!prop || !prop->value)
+		return -EINVAL;
+	if ((offset + 1) * 8 > prop->length)
+		return -EINVAL;
+
+	*value = of_read_number(prop->value + (offset * 8), 2);
+	return 0;
+}
+EXPORT_SYMBOL(of_read_property_u64);
+
+/**
+ * of_getprop_u64 - Find a property in a device node and read a 64-bit value
+ * @np:		device node from which the property value is to be read.
+ * @propname	name of the property to be searched.
+ * @offset:	cell number to read (each cell is 64-bits).
+ * @value:	returned value of the cell
+ *
+ * Search for a property in a device node and read a indexed 64-bit value of a
+ * property cell. Returns the 64-bit cell value, -EINVAL in case the
property or
+ * the indexed cell does not exist.
+ */
+int
+of_getprop_u64(struct device_node *np, char *propname, int offset, u64 *value)
+{
+	return of_read_property_u64(of_find_property(np, propname, NULL),
+					offset, value);
+}
+EXPORT_SYMBOL(of_getprop_u64);
+
+/**
+ * of_read_property_string - Returns a pointer to a indexed null terminated
+ *				property value string
+ * @prop:	property to read from.
+ * @offset:	index of the property string to be read.
+ * @string:	pointer to a null terminated string, valid only if the return
+ *		value is 0.
+ *
+ * Returns a pointer to a indexed null terminated property cell string, -EINVAL
+ * in case the cell does not exist.
+ */
+int of_read_property_string(struct property *prop, int offset, char **string)
+{
+	char *c;
+
+	if (!prop || !prop->value)
+		return -EINVAL;
+
+	c = (char *)prop->value;
+	while (offset--)
+		while (*c++)
+			;
+
+	*string = c;
+	return 0;
+}
+
+/**
+ * of_getprop_string - Find a property in a device node and read a null
+ *			terminated string property
+ * @np:		device node from which the property value is to be read.
+ * @propname	name of the property to be searched.
+ * @offset:	cell number to read (each cell contains a null-terminated
+ *		string).
+ * @string:	pointer to a null terminated string, valid only if the return
+ *		value is 0.
+ *
+ * Search for a property in a device node and return a pointer to a indexed
+ * string value of a property cell. Returns a pointer to a string, -EINVAL
+ * in case the property or the indexed cell does not exist.
+ */
+int of_getprop_string(struct device_node *np, char *propname, int offset,
+			char **string)
+{
+	return of_read_property_string(of_find_property(np, propname, NULL),
+					offset, string);
+}
+EXPORT_SYMBOL(of_getprop_string);
+
+/**
  * of_parse_phandle - Resolve a phandle property to a device_node pointer
  * @np: Pointer to device node holding phandle property
  * @phandle_name: Name of property holding a phandle value
diff --git a/include/linux/of.h b/include/linux/of.h
index bfc0ed1..aff2786 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -195,6 +195,16 @@ extern struct device_node *of_find_node_with_property(
 extern struct property *of_find_property(const struct device_node *np,
 					 const char *name,
 					 int *lenp);
+extern int of_read_property_u32(struct property *prop, u32 offset, u32 *value);
+extern int of_getprop_u32(struct device_node *np, char *propname, int offset,
+				u32 *value);
+extern int of_read_property_u64(struct property *prop, int offset, u64 *value);
+extern int of_getprop_u64(struct device_node *np, char *propname, int offset,
+				u64 *value);
+extern int of_read_property_string(struct property *prop, int offset,
+				char **string);
+extern int of_getprop_string(struct device_node *np, char *propname,
int offset,
+				char **string);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
 extern int of_device_is_available(const struct device_node *device);
-- 
1.6.6.rc2
