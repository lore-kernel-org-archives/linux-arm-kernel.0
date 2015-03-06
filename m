From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 6 Mar 2015 17:33:44 +0800
Subject: [PATCH v5 27/29] PCI: Export find_pci_host_bridge() and rename to
 pci_find_host_bridge()
In-Reply-To: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
References: <1425634426-437-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425634426-437-28-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host-bridge.c |    6 +++---
 drivers/pci/pci.h         |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index bc1de59..51f0a82 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -103,7 +103,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
@@ -121,7 +121,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
 	resource_size_t offset = 0;
 
@@ -146,7 +146,7 @@ static bool region_contains(struct pci_bus_region *region1,
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
 	resource_size_t offset = 0;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8bf5be7..ca9fc51 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -326,4 +326,6 @@ struct pci_host_bridge *pci_create_host_bridge(
 		void *sysdata, struct pci_host_bridge_ops *ops);
 
 void pci_free_host_bridge(struct pci_host_bridge *host);
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
+
 #endif /* DRIVERS_PCI_H */
-- 
1.7.1
