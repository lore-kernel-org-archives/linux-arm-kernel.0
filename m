From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 5 Oct 2018 20:00:06 +0530
Subject: [PATCH 4/4] firmware: ti_sci: Add helper apis to mange resources
In-Reply-To: <20181005143006.18284-1-lokeshvutla@ti.com>
References: <20181005143006.18284-1-lokeshvutla@ti.com>
Message-ID: <20181005143006.18284-5-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each resource with in the device can be uniquely identified
by a type and subtype as defined by TISCI. Since this is generic
across the devices, resource allocation also can be made generic
instead of each client driver handling the resource. So add helper
apis to manage the resource.

devm_ti_sci_get_of_resource() expects resource from dt
in form of tuples <type, subtype>.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/firmware/ti_sci.c              | 126 +++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  48 ++++++++++
 2 files changed, 174 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 5184ff38804f..53443bd093fb 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2414,6 +2414,132 @@ const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
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
+			    struct device *dev, char *of_prop)
+{
+	u32 resource_type, resource_subtype;
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
+	res->sets = sets / 2;
+
+	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
+				 GFP_KERNEL);
+	if (!res->desc)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < res->sets; i++) {
+		ret = of_property_read_u32_index(dev_of_node(dev), of_prop,
+						 i * 2, &resource_type);
+		if (ret)
+			return ERR_PTR(-EINVAL);
+
+		ret = of_property_read_u32_index(dev_of_node(dev), of_prop,
+						 (i * 2) + 1,
+						 &resource_subtype);
+		if (ret)
+			return ERR_PTR(-EINVAL);
+
+		ret = handle->ops.rm_core_ops.get_range(handle, resource_type,
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
index 837f4b25171c..ff897900b347 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -316,6 +316,33 @@ struct ti_sci_handle {
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
@@ -324,6 +351,11 @@ const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
 						  const char *property);
 const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
 						       const char *property);
+u16 ti_sci_get_free_resource(struct ti_sci_resource *res);
+void ti_sci_release_resource(struct ti_sci_resource *res, u16 id);
+struct ti_sci_resource *
+devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
+			    struct device *dev, char *of_prop);
 
 #else	/* CONFIG_TI_SCI_PROTOCOL */
 
@@ -356,6 +388,22 @@ const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
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
+			    struct device *dev, char *of_prop)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif	/* CONFIG_TI_SCI_PROTOCOL */
 
 #endif	/* __TISCI_PROTOCOL_H */
-- 
2.19.0
