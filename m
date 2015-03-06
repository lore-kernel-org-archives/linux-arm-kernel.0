From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 6 Mar 2015 17:33:21 +0800
Subject: [PATCH v5 04/29] PCI: Remove deprecated pci_scan_bus_parented()
In-Reply-To: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
References: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425634426-437-5-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No one uses pci_scan_bus_parented() any more,
remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   19 -------------------
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8ef0375..699a238 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2091,25 +2091,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-/* Deprecated; use pci_scan_root_bus() instead */
-struct pci_bus *pci_scan_bus_parented(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *b;
-
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
-	if (b)
-		pci_scan_child_bus(b);
-	else
-		pci_free_resource_list(&resources);
-	return b;
-}
-EXPORT_SYMBOL(pci_scan_bus_parented);
-
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 					void *sysdata)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..36effb8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -769,8 +769,6 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
-- 
1.7.1
