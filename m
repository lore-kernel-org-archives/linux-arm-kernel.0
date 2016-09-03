From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 03 Sep 2016 09:22:45 +0100
Subject: [PATCH] ARM: locomo: fix locomo irq handling
Message-ID: <E1bg6Dt-0002sJ-Or@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Accidentally booting Collie on Assabet reveals that the locomo driver
incorrectly overwrites gpio-sa1100's chip data for its parent interrupt,
leading to oops in sa1100_gpio_unmask() and sa1100_update_edge_regs().
Fix locomo to use the handler data rather than chip data for its parent
interrupt.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/locomo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 0e97b4b871f9..6c7b06854fce 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -140,7 +140,7 @@ static struct locomo_dev_info locomo_devices[] = {
 
 static void locomo_handler(struct irq_desc *desc)
 {
-	struct locomo *lchip = irq_desc_get_chip_data(desc);
+	struct locomo *lchip = irq_desc_get_handler_data(desc);
 	int req, i;
 
 	/* Acknowledge the parent IRQ */
@@ -200,8 +200,7 @@ static void locomo_setup_irq(struct locomo *lchip)
 	 * Install handler for IRQ_LOCOMO_HW.
 	 */
 	irq_set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
-	irq_set_chip_data(lchip->irq, lchip);
-	irq_set_chained_handler(lchip->irq, locomo_handler);
+	irq_set_chained_handler_and_data(lchip->irq, locomo_handler, lchip);
 
 	/* Install handlers for IRQ_LOCOMO_* */
 	for ( ; irq <= lchip->irq_base + 3; irq++) {
-- 
2.1.0
