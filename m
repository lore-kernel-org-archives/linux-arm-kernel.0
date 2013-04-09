From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Apr 2013 23:06:26 +0200
Subject: [PATCHv8 05/19] of/pci: Add of_pci_parse_bus_range() function
In-Reply-To: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365541601-14095-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <thierry.reding@avionic-design.de>

This function can be used to parse a bus-range property as specified by
device nodes representing PCI bridges.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/of/of_pci.c    |   25 +++++++++++++++++++++++++
 include/linux/of_pci.h |    1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index b77e8d8..e9106dc 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -232,3 +232,28 @@ int of_pci_get_devfn(struct device_node *np)
 	return (be32_to_cpup(reg) >> 8) & 0xff;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_devfn);
+
+/**
+ * of_pci_parse_bus_range() - parse the bus-range property of a PCI device
+ * @node: device node
+ * @res: address to a struct resource to return the bus-range
+ *
+ * Returns 0 on success or a negative error-code on failure.
+ */
+int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
+{
+	const __be32 *values;
+	int len;
+
+	values = of_get_property(node, "bus-range", &len);
+	if (!values || len < sizeof(*values) * 2)
+		return -EINVAL;
+
+	res->name = node->name;
+	res->start = be32_to_cpup(values++);
+	res->end = be32_to_cpup(values);
+	res->flags = IORESOURCE_BUS;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 302aca0..be97a6f 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -12,6 +12,7 @@ struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
+int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 
 void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			struct device_node *dev, int primary);
-- 
1.7.9.5
