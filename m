From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 27 Nov 2014 13:41:31 +0800
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
Message-ID: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets pci device's dma ops as coherent if the root
controller is dma-coherent.

This patch fixes the bug in below link:

	https://bugs.launchpad.net/bugs/1386490

Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Dann Frazier <dann.frazier@canonical.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm64/kernel/pci.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index ce5836c..4b6444a 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 
 #include <asm/pci-bridge.h>
@@ -37,6 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
+/* Inherit root controller's dma coherent ops */
+static void pci_dma_config(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct device *host;
+
+	while (!pci_is_root_bus(bus)) {
+		bus = bus->parent;
+	}
+
+	host = bus->dev.parent->parent;
+	if (of_dma_is_coherent(host->of_node))
+		set_arch_dma_coherent_ops(&dev->dev);
+}
+
 /*
  * Try to assign the IRQ number from DT when adding a new device
  */
@@ -44,6 +60,7 @@ int pcibios_add_device(struct pci_dev *dev)
 {
 	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
 
+	pci_dma_config(dev);
 	return 0;
 }
 
-- 
1.7.9.5
