From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 23 Jan 2014 23:38:04 +0100
Subject: [PATCH 1/3] irqchip: orion: clear bridge cause register on init
In-Reply-To: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390516686-2224-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is good practice to mask and clear pending irqs on init. We already
mask all irqs, so also clear the bridge irq cause register.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/irqchip/irq-orion.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index e51d40031884..4137c3d15284 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -180,8 +180,9 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
 
-	/* mask all interrupts */
+	/* mask and clear all interrupts */
 	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_MASK);
+	writel(0, gc->reg_base + ORION_BRIDGE_IRQ_CAUSE);
 
 	irq_set_handler_data(irq, domain);
 	irq_set_chained_handler(irq, orion_bridge_irq_handler);
-- 
1.8.5.2
