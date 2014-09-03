From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  3 Sep 2014 11:07:48 +0200
Subject: [PATCH 2/5] irqchip: atmel-aic: add irq fixups for at91sam926x SoCs
In-Reply-To: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1409735271-15353-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91sam9260, at91sam9261, at91sam9263 and at91sam9g20 embed an RTT
(Real Time Timer) block and thus need to call the aic_common_rtt_irq_fixup
function.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/irqchip/irq-atmel-aic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index a82869e..c21c3d2 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -216,11 +216,20 @@ static void __init at91sam9_aic_irq_fixup(struct device_node *root)
 	aic_common_rtc_irq_fixup(root);
 }
 
+static void __init at91sam9260_aic_irq_fixup(struct device_node *root)
+{
+	aic_common_rtt_irq_fixup(root);
+}
+
 static const struct of_device_id __initdata aic_irq_fixups[] = {
 	{ .compatible = "atmel,at91sam9g45", .data = at91sam9_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9n12", .data = at91sam9_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9rl", .data = at91sam9_aic_irq_fixup },
 	{ .compatible = "atmel,at91sam9x5", .data = at91sam9_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9260", .data = at91sam9260_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9261", .data = at91sam9260_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9263", .data = at91sam9260_aic_irq_fixup },
+	{ .compatible = "atmel,at91sam9g20", .data = at91sam9260_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
-- 
1.9.1
