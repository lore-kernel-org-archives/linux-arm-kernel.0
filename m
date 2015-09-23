From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 22 Sep 2015 17:00:05 -0700
Subject: [PATCH v2 2/3] of/irq: Add new function of_msi_map_rid()
In-Reply-To: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442966406-13198-3-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

The device tree property "msi-map" specifies how to create the PCI
requester id used in some MSI controllers.  Add a new function
of_msi_map_rid() that finds the msi-map property and applies its
translation to a given requester id.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/of/irq.c       | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_irq.h |  7 ++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 55317fa..3f64d2e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -598,3 +598,89 @@ void of_msi_configure(struct device *dev, struct device_node *np)
 		d = irq_find_host(msi_np);
 	dev_set_msi_domain(dev, d);
 }
+
+/**
+ * of_msi_map_rid - Map a MSI requester ID for a device.
+ * @dev: device for which the mapping is to be done.
+ * @msi_np: device node of the expected msi controller.
+ * @rid_in: unmapped MSI requester ID for the device.
+ *
+ * Walk up the device hierarchy looking for devices with a "msi-map"
+ * property.  If found, apply the mapping to @rid_in.
+ *
+ * Returns the mapped MSI requester ID.
+ */
+u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
+{
+	struct device *parent_dev;
+	struct device_node *msi_controller_node;
+	const __be32 *msi_map;
+	u32 map_mask, masked_rid;
+	u32 rid_base, msi_base, rid_len, phandle;
+	int msi_map_len;
+	bool matched;
+	u32 rid_out = rid_in;
+
+	/*
+	 * Walk up the device parent links looking for one with a
+	 * "msi-map" property.
+	 */
+	msi_map = NULL;
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
+		if (!parent_dev->of_node)
+			continue;
+
+		msi_map = of_get_property(parent_dev->of_node,
+					  "msi-map", &msi_map_len);
+		if (!msi_map)
+			continue;
+
+		if (msi_map_len % (4 * sizeof(__be32))) {
+			dev_err(parent_dev, "Error: Bad msi-map length: %d\n",
+				msi_map_len);
+			goto out;
+		}
+		/* We have a good parent_dev and msi_map, let's use them. */
+		break;
+	}
+	if (!msi_map)
+		goto out;
+
+	/* The default is to select all bits. */
+	map_mask = 0xffffffff;
+
+	/*
+	 * Can be overridden by "msi-map-mask" property.  If
+	 * of_property_read_u32() fails, the default is used.
+	 */
+	of_property_read_u32(parent_dev->of_node, "msi-map-mask", &map_mask);
+
+	masked_rid = map_mask & rid_in;
+	matched = false;
+	while (!matched && msi_map_len >= 4 * sizeof(__be32)) {
+		rid_base = be32_to_cpup(msi_map + 0);
+		phandle = be32_to_cpup(msi_map + 1);
+		msi_base = be32_to_cpup(msi_map + 2);
+		rid_len = be32_to_cpup(msi_map + 3);
+
+		msi_controller_node = of_find_node_by_phandle(phandle);
+
+		matched = masked_rid >= rid_base &&
+			masked_rid < rid_base + rid_len &&
+			msi_np == msi_controller_node;
+
+		of_node_put(msi_controller_node);
+		msi_map_len -= 4 * sizeof(__be32);
+		msi_map += 4;
+	}
+	if (!matched)
+		goto out;
+
+	rid_out = masked_rid + msi_base;
+	dev_dbg(dev,
+		"msi-map at: %s, using mask %08x, rid-base: %08x, msi-base: %08x, length: %08x, rid: %08x -> %08x\n",
+		dev_name(parent_dev), map_mask, rid_base, msi_base,
+		rid_len, rid_in, rid_out);
+out:
+	return rid_out;
+}
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 4bcbd58..8cd9334 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -75,6 +75,7 @@ static inline int of_irq_to_resource_table(struct device_node *dev,
 extern unsigned int irq_of_parse_and_map(struct device_node *node, int index);
 extern struct device_node *of_irq_find_parent(struct device_node *child);
 extern void of_msi_configure(struct device *dev, struct device_node *np);
+u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
 
 #else /* !CONFIG_OF */
 static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
@@ -87,6 +88,12 @@ static inline void *of_irq_find_parent(struct device_node *child)
 {
 	return NULL;
 }
+
+static inline u32 of_msi_map_rid(struct device *dev,
+				 struct device_node *msi_np, u32 rid_in)
+{
+	return rid_in;
+}
 #endif /* !CONFIG_OF */
 
 #endif /* __OF_IRQ_H */
-- 
1.9.1
