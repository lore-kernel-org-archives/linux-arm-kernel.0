From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 18 Nov 2015 16:49:52 -0800
Subject: [PATCH] PCI: Fix logic OF logic in pci_dma_configure()
Message-ID: <1447894192-17210-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a bug introduced by previous commit,
which incorrectly checkes the of_node of the end-point device.
Instead, it should check the of_node of the host bridge.

Fixes: 50230713b639 ("PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e735c72..edb1984 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1685,8 +1685,8 @@ static void pci_dma_configure(struct pci_dev *dev)
 {
 	struct device *bridge = pci_get_host_bridge_device(dev);
 
-	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
-		if (bridge->parent)
+	if (IS_ENABLED(CONFIG_OF) &&
+		bridge->parent && bridge->parent->of_node) {
 			of_dma_configure(&dev->dev, bridge->parent->of_node);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
-- 
2.1.0
