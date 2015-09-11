From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 11 Sep 2015 16:21:55 -0700
Subject: [PATCH 2/6] PCI: generic: Only fixup irqs for bus we are creating.
In-Reply-To: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1442013719-5001-3-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Use pci_walk_bus() to restrict the fixup irq actions to only the bus
being created.

If we create multiple buses with pci-host-generic, or there are buses
created by other drivers, we don't want to call pci_fixup_irqs() which
operates on all devices, not just the devices on the bus being added.
The consequence is that either the fixups are done more than once, or
in some cases incorrect fixups could be applied.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/host/pci-host-generic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 265dd25..a0fb241 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -205,6 +205,12 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 	return 0;
 }
 
+static int gen_pci_fixup_irq_cb(struct pci_dev *dev, void *arg)
+{
+	pdev_fixup_irq(dev, pci_common_swizzle, of_irq_parse_and_map_pci);
+	return 0;
+}
+
 static int gen_pci_probe(struct platform_device *pdev)
 {
 	int err;
@@ -262,7 +268,7 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_walk_bus(bus, gen_pci_fixup_irq_cb, NULL);
 
 	if (!pci_has_flag(PCI_PROBE_ONLY)) {
 		pci_bus_size_bridges(bus);
-- 
1.7.11.7
