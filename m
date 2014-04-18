From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Apr 2014 14:19:48 +0200
Subject: [PATCH 2/7] irqchip: armada-370-xp: implement the ->check_device()
 msi_chip operation
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397823593-1932-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, we were leaving the ->check_device() msi_chip operation
empty, which leads the PCI core to believe that we support both MSI
and MSI-X. In fact, we do not support MSI-X, so we have to tell this
to the PCI core by providing an implementation of this operation.

Fixes: 31f614edb726fcc4d5aa0f2895fbdec9b04a3ca4 ('irqchip: armada-370-xp: implement MSI support')
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
 drivers/irqchip/irq-armada-370-xp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 3c8d89b..78b0ac9 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -162,6 +162,15 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 	armada_370_xp_free_msi(d->hwirq);
 }
 
+static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
+					  int nvec, int type)
+{
+	/* We support MSI, but not MSI-X */
+	if (type == PCI_CAP_ID_MSI)
+		return 0;
+	return -EINVAL;
+}
+
 static struct irq_chip armada_370_xp_msi_irq_chip = {
 	.name = "armada_370_xp_msi_irq",
 	.irq_enable = unmask_msi_irq,
@@ -200,6 +209,7 @@ static int armada_370_xp_msi_init(struct device_node *node,
 
 	msi_chip->setup_irq = armada_370_xp_setup_msi_irq;
 	msi_chip->teardown_irq = armada_370_xp_teardown_msi_irq;
+	msi_chip->check_device = armada_370_xp_check_msi_device;
 	msi_chip->of_node = node;
 
 	armada_370_xp_msi_domain =
-- 
1.9.2
