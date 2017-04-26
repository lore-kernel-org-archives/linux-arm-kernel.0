From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:17:53 +0100
Subject: [RFC/RFT PATCH 02/18] PCI: Add pci_free_host_bridge interface
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-3-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a52d1443bba1 ("PCI: Export host bridge registration interface")
exported the pci_alloc_host_bridge() interface so that PCI host
controllers drivers can make use of it.

Introduce pci_alloc_host_bridge() kernel counterpart to free the
host bridge data structures, pci_free_host_bridge(), export it
and update kernel functions releasing host bridge objects allocated
memory to make use of it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 11 ++++++++---
 include/linux/pci.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d0ddb69..7e4ffc4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -517,9 +517,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	if (bridge->release_fn)
 		bridge->release_fn(bridge);
 
-	pci_free_resource_list(&bridge->windows);
-
-	kfree(bridge);
+	pci_free_host_bridge(bridge);
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
@@ -537,6 +535,13 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 }
 EXPORT_SYMBOL(pci_alloc_host_bridge);
 
+void pci_free_host_bridge(struct pci_host_bridge *bridge)
+{
+	pci_free_resource_list(&bridge->windows);
+
+	kfree(bridge);
+}
+EXPORT_SYMBOL(pci_free_host_bridge);
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..99878a9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -450,6 +450,7 @@ static inline struct pci_host_bridge *pci_host_bridge_from_priv(void *priv)
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
+void pci_free_host_bridge(struct pci_host_bridge *bridge);
 int pci_register_host_bridge(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
-- 
2.10.0
