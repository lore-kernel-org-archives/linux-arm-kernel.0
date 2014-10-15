From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 15 Oct 2014 11:07:14 +0800
Subject: [PATCH v3 26/27] tile/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1413342435-7876-27-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/tile/include/asm/pci.h |   10 ++++++++++
 arch/tile/kernel/pci_gx.c   |   13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/tile/include/asm/pci.h b/arch/tile/include/asm/pci.h
index dfedd7a..d27d9ec 100644
--- a/arch/tile/include/asm/pci.h
+++ b/arch/tile/include/asm/pci.h
@@ -152,6 +152,7 @@ struct pci_controller {
 	int pio_io_index;	/* PIO region index for I/O space access */
 #endif
 
+	struct msi_chip *msi_chip;
 	/*
 	 * Mem-Map regions for all the memory controllers so that Linux can
 	 * map all of its physical memory space to the PCI bus.
@@ -179,6 +180,15 @@ struct pci_controller {
 	int irq_intx_table[4];
 };
 
+extern struct msi_chip tilegx_msi;
+
+static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
+{
+	struct pci_controller *controller = bus->sysdata;
+
+	return controller->msi_chip;
+}
+
 extern struct pci_controller pci_controllers[TILEGX_NUM_TRIO * TILEGX_TRIO_PCIES];
 extern gxio_trio_context_t trio_contexts[TILEGX_NUM_TRIO];
 extern int num_trio_shims;
diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index e39f9c5..ba66517 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -887,6 +887,7 @@ int __init pcibios_init(void)
 					controller->mem_offset);
 		pci_add_resource(&resources, &controller->io_space);
 		controller->first_busno = next_busno;
+		controller->msi_chip = &tilegx_msi;
 		bus = pci_scan_root_bus(NULL, next_busno, controller->ops,
 					controller, &resources);
 		controller->root_bus = bus;
@@ -1485,7 +1486,8 @@ static struct irq_chip tilegx_msi_chip = {
 	/* TBD: support set_affinity. */
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int tile_setup_msi_irq(struct msi_chip *chip,
+		struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct pci_controller *controller;
 	gxio_trio_context_t *trio_context;
@@ -1604,7 +1606,12 @@ is_64_failure:
 	return ret;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+static void tile_teardown_msi_irq(struct msi_chip *chip, unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
+
+struct msi_chip tilegx_msi = {
+	.setup_irq = tile_setup_msi_irq,
+	.teardown_irq = tile_teardown_msi_irq,
+};
-- 
1.7.1
