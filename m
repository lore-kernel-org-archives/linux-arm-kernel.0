From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 16 Jan 2015 09:44:16 +0800
Subject: [PATCH 18/28] PCI/sparc: Use pci_scan_root_bridge() for simplicity
In-Reply-To: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1421372666-12288-19-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we could use pci_scan_root_bridge() to scan
pci buses, provide sparc specific pci_host_bridge_ops.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/sparc/kernel/pci.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index d798b42..42dc21f 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -647,12 +647,31 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 		pci_claim_bus_resources(child_bus);
 }
 
+static void pci_host_bridge_probe_mode(
+		struct pci_host_bridge *host)
+{
+	host->of_scan = true;
+}
+
+static void pci_host_bridge_of_scan_bus(
+		struct pci_host_bridge *host)
+{
+	struct pci_pbm_info *pbm = dev_get_drvdata(&host->dev);
+	struct device_node *node = pbm->op->dev.of_node;
+
+	pci_of_scan_bus(pbm, node, host->bus);
+}
+
+static struct pci_host_bridge_ops phb_ops = {
+	.phb_of_scan_bus,
+};
+
 struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 				 struct device *parent)
 {
 	LIST_HEAD(resources);
 	struct device_node *node = pbm->op->dev.of_node;
-	struct pci_bus *bus;
+	struct pci_host_bridge *host;
 
 	printk("PCI: Scanning PBM %s\n", node->full_name);
 
@@ -664,17 +683,16 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pbm->busn.end	= pbm->pci_last_busno;
 	pbm->busn.flags	= IORESOURCE_BUS;
 	pci_add_resource(&resources, &pbm->busn);
-	bus = pci_create_root_bus(parent, 
+	host = pci_scan_root_bridge(parent,
 			PCI_DOMBUS(pbm->index, pbm->pci_first_busno), 
-			pbm->pci_ops, pbm, &resources);
-	if (!bus) {
-		printk(KERN_ERR "Failed to create bus for %s\n",
+			pbm->pci_ops, pbm, &resources, &phb_ops);
+	if (!host) {
+		printk(KERN_ERR "Failed to create host bridge for %s\n",
 		       node->full_name);
 		pci_free_resource_list(&resources);
 		return NULL;
 	}
 
-	pci_of_scan_bus(pbm, node, bus);
 	pci_bus_add_devices(bus);
 	pci_bus_register_of_sysfs(bus);
 
-- 
1.7.1
