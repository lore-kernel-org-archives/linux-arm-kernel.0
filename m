From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 16:44:06 +0100
Subject: [PATCH 2/2] irqchip/gic-v3-its: Count additional LPIs for the aliased
 devices
In-Reply-To: <1443800646-8074-1-git-send-email-marc.zyngier@arm.com>
References: <1443800646-8074-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443800646-8074-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When configuring the interrupt mapping for a new device, we
iterate over all the possible aliases to account for their
maximum MSI allocation. This was introduced by e8137f4f5088
("irqchip: gicv3-its: Iterate over PCI aliases to generate ITS configuration").

Turns out that the code doing that is a bit braindead, and repeatedly
accounts for the same device over and over.

Fix this by counting the actual alias that is passed to us by the
core code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cf351c6..a7c8c9f 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -62,7 +62,7 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 
 	dev_alias->dev_id = alias;
 	if (pdev != dev_alias->pdev)
-		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
+		dev_alias->count += its_pci_msi_vec_count(pdev);
 
 	return 0;
 }
-- 
2.1.4
