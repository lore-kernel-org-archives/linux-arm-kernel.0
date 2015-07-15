From: ddaney.cavm@gmail.com (David Daney)
Date: Wed, 15 Jul 2015 09:54:41 -0700
Subject: [PATCH 1/5] pci: Add is_pcierc element to struct pci_bus
In-Reply-To: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1436979285-8177-2-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

... and use is to force only_one_child() to return true.

Needed because the ThunderX PCIe RC cannot be identified by existing methods.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/probe.c | 2 ++
 include/linux/pci.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..11ec2e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1643,6 +1643,8 @@ static int only_one_child(struct pci_bus *bus)
 {
 	struct pci_dev *parent = bus->self;
 
+	if (bus->is_pcierc)
+		return 1;
 	if (!parent || !pci_is_pcie(parent))
 		return 0;
 	if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..1f1ce73 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -473,6 +473,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */
 	struct bin_attribute	*legacy_mem; /* legacy mem */
 	unsigned int		is_added:1;
+	unsigned int		is_pcierc:1;
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
-- 
1.9.1
