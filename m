From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:06 +0100
Subject: [RFT PATCH v2 06/42] PCI: Add devm_pci_alloc_host_bridge() interface
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-7-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct pci_host_bridge can be allocated by PCI host bridge drivers
which usually allocate and map memory through devm managed interfaces.

Add a devm version for the pci_alloc_host_bridge() interface to
simplify PCI host controller drivers porting and simplify the
drivers failures paths.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/pci/probe.c                   | 24 ++++++++++++++++++++++--
 include/linux/pci.h                   |  2 ++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index e72587f..ffbc891 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -342,6 +342,7 @@ PER-CPU MEM
   devm_free_percpu()
 
 PCI
+  devm_pci_alloc_host_bridge()  : managed PCI host bridge allocation
   devm_pci_remap_cfgspace()	: ioremap PCI configuration space
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
   pcim_enable_device()		: after success, all PCI ops become managed
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cbf0d0c..e3f6965 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -510,14 +510,18 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	return b;
 }
 
-static void pci_release_host_bridge_dev(struct device *dev)
+static void devm_pci_release_host_bridge_dev(struct device *dev)
 {
 	struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
 
 	if (bridge->release_fn)
 		bridge->release_fn(bridge);
+}
 
-	pci_free_host_bridge(bridge);
+static void pci_release_host_bridge_dev(struct device *dev)
+{
+	devm_pci_release_host_bridge_dev(dev);
+	pci_free_host_bridge(to_pci_host_bridge(dev));
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
@@ -535,6 +539,22 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 }
 EXPORT_SYMBOL(pci_alloc_host_bridge);
 
+struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
+						   size_t priv)
+{
+	struct pci_host_bridge *bridge;
+
+	bridge = devm_kzalloc(dev, sizeof(*bridge) + priv, GFP_KERNEL);
+	if (!bridge)
+		return NULL;
+
+	INIT_LIST_HEAD(&bridge->windows);
+	bridge->dev.release = devm_pci_release_host_bridge_dev;
+
+	return bridge;
+}
+EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
+
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5720635..b21308e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -463,6 +463,8 @@ static inline struct pci_host_bridge *pci_host_bridge_from_priv(void *priv)
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv);
+struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
+						   size_t priv);
 void pci_free_host_bridge(struct pci_host_bridge *bridge);
 int pci_register_host_bridge(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
-- 
2.10.0
