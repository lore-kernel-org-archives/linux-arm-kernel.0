From: rric@kernel.org (Robert Richter)
Date: Sun,  3 May 2015 22:49:29 +0200
Subject: [PATCH 1/4] arm64: gicv3: its: Encode domain number in PCI stream id
In-Reply-To: <1430686172-18222-1-git-send-email-rric@kernel.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
Message-ID: <1430686172-18222-2-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@cavium.com>

PCI stream ids need to consider pci bridge number to be unique on the
system. Using only bus and devfn can't do the trick in systems that
have multiple pci bridges.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9687f8afebff..e30b4de04c6c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1186,7 +1186,7 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct its_pci_alias *dev_alias = data;
 
-	dev_alias->dev_id = alias;
+	dev_alias->dev_id = (pci_domain_nr(pdev->bus) << 16) | alias;
 	if (pdev != dev_alias->pdev)
 		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
 
-- 
2.1.1
