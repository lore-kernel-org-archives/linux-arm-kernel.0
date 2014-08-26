From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:33 +0100
Subject: [PATCH v2 18/26] irqchip: GICv3: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-19-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 57eaa5a..9e31449 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -274,14 +274,13 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		irqnr = gic_read_iar();
 
 		if (likely(irqnr > 15 && irqnr < 1020)) {
-			u64 irq = irq_find_mapping(gic_data.domain, irqnr);
-			if (likely(irq)) {
-				handle_IRQ(irq, regs);
-				continue;
+			int err;
+			err = handle_domain_irq(gic_data.domain, irqnr, regs);
+			if (err) {
+				WARN_ONCE(true, "Unexpected SPI received!\n");
+				gic_write_eoir(irqnr);
 			}
-
-			WARN_ONCE(true, "Unexpected SPI received!\n");
-			gic_write_eoir(irqnr);
+			continue;
 		}
 		if (irqnr < 16) {
 			gic_write_eoir(irqnr);
-- 
2.0.4
