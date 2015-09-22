From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 22 Sep 2015 16:49:13 -0700
Subject: [PATCH v3 2/6] PCI: generic: Only fixup irqs for bus we are creating.
In-Reply-To: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442965757-12925-3-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

If we create multiple buses with pci-host-generic, or there are buses
created by other drivers, we don't want to call pci_fixup_irqs() which
operates on all devices, not just the devices on the bus being added.
The consequence is that either the fixups are done more than once, or
in some cases incorrect fixups could be applied.

Call pci_bus_fixup_irqs() instead of pci_fixup_irqs().

Signed-off-by: David Daney <david.daney@cavium.com>
---
No change from v2.

Changes from v1: Moved most of the code to pci_bus_fixup_irqs(),
making this patch very simple.

 drivers/pci/host/pci-host-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 265dd25..9e9f1c3 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -262,7 +262,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_bus_fixup_irqs(bus, pci_common_swizzle, of_irq_parse_and_map_pci);
 
 	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		pci_bus_size_bridges(bus);
-- 
1.9.1
