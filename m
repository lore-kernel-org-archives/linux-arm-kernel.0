From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Sep 2014 16:15:03 -0500
Subject: [PATCH 3/9] irqchip: omap-intc: minor improvement to
 omap_irq_pending()
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Message-ID: <1410815709-462-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already hold the number of Pending registers
in omap_nr_pending. Let's use that instead.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 1478f1a..2933760 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -174,11 +174,10 @@ static void __init omap_irq_soft_reset(void)
 
 int omap_irq_pending(void)
 {
-	int irq;
+	int i;
 
-	for (irq = 0; irq < omap_nr_irqs; irq += 32)
-		if (intc_readl(INTC_PENDING_IRQ0 +
-					((irq >> 5) << 5)))
+	for (i = 0; i < omap_nr_pending; i++)
+		if (intc_readl(INTC_PENDING_IRQ0 + (0x20 * i)))
 			return 1;
 	return 0;
 }
-- 
2.0.1.563.g66f467c
