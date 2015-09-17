From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 17 Sep 2015 15:02:12 -0700
Subject: [PATCH v2 5/5] PCI: generic: Pass proper starting bus number to
 pci_scan_root_bus().
In-Reply-To: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442527332-1174-6-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

If the bus is being configured with a bus-range that does not start at
zero, pass that starting bus number to pci_scan_root_bus().  Passing
the incorrect value of zero causes attempted config accesses outside
of the supported range, which cascades to an OOPs spew and eventual
kernel panic.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
No change from v1.

 drivers/pci/host/pci-host-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 0a9c453..e364232 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -259,7 +259,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 	if (!pci_has_flag(PCI_PROBE_ONLY))
 		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
-	bus = pci_scan_root_bus(dev, 0,
+	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
 				&pci->cfg.ops.ops, pci, &pci->resources);
 	if (!bus) {
 		dev_err(dev, "Scanning rootbus failed");
-- 
1.9.1
