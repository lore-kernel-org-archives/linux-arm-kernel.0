From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 17 Sep 2015 11:00:59 -0700
Subject: [PATCH 2/2] irqchip/gicv3-its: Handle OF device tree "msi-map"
 properties.
In-Reply-To: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442512859-31633-3-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Search up the device hierarchy to find devices with a "msi-map"
property, if found apply the mapping to the GIC device id.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cf351c6..aa61cef 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -73,6 +73,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	struct pci_dev *pdev;
 	struct its_pci_alias dev_alias;
 	struct msi_domain_info *msi_info;
+	struct device *parent_dev;
+	struct device_node *msi_controller_node = NULL;
 
 	if (!dev_is_pci(dev))
 		return -EINVAL;
@@ -84,6 +86,77 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	dev_alias.count = nvec;
 
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+	/*
+	 * Walk up the device parent links looking for one with a
+	 * "msi-map" property.
+	 */
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
+		u32 msi_mask, masked_devid;
+		u32 rid_base, msi_base, rid_len, phandle;
+		int msi_map_len;
+		const __be32 *msi_map;
+		bool matched;
+
+		if (!parent_dev->of_node)
+			continue;
+
+		msi_map = of_get_property(parent_dev->of_node,
+					  "msi-map", &msi_map_len);
+		if (!msi_map)
+			continue;
+
+		/* The default is to select all bits. */
+		msi_mask = 0xffffffff;
+
+		/*
+		 * Can be overridden by "msi-mask" property.  If
+		 * of_property_read_u32() fails, the default is
+		 * used.
+		 */
+		of_property_read_u32(parent_dev->of_node,
+				     "msi-mask", &msi_mask);
+
+		masked_devid = msi_mask & dev_alias.dev_id;
+		matched = false;
+		while (msi_map_len >= 4 * sizeof(__be32)) {
+			rid_base = be32_to_cpup(msi_map + 0);
+			phandle = be32_to_cpup(msi_map + 1);
+			msi_base = be32_to_cpup(msi_map + 2);
+			rid_len = be32_to_cpup(msi_map + 3);
+
+			if (masked_devid < rid_base ||
+			    masked_devid >= rid_base + rid_len) {
+				msi_map_len -= 4 * sizeof(__be32);
+				msi_map += 4;
+				continue;
+			}
+			matched = true;
+			break;
+		}
+		if (!matched) {
+			dev_err(dev,
+				"No match in \"msi-map\" of %s for dev_id: %x\n",
+				dev_name(parent_dev), dev_alias.dev_id);
+			break;
+		}
+
+		msi_controller_node = of_find_node_by_phandle(phandle);
+		if (domain->of_node != msi_controller_node) {
+			dev_err(dev,
+				"ERROR: msi-map mismatch \"%s\" vs. \"%s\"\n",
+				domain->of_node->full_name,
+				msi_controller_node ? NULL : msi_controller_node->full_name);
+			break;
+		}
+		dev_dbg(dev,
+			"msi-map at: %s, len: %d, using mask %08x, rid: %08x, msi: %08x, rid_len: %08x, dev_id: %08x\n",
+			dev_name(parent_dev), msi_map_len, msi_mask, rid_base,
+			msi_base, rid_len, dev_alias.dev_id);
+		dev_alias.dev_id = masked_devid + msi_base;
+		dev_dbg(dev, "New dev_id: %08x\n", dev_alias.dev_id);
+		break;
+	}
+	of_node_put(msi_controller_node);
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = dev_alias.dev_id;
-- 
1.9.1
