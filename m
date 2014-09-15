From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Sep 2014 16:15:05 -0500
Subject: [PATCH 5/9] irqchip: omap-intc: remove unnecesary
 of_address_to_resource() call
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Message-ID: <1410815709-462-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_iomap(), which is called from omap_init_irq_of(),
already takes care of making sure we have a valid
resource to deal with. Because of that, we can
safely remove our explicit call to of_address_to_resource().

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index f4d562e..e97b535 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -362,7 +362,6 @@ void __init ti81xx_init_irq(void)
 static int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
-	struct resource res;
 	int ret;
 
 	omap_nr_pending = 3;
@@ -371,11 +370,6 @@ static int __init intc_of_init(struct device_node *node,
 	if (WARN_ON(!node))
 		return -ENODEV;
 
-	if (of_address_to_resource(node, 0, &res)) {
-		WARN(1, "unable to get intc registers\n");
-		return -EINVAL;
-	}
-
 	if (of_device_is_compatible(node, "ti,am33xx-intc")) {
 		omap_nr_irqs = 128;
 		omap_nr_pending = 4;
-- 
2.0.1.563.g66f467c
