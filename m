From: dhdang@apm.com (Duc Dang)
Date: Tue,  9 Feb 2016 17:49:44 -0800
Subject: [PATCH] pci: xgene: Add ECAM fixups
Message-ID: <1455068984-22210-1-git-send-email-dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Gene PCIe controller does not fully support ECAM.
This patch adds required ECAM fixup to allow X-Gene
PCIe controller to be functional in ACPI boot mode.

This patch is based on the original work of
Mark Salter <msalter@redhat.com> and depends on
Tomasz's PCIe ACPI series:
https://lkml.org/lkml/2016/2/4/646

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/pci/host/pci-xgene.c | 130 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index ae00ce2..5d3f74e 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -29,6 +29,11 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#include <linux/ecam.h>
+#include <linux/pci-acpi.h>
+#endif
 
 #define PCIECORE_CTLANDSTATUS		0x50
 #define PIM1_1L				0x80
@@ -76,6 +81,13 @@ struct xgene_pcie_port {
 	u32			version;
 };
 
+static struct xgene_pcie_port *(*xgene_pcie_bus_to_port)(struct pci_bus *bus);
+
+static struct xgene_pcie_port *xgene_pcie_dt_bus_to_port(struct pci_bus *bus)
+{
+	return bus->sysdata;
+}
+
 static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
 {
 	return (addr & PCI_BASE_ADDRESS_MEM_MASK) | flags;
@@ -87,7 +99,7 @@ static inline u32 pcie_bar_low_val(u32 addr, u32 flags)
  */
 static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
+	struct xgene_pcie_port *port = xgene_pcie_bus_to_port(bus);
 
 	if (bus->number >= (bus->primary + 1))
 		return port->cfg_base + AXI_EP_CFG_ACCESS;
@@ -101,7 +113,7 @@ static void __iomem *xgene_pcie_get_cfg_base(struct pci_bus *bus)
  */
 static void xgene_pcie_set_rtdid_reg(struct pci_bus *bus, uint devfn)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
+	struct xgene_pcie_port *port = xgene_pcie_bus_to_port(bus);
 	unsigned int b, d, f;
 	u32 rtdid_val = 0;
 
@@ -148,7 +160,7 @@ static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
-	struct xgene_pcie_port *port = bus->sysdata;
+	struct xgene_pcie_port *port = xgene_pcie_bus_to_port(bus);
 
 	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
 	    PCIBIOS_SUCCESSFUL)
@@ -509,6 +521,116 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+#define APM_OEM_ID		"APM   "
+#define APM_XGENE_TABLE_ID	"XGENE   "
+static LIST_HEAD(xgene_acpi_pcie_roots);
+
+struct xgene_pcie_acpi_root {
+	struct list_head list;
+	struct acpi_pci_root *root;
+	struct xgene_pcie_port port;
+};
+
+static struct xgene_pcie_port *xgene_pcie_acpi_bus_to_port(struct pci_bus *bus)
+{
+	struct acpi_pci_root *root = bus->sysdata;
+	struct xgene_pcie_acpi_root *xgene_root;
+
+	list_for_each_entry(xgene_root, &xgene_acpi_pcie_roots, list) {
+		if (xgene_root->root == root)
+			return &xgene_root->port;
+	}
+
+	return NULL;
+}
+
+static acpi_status xgene_pcie_find_csr_base(struct acpi_resource *acpi_res,
+					    void *data)
+{
+	struct xgene_pcie_acpi_root *root = data;
+	struct acpi_resource_fixed_memory32 *fixed32;
+
+	if (acpi_res->type == ACPI_RESOURCE_TYPE_FIXED_MEMORY32) {
+		fixed32 = &acpi_res->data.fixed_memory32;
+		root->port.csr_base = ioremap(fixed32->address,
+					      fixed32->address_length);
+		return AE_CTRL_TERMINATE;
+	}
+	return AE_OK;
+}
+
+static int xgene_pcie_mcfg_fixup(struct acpi_pci_root *root)
+{
+	struct pci_mmcfg_region *cfg;
+	struct acpi_device *device = root->device;
+	struct xgene_pcie_acpi_root *acpi_root;
+
+	acpi_root = kzalloc(sizeof(*acpi_root), GFP_KERNEL);
+	if (acpi_root == NULL)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&acpi_root->list);
+	acpi_root->root = root;
+
+	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
+	if (cfg)
+		acpi_root->port.cfg_base = cfg->virt;
+	else {
+		dev_err(&device->dev, "Failed to get CFG virt base\n");
+		return -ENODEV;
+	}
+
+	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+			    xgene_pcie_find_csr_base, acpi_root);
+
+	if (!acpi_root->port.csr_base) {
+		kfree(acpi_root);
+		return -ENODEV;
+	}
+
+	/* Update bus_to_port method */
+	xgene_pcie_bus_to_port = xgene_pcie_acpi_bus_to_port;
+
+	/* Set to IP version 1 to disable Configuration-Request Retry Status */
+	acpi_root->port.version = XGENE_PCIE_IP_VER_1;
+
+	list_add(&acpi_root->list, &xgene_acpi_pcie_roots);
+
+	return 0;
+}
+
+static int xgene_pcie_acpi_match(struct pci_mcfg_fixup *fixup,
+				 struct acpi_pci_root *root)
+{
+	struct acpi_table_header table_header;
+
+	if (acpi_get_table_header(ACPI_SIG_MCFG, 0, &table_header))
+		return 0;
+
+	if (strncmp(APM_OEM_ID, table_header.oem_id, ACPI_OEM_ID_SIZE))
+		return 0;
+
+	if (strncmp(APM_XGENE_TABLE_ID, table_header.oem_table_id,
+		    ACPI_OEM_TABLE_ID_SIZE))
+		return 0;
+
+	/*
+	 * MCFG table matches with X-Gene PCIe MCFG table.
+	 * Now perform additional fix-up actions to prepare for
+	 * X-Gene PCIe private data.
+	 */
+	if (xgene_pcie_mcfg_fixup(root))
+		return 0;
+
+	return 1;
+}
+
+DECLARE_ACPI_MCFG_FIXUP(NULL, xgene_pcie_acpi_match, &xgene_pcie_ops,
+			PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
+
+#endif /* CONFIG_ACPI */
+
 static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
@@ -518,6 +640,8 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	int ret;
 	LIST_HEAD(res);
 
+	xgene_pcie_bus_to_port = xgene_pcie_dt_bus_to_port;
+
 	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
-- 
1.9.1
