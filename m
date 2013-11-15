From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:53 +0400
Subject: [PATCH 2/9] ARM: locomo: don't clobber chip data for chained irq
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently locomo uses chip data to pass private data to chained irq
handler. Thus it clobbers the private data of the corresponding chip
(sa1100 or pxa). Make locomo use handler data for this purpose.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/common/locomo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c362..f26bd50 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -140,7 +140,7 @@ static struct locomo_dev_info locomo_devices[] = {
 
 static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct locomo *lchip = irq_get_chip_data(irq);
+	struct locomo *lchip = irq_get_handler_data(irq);
 	int req, i;
 
 	/* Acknowledge the parent IRQ */
@@ -198,7 +198,7 @@ static void locomo_setup_irq(struct locomo *lchip)
 	 * Install handler for IRQ_LOCOMO_HW.
 	 */
 	irq_set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
-	irq_set_chip_data(lchip->irq, lchip);
+	irq_set_handler_data(lchip->irq, lchip);
 	irq_set_chained_handler(lchip->irq, locomo_handler);
 
 	/* Install handlers for IRQ_LOCOMO_* */
-- 
1.8.4.2
