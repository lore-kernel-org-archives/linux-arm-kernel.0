From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:33 +0100
Subject: [PATCH 10/15] irqchip: sirfsoc: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-sirfsoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
index 5e54f6d..a469355 100644
--- a/drivers/irqchip/irq-sirfsoc.c
+++ b/drivers/irqchip/irq-sirfsoc.c
@@ -50,12 +50,10 @@ sirfsoc_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
 {
 	void __iomem *base = sirfsoc_irqdomain->host_data;
-	u32 irqstat, irqnr;
+	u32 irqstat;
 
 	irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
-	irqnr = irq_find_mapping(sirfsoc_irqdomain, irqstat & 0xff);
-
-	handle_IRQ(irqnr, regs);
+	handle_domain_irq(sirfsoc_irqdomain, irqstat & 0xff, regs);
 }
 
 static int __init sirfsoc_irq_init(struct device_node *np,
-- 
2.0.0
