From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Feb 2016 15:46:58 +0100
Subject: [PATCH v3 3/6] irqchip: irq-armada-370-xp: use PCI_MSI_DOORBELL_START
 where appropriate
In-Reply-To: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455115621-22846-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Gregory Clement, this commit adjusts the
irq-armada-370-xp driver to use the PCI_MSI_DOORBELL_START define in
the armada_370_xp_handle_msi_irq() function, rather than hardcoding
its value.

Suggested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index e5738c5..f53eb71 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -401,10 +401,10 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 
 		if (is_chained) {
 			irq = irq_find_mapping(armada_370_xp_msi_inner_domain,
-					       msinr - 16);
+					       msinr - PCI_MSI_DOORBELL_START);
 			generic_handle_irq(irq);
 		} else {
-			irq = msinr - 16;
+			irq = msinr - PCI_MSI_DOORBELL_START;
 			handle_domain_irq(armada_370_xp_msi_inner_domain,
 					  irq, regs);
 		}
-- 
2.6.4
