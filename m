From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 18 Oct 2018 21:10:12 +0530
Subject: [PATCH v2 05/10] firmware: ti_sci: Add helper apis to manage resources
In-Reply-To: <20181018154017.7112-1-lokeshvutla@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
Message-ID: <20181018154017.7112-6-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each resource with in the device can be uniquely identified
by a type and subtype as defined by TISCI. Since this is generic
across the devices, resource allocation also can be made generic
instead of each client driver handling the resource. So add helper
apis to manage the resource.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v1:
- Updated to use RM mapping table
- AM6 SoC information is derived from here[1]
[1] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html

 drivers/firmware/ti_sci.c              | 128 +++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  48 ++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c2f0815edab6..581d7a151533 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2480,6 +2480,134 @@ const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_by_phandle);
 
+/*
+ * ti_sci_get_free_resource() - Get a free resource from TISCI resource.
+ * @res:	Pointer to the TISCI resource
+ *
+ * Return: resource num if all went ok else TI_SCI_RESOURCE_NULL.
+ */
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
+{
+	unsigned long flags;
+	u16 set, free_bit;
+
+	raw_spin_lock_irqsave(&res->lock, flags);
+	for (set = 0; set < res->sets; set++) {
+		free_bit = find_first_zero_bit(res->desc[set].res_map,
+					       res->desc[set].num);
+		if (free_bit != res->desc[set].num) {
+			set_bit(free_bit, res->desc[set].res_map);
+			raw_spin_unlock_irqrestore(&res->lock, flags);
+			return res->desc[set].start + free_bit;
+		}
+	}
+	raw_spin_unlock_irqrestore(&res->lock, flags);
+
+	return TI_SCI_RESOURCE_NULL;
+}
+EXPORT_SYMBOL_GPL(ti_sci_get_free_resource);
+
+/**
+ * ti_sci_release_resource() - Release a resource from TISCI resource.
+ * @res:	Pointer to the TISCI resource
+ */
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
+{
+	unsigned long flags;
+	u16 set;
+
+	raw_spin_lock_irqsave(&res->lock, flags);
+	for (set = 0; set < res->sets; set++) {
+		if (res->desc[set].start <= id &&
+		    (res->desc[set].num + res->desc[set].start) > id)
+			clear_bit(id - res->desc[set].start,
+				  res->desc[set].res_map);
+	}
+	raw_spin_unlock_irqrestore(&res->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ti_sci_release_resource);
+
+/**
+ * devm_ti_sci_get_of_resource() - Get a TISCI resource assigned to a device
+ * @handle:	TISCI handle
+ * @dev:	Device pointer to which the resource is assigned
+ * @of_prop:	property name by which the resource are represented
+ *
+ * Note: This function expects of_prop to be in the form of tuples
+ *	<type, subtype>. Allocates and initializes ti_sci_resource structure
+ *	for each of_prop. Client driver can directly call
+ *	ti_sci_(get_free, release)_resource apis for handling the resource.
+ *
+ * Return: Pointer to ti_sci_resource if all went well else appropriate
+ *	   error pointer.
+ */
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop)
+{
+	u32 resource_subtype;
+	u16 resource_type;
+	struct ti_sci_resource *res;
+	int sets, i, ret;
+
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	sets = of_property_count_elems_of_size(dev_of_node(dev), of_prop,
+					       sizeof(u32));
+	if (sets < 0) {
+		dev_err(dev, "%s resource type ids not available\n", of_prop);
+		return ERR_PTR(sets);
+	}
+
+	res->sets = sets;
+
+	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
+				 GFP_KERNEL);
+	if (!res->desc)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ti_sci_get_resource_type(handle_to_ti_sci_info(handle), dev_id,
+				       &resource_type);
+	if (ret) {
+		dev_err(dev, "No valid resource type for %u\n", dev_id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	for (i = 0; i < res->sets; i++) {
+		ret = of_property_read_u32_index(dev_of_node(dev), of_prop, i,
+						 &resource_subtype);
+		if (ret)
+			return ERR_PTR(-EINVAL);
+
+		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
+							resource_subtype,
+							&res->desc[i].start,
+							&res->desc[i].num);
+		if (ret) {
+			dev_err(dev, "type %d subtype %d not allocated for host %d\n",
+				resource_type, resource_subtype,
+				handle_to_ti_sci_info(handle)->host_id);
+			return ERR_PTR(ret);
+		}
+
+		dev_dbg(dev, "res type = %d, subtype = %d, start = %d, num = %d\n",
+			resource_type, resource_subtype, res->desc[i].start,
+			res->desc[i].num);
+
+		res->desc[i].res_map =
+			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
+				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
+		if (!res->desc[i].res_map)
+			return ERR_PTR(-ENOMEM);
+	}
+	raw_spin_lock_init(&res->lock);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(devm_ti_sci_get_of_resource);
+
 static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 				void *cmd)
 {
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 6d17580839dc..2a1a41a17295 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -317,6 +317,33 @@ struct ti_sci_handle {
 	struct ti_sci_ops ops;
 };
 
+#define TI_SCI_RESOURCE_NULL	0xffff
+
+/**
+ * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
+ * @start:	Start index of the resource.
+ * @num:	Number of resources.
+ * @res_map:	Bitmap to manage the allocation of these resources.
+ */
+struct ti_sci_resource_desc {
+	u16 start;
+	u16 num;
+	unsigned long *res_map;
+};
+
+/**
+ * struct ti_sci_resource - Structure representing a resource assigned
+ *			    to a device.
+ * @sets:	Number of sets available from this resource type
+ * @lock:	Lock to guard the res map in each set.
+ * @desc:	Array of resource descriptors.
+ */
+struct ti_sci_resource {
+	u16 sets;
+	raw_spinlock_t lock;
+	struct ti_sci_resource_desc *desc;
+};
+
 #if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
 const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
 int ti_sci_put_handle(const struct ti_sci_handle *handle);
@@ -325,6 +352,11 @@ const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
 						  const char *property);
 const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 						       const char *property);
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res);
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id);
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop);
 
 #else	/* CONFIG_TI_SCI_PROTOCOL */
 
@@ -357,6 +389,22 @@ const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
+{
+	return TI_SCI_RESOURCE_NULL;
+}
+
+static inline void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
+{
+}
+
+static inline struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, u32 dev_id, char *of_prop)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif	/* CONFIG_TI_SCI_PROTOCOL */
 
 #endif	/* __TISCI_PROTOCOL_H */
-- 
2.19.1
