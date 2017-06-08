From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:04 +0100
Subject: [RFT PATCH v2 04/42] PCI: Initialize bridge release function at
 bridge allocation
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-5-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_register_host_bridge() kernel interface
allows PCI host controller drivers to create the struct pci_host_bridge
object, initialize it and register it with the kernel so that its
corresponding PCI bus can be scanned and its devices probed.

The host bridge device release function pci_release_host_bridge_dev is a
static function common for all struct pci_host_bridge allocated objects,
so in its current form cannot be used by PCI host bridge controllers
drivers to initialize the allocated struct pci_host_bridge, which
leaves struct pci_host_bridge devices release function uninitialized.

Since pci_release_host_bridge_dev is a function common to all PCI
host bridge objects, initialize it in pci_alloc_host_bridge() (ie
common host bridge allocation interface) so that all struct
pci_host_bridge objects have their release function initialized by
default at allocation time, removing the need for exporting the
common pci_release_host_bridge_dev function to other compilation
units.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 19c8950..586d83d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -531,6 +531,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
@@ -2310,7 +2311,6 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 		return NULL;
 
 	bridge->dev.parent = parent;
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	list_splice_init(resources, &bridge->windows);
 	bridge->sysdata = sysdata;
-- 
2.10.0
