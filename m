From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed,  9 Jan 2013 21:43:03 +0100
Subject: [PATCH 03/14] of/pci: Add of_pci_get_bus() function
In-Reply-To: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1357764194-12677-4-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function can be used to parse the number of a device's parent PCI
bus from a standard 5-cell PCI resource.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/of/of_pci.c    | 21 +++++++++++++++++++++
 include/linux/of_pci.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 0dd52df..7d5d2c3 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -43,6 +43,27 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 EXPORT_SYMBOL_GPL(of_pci_find_child_device);
 
 /**
+ * of_pci_get_bus() - Get bus number for a device node
+ * @np: device node
+ *
+ * Parses a standard 5-cell PCI resource and returns the 8-bit bus number of
+ * the device's parent PCI bus. On error a negative error code is returned.
+ */
+int of_pci_get_bus(struct device_node *np)
+{
+	unsigned int size;
+	const __be32 *reg;
+
+	reg = of_get_property(np, "reg", &size);
+
+	if (!reg || size < 5 * sizeof(__be32))
+		return -EINVAL;
+
+	return (be32_to_cpup(reg) >> 16) & 0xff;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_bus);
+
+/**
  * of_pci_get_devfn() - Get device and function numbers for a device node
  * @np: device node
  *
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 91ec484..9118321 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -10,6 +10,7 @@ int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
+int of_pci_get_bus(struct device_node *np);
 int of_pci_get_devfn(struct device_node *np);
 
 #endif
-- 
1.8.1
