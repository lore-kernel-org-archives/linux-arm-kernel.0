From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 23 May 2018 10:44:05 +0200
Subject: [PATCH] pinctrl: armada-37xx: Fix spurious irq management
Message-ID: <20180523084405.14410-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Terry Zhou <bjzhou@marvell.com>

Until now, if we found spurious irq in irq_handler, we only updated the
status in register but not the status in the code. Due to this the system
will got stuck dues to the infinite loop

[gregory.clement at bootlin.com: update comment and add fix and stable tags]
Fixes: 30ac0d3b0702 ("pinctrl: armada-37xx: Add edge both type gpio irq support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Terry Zhou <bjzhou@marvell.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5b63248c8209..7bef929bd7fe 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -679,12 +679,13 @@ static void armada_37xx_irq_handler(struct irq_desc *desc)
 					writel(1 << hwirq,
 					       info->base +
 					       IRQ_STATUS + 4 * i);
-					continue;
+					goto update_status;
 				}
 			}
 
 			generic_handle_irq(virq);
 
+update_status:
 			/* Update status in case a new IRQ appears */
 			spin_lock_irqsave(&info->irq_lock, flags);
 			status = readl_relaxed(info->base +
-- 
2.17.0
