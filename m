From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 25 Sep 2014 11:14:31 +0800
Subject: [PATCH v2 21/22] tile/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1411614872-4009-22-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/tile/kernel/pci_gx.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
index e39f9c5..4912b75 100644
--- a/arch/tile/kernel/pci_gx.c
+++ b/arch/tile/kernel/pci_gx.c
@@ -1485,7 +1485,7 @@ static struct irq_chip tilegx_msi_chip = {
 	/* TBD: support set_affinity. */
 };
 
-int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+static int tile_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct pci_controller *controller;
 	gxio_trio_context_t *trio_context;
@@ -1604,7 +1604,17 @@ is_64_failure:
 	return ret;
 }
 
-void arch_teardown_msi_irq(unsigned int irq)
+void tile_teardown_msi_irq(unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
+
+static struct msi_chip tile_msi_chip = {
+	.setup_irq = tile_setup_msi_irq,
+	.teardown_irq = tile_teardown_msi_irq,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &tile_msi_chip;
+}
-- 
1.7.1
